Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6373796E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhEJSRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 14:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231577AbhEJSRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 14:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620670587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ao0m3qiHQNSe4HT7iJWrIcrYiJRaXz4VOGXopwkJ7Mw=;
        b=OiICfiQbDPdVFDY/LI5YdUyRwFP+LW2W5PKT8yNZPQt1dRVfoZb/s+MOvcPex7Xg7iMlsS
        aAQgdd0WU8srEP/UAaD+AMYrRI4RoRDextSonFmyvtUEVgJv/xJifhb2f51fX2/RgPLZa0
        A+E+Fd1dVn5K5zfc5XR+Amk3ZxdNd94=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-obK8MT4-NTyR6eghOdBcCQ-1; Mon, 10 May 2021 14:16:26 -0400
X-MC-Unique: obK8MT4-NTyR6eghOdBcCQ-1
Received: by mail-qt1-f198.google.com with SMTP id j12-20020ac8550c0000b02901dae492d1f2so4936542qtq.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 11:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ao0m3qiHQNSe4HT7iJWrIcrYiJRaXz4VOGXopwkJ7Mw=;
        b=nAyW9oIPnsZNcWsRQosgQtHcuf/NPZgDLK/EuQ2L5JrUmvvdyW1DNqkJjGyTLzyrnv
         7tsEjsBm3Bu4B7PRx47mDgb/jG7V33SdNLFnm8Lv82iZj4urAYWFxqxG4FGh1L0R43Oh
         ZL9049IpNLc8o3b+RLXTskv9tbbCWa+nNDCBplFNU8sq19hXN5YhUWjSMIv2YqjzJA5r
         Z1kVvQoWs8mLKJ/38ZCZlFwgH9HSImeC9Kqr/Drt55FIZEnjSMckOoyWHg7CzPtWqpkt
         STrieX8U2DDyqC+eb5mfpVvhUbUpAuv/UkduOUQjej879sXn518syINZyeZdg8k/232c
         2NAQ==
X-Gm-Message-State: AOAM5329ZXIakf8lHSjadr91pqutFJh8ERcESHJOre+NBHpxYrsPp3tw
        L+NJnWWopQNE9ELz51qZiMXXQdgeW1XHr2W5aEMMjeic8prr82gQIZfp0DrIFkZfpza4uRLdq12
        DHmLr2td1ojtOtFYgfHYG5IYI
X-Received: by 2002:a05:622a:1d1:: with SMTP id t17mr23869844qtw.267.1620670585797;
        Mon, 10 May 2021 11:16:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx09Q4QJnreTI0TPGe4ZrkldzJYBzrhDZmCISV5l1LSco4BzbaJnyw4UNwNIeUdGJq/oqD9A==
X-Received: by 2002:a05:622a:1d1:: with SMTP id t17mr23869831qtw.267.1620670585617;
        Mon, 10 May 2021 11:16:25 -0700 (PDT)
Received: from horse (pool-173-76-174-238.bstnma.fios.verizon.net. [173.76.174.238])
        by smtp.gmail.com with ESMTPSA id j196sm12135152qke.25.2021.05.10.11.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 11:16:25 -0700 (PDT)
Date:   Mon, 10 May 2021 14:16:23 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH 1/2] virtiofs, dax: Fix smatch warning about loss of info
 during shift
Message-ID: <20210510181623.GA185367@horse>
References: <20210506184304.321645-1-vgoyal@redhat.com>
 <20210506184304.321645-2-vgoyal@redhat.com>
 <YJQ+ex2DUPYo1GV5@work-vm>
 <20210506193517.GF388843@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506193517.GF388843@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 12:35:17PM -0700, Matthew Wilcox wrote:
> On Thu, May 06, 2021 at 08:07:39PM +0100, Dr. David Alan Gilbert wrote:
> > > @@ -186,7 +186,7 @@ static int fuse_setup_one_mapping(struct inode *inode, unsigned long start_idx,
> > >  	struct fuse_conn_dax *fcd = fm->fc->dax;
> > >  	struct fuse_inode *fi = get_fuse_inode(inode);
> > >  	struct fuse_setupmapping_in inarg;
> > > -	loff_t offset = start_idx << FUSE_DAX_SHIFT;
> > > +	loff_t offset = (loff_t)start_idx << FUSE_DAX_SHIFT;
> > 
> > I've not followed the others back, but isn't it easier to change
> > the start_idx parameter to be a loff_t, since the places it's called
> > from are poth loff_t pos?
> 
> But an index isn't a file offset, and shouldn't be typed as such.

Agreed. This is index, so it seems better to not use "loff_t" to
represent it.

Vivek

