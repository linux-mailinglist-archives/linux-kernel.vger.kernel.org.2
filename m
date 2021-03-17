Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA84933FA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhCQUlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhCQUlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:41:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433C9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wSTffLxRvbfWNiwQavgHvVZJbejq7y1KUbBR2HBcwJs=; b=ld5DyQF+1/bh/cItmNZ3cdq8Kb
        653hzvRn2JLN72BXCkJyr40IsnfRW0UBpZ6hV3z22c69dyhbGLMfcJFT1Eg49ucejtjHx5+W6P6ze
        RCmrHdar7lx3x/P3oPWLdKvNNY1liLrv0nqepyueQyyUMD1hATKch1MNGChz5W74bTbTYzquU5A7P
        k4oKwY+pu0MuHD4hQMZI4+Mw/9z37f8PF8AaqhBmllWB9cu6Xtab8MaOdGC1Yr+LlMgnAs+ZJx+Ry
        155JE7wqJq4R+mwbgrcUqfXCSfl3FYUGc8vUdKmzZOGpWpHHHqruagMmJ4uSa/DyVFkmXb/SeH4Nd
        TRDEiApA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMcwu-001gdl-Dn; Wed, 17 Mar 2021 20:39:30 +0000
Subject: Re: [PATCH] ALSA: asihpi: fix comment syntax in file headers
To:     Aditya Srivastava <yashsri421@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
References: <20210317202144.20290-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <608b4400-dfda-9702-ae3a-b1bc9aca6da6@infradead.org>
Date:   Wed, 17 Mar 2021 13:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317202144.20290-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 1:21 PM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are files in sound/pci/asihpi which follow this syntax in their file
> headers, i.e. start with '/**' like comments, which causes unexpected
> warnings from kernel-doc.
> 
> E.g., running scripts/kernel-doc -none on sound/pci/asihpi/hpidspcd.h
> causes this warning:
> "warning: Cannot understand
>  on line 4 - I thought it was a doc line"
> 
> Provide a simple fix by replacing the kernel-doc like comment syntax with
> general format, i.e. "/*", to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> * Applies perfectly on next-20210312
> 
>  sound/pci/asihpi/hpicmn.h   | 2 +-
>  sound/pci/asihpi/hpidspcd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/asihpi/hpicmn.h b/sound/pci/asihpi/hpicmn.h
> index de3bedd29d94..8ec656cf8848 100644
> --- a/sound/pci/asihpi/hpicmn.h
> +++ b/sound/pci/asihpi/hpicmn.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>  
>      AudioScience HPI driver
>      Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
> diff --git a/sound/pci/asihpi/hpidspcd.h b/sound/pci/asihpi/hpidspcd.h
> index a01e8c6092bd..9f1468ed7096 100644
> --- a/sound/pci/asihpi/hpidspcd.h
> +++ b/sound/pci/asihpi/hpidspcd.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /***********************************************************************/
> -/**
> +/*
>  
>      AudioScience HPI driver
>      Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
> 


-- 
~Randy

