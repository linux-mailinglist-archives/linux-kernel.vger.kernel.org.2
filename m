Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B9D3FF16C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbhIBQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:32:10 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:46764 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346324AbhIBQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:32:09 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 705B21D99;
        Thu,  2 Sep 2021 19:31:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630600269;
        bh=0PEs+2tQ7ZmF73BqpIRvwTSI41YUXcuWRwtZTt/Qn28=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tz27rhaHmItyR6Lkxnwqq/S/fZ9+iwCXsW7woLRSuA7nDqSeASdXncFLfQ1ad6D7h
         eFKD2vFh4yRKHIj1FCMOE/Sw8yneF1Qb2vu9UWLCs98K2P7/H3+ZN+Y3j1aZIfyFeM
         8TdNtKTKcz/SZn7DehY7Bonw8uwUwWtLVarDVwQ0=
Received: from [192.168.211.59] (192.168.211.59) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 2 Sep 2021 19:31:09 +0300
Subject: Re: [PATCH] fs/ntfs3: Remove GPL boilerplates from decompress lib
 files
To:     Kari Argillander <kari.argillander@gmail.com>,
        <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>
References: <20210826214441.1614837-1-kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Message-ID: <e90b9068-2b23-0a6d-944b-c8eab7cf5107@paragon-software.com>
Date:   Thu, 2 Sep 2021 19:31:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210826214441.1614837-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.59]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.08.2021 00:44, Kari Argillander wrote:
> Files already have SDPX identifier so no reason to keep boilerplates in
> these files anymore.
> 
> CC: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
> This is probably ok to you Eric just wanted to make sure and be polite.
> ---
>  fs/ntfs3/lib/decompress_common.c | 13 -------------
>  fs/ntfs3/lib/decompress_common.h | 14 --------------
>  fs/ntfs3/lib/lzx_decompress.c    | 13 -------------
>  fs/ntfs3/lib/xpress_decompress.c | 13 -------------
>  4 files changed, 53 deletions(-)
> 
> diff --git a/fs/ntfs3/lib/decompress_common.c b/fs/ntfs3/lib/decompress_common.c
> index 83c9e93aea77..09e9e6544946 100644
> --- a/fs/ntfs3/lib/decompress_common.c
> +++ b/fs/ntfs3/lib/decompress_common.c
> @@ -3,19 +3,6 @@
>   * decompress_common.c - Code shared by the XPRESS and LZX decompressors
>   *
>   * Copyright (C) 2015 Eric Biggers
> - *
> - * This program is free software: you can redistribute it and/or modify it under
> - * the terms of the GNU General Public License as published by the Free Software
> - * Foundation, either version 2 of the License, or (at your option) any later
> - * version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
> - * details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #include "decompress_common.h"
> diff --git a/fs/ntfs3/lib/decompress_common.h b/fs/ntfs3/lib/decompress_common.h
> index 66297f398403..2d70ae42f1b5 100644
> --- a/fs/ntfs3/lib/decompress_common.h
> +++ b/fs/ntfs3/lib/decompress_common.h
> @@ -1,22 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
> -
>  /*
>   * decompress_common.h - Code shared by the XPRESS and LZX decompressors
>   *
>   * Copyright (C) 2015 Eric Biggers
> - *
> - * This program is free software: you can redistribute it and/or modify it under
> - * the terms of the GNU General Public License as published by the Free Software
> - * Foundation, either version 2 of the License, or (at your option) any later
> - * version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
> - * details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #include <linux/string.h>
> diff --git a/fs/ntfs3/lib/lzx_decompress.c b/fs/ntfs3/lib/lzx_decompress.c
> index 77a381a693d1..6b16f07073c1 100644
> --- a/fs/ntfs3/lib/lzx_decompress.c
> +++ b/fs/ntfs3/lib/lzx_decompress.c
> @@ -6,19 +6,6 @@
>   * this is the only size used in System Compression.
>   *
>   * Copyright (C) 2015 Eric Biggers
> - *
> - * This program is free software: you can redistribute it and/or modify it under
> - * the terms of the GNU General Public License as published by the Free Software
> - * Foundation, either version 2 of the License, or (at your option) any later
> - * version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
> - * details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #include "decompress_common.h"
> diff --git a/fs/ntfs3/lib/xpress_decompress.c b/fs/ntfs3/lib/xpress_decompress.c
> index 3d98f36a981e..769c6d3dde67 100644
> --- a/fs/ntfs3/lib/xpress_decompress.c
> +++ b/fs/ntfs3/lib/xpress_decompress.c
> @@ -5,19 +5,6 @@
>   * based on the code from wimlib.
>   *
>   * Copyright (C) 2015 Eric Biggers
> - *
> - * This program is free software: you can redistribute it and/or modify it under
> - * the terms of the GNU General Public License as published by the Free Software
> - * Foundation, either version 2 of the License, or (at your option) any later
> - * version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> - * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
> - * details.
> - *
> - * You should have received a copy of the GNU General Public License along with
> - * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
>  #include "decompress_common.h"
> 

Hi, Kari, Eric!

Applied, thanks!
