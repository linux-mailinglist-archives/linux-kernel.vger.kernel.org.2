Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077F838D9FF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 10:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhEWIMr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 23 May 2021 04:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhEWIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 04:12:34 -0400
X-Greylist: delayed 81817 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 May 2021 01:11:08 PDT
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [IPv6:2001:41d0:305:2100::8a0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FA08C061574;
        Sun, 23 May 2021 01:11:08 -0700 (PDT)
Received: from philogene.localnet (localhost [IPv6:::1])
        by ursule.remlab.net (Postfix) with ESMTP id 14100C2C68;
        Sun, 23 May 2021 11:11:07 +0300 (EEST)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     courmisch@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Phonet: fix kernel-doc syntax in file headers and remove file names
Date:   Sun, 23 May 2021 11:11:06 +0300
Message-ID: <1794881.Lfz63IBmft@philogene>
Organization: Remlab Tmi
In-Reply-To: <20210522113408.8766-1-yashsri421@gmail.com>
References: <52313028.m8L9TnScQ9@philogene> <20210522113408.8766-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 22 mai 2021, 14:34:08 EEST Aditya Srivastava a écrit :
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> For e.g., the header for include/linux/phonet.h follows this syntax, but
> the content inside does not comply with kernel-doc.
> 
> This line was probably not meant for kernel-doc parsing, but is parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warning from kernel-doc:
> warning: This comment starts with '/**', but isn't a kernel-doc comment.
> Refer Documentation/doc-guide/kernel-doc.rst * file phonet.h
> 
> Provide a simple fix by replacing this occurrence with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Also remove the redundant file name from the comment headers.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Rémi Denis-Courmont <courmisch@gmail.com>

> ---
> Changes in v2:
> - Remove file name information from comment headers as well, as suggested by
> Randy and Remi
> 
>  include/linux/phonet.h      | 4 +---
>  include/uapi/linux/phonet.h | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/phonet.h b/include/linux/phonet.h
> index bc7d1e529efc..6117a0e462d3 100644
> --- a/include/linux/phonet.h
> +++ b/include/linux/phonet.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> - * file phonet.h
> - *
> +/*
>   * Phonet sockets kernel interface
>   *
>   * Copyright (C) 2008 Nokia Corporation. All rights reserved.
> diff --git a/include/uapi/linux/phonet.h b/include/uapi/linux/phonet.h
> index a2f6b37a5937..e7e14b5e59c6 100644
> --- a/include/uapi/linux/phonet.h
> +++ b/include/uapi/linux/phonet.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/**
> - * file phonet.h
> - *
> +/*
>   * Phonet sockets kernel interface
>   *
>   * Copyright (C) 2008 Nokia Corporation. All rights reserved.


-- 
Rémi Denis-Courmont


