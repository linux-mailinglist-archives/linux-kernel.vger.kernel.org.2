Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F822314B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBIJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229799AbhBIJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612862610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVmWIv//iucXq6uCAj+vo+FMJ8H4hs+IHQRTElKDAL8=;
        b=eBQC/mMVGpdRzBF6OYXK0aykXOHi6vzaFfEy3pkhLE6n5zLQlFzp833wiB3qBYtoTw6X/7
        TrmPOriiu1SOj3KmIRuWvCYgSyts9KeQHefgEhKXwjLvkGClwkxdJHhwpUvP+jlkdE3ZiI
        5mO4EsEVLVn/M05aCb0jubNDBA39FX8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-bTrr6ANwOmGAj-A9TG9bNg-1; Tue, 09 Feb 2021 04:23:28 -0500
X-MC-Unique: bTrr6ANwOmGAj-A9TG9bNg-1
Received: by mail-wm1-f69.google.com with SMTP id p8so2225639wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BVmWIv//iucXq6uCAj+vo+FMJ8H4hs+IHQRTElKDAL8=;
        b=UAhtVcHP+TNI4+0YnQXbegSkBZUlvfgSFrf1kW0ETWycZmbogAa+YU6vO05TMY8cgX
         fx6dd+3wz7w5++DU1zIxk+POhIYI09K34LrtdTWXEXfP1PzHYwK7J3PPCrncV0vyfyoo
         JiGKH/Q6D+3qTG7l35iur0idUKdwB0dKwCL+ssFSH2XpJdzw4eD+GAX4fwBFwqQANHjf
         LNpDX/MPCO1jaovSqzxMJW23z89CyvLAM9vPWuVl/dB3oilmQULFsdRf9xCHl2g4H7O3
         lUduzNodhkvzkA8BJlBO6dlocZbo2N+FuIgSBI3OnrDlQ9tKa0HkriIdYtHtmXxBsxoz
         qDVg==
X-Gm-Message-State: AOAM533EyafBxtc1AnuQZoAXS906xNNuVQeEtocB4YAv2KbPSlLNep7a
        VCdi41upPDHW1asaB/N/eTSNaxn4uYDQPSRRP+OS4xF5JQW0Wxp3W/UVv0SQ1OBE3wOU27n0S+b
        +Ywfwjywz4tjDmAJI4peshopZ
X-Received: by 2002:a5d:6189:: with SMTP id j9mr24283590wru.256.1612862606525;
        Tue, 09 Feb 2021 01:23:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEgCfd2YHE4LE5EhAHm3i1Bv4aGPtqQBNsL7PCyfGHd2rtLbahxTUalPUc43FnbGJPrFPd3w==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr24283573wru.256.1612862606374;
        Tue, 09 Feb 2021 01:23:26 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id t17sm3415997wmi.20.2021.02.09.01.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 01:23:25 -0800 (PST)
Date:   Tue, 9 Feb 2021 04:23:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        lulu@redhat.com, sgarzare@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
Message-ID: <20210209042000-mutt-send-email-mst@kernel.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210205103214-mutt-send-email-mst@kernel.org>
 <24cb3ebe-1248-3e31-0716-cf498cf1d728@redhat.com>
 <20210208070253-mutt-send-email-mst@kernel.org>
 <fe639f0f-d639-3c3c-e297-042127788aca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe639f0f-d639-3c3c-e297-042127788aca@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:29:46AM +0800, Jason Wang wrote:
> 
> On 2021/2/8 下午8:04, Michael S. Tsirkin wrote:
> > On Mon, Feb 08, 2021 at 01:42:27PM +0800, Jason Wang wrote:
> > > On 2021/2/5 下午11:34, Michael S. Tsirkin wrote:
> > > > On Mon, Jan 04, 2021 at 02:55:00PM +0800, Jason Wang wrote:
> > > > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > > > I don't exactly get why we need to split the modern driver out,
> > > > and it can confuse people who are used to be seeing virtio-pci.
> > > 
> > > The virtio-pci module still there. No user visible changes. Just some codes
> > > that could be shared with other driver were split out.
> > > 
> > What I am saying is this: we can have virtio-vdpa depend on
> > virtio-pci without splitting the common code out to an
> > extra module.
> 
> 
> Ok.
> 
> 
> > 
> > > > The vdpa thing so far looks like a development tool, why do
> > > > we care that it depends on a bit of extra code?
> > > 
> > > If I'm not misunderstanding, trying to share codes is proposed by you here:
> > > 
> > > https://lkml.org/lkml/2020/6/10/232
> > > 
> > > We also had the plan to convert IFCVF to use this library.
> > > 
> > > Thanks
> > If that happens then an extra module might become useful.
> 
> 
> So does it make sense that I post a new version and let's merge it first.
> Then Intel or I can convert IFCVF to use the library?
> 
> Thanks

Generally it's best if we actually have a couple of users before we bother
with refactoring - it's hard to predict the future,
so we don't really know what kind of refactoring will work for IFCVF ...

> 
> > 

