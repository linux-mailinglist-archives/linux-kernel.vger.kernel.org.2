Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E53389723
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhEST7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:59:14 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:38792 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhEST7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:59:10 -0400
Received: by mail-pl1-f176.google.com with SMTP id 69so7676842plc.5;
        Wed, 19 May 2021 12:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ye6B2Mg3FnnXaKb9M8n5F28Q2Kx9wSYWuGuUQsghp/c=;
        b=ocjYioAN0eaX267+zJuqI1HUDzaT1sLMbdLxDgDGrMuBxTB8zL0XMw+yGsdCyTcLEz
         pJfn0y5185yqa/s7eWd1IpPMuIkduPWpLxAzONYTTnWs/9n7e8wrRJyiie8G+0gufGZz
         beZqUYpVjDC9rN9/KwUTxjg0fXBBXBOaJc5PhMUB2oNIVIV6q9NkU8TUXqvpYJd53zeE
         7z7tEW58C3p/Ph1KGOVsixsjBsUeFRzQndYlOBEY5252xOWRida0s+JjLOANctwOsrpc
         o2SXQhCaK87HGbBnphGkdGS/4Ae+VmWs+YoKG3pejNVlFWvjo9TstPI62Azt6V4dQp4u
         chrg==
X-Gm-Message-State: AOAM532kEnTYCcpxja6XoXBtXOoiqFTx6Rx+TwqvhAeCULsU5jYQkHCZ
        LVpEpDr1BEcawKYZRGraH80=
X-Google-Smtp-Source: ABdhPJzi5Cw65WIz3Pny24uTwGtgUWorOHFBTN4uLW0DqWpiLoByp4FgN4fGEhFqnJ4gr4YckHBtxQ==
X-Received: by 2002:a17:90a:de16:: with SMTP id m22mr1039091pjv.60.1621454270555;
        Wed, 19 May 2021 12:57:50 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u12sm180554pfh.122.2021.05.19.12.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:57:49 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2FEF640321; Wed, 19 May 2021 19:57:49 +0000 (UTC)
Date:   Wed, 19 May 2021 19:57:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] null_blk: add error handling support for
 add_disk()
Message-ID: <20210519195749.GT4332@42.do-not-panic.com>
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-8-mcgrof@kernel.org>
 <842b6a8d-8880-a0da-a38b-39378dc6ebb9@suse.de>
 <20210512164709.GA4332@42.do-not-panic.com>
 <d519b9ce-ad28-a266-786f-4128e0b91b9f@suse.de>
 <20210512172039.GQ4332@42.do-not-panic.com>
 <096c9d6f-b765-ab70-098e-ab64d8b411df@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <096c9d6f-b765-ab70-098e-ab64d8b411df@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 07:28:16PM +0200, Hannes Reinecke wrote:
> On 5/12/21 7:20 PM, Luis Chamberlain wrote:
> > On Wed, May 12, 2021 at 07:12:03PM +0200, Hannes Reinecke wrote:
> > > On 5/12/21 6:47 PM, Luis Chamberlain wrote:
> > > > On Wed, May 12, 2021 at 05:16:39PM +0200, Hannes Reinecke wrote:
> > > > > On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> > > > > > We never checked for errors on add_disk() as this function
> > > > > > returned void. Now that this is fixed, use the shiny new
> > > > > > error handling.
> > > > > > 
> > > > > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > > > > ---
> > > > > >     drivers/block/null_blk/main.c | 9 +++++++--
> > > > > >     1 file changed, 7 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> > > > > > index 5f006d9e1472..2346d1292b26 100644
> > > > > > --- a/drivers/block/null_blk/main.c
> > > > > > +++ b/drivers/block/null_blk/main.c
> > > > > > @@ -1699,6 +1699,7 @@ static int init_driver_queues(struct nullb *nullb)
> > > > > >     static int null_gendisk_register(struct nullb *nullb)
> > > > > >     {
> > > > > > +	int ret;
> > > > > >     	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
> > > > > >     	struct gendisk *disk;
> > > > > > @@ -1719,13 +1720,17 @@ static int null_gendisk_register(struct nullb *nullb)
> > > > > >     	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
> > > > > >     	if (nullb->dev->zoned) {
> > > > > > -		int ret = null_register_zoned_dev(nullb);
> > > > > > +		ret = null_register_zoned_dev(nullb);
> > > > > >     		if (ret)
> > > > > >     			return ret;
> > > > > >     	}
> > > > > > -	add_disk(disk);
> > > > > > +	ret = add_disk(disk);
> > > > > > +	if (ret) {
> > > > > 
> > > > > unregister_zoned_device() ?
> > > > 
> > > > That function does not exist, do you mean null_free_zoned_dev()? If so
> > > > that is done by the caller.
> > > > 
> > > What I intended to say is that you are calling 'null_register_zoned_dev()'
> > > at one point, but don't call a cleanup function if there is an error later
> > > in the path, leaving the caller to guess whether null_register_zoned_dev()
> > > has been called or not.
> > > So we should call the cleanup function here, too.
> > 
> > The cleanup for zone stuff is done on the caller.
> > 
> My point being: how does he know?

The person who is maintainer of the code would.

> The zone stuff might or might not be initialized.
> Why not do the cleanup action in the error path of this function?

Because its not currently allocated in that function, its done in
the caller function.

  Luis
