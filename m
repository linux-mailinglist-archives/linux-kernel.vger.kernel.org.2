Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1833B027
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCOKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:42:19 -0400
Received: from foss.arm.com ([217.140.110.172]:59322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhCOKl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:41:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EF0E1FB;
        Mon, 15 Mar 2021 03:41:58 -0700 (PDT)
Received: from [10.57.55.99] (unknown [10.57.55.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7EED3F70D;
        Mon, 15 Mar 2021 03:41:57 -0700 (PDT)
Subject: Re: [PATCH] arm64: csum: cast to the proper type
To:     Alex Elder <elder@linaro.org>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210315012650.1221328-1-elder@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <031a3734-c677-5d42-2329-81f5f6ba1cfe@arm.com>
Date:   Mon, 15 Mar 2021 10:41:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315012650.1221328-1-elder@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-15 01:26, Alex Elder wrote:
> The last line of ip_fast_csum() calls csum_fold(), forcing the
> type of the argument passed to be u32.  But csum_fold() takes a
> __wsum argument (which is __u32 __bitwise for arm64).  As long
> as we're forcing the cast, cast it to the right type.

Oddly, the commit adding the cast does specifically speak about 
converting to __wsum, so I'm not sure what happened there... :/

Anyway, this seems to make sense.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
> 
> With this patch in place, quite a few "different base types" sparse
> warnings go away on a full arm64 kernel build.  More specifically:
>    warning: incorrect type in argument 1 (different base types)
>       expected restricted __wsum [usertype] csum
>       got unsigned int [usertype]
> 
> 					-Alex
> 
>   arch/arm64/include/asm/checksum.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/checksum.h b/arch/arm64/include/asm/checksum.h
> index 93a161b3bf3fe..dc52b733675db 100644
> --- a/arch/arm64/include/asm/checksum.h
> +++ b/arch/arm64/include/asm/checksum.h
> @@ -37,7 +37,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>   	} while (--n > 0);
>   
>   	sum += ((sum >> 32) | (sum << 32));
> -	return csum_fold((__force u32)(sum >> 32));
> +	return csum_fold((__force __wsum)(sum >> 32));
>   }
>   #define ip_fast_csum ip_fast_csum
>   
> 
