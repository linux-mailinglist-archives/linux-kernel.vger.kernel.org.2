Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC04734F399
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhC3Vf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhC3VfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:35:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDD2C061574;
        Tue, 30 Mar 2021 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=z7gpjKduYgeN6oL2kpf0goTjGuX7Jirh6bppui9tmTw=; b=l+hnoP3v0qdie0iPZDvdZiuoBW
        Iyfz7J0yph9CuU+XlaLvnSo8ku2k7KDd/d+krMIST6s9Fyv/egtQgT3W7t7p6hjWDOv5kSjalw4Ec
        2UXpr36d7MW1htLT+rvF7dYmYqKfWrD8SaZnI3uaA/Y7LaB/HdZimrmGUV+X/FU5LQdQZd9MAmGR6
        NDsGb+rIi8T+u5KgbpaQ6qj8t/KO6X+y5CJJ4Kc2mMI6iyux8Pz8u4cQL9Ig/clytqOfua63wAsCW
        wJwqt1HMRxUeNDwlSLKt9CLSomizp6PDlJyp6MMwFMzNOVpaEZ8iCg/EbLmz5xPDO9FjDdjhTG8xR
        N8Wq8hZw==;
Received: from [2601:1c0:6280:3f0::4557]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRLyp-003dqg-0Z; Tue, 30 Mar 2021 21:33:07 +0000
Subject: Re: [PATCH] x86/platform/intel/quark: fix incorrect kernel-doc
 comment syntax in files
To:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     lukas.bulwahn@gmail.com, dvhart@infradead.org, andy@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20210330213022.28769-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1f37b726-7f03-99dc-546f-7d33a1f2c6c9@infradead.org>
Date:   Tue, 30 Mar 2021 14:32:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330213022.28769-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 2:30 PM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in arch/x86/platform/intel-quark, which follow this
> syntax, but the content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc.
> 
> E.g., presence of kernel-doc like comment in the header lines for
> arch/x86/platform/intel-quark/imr.c causes these warnings:
> "warning: Function parameter or member 'fmt' not described in 'pr_fmt'"
> "warning: expecting prototype for c(). Prototype was for pr_fmt() instead"
> 
> Similarly for arch/x86/platform/intel-quark/imr_selftest.c too.
> 
> Provide a simple fix by replacing these occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> * Applies perfectly on next-20210326
> 
>  arch/x86/platform/intel-quark/imr.c          | 2 +-
>  arch/x86/platform/intel-quark/imr_selftest.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
> index 122e0f37b1f5..d3d456925b2a 100644
> --- a/arch/x86/platform/intel-quark/imr.c
> +++ b/arch/x86/platform/intel-quark/imr.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * imr.c -- Intel Isolated Memory Region driver
>   *
>   * Copyright(c) 2013 Intel Corporation.
> diff --git a/arch/x86/platform/intel-quark/imr_selftest.c b/arch/x86/platform/intel-quark/imr_selftest.c
> index 570e3062faac..761f3689f60a 100644
> --- a/arch/x86/platform/intel-quark/imr_selftest.c
> +++ b/arch/x86/platform/intel-quark/imr_selftest.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * imr_selftest.c -- Intel Isolated Memory Region self-test driver
>   *
>   * Copyright(c) 2013 Intel Corporation.
> 


-- 
~Randy

