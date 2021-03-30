Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2846C34F2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhC3VDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhC3VDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:03:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868E2C061574;
        Tue, 30 Mar 2021 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=HUbATrNsHGZOy4VwMo16gFCkoyooGCF07RUQqafwLSU=; b=hPiYumTyzR5xFL+xzKLpGdYZzm
        FIY8lNix7wKiNQxDSphpiBA0G8QB2C1OZTOmHaK8r+r+QtLMsjBZFo+/eOEhmwvOTlJVMIPxqiXbW
        YjgACTw+p+u7KkRFLIylBbHp1NiuVeCKjpSSJ3EMSTUsA9eZNeW3w1Muq2Ku/EY9tsk/nJV31ykpU
        +Ll8gzgH9eQYuGMC2XmyFb46zxs2aqCkIeN2OOr3G450UxGbj4stz1tNc5RrKkxG2DNgHbBNJTdAu
        h04PRgUJfXb3Kl43kDlFNYnxHQ51QWk35c3VDW8Ibt7nAxXi2zNl5Ekock1z81XbD1XPY0qnVGPym
        M61MzbQw==;
Received: from [2601:1c0:6280:3f0::4557]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRLVl-003bQT-GV; Tue, 30 Mar 2021 21:02:57 +0000
Subject: Re: [PATCH] ARM: mach-sa1100: fix incorrect kernel-doc comment syntax
 in file
To:     Aditya Srivastava <yashsri421@gmail.com>, linux@armlinux.org.uk
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210330204407.25690-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1fc5b958-da00-3f0f-5db0-b32cd129fd4f@infradead.org>
Date:   Tue, 30 Mar 2021 14:02:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330204407.25690-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/21 1:44 PM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> The header for arch/arm/mach-sa1100/jornada720_ssp.c follows this syntax,
> but the content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes these warnings from kernel-doc:
> "warning: Function parameter or member 'jornada_ssp_lock' not described in 'DEFINE_SPINLOCK'"
> "warning: expecting prototype for mac(). Prototype was for DEFINE_SPINLOCK() instead"
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> * Applies perfectly on next-20210326
> 
>  arch/arm/mach-sa1100/jornada720_ssp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
> index 1dbe98948ce3..148bcee3ee58 100644
> --- a/arch/arm/mach-sa1100/jornada720_ssp.c
> +++ b/arch/arm/mach-sa1100/jornada720_ssp.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   *  arch/arm/mac-sa1100/jornada720_ssp.c
>   *
>   *  Copyright (C) 2006/2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
> 


-- 
~Randy

