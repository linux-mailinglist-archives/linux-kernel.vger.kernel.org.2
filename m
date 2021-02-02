Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD530C891
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbhBBRyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbhBBRxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:53:24 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D81FC0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:52:44 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b145so8054718pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7D6NDJ8JurbzRvXAZfhNbB6zLtcLIAHsoQYIRv3jhYI=;
        b=r3roLyTmjYSIAF0ozy49vk1j6SAU5qhxJPPFL5Pgc2An5vnA+0hntX7ZjpDguYtq3z
         uFICR8KWjKXjGswKF/GHZzNKLpKJw8i5IUikdTgJ3BvA9or/ZygGG/6mZfdCrtdJgNB7
         TkVBlkSS76PAwUcpQOBSgTkxnzuc/hFbiPfSCCCBvyxREqWSgGLXs4GEsIxhztnMY3+2
         eyJUBwVa+Rch1m02yySU15EjnX1YgdBAk6lfMJjp7RRhp5UYCQw5DQQSzewMtw6kTDF5
         GvatgDwrEkc0ylbMKUQ2U1KdWguth3qPrzkvtBDskVJMSrLbQ39rm0w6d9N75x7gy2KJ
         x3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7D6NDJ8JurbzRvXAZfhNbB6zLtcLIAHsoQYIRv3jhYI=;
        b=G0tgbmVqI/f1GpgUuPUgAxV1EEPCGvaHV1LotKssWFeB8opi1jDPB2tGGtBHy43kR3
         bY2findF+nsAOp0GbzEr2KlfwR3QV78bNxWTv8rJVNt9vSArk7IpujYT6jVL+4vp2UET
         HGqLflaZ0H9cb+z89fPhj/vohYeaLQtEzzTXONJ6uXpEhHWfItVxvSpvzGpB9+mrmH/U
         QzipjBWHbcruid//5oHjtY8SIsFvwQREW0Wsww+X5mLqAxDF6B+YM+tTlccM5K8jAxaz
         iGFjRc2qxIm8HbceuzSc6t/bker6eZsLEwbhFkwMlqQlxPO09LsezbGVNq4rS/UYlN1i
         hnRA==
X-Gm-Message-State: AOAM5327hMO2ibzREHB7P0jWaROtJ2tZM8j8FLVxp/bZGg1klBIDUJSx
        ntuyqzuFGIZVc4l5uIDzaw/9RQ==
X-Google-Smtp-Source: ABdhPJy9E2aLBeEHTMuM6OdpmIeJ8Q7Lr/JvFBU1z1mrIaTG04U5u9jGLujZ8hvVpxKJAQ0ccuTsAA==
X-Received: by 2002:a65:67cf:: with SMTP id b15mr23259677pgs.429.1612288363519;
        Tue, 02 Feb 2021 09:52:43 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id v26sm21060199pff.195.2021.02.02.09.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:52:42 -0800 (PST)
Date:   Tue, 2 Feb 2021 10:52:41 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 04/14] coresight: ete: Add support for ETE sysreg
 access
Message-ID: <20210202175241.GC1536093@xps15>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-5-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:25:28PM +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Add support for handling the system registers for Embedded Trace
> Extensions (ETE). ETE shares most of the registers with ETMv4 except
> for some and also adds some new registers. Re-arrange the ETMv4x list
> to share the common definitions and add the ETE sysreg support.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 32 +++++++++++++
>  drivers/hwtracing/coresight/coresight-etm4x.h      | 52 ++++++++++++++++++----
>  2 files changed, 75 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 9edf8be..9e92d2a 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -114,6 +114,38 @@ void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>  	}
>  }
>  
> +u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
> +{
> +	u64 res = 0;
> +
> +	switch (offset) {
> +	ETE_READ_CASES(res)
> +	default :
> +		WARN_ONCE(1, "ete: trying to read unsupported register @%x\n",
> +			 offset);

Alignment

> +	}
> +
> +	if (!_relaxed)
> +		__iormb(res);	/* Imitate the !relaxed I/O helpers */
> +
> +	return res;
> +}
> +
> +void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
> +{
> +	if (!_relaxed)
> +		__iowmb();	/* Imitate the !relaxed I/O helpers */
> +	if (!_64bit)
> +		val &= GENMASK(31, 0);
> +
> +	switch (offset) {
> +	ETE_WRITE_CASES(val)
> +	default :
> +		WARN_ONCE(1, "ete: trying to write to unsupported register @%x\n",
> +			offset);

Alignment

> +	}
> +}

The etm4x_sysreg_xyz() equivalent of these use a pr_warn_ratelimited() rather
than a WARN_ONE().  

With that:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +
>  static void etm_detect_os_lock(struct etmv4_drvdata *drvdata,
>  			       struct csdev_access *csa)
>  {
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 0e86eba..ca24ac5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -29,6 +29,7 @@
>  #define TRCAUXCTLR			0x018
>  #define TRCEVENTCTL0R			0x020
>  #define TRCEVENTCTL1R			0x024
> +#define TRCRSR				0x028
>  #define TRCSTALLCTLR			0x02C
>  #define TRCTSCTLR			0x030
>  #define TRCSYNCPR			0x034
> @@ -49,6 +50,7 @@
>  #define TRCSEQRSTEVR			0x118
>  #define TRCSEQSTR			0x11C
>  #define TRCEXTINSELR			0x120
> +#define TRCEXTINSELRn(n)		(0x120 + (n * 4)) /* n = 0-3 */
>  #define TRCCNTRLDVRn(n)			(0x140 + (n * 4)) /* n = 0-3 */
>  #define TRCCNTCTLRn(n)			(0x150 + (n * 4)) /* n = 0-3 */
>  #define TRCCNTVRn(n)			(0x160 + (n * 4)) /* n = 0-3 */
> @@ -160,10 +162,22 @@
>  #define CASE_NOP(__unused, x)					\
>  	case (x):	/* fall through */
>  
> +#define ETE_ONLY_SYSREG_LIST(op, val)		\
> +	CASE_##op((val), TRCRSR)		\
> +	CASE_##op((val), TRCEXTINSELRn(1))	\
> +	CASE_##op((val), TRCEXTINSELRn(2))	\
> +	CASE_##op((val), TRCEXTINSELRn(3))
> +
>  /* List of registers accessible via System instructions */
> -#define ETM_SYSREG_LIST(op, val)		\
> -	CASE_##op((val), TRCPRGCTLR)		\
> +#define ETM4x_ONLY_SYSREG_LIST(op, val)		\
>  	CASE_##op((val), TRCPROCSELR)		\
> +	CASE_##op((val), TRCVDCTLR)		\
> +	CASE_##op((val), TRCVDSACCTLR)		\
> +	CASE_##op((val), TRCVDARCCTLR)		\
> +	CASE_##op((val), TRCOSLAR)
> +
> +#define ETM_COMMON_SYSREG_LIST(op, val)		\
> +	CASE_##op((val), TRCPRGCTLR)		\
>  	CASE_##op((val), TRCSTATR)		\
>  	CASE_##op((val), TRCCONFIGR)		\
>  	CASE_##op((val), TRCAUXCTLR)		\
> @@ -180,9 +194,6 @@
>  	CASE_##op((val), TRCVIIECTLR)		\
>  	CASE_##op((val), TRCVISSCTLR)		\
>  	CASE_##op((val), TRCVIPCSSCTLR)		\
> -	CASE_##op((val), TRCVDCTLR)		\
> -	CASE_##op((val), TRCVDSACCTLR)		\
> -	CASE_##op((val), TRCVDARCCTLR)		\
>  	CASE_##op((val), TRCSEQEVRn(0))		\
>  	CASE_##op((val), TRCSEQEVRn(1))		\
>  	CASE_##op((val), TRCSEQEVRn(2))		\
> @@ -277,7 +288,6 @@
>  	CASE_##op((val), TRCSSPCICRn(5))	\
>  	CASE_##op((val), TRCSSPCICRn(6))	\
>  	CASE_##op((val), TRCSSPCICRn(7))	\
> -	CASE_##op((val), TRCOSLAR)		\
>  	CASE_##op((val), TRCOSLSR)		\
>  	CASE_##op((val), TRCACVRn(0))		\
>  	CASE_##op((val), TRCACVRn(1))		\
> @@ -369,12 +379,36 @@
>  	CASE_##op((val), TRCPIDR2)		\
>  	CASE_##op((val), TRCPIDR3)
>  
> -#define ETM4x_READ_SYSREG_CASES(res)	ETM_SYSREG_LIST(READ, (res))
> -#define ETM4x_WRITE_SYSREG_CASES(val)	ETM_SYSREG_LIST(WRITE, (val))
> +#define ETM4x_READ_SYSREG_CASES(res)		\
> +	ETM_COMMON_SYSREG_LIST(READ, (res))	\
> +	ETM4x_ONLY_SYSREG_LIST(READ, (res))
> +
> +#define ETM4x_WRITE_SYSREG_CASES(val)		\
> +	ETM_COMMON_SYSREG_LIST(WRITE, (val))	\
> +	ETM4x_ONLY_SYSREG_LIST(WRITE, (val))
> +
> +#define ETM_COMMON_SYSREG_LIST_CASES		\
> +	ETM_COMMON_SYSREG_LIST(NOP, __unused)
> +
> +#define ETM4x_SYSREG_LIST_CASES			\
> +	ETM_COMMON_SYSREG_LIST_CASES		\
> +	ETM4x_ONLY_SYSREG_LIST(NOP, __unused)
>  
> -#define ETM4x_SYSREG_LIST_CASES		ETM_SYSREG_LIST(NOP, __unused)
>  #define ETM4x_MMAP_LIST_CASES		ETM_MMAP_LIST(NOP, __unused)
>  
> +/* ETE only supports system register access */
> +#define ETE_READ_CASES(res)			\
> +	ETM_COMMON_SYSREG_LIST(READ, (res))	\
> +	ETE_ONLY_SYSREG_LIST(READ, (res))
> +
> +#define ETE_WRITE_CASES(val)			\
> +	ETM_COMMON_SYSREG_LIST(WRITE, (val))	\
> +	ETE_ONLY_SYSREG_LIST(WRITE, (val))
> +
> +#define ETE_ONLY_SYSREG_LIST_CASES		\
> +	ETM_COMMON_SYSREG_LIST_CASES		\
> +	ETE_ONLY_SYSREG_LIST(NOP, __unused)
> +
>  #define read_etm4x_sysreg_offset(offset, _64bit)				\
>  	({									\
>  		u64 __val;							\
> -- 
> 2.7.4
> 
