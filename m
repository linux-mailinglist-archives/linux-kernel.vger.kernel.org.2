Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A67335102B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhDAHgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:36:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:46608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232951AbhDAHfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:35:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78C66AF32;
        Thu,  1 Apr 2021 07:35:41 +0000 (UTC)
Date:   Thu, 1 Apr 2021 09:35:40 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Chao Leng <lengchao@huawei.com>,
        Victor Gladkov <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
Message-ID: <20210401073540.6tsv2ib3fapnglqo@beryllium.lan>
References: <20210331131228.131118-1-dwagner@suse.de>
 <BYAPR04MB49658F0DDA22B253F98C6F3A867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49658F0DDA22B253F98C6F3A867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chaitanya,

On Wed, Mar 31, 2021 at 08:34:31PM +0000, Chaitanya Kulkarni wrote:
> >   WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
> 
> For now keep the current style.

Okay, I thought so too. I am just wondering if a patch for changing all
the permission sets is acceptable. I prefer the the octal permissions ;)

> > +static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> > +
> > +	if (ctrl->opts->fast_io_fail_tmo == -1)
> > +		return sprintf(buf, "off\n");
> > +	return sprintf(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
> 
> do we need snprintf() for 2nd ?

Sure thing can do. Also here I followed the existing style. The other
store functions tend to use sprintf().

> > +	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
> > +	if (err)
> > +		return -EINVAL;
> > +
> 
> since you are returning an error, you can remove next else if, this also
> removes the extra line after above return. Something like this on the top
> of yours totally untested :-

Right, same here, followed the existing style. I prepare a patch which
addresses your comments for the existing code as well.

Thanks,
Daniel
