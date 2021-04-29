Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3036EF05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbhD2Rib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:38:31 -0400
Received: from foss.arm.com ([217.140.110.172]:57466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhD2Ri3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:38:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 181881FB;
        Thu, 29 Apr 2021 10:37:42 -0700 (PDT)
Received: from [10.57.61.145] (unknown [10.57.61.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B102E3F70D;
        Thu, 29 Apr 2021 10:37:39 -0700 (PDT)
Subject: Re: [PATCH] [v2] coresight: etm4x: avoid build failure with unrolled
 loops
To:     Arnd Bergmann <arnd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Qi Liu <liuqi115@huawei.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210429145752.3218324-1-arnd@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <dff8cbd8-8c56-ae6e-ecc2-9ca183113ab2@arm.com>
Date:   Thu, 29 Apr 2021 18:37:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429145752.3218324-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

On 29/04/2021 15:57, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-12 fails to build the etm4x driver with -fsanitize=array-bounds,
> where it decides to unroll certain loops in a way that result in a
> C variable getting put into an inline assembly
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
> This only happened in a few loops in which the array bounds sanitizer
> added a special case for an array overflow that clang determined to be
> possible, but any compiler is free to unroll any of the loops in the
> same way that breaks the sysreg macros.
> 
> Introduce helper functions that perform a sysreg access with a
> non-constant register number and use them in each call that passes
> a loop counter.

You don't need to add this special helper. We have the exact 
infrastructure already. So these could simply be replaced with:

csdev_access_xxx(csa, ...)

see :

include/linux/coresight.h

Cheers
Suzuki
