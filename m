Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3D032CCCA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhCDGXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbhCDGWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:22:49 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6670EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 22:22:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d12so15631752pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 22:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wa5muaXHut4hfwXTsUBvUfthAuhKwhmv9/hS3aAHRxQ=;
        b=Ei8dVn1tS3L8d+KCjI+VuCzSj+Cfa7yV0HFL1DM94rBiWSDms9SHkHwivMYn04bjmx
         OY7XuGQpzmXg0EUzXpFAvpzAbXLTJKYqOnctbovAHMT8rOH5KdM45V87GeUhl5QmBmOf
         9SsmlkYM/nbtIcpXpwLUik8NdP/SeznAYt/+RCuNSN4C49b2N8+qrYgTtMsFHLPlCq3i
         oFaz4h5lYyjePLRasP1ShTXGMxKB4OpTzRm53eQV4pK89hTc9zr8XIMmx5W/jGKNj+L3
         M9VgZ1z/fQqUt6B/WABIinlH+Kr151hgBCYsKRas0sZSUw/S+UXNv+4IxVwtGr+bxBZB
         7OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wa5muaXHut4hfwXTsUBvUfthAuhKwhmv9/hS3aAHRxQ=;
        b=rsCSmMbvVsMEZ/tEvJcp7b9umNOHiY6fvD3oS5Kd2YzOsvL6EDVTdRLeQ595VWHe8x
         h0d3nfISSXQfFK8aUhVZLhJ3Tq4qkx+zXnBL/nv8Ab0f38ItgzfUx8GnENY9Cp3ZAkKP
         xNKNAGoONMAOZdpCVef0Oj/BbniK/YztUTimyRsYq2BaN6q69Bt8Z5ft+JlQEq6KEaFv
         nERW3+KuY6dliGbarLZGp7Y3ocOW9jKZm+zYYRRMCGF6tk++oFCxEAG0AWap068RMlg3
         ikC3VpygwSDUOcQ8amLcrMlBhCgTtzmlL00mmFN9e/Q5jssiXp6Xn7V/Abd+AwXRd4zK
         d4Ug==
X-Gm-Message-State: AOAM531cl5en6JHQvhva3V5xXKhtgmZxT1AbGmGyZpw41Nr+woBEjQRq
        LkFRwo0I/IJVm2OPHxhyFwBQOA==
X-Google-Smtp-Source: ABdhPJxxhHevBDuxsi5CHKFWK0/YIVXgJSyzO2vm7eUTrnkAE2fGT16nVrdFVJcwBDOhVAjGBkGaQg==
X-Received: by 2002:a63:3e03:: with SMTP id l3mr1928769pga.452.1614838928731;
        Wed, 03 Mar 2021 22:22:08 -0800 (PST)
Received: from google.com ([2620:0:1008:10:5ddf:a7e:5239:ef47])
        by smtp.gmail.com with ESMTPSA id q128sm26609812pfb.51.2021.03.03.22.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 22:22:08 -0800 (PST)
Date:   Wed, 3 Mar 2021 22:22:03 -0800
From:   Vipin Sharma <vipinsh@google.com>
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     tj@kernel.org, mkoutny@suse.com, rdunlap@infradead.org,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, jon.grimm@amd.com,
        eric.vantassell@amd.com, pbonzini@redhat.com, hannes@cmpxchg.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com, corbet@lwn.net,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, gingell@google.com,
        rientjes@google.com, dionnaglaze@google.com, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v2 2/2] cgroup: sev: Miscellaneous cgroup documentation.
Message-ID: <YEB8i6Chq4K/GGF6@google.com>
References: <20210302081705.1990283-1-vipinsh@google.com>
 <20210302081705.1990283-3-vipinsh@google.com>
 <20210303185513.27e18fce@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303185513.27e18fce@jacob-builder>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 06:55:13PM -0800, Jacob Pan wrote:
> Hi Vipin,
> 
> On Tue,  2 Mar 2021 00:17:05 -0800, Vipin Sharma <vipinsh@google.com> wrote:
> 
> > +Migration and Ownership
> > +~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +A miscellaneous scalar resource is charged to the cgroup in which it is
> > used +first, and stays charged to that cgroup until that resource is
> > freed. Migrating +a process to a different cgroup does not move the
> > charge to the destination +cgroup where the process has moved.
> > +
> I am trying to see if IOASIDs cgroup can also fit in this misc controller
> as yet another resource type.
> https://lore.kernel.org/linux-iommu/20210303131726.7a8cb169@jacob-builder/T/#u
> However, unlike sev IOASIDs need to be migrated if the process is moved to
> another cgroup. i.e. charge the destination and uncharge the source.
> 
> Do you think this behavior can be achieved by differentiating resource
> types? i.e. add attach callbacks for certain types. Having a single misc
> interface seems cleaner than creating another controller.

I think it makes sense to add support for migration for the resources
which need it. Resources like SEV, SEV-ES will not participate in
migration and won't stop can_attach() to succeed, other resources which
need migration will allow or stop based on their limits and capacity in
the destination.
