Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7CB33A612
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 17:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhCNQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhCNQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 12:17:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C094C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=h3oKT2DIWMi/3UOnem0PmyfrJuvNhkM34vsZ5Qcbs8I=; b=aaJt/VQm3LY5XSCT8IZoqz6Dfu
        RHGD6IcX8kOz4lYEBQzKW4vqCWhl54QfBJZc9YSopxtB289Mz+vP4k/TtDE7uKtCSOpaamIDgWdl4
        J3H9wB23k/bWDyfxP7ATLI6a2NWh+nr14Fsm51QhmRLKaXavPYq9c7JFOuflxxb+e9H+sjk9GmEpQ
        iJCDlH2ynfGFS5JMDOP3i3E/sIipk5T9KcQr7AC9Z2PwsYKjQMgdIYnxXAzYthOStEnVY5MWCPmM8
        XySCxYCSylV8VdUCjv0wf8OaEiaimRs/D9Hx8sj6U5xD7XqIupipP+irq5s+uUddNVb0unAyV7Vcb
        DbiHgJOQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLTQf-001DPd-Ni; Sun, 14 Mar 2021 16:17:22 +0000
Subject: Re: [PATCH] soc: fsl: guts: fix comment syntax in file
To:     Aditya Srivastava <yashsri421@gmail.com>, leoyang.li@nxp.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210314072828.9270-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1cab34f0-dcd1-b8ff-6bab-38ff9adc94b5@infradead.org>
Date:   Sun, 14 Mar 2021 09:17:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314072828.9270-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/21 11:28 PM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for kernel-doc comments.
> There are certain comments in include/linux/fsl/guts.h which follows this
> syntax, but the content inside does not comply with kernel-doc.
> 
> E.g., opening comment for "Freecale 85xx and 86xx Global Utilties
> register set" follows kernel-doc syntax(i.e., '/**'), but the content
> inside does not comply with any kernel-doc specification (function,
> struct, etc).
> 
> This causes unwelcomed warning from kernel-doc:
> "warning: expecting prototype for Freecale 85xx and 86xx Global Utilties register set(). Prototype was for __FSL_GUTS_H__() instead"
> 
> Replace all such comment occurrences with general comment format,
> i.e. '/*' to pervent kernel-doc from parsing these.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> * Applies perfectly on next-20210312
> 
>  include/linux/fsl/guts.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fsl/guts.h b/include/linux/fsl/guts.h
> index 0ac27b233f12..fdb55ca47a4f 100644
> --- a/include/linux/fsl/guts.h
> +++ b/include/linux/fsl/guts.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -/**
> +/*
>   * Freecale 85xx and 86xx Global Utilties register set
>   *
>   * Authors: Jeff Brown
> @@ -14,7 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/io.h>
>  
> -/**
> +/*
>   * Global Utility Registers.
>   *
>   * Not all registers defined in this structure are available on all chips, so
> 


-- 
~Randy

