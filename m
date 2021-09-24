Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC9841788A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbhIXQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 12:33:19 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:46988 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244892AbhIXQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:33:18 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8671F183E9A69;
        Fri, 24 Sep 2021 16:31:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id DA7302550F1;
        Fri, 24 Sep 2021 16:31:42 +0000 (UTC)
Message-ID: <4ec51e7e259aef975626edf95107fea4736ea8e8.camel@perches.com>
Subject: Re: [PATCH 3/3] fs/ntfs3: Refactoring of ntfs_set_ea
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 24 Sep 2021 09:31:41 -0700
In-Reply-To: <cb84627e-ff9c-1945-ea53-89d66e13406b@paragon-software.com>
References: <eb131ee0-3e89-da58-650c-5b84dd792a49@paragon-software.com>
         <cb84627e-ff9c-1945-ea53-89d66e13406b@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3ij1nfqzkxzszfdp7pe6gjy6g4mzb7t7
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: DA7302550F1
X-Spam-Status: No, score=2.60
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Z45sQdHU0BFqVzOnaeLWa9AURy1wUmRQ=
X-HE-Tag: 1632501102-150301
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-24 at 19:16 +0300, Konstantin Komarov wrote:
> Make code more readable.
> Don't try to read zero bytes.
> Add warning when size of exteneded attribute exceeds limit.
[]
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
[]
> @@ -366,21 +368,22 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
[]
> +	ea_info.size = cpu_to_le32(size);
> +
> +	/*
> +	 * 1. Check ea_info.size_pack for overflow.
> +	 * 2. New attibute size must fit value from $AttrDef
> +	 */
> +	if (new_pack > 0xffff || size > sbi->ea_max_size) {
> +		ntfs_inode_warn(
> +			inode,
> +			"The size of exteneded attributes must not exceed 64K");

trivial typo of extended.  Pedants might suggest KiB.


