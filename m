Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC743A8C69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhFOXY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230082AbhFOXYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623799367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LXUq5cb1UWu1BCLlmGyskR+e5MH/GTRwiZlW5p72XDU=;
        b=BOIQ+Dm7T14ROLxo7sjfEcUFc4KLcXomw1jXRtsMOi5mqsWQKJd2SsQC+pHfk6dnpXKzyN
        OHo/qDigciUyNqCyF0Md//wGIQeRs8bj9co0v9CC8h6XyvfTMMse0xOj9XCl+jB1vcNOtu
        6kYHuMpmzV30lLcHtkSzmL6x48fteYA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-JuMgp5Q_PLydUx5P7m6lgQ-1; Tue, 15 Jun 2021 19:22:46 -0400
X-MC-Unique: JuMgp5Q_PLydUx5P7m6lgQ-1
Received: by mail-ot1-f69.google.com with SMTP id 59-20020a9d0dc10000b02902a57e382ca1so328412ots.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 16:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=LXUq5cb1UWu1BCLlmGyskR+e5MH/GTRwiZlW5p72XDU=;
        b=tuezHS3KiizglICkGD80pjykig6oYuKL/g++gtKUZ+fDbErh2Y3jDg+H5QC6YGBAyw
         0b9B4TNlLmMZUNQs3JHBOa6CKRCmHBBMPYt/plTvtk8ExOJg4xwhhdNNXdvw/fUGzBeE
         QXqPBzpk4iIPKdiF84LnX4h1VnLKmmIH5erCjptJCdCvhfMMsDb0mBph9LfHw+ocS11x
         Tf4EKjkk9dh8oLBPrR92r2eiHipU44uJpZFRoWeVsBhgi98LcXRJvNY5sLXJD4/Y9icN
         1mSXhHYJ839K3ZnnKMeYVvwWT2Bk81riJNN70dNCJ0wTQjYge3IvkxypxDE8KGVrb44G
         jbOw==
X-Gm-Message-State: AOAM531Cr2YQ81ilBp5yuR499S5iqSes+SNJW/DTP3750/rZFDyyDojW
        +BT6HWOXj1wqYIyVn/6/LVbfEQI5aHMK+GKVRbQ3W/zO8SpxC2iOw/ogmWNRRr2N0griRoaatfS
        F4hiKBoDLUI7/kJshSmWncNCO
X-Received: by 2002:a05:6808:1482:: with SMTP id e2mr1519064oiw.150.1623799365346;
        Tue, 15 Jun 2021 16:22:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtpMcQE3vDixojPJ646O+KOAK/rMnaA9TlvDaXP1d75MjQEzIGZCfuYwCxhBANgFA+MjDXWw==
X-Received: by 2002:a05:6808:1482:: with SMTP id e2mr1519037oiw.150.1623799365123;
        Tue, 15 Jun 2021 16:22:45 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id q6sm85178oot.40.2021.06.15.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:22:44 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:22:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>, cohuck@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        aviadye@nvidia.com, oren@nvidia.com, shahafs@nvidia.com,
        parav@nvidia.com, artemp@nvidia.com, kwankhede@nvidia.com,
        ACurrid@nvidia.com, cjia@nvidia.com, yishaih@nvidia.com,
        kevin.tian@intel.com, hch@infradead.org, targupta@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, liulongfang@huawei.com,
        yan.y.zhao@intel.com
Subject: Re: [PATCH 09/11] PCI: add matching checks for driver_override
 binding
Message-ID: <20210615172242.4b2be854.alex.williamson@redhat.com>
In-Reply-To: <20210615230017.GZ1002214@nvidia.com>
References: <20210608224517.GQ1002214@nvidia.com>
        <20210608192711.4956cda2.alex.williamson@redhat.com>
        <117a5e68-d16e-c146-6d37-fcbfe49cb4f8@nvidia.com>
        <20210614124250.0d32537c.alex.williamson@redhat.com>
        <70a1b23f-764d-8b3e-91a4-bf5d67ac9f1f@nvidia.com>
        <20210615090029.41849d7a.alex.williamson@redhat.com>
        <20210615150458.GR1002214@nvidia.com>
        <20210615102049.71a3c125.alex.williamson@redhat.com>
        <20210615204216.GY1002214@nvidia.com>
        <20210615155900.51f09c15.alex.williamson@redhat.com>
        <20210615230017.GZ1002214@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 20:00:17 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jun 15, 2021 at 03:59:00PM -0600, Alex Williamson wrote:
> > On Tue, 15 Jun 2021 17:42:16 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Tue, Jun 15, 2021 at 10:20:49AM -0600, Alex Williamson wrote:  
> > > > On Tue, 15 Jun 2021 12:04:58 -0300
> > > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >     
> > > > > On Tue, Jun 15, 2021 at 09:00:29AM -0600, Alex Williamson wrote:
> > > > >     
> > > > > > "vfio" override in PCI-core plays out for other override types.  Also I
> > > > > > don't think dynamic IDs should be handled uniquely, new_id_store()
> > > > > > should gain support for flags and userspace should be able to add new
> > > > > > dynamic ID with override-only matches to the table.  Thanks,      
> > > > > 
> > > > > Why? Once all the enforcement is stripped out the only purpose of the
> > > > > new flag is to signal a different prepration of modules.alias - which
> > > > > won't happen for the new_id path anyhow    
> > > > 
> > > > Because new_id allows the admin to insert a new pci_device_id which has
> > > > been extended to include a flags field and intentionally handling
> > > > dynamic IDs differently from static IDs seems like generally a bad
> > > > thing.      
> > > 
> > > I'd agree with you if there was a functional difference at runtime,
> > > but since that was all removed, I don't think we should touch new_id.
> > > 
> > > This ends up effectively being only a kbuild related patch that
> > > changes how modules.alias is built.  
> > 
> > But it wasn't all removed.  The proposal had:
> > 
> >  a) Short circuit the dynamic ID match
> >  b) Fail a driver-override-only match without a driver_override
> >  c) Fail a non-driver-override-only match with a driver_override
> > 
> > Max is only proposing removing c).
> > 
> > b) alone is a functional, runtime difference.  
> 
> I would state b) differently:
> 
> b) Ignore the driver-override-only match entries in the ID table.

No, pci_match_device() returns NULL if a match is found that is marked
driver-override-only and a driver_override is not specified.  That's
the same as no match at all.  We don't then go on to search past that
match in the table, we fail to bind the driver.  That's effectively an
anti-match when there's no driver_override on the device.

> As if we look at new_id, I can't think of any reason for userspace to
> add an entry to the ID table and then tell the kernel to ignore
> it. If you want the kernel to ignore it then just don't add it in the
> first place.
> 
> Do you have some other scenario in mind?

Sure, what if I have two different GPUs in my system, one works fine
with the FOSS driver, the other requires a 3rd party driver.  I don't
want to blacklist the FOSS driver, but I don't want it to claim the
other GPU.  I can create an anti-match that effectively removes one GPU
from the FOSS driver unless it's bound with a driver_override.

I understand that's not your intended use case, but I think this allows
that and justifies handling a dynamic ID the same as a static ID.
Adding a field to pci_device_id, which is otherwise able to be fully
specified via new_id, except for this field, feels like a bug.  Thanks,

Alex

