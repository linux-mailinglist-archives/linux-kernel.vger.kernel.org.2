Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED0032547C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhBYRWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:22:00 -0500
Received: from foss.arm.com ([217.140.110.172]:42116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhBYRV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:21:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 810F8101E;
        Thu, 25 Feb 2021 09:21:08 -0800 (PST)
Received: from [10.57.49.35] (unknown [10.57.49.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9339C3F73D;
        Thu, 25 Feb 2021 09:21:04 -0800 (PST)
Subject: Re: [PATCH] coresight: etm4x: work around clang-12+ build failure
To:     Arnd Bergmann <arnd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210225094324.3542511-1-arnd@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <19c9eba2-c5cd-301f-4dfa-a31c971728f9@arm.com>
Date:   Thu, 25 Feb 2021 17:20:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225094324.3542511-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/21 9:42 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-12 fails to build the etm4x driver with -fsanitize=array-bounds:
> 
> <instantiation>:1:7: error: expected constant expression in '.inst' directive
> .inst (0xd5200000|((((2) << 19) | ((1) << 16) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 7) & 0x7)) << 12) | ((((((((((0x160 + (i * 4))))) >> 2))) & 0xf)) << 8) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 4) & 0x7)) << 5)))|(.L__reg_num_x8))
>        ^
> drivers/hwtracing/coresight/coresight-etm4x-core.c:702:4: note: while in macro instantiation
>                          etm4x_relaxed_read32(csa, TRCCNTVRn(i));
>                          ^
> drivers/hwtracing/coresight/coresight-etm4x.h:403:4: note: expanded from macro 'etm4x_relaxed_read32'
>                   read_etm4x_sysreg_offset((offset), false)))
>                   ^
> drivers/hwtracing/coresight/coresight-etm4x.h:383:12: note: expanded from macro 'read_etm4x_sysreg_offset'
>                          __val = read_etm4x_sysreg_const_offset((offset));       \
>                                  ^
> drivers/hwtracing/coresight/coresight-etm4x.h:149:2: note: expanded from macro 'read_etm4x_sysreg_const_offset'
>          READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
>          ^
> drivers/hwtracing/coresight/coresight-etm4x.h:144:2: note: expanded from macro 'READ_ETM4x_REG'
>          read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
>          ^
> arch/arm64/include/asm/sysreg.h:1108:15: note: expanded from macro 'read_sysreg_s'
>          asm volatile(__mrs_s("%0", r) : "=r" (__val));                  \
>                       ^
> arch/arm64/include/asm/sysreg.h:1074:2: note: expanded from macro '__mrs_s'
> "       mrs_s " v ", " __stringify(r) "\n"                      \
>   ^
> 
> It appears that the __builin_constant_p() check in
> read_etm4x_sysreg_offset() falsely returns 'true' here because clang
> decides finds that an out-of-bounds access to config->cntr_val[] cannot

s/decides finds/decides/ ?

> happen, and then it unrolls the loop with constant register numbers. Then
> when actually emitting the output, it fails to figure out the value again.
> 
> While this is incorrect behavior in clang, it is easy to work around
> by avoiding the out-of-bounds array access. Do this by limiting the
> loop counter to the actual dimension of the array.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1310
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 15016f757828..4cccf874a602 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -691,13 +691,13 @@ static void etm4_disable_hw(void *info)
>   			"timeout while waiting for PM stable Trace Status\n");
>   
>   	/* read the status of the single shot comparators */
> -	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> +	for (i = 0; i < min_t(u32, drvdata->nr_ss_cmp, ETM_MAX_SS_CMP); i++) {
>   		config->ss_status[i] =
>   			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
>   	}
>   

There are more places where we do this. So I believe you need the similar
change elsewhere too in the driver. So, that becomes cumbersome for circumventing
the compiler issue.

Suzuki
