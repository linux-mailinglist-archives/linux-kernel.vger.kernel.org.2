Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA953FE85B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 06:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhIBEXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 00:23:20 -0400
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:44804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229536AbhIBEXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 00:23:19 -0400
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6D5B1299A1;
        Thu,  2 Sep 2021 04:22:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 94D59B2795;
        Thu,  2 Sep 2021 04:22:20 +0000 (UTC)
Message-ID: <1d303f4553e67abee4f0c4cdc32231813a4bcb3f.camel@perches.com>
Subject: Re: [PATCH 2/5] fs/ntfs3: Use consistent spacing around '+'
From:   Joe Perches <joe@perches.com>
To:     Kari Argillander <kari.argillander@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 01 Sep 2021 21:22:19 -0700
In-Reply-To: <20210831181505.1074767-3-kari.argillander@gmail.com>
References: <20210831181505.1074767-1-kari.argillander@gmail.com>
         <20210831181505.1074767-3-kari.argillander@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.41
X-Stat-Signature: 6ywud8xu4eygy654qqjibymws8n1m811
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 94D59B2795
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19sh78KRiSh5KevcMk8MxvtAdMM0b+8bpY=
X-HE-Tag: 1630556540-782866
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-31 at 21:15 +0300, Kari Argillander wrote:
> Use consistent spacing around '+' for better code reading. Checkpatch
> will also be happy.

I think you should remove the + instead

> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
[]
> @@ -1451,7 +1451,7 @@ int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
>  		attr->res.flags = RESIDENT_FLAG_INDEXED;
>  
> 
>  		/* is_attr_indexed(attr)) == true */
> -		le16_add_cpu(&ni->mi.mrec->hard_links, +1);
> +		le16_add_cpu(&ni->mi.mrec->hard_links, + 1);

		le16_add_cpu(&ni->mi.mrec->hard_links, 1);


