Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E743E9E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhHLGTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:19:17 -0400
Received: from verein.lst.de ([213.95.11.211]:43000 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233076AbhHLGTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:19:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6B1368AFE; Thu, 12 Aug 2021 08:18:39 +0200 (CEST)
Date:   Thu, 12 Aug 2021 08:18:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Sandeen <sandeen@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] WARNING in internal_create_group
Message-ID: <20210812061839.GA26497@lst.de>
References: <000000000000bd7c8a05c719ecf2@google.com> <20210721033703.949-1-hdanton@sina.com> <20210721043034.GB7444@lst.de> <39ac87a8-42ac-acf7-11eb-ba0b6a9f4a95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ac87a8-42ac-acf7-11eb-ba0b6a9f4a95@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 12:37:08AM +0300, Pavel Skripkin wrote:
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1725,7 +1725,17 @@ static int nbd_dev_add(int index)
>  	refcount_set(&nbd->refs, 1);
>  	INIT_LIST_HEAD(&nbd->list);
>  	disk->major = NBD_MAJOR;
> +
> +	/* Too big first_minor can cause duplicate creation of
> +	 * sysfs files/links, since first_minor will be truncated to
> +	 * byte in __device_add_disk().
> +	 */
>  	disk->first_minor = index << part_shift;
> +	if (disk->first_minor > 0xff) {
> +		err = -EINVAL;
> +		goto out_free_idr;
> +	}
> +
>  	disk->minors = 1 << part_shift;
>  	disk->fops = &nbd_fops;
>  	disk->private_data = nbd;
>
>
> What to do you think about it?

This sounds reasonable and looks good to me.
