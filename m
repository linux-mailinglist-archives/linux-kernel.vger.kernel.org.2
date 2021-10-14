Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7418742D004
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJNBsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhJNBsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:48:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5469960E78;
        Thu, 14 Oct 2021 01:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634175966;
        bh=tua+i/uJvDkd/ZtFDkoqVbra2yWlOooBf2r2SG+eGKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+9z2m9wTvKTY6lWS16h6yybTBuwTAZdeEvVgdwQwr+8rOhFKhvXt/C3L71ziMzi4
         pe9PAadvDGR0W7Ct7B17451hZIJ5J1bojQ0/Sh2BW5SJrll2mojz6rKLhWiFrhlvCI
         plmAxHJi1maoiie0XASFiZxFGkz9QCH3LcVKsIEz0od1adpPHbtvsFmOpYhym4KOJX
         rUV8mcTIXSDAewVsUbvPDau0snmnUXzNU6WqPvk+iXDcAxLYVljCigXXIqlI4oJBLS
         ddBqVpUhg7RGgcgdUbYcu38VYFe3UUgaasj8+yEjX0wAQc135qz5ja0GOF+lGskNs/
         vsZt5/PGPIGew==
Date:   Thu, 14 Oct 2021 09:45:49 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Lasse Collin <lasse.collin@tukaani.org>,
        Chao Yu <chao@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] erofs: add LZMA compression support
Message-ID: <20211014014548.GA14439@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Lasse Collin <lasse.collin@tukaani.org>, Chao Yu <chao@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211010213145.17462-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 05:31:38AM +0800, Gao Xiang wrote:

...

> 
> 
> Hi Andrew,
> 
> Some XZ embedded (lib/xz) patches by Lasse are sent out together in this series
> although they're irrelevant to MicroLZMA but quite coupled. Can I send a pull
> request together with EROFS LZMA support for 5.16 then? Many thanks in advance!

ping.. I've tested EROFS LZMA support with my own ro_fsstress. I'd like to
apply them into -next for wider integration tests even though MicroLZMA
itself is relatively independent decoder (it mainly calls raw LZMA decoding
functions) thus it should not impact all the current users.

Thanks,
Gao Xiang


> 
> Thanks,
> Gao Xiang
> 
> 
> Gao Xiang (2):
>   erofs: rename some generic methods in decompressor
>   erofs: lzma compression support
> 
> Lasse Collin (5):
>   lib/xz: Avoid overlapping memcpy() with invalid input with in-place
>     decompression
>   lib/xz: Validate the value before assigning it to an enum variable
>   lib/xz: Move s->lzma.len = 0 initialization to lzma_reset()
>   lib/xz: Add MicroLZMA decoder
>   lib/xz, lib/decompress_unxz.c: Fix spelling in comments
> 
>  fs/erofs/Kconfig             |  16 ++
>  fs/erofs/Makefile            |   1 +
>  fs/erofs/compress.h          |  16 ++
>  fs/erofs/decompressor.c      |  73 +++++----
>  fs/erofs/decompressor_lzma.c | 290 +++++++++++++++++++++++++++++++++++
>  fs/erofs/erofs_fs.h          |  14 +-
>  fs/erofs/internal.h          |  22 +++
>  fs/erofs/super.c             |  17 +-
>  fs/erofs/zdata.c             |   4 +-
>  fs/erofs/zdata.h             |   7 -
>  fs/erofs/zmap.c              |   5 +-
>  include/linux/xz.h           | 106 +++++++++++++
>  lib/decompress_unxz.c        |  10 +-
>  lib/xz/Kconfig               |  13 ++
>  lib/xz/xz_dec_lzma2.c        | 182 +++++++++++++++++++++-
>  lib/xz/xz_dec_stream.c       |   6 +-
>  lib/xz/xz_dec_syms.c         |   9 +-
>  lib/xz/xz_private.h          |   3 +
>  18 files changed, 725 insertions(+), 69 deletions(-)
>  create mode 100644 fs/erofs/decompressor_lzma.c
> 
> -- 
> 2.20.1
> 
