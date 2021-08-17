Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8879E3EF603
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 01:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhHQXMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 19:12:45 -0400
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:55966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229466AbhHQXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:12:44 -0400
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9D511837F24A;
        Tue, 17 Aug 2021 23:12:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 385B81D42FA;
        Tue, 17 Aug 2021 23:12:09 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 17 Aug 2021 16:12:08 -0700
From:   Joe Perches <joe@perches.com>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/ntfs3: Use kcalloc/kmalloc_array over
 kzalloc/kmalloc
In-Reply-To: <20210817193815.307182-4-kari.argillander@gmail.com>
References: <20210817193815.307182-1-kari.argillander@gmail.com>
 <20210817193815.307182-4-kari.argillander@gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <ef1d002a0720ace0ed8dd79c2ac3c600@perches.com>
X-Sender: joe@perches.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.49
X-Stat-Signature: swyfssfb7ah5sa7nde56bws168e185bh
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 385B81D42FA
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19OIv/oxDy8QFR48+FXAV3FI4jvd0nPIaw=
X-HE-Tag: 1629241929-872911
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 12:38, Kari Argillander wrote:
> Use kcalloc/kmalloc_array over kzalloc/kmalloc when we allocate array.
> Checkpatch found these after we did not use our own defined allocation
> wrappers.
[]
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
[]
> @@ -900,7 +900,7 @@ static ssize_t ntfs_compress_write(struct kiocb
> *iocb, struct iov_iter *from)
>  		return -EOPNOTSUPP;
>  	}
> 
> -	pages = kmalloc(pages_per_frame * sizeof(struct page *), GFP_NOFS);
> +	pages = kcalloc(pages_per_frame, sizeof(struct page *), GFP_NOFS);

This is not an exact transformation.
This allocates zeroed memory.
Use kmalloc_array here instead.
