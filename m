Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341293FD172
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbhIACl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:41:59 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:51820 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231613AbhIACl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:41:58 -0400
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2F702100E7B45;
        Wed,  1 Sep 2021 02:41:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 6A68B13D97;
        Wed,  1 Sep 2021 02:41:00 +0000 (UTC)
Message-ID: <5197939870d1867dd2131a8fdff8842b777c6016.camel@perches.com>
Subject: Re: [PATCH 1/5] fs/ntfs3: Use kmalloc_array over kmalloc with
 multiply
From:   Joe Perches <joe@perches.com>
To:     Kari Argillander <kari.argillander@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 31 Aug 2021 19:40:58 -0700
In-Reply-To: <20210831181505.1074767-2-kari.argillander@gmail.com>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
         <20210831181505.1074767-2-kari.argillander@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=6.31
X-Stat-Signature: ocpfoi6u79nnsuqi3qfgc1bwhd7u4rmf
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 6A68B13D97
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18uSKCNe+O15Z6+tqeiXjSvmPXVWSJxc2w=
X-HE-Tag: 1630464060-919141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-31 at 21:15 +0300, Kari Argillander wrote:
> If we do not use kmalloc_array we get checkpatch warning. It is also
> little safer if something goes wrong with coding.
[]
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
[]
> @@ -707,7 +707,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
>  		u16 *ptr;
>  		int new_slots = ALIGN(2 * nslots, 8);
>  
> 
> -		ptr = kmalloc(sizeof(u16) * new_slots, GFP_NOFS);
> +		ptr = kmalloc_array(new_slots, sizeof(u16), GFP_NOFS);
>  		if (ptr)
>  			memcpy(ptr, offs, sizeof(u16) * max_idx);

This multiplication could also overflow.

Maybe use krealloc?


