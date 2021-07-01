Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD033B8F11
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhGAIvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235088AbhGAIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625129319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FWtBsSNWOGoBz0joLRACuRfxa8gzRbsAHo0rqGyAWsA=;
        b=hMuf6H639mp4Id89omSVWeUcprotIWsXv2Y2hwMEWUx2D4VtYNcfivkA8h2OWiMFedBlPF
        tAvMuWNVYU4sey43SFEa8/PL6EllA7rkGCYkSkWaG9DzrPbFi1JWZCRISuoYbqDAjgKYzl
        ymBVx9CAmhNN2wOVpAcTictE0e7o4e0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-620RDs9PNbytv0WcCTPRlg-1; Thu, 01 Jul 2021 04:48:37 -0400
X-MC-Unique: 620RDs9PNbytv0WcCTPRlg-1
Received: by mail-wr1-f72.google.com with SMTP id l12-20020a5d410c0000b029012b4f055c9bso2022313wrp.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 01:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FWtBsSNWOGoBz0joLRACuRfxa8gzRbsAHo0rqGyAWsA=;
        b=mbUfRy89XnLfnm+PZPAGqpkl3e2teKgPaCV4yfb+aQ/UsAQaZKQIl45s9CXgy4LUIB
         FPcPc2d1r7/O1gr7EPEDLnf9heZ0HjQGqO0TD2wdAzSPnMDbi7z8bmrvnyBbpMKCIg87
         +bEt43w2XeKg6UgCEmRRvS5fcCVhTNZ0ujWBi9TbB91T76zn0tPNf6y7PmB5ob+d6eJp
         FQLO/VDy+ASJOzoc7VY8Ay6UUgHofIdCGfKTx7FCz51cPTMG1/Xm3Jpd2bxi1yr006DI
         Fk1E/5wI8X8Eo6hUb1lZ0zHzr4EGSr/U45pnBdjnf6GVgExQ0qGOKRdzc4qR5pd+aljD
         k2dA==
X-Gm-Message-State: AOAM533JxJC5hgOSAdK5X3Mk6Aq15K6gcd7eObRkaxA1FvCvcLEdD7F3
        GyENfVhpMzERYBOhChiC4GMUN1wkPReRDzDJDDKAjAfMsOCj6Pg4Z1dp2kmkSfR1qQDJnBBoBwC
        MYrVj8N4c3PPIV9ifkIWlFCow
X-Received: by 2002:a05:6000:2c4:: with SMTP id o4mr43144749wry.79.1625129316787;
        Thu, 01 Jul 2021 01:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhMTAHjQtfmaMDWAxYyJ7eL0jGVtWwILpGQJOCD3Xe267JSVLAYu8bvCBAHkOGQZBRs7AX9w==
X-Received: by 2002:a05:6000:2c4:: with SMTP id o4mr43144730wry.79.1625129316604;
        Thu, 01 Jul 2021 01:48:36 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id y7sm6730729wro.51.2021.07.01.01.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 01:48:35 -0700 (PDT)
Date:   Thu, 1 Jul 2021 09:48:33 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Daniel Walsh <dwalsh@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <YN2BYXv79PswrN2E@work-vm>
References: <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
 <20210629152007.GC5231@redhat.com>
 <78663f5c-d2fd-747a-48e3-0c5fd8b40332@schaufler-ca.com>
 <20210629173530.GD5231@redhat.com>
 <f4992b3a-a939-5bc4-a5da-0ce8913bd569@redhat.com>
 <YNvvLIv16jY8mfP8@mit.edu>
 <YNwmXOqT7LgbeVPn@work-vm>
 <YNyECw/1FzDCW3G8@mit.edu>
 <YNyHVhGPe1bFAt+C@work-vm>
 <YNzNLTxflKbDi8W2@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNzNLTxflKbDi8W2@mit.edu>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Theodore Ts'o (tytso@mit.edu) wrote:
> On Wed, Jun 30, 2021 at 04:01:42PM +0100, Dr. David Alan Gilbert wrote:
> > 
> > Even if you fix symlinks, I don't think it fixes device nodes or
> > anything else where the permissions bitmap isn't purely used as the
> > permissions on the inode.
> 
> I think we're making a mountain out of a molehill.  Again, very few
> people are using quota these days.  And if you give someone write
> access to a 8TB disk, do you really care if they can "steal" 32k worth
> of space (which is the maximum size of an xattr, enforced by the VFS).
> 
> OK, but what about character mode devices?  First of all, most users
> don't have access to huge number of devices, but let's assume
> something absurd.  Let's say that a user has write access to *1024*
> devices.  (My /dev has 233 character mode devices, and I have write
> access to well under a dozen.)
> 
> An 8TB disk costs about $200.  So how much of the "stolen" quota space
> are we talking about, assuming the user has access to 1024 devices,
> and the file system actually supports a 32k xattr.
> 
>     32k * 1024 * $200 / 8TB / (1024*1024*1024) = $0.000763 = 0.0763 cents
> 
> A 2TB SSD is less around $180, so even if we calculate the prices
> based on SSD space, we're still talking about a quarter of a penny.
> 
> Why are we worrying about this?

I'm not worrying about storage cost, but we would need to define what
the rules are on who can write and change a user.* xattr on a device
node.  It doesn't feel sane to make it anyone who can write to the
device; then everyone can start leaving droppings on /dev/null.

The other evilness I can imagine, is if there's a 32k limit on xattrs on
a node, an evil user could write almost 32k of junk to the node
and then break the next login that tries to add an acl or breaks the
next relabel.

Dave

> 						- Ted
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

