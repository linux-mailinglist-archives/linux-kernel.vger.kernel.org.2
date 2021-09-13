Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975E0409A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbhIMQyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:54:05 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:58552 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238466AbhIMQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:54:04 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id C1D4C8226C;
        Mon, 13 Sep 2021 19:52:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1631551967;
        bh=PDgIp30dcU6oTi9tvqsbgLoR0+LbWe2UZNzoDH8i1fo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NSFEEpjHDDLBjONE8Iqkops8Lr3x3oGzzR6jFP8zLQMFYLgSvIAFoen65pB/EIkJc
         /CuZmX3S2KEZ7DDg56IQ5S2NpzbY2Uiim3QwdMUN3rhflw2xrsVq+h5wYckpNHCoJl
         2jYS2S9NyCUl8AeDZ7TKsE17DJYmkQCwOnw1bqh0=
Received: from [192.168.211.103] (192.168.211.103) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 13 Sep 2021 19:52:47 +0300
Message-ID: <babdd096-38e2-6cab-3326-3d2c97332980@paragon-software.com>
Date:   Mon, 13 Sep 2021 19:52:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/8] fs/ntfs3: Refactor header includes
Content-Language: en-US
To:     Kari Argillander <kari.argillander@gmail.com>,
        <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>
References: <20210902161528.6262-1-kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20210902161528.6262-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.103]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.09.2021 19:15, Kari Argillander wrote:
> Right now header includes are big mess with ntfs3 imo. We cannot example
> include ntfs3 headers without need of punch of includes to source file.
> This patch set try to address that. When this patch series is applied we
> can include any header file without need of include anything else. This
> does not mean source file should rely what header file includes. Instead
> it should include them by self also if it needs them.
> 
> When some include is added I have write why this is needed to commit
> message. Hopefully this will help when someone wants to correct them
> again. I have also just delete unnecessary headers from some .c files
> and not added what is needed. Usually deleted headers where there
> because ntfs_fs.h need them not file itself. When file was simple enough
> I added all necessary linux headers.
> 
> I did not add linux/headers to all files yet. That is big job. This is
> good starting point. I did try to build every file itself so this will
> build like it should.
> 
> Please do not hesitate to tell if there is something wrong with this
> series or somethings could be done better.
> 
> V2:
> 	Add missing first patch
> 	Rebase
> 	Use base-commit with format-patch
> 
> Kari Argillander (8):
>   fs/ntfs3. Add forward declarations for structs to debug.h
>   fs/ntfs3: Add missing header files to ntfs.h
>   fs/ntfs3: Add missing headers and forward declarations to ntfs_fs.h
>   fs/ntfs3: Add missing header and guards to lib/ headers
>   fs/ntfs3: Change right headers to bitfunc.c
>   fs/ntfs3: Change right headers to upcase.c
>   fs/ntfs3: Change right headers to lznt.c
>   fs/ntfs3: Remove unneeded header files from c files
> 
>  fs/ntfs3/attrib.c                |  5 -----
>  fs/ntfs3/attrlist.c              |  3 ---
>  fs/ntfs3/bitfunc.c               |  7 +------
>  fs/ntfs3/bitmap.c                |  3 ---
>  fs/ntfs3/debug.h                 |  3 +++
>  fs/ntfs3/dir.c                   |  3 ---
>  fs/ntfs3/file.c                  |  1 -
>  fs/ntfs3/frecord.c               |  3 ---
>  fs/ntfs3/fslog.c                 |  4 ----
>  fs/ntfs3/fsntfs.c                |  1 -
>  fs/ntfs3/index.c                 |  1 -
>  fs/ntfs3/inode.c                 |  2 --
>  fs/ntfs3/lib/decompress_common.h |  5 +++++
>  fs/ntfs3/lib/lib.h               |  6 ++++++
>  fs/ntfs3/lznt.c                  | 10 +++++-----
>  fs/ntfs3/namei.c                 |  4 ----
>  fs/ntfs3/ntfs.h                  |  9 +++++++++
>  fs/ntfs3/ntfs_fs.h               | 31 +++++++++++++++++++++++++++++++
>  fs/ntfs3/record.c                |  3 ---
>  fs/ntfs3/run.c                   |  2 --
>  fs/ntfs3/super.c                 |  2 --
>  fs/ntfs3/upcase.c                |  8 ++------
>  fs/ntfs3/xattr.c                 |  3 ---
>  23 files changed, 62 insertions(+), 57 deletions(-)
> 
> 
> base-commit: d3624466b56dd5b1886c1dff500525b544c19c83
> 

Hi Kari!

Thanks for work - applied!
