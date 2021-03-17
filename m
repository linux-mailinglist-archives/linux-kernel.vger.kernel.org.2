Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F333FA20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhCQUvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCQUvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:51:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC4AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=D5D89/TKIGeXZgkbBE6j29aBo7eeo92Jhg5zvf77KOQ=; b=xfJW51k+Ypgc4yunBzBb3XyJ/d
        NpavTMH96gs/TV/mpS3LNicoztscHjRempy6YpFsxMK6VyFyJBePLAUxF0Dn/Lsy1IbgKhozj65u2
        BXBYp4I8GB/KHL+/2vIEigEvoRbXE6cYN0x9iBufHpXvoBf6jYw97s6mIhGzr5UIJF3n4Iq+J9lUx
        ROh2AlBIfu+3MT9Q3AQ5o8BpVnaQi9TSokRSTT5HpwUrWYfG59gcwGfM+jaeZaRogecAAUkWXiZXy
        dWIipXCO/IrDuzXUUkDBApIGC7u4QlScA1GdFtmsiP1P7Ktk0IgPEu5TK1FPSyFXFWceEVpb4c/sB
        zvFGYqaA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMd8C-001ggk-41; Wed, 17 Mar 2021 20:51:09 +0000
Subject: Re: [PATCH] ALSA: ctxfi: fix comment syntax in file headers
To:     Aditya Srivastava <yashsri421@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, perex@perex.cz,
        tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20210317203932.23993-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <68e0dfd9-ed58-dec3-31b7-c5384d8640f8@infradead.org>
Date:   Wed, 17 Mar 2021 13:50:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317203932.23993-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 1:39 PM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are files in sound/pci/ctxfi which follow this syntax in their file
> headers, i.e. start with '/**' like comments, which causes unexpected
> warnings from kernel-doc.
> 
> E.g., running scripts/kernel-doc -none on sound/pci/ctxfi/ctresource.c
> causes this warning:
> "warning: wrong kernel-doc identifier on line:
>  * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved."
> 
> Similarly for other files too.
> 
> Provide a simple fix by replacing the kernel-doc like comment syntax with
> general format, i.e. "/*", to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  sound/pci/ctxfi/ct20k1reg.h  | 2 +-
>  sound/pci/ctxfi/ct20k2reg.h  | 2 +-
>  sound/pci/ctxfi/ctamixer.c   | 2 +-
>  sound/pci/ctxfi/ctamixer.h   | 2 +-
>  sound/pci/ctxfi/ctatc.c      | 2 +-
>  sound/pci/ctxfi/ctatc.h      | 2 +-
>  sound/pci/ctxfi/ctdaio.c     | 2 +-
>  sound/pci/ctxfi/ctdaio.h     | 2 +-
>  sound/pci/ctxfi/cthardware.h | 2 +-
>  sound/pci/ctxfi/cthw20k1.h   | 2 +-
>  sound/pci/ctxfi/cthw20k2.h   | 2 +-
>  sound/pci/ctxfi/ctimap.h     | 2 +-
>  sound/pci/ctxfi/ctmixer.h    | 2 +-
>  sound/pci/ctxfi/ctpcm.h      | 2 +-
>  sound/pci/ctxfi/ctresource.c | 2 +-
>  sound/pci/ctxfi/ctresource.h | 2 +-
>  sound/pci/ctxfi/ctsrc.c      | 2 +-
>  sound/pci/ctxfi/ctsrc.h      | 2 +-
>  sound/pci/ctxfi/ctvmem.c     | 2 +-
>  sound/pci/ctxfi/ctvmem.h     | 2 +-
>  20 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/pci/ctxfi/ct20k1reg.h b/sound/pci/ctxfi/ct20k1reg.h
> index d4bfee499fb1..05bb006c0f4c 100644
> --- a/sound/pci/ctxfi/ct20k1reg.h
> +++ b/sound/pci/ctxfi/ct20k1reg.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   */
>  
> diff --git a/sound/pci/ctxfi/ct20k2reg.h b/sound/pci/ctxfi/ct20k2reg.h
> index af94ea66fdda..02f67828eabe 100644
> --- a/sound/pci/ctxfi/ct20k2reg.h
> +++ b/sound/pci/ctxfi/ct20k2reg.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   */
>  
> diff --git a/sound/pci/ctxfi/ctamixer.c b/sound/pci/ctxfi/ctamixer.c
> index d4ff377eb3a3..da6e6350ceaf 100644
> --- a/sound/pci/ctxfi/ctamixer.c
> +++ b/sound/pci/ctxfi/ctamixer.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctamixer.c
> diff --git a/sound/pci/ctxfi/ctamixer.h b/sound/pci/ctxfi/ctamixer.h
> index 4fafb397abed..4498e6139d0e 100644
> --- a/sound/pci/ctxfi/ctamixer.h
> +++ b/sound/pci/ctxfi/ctamixer.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctamixer.h
> diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
> index f8ac96cf38a4..78f35e88aed6 100644
> --- a/sound/pci/ctxfi/ctatc.c
> +++ b/sound/pci/ctxfi/ctatc.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File    ctatc.c
> diff --git a/sound/pci/ctxfi/ctatc.h b/sound/pci/ctxfi/ctatc.h
> index ac31b32b277b..0bc7b71d910b 100644
> --- a/sound/pci/ctxfi/ctatc.h
> +++ b/sound/pci/ctxfi/ctatc.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctatc.h
> diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
> index 4cb47b5a792c..f589da045342 100644
> --- a/sound/pci/ctxfi/ctdaio.c
> +++ b/sound/pci/ctxfi/ctdaio.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctdaio.c
> diff --git a/sound/pci/ctxfi/ctdaio.h b/sound/pci/ctxfi/ctdaio.h
> index 431583bb0a3e..bd6310f48013 100644
> --- a/sound/pci/ctxfi/ctdaio.h
> +++ b/sound/pci/ctxfi/ctdaio.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctdaio.h
> diff --git a/sound/pci/ctxfi/cthardware.h b/sound/pci/ctxfi/cthardware.h
> index 9e6b83bd432d..f406b626a28c 100644
> --- a/sound/pci/ctxfi/cthardware.h
> +++ b/sound/pci/ctxfi/cthardware.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	cthardware.h
> diff --git a/sound/pci/ctxfi/cthw20k1.h b/sound/pci/ctxfi/cthw20k1.h
> index b7cbe82d71bd..ffb019abf651 100644
> --- a/sound/pci/ctxfi/cthw20k1.h
> +++ b/sound/pci/ctxfi/cthw20k1.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	cthw20k1.h
> diff --git a/sound/pci/ctxfi/cthw20k2.h b/sound/pci/ctxfi/cthw20k2.h
> index 797b13dcd84c..6993a3d5277a 100644
> --- a/sound/pci/ctxfi/cthw20k2.h
> +++ b/sound/pci/ctxfi/cthw20k2.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	cthw20k2.h
> diff --git a/sound/pci/ctxfi/ctimap.h b/sound/pci/ctxfi/ctimap.h
> index 79bc94bce4d5..49b1bb831410 100644
> --- a/sound/pci/ctxfi/ctimap.h
> +++ b/sound/pci/ctxfi/ctimap.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctimap.h
> diff --git a/sound/pci/ctxfi/ctmixer.h b/sound/pci/ctxfi/ctmixer.h
> index 770dc18a85e8..e812f6c93b41 100644
> --- a/sound/pci/ctxfi/ctmixer.h
> +++ b/sound/pci/ctxfi/ctmixer.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctmixer.h
> diff --git a/sound/pci/ctxfi/ctpcm.h b/sound/pci/ctxfi/ctpcm.h
> index dfa1c62f7d1e..8b39bdd262b4 100644
> --- a/sound/pci/ctxfi/ctpcm.h
> +++ b/sound/pci/ctxfi/ctpcm.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctpcm.h
> diff --git a/sound/pci/ctxfi/ctresource.c b/sound/pci/ctxfi/ctresource.c
> index 6d0a01b189e1..81ad26934518 100644
> --- a/sound/pci/ctxfi/ctresource.c
> +++ b/sound/pci/ctxfi/ctresource.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctresource.c
> diff --git a/sound/pci/ctxfi/ctresource.h b/sound/pci/ctxfi/ctresource.h
> index 93e47488a1c1..fdbfd808816d 100644
> --- a/sound/pci/ctxfi/ctresource.h
> +++ b/sound/pci/ctxfi/ctresource.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctresource.h
> diff --git a/sound/pci/ctxfi/ctsrc.c b/sound/pci/ctxfi/ctsrc.c
> index 37c18ce84974..bd4697b44233 100644
> --- a/sound/pci/ctxfi/ctsrc.c
> +++ b/sound/pci/ctxfi/ctsrc.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctsrc.c
> diff --git a/sound/pci/ctxfi/ctsrc.h b/sound/pci/ctxfi/ctsrc.h
> index 1204962280c8..1124daf50c9b 100644
> --- a/sound/pci/ctxfi/ctsrc.h
> +++ b/sound/pci/ctxfi/ctsrc.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File	ctsrc.h
> diff --git a/sound/pci/ctxfi/ctvmem.c b/sound/pci/ctxfi/ctvmem.c
> index bde28aa9e139..7a805c4a58e1 100644
> --- a/sound/pci/ctxfi/ctvmem.c
> +++ b/sound/pci/ctxfi/ctvmem.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File    ctvmem.c
> diff --git a/sound/pci/ctxfi/ctvmem.h b/sound/pci/ctxfi/ctvmem.h
> index 54818a3c245d..da54cbcdb0be 100644
> --- a/sound/pci/ctxfi/ctvmem.h
> +++ b/sound/pci/ctxfi/ctvmem.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/**
> +/*
>   * Copyright (C) 2008, Creative Technology Ltd. All Rights Reserved.
>   *
>   * @File    ctvmem.h
> 


-- 
~Randy

