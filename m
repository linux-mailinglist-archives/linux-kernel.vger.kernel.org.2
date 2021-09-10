Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99ED540682A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 10:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhIJILS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 04:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231691AbhIJILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 04:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631261406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04dg9eLo5DobwnbTP7RmzFwFoUSaWkodvk2ic+H8548=;
        b=LItJBSy3DHmwpkZiTV8nTOaBEjmbjBx0MM7KbZrNZMAez1LrJIGSPPcqEHbwiV8aeJyN5g
        kHpSk6RZdlMFc4q2syUlTgELQewXUazzSyz+cwJIKNPrSue0+00Gd0zaPEQ8RFxRcv4ky8
        S6AQE+ufAUYsv0K5Ts66rbsL+Wix1LI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-7CYRIdSRMT6F1ka46RGksQ-1; Fri, 10 Sep 2021 04:10:05 -0400
X-MC-Unique: 7CYRIdSRMT6F1ka46RGksQ-1
Received: by mail-wm1-f71.google.com with SMTP id j21-20020a05600c1c1500b00300f1679e4dso245240wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=04dg9eLo5DobwnbTP7RmzFwFoUSaWkodvk2ic+H8548=;
        b=VkLFMojKLAKOW+sirOyDNIAvioojWrR0WzFvM4am+NnJVRJ06meau6A80gLtRNHH0v
         p4a6DFlVuEmKGUAJ4OCqXY/BslnYe7dpFs8tVFXgxTP9WlCTH7/lJ0HGhjFOOnybUaTF
         NfGscbJq9Jqy9rBDGnYZ1SoCIIJ9rwNaSMdmwjDs1DpDepIm5t845R8JGeHf0PcTcDai
         w/DRTd2SyQUn2NCPL69QT4FgJZzJrOiFWvJ0GyYtpPnHMSmelvw76Tk6ipJlpqA3E+Vp
         lz00cu+3ysaTQ3PBUQlgiJi4eSLoXN4hSd5GQCFPowS/9MM5KB5P/UQITImciQmcbwt4
         n5xA==
X-Gm-Message-State: AOAM532RhfHgBchILFMe2MLtB3YwVBBux5uTNKHfo4xI6dcYos30W2kF
        7LoSy44NNryPCWvTX8Rfdk2DWW6UgxbjuP9VpJ9n8jhnYmwauv6/lhtiCdzgfsEs1BEbM3YZ3o/
        Z1suxty0Yzmprjn4fS/8/xsXW
X-Received: by 2002:a05:600c:3b0e:: with SMTP id m14mr7171031wms.118.1631261403954;
        Fri, 10 Sep 2021 01:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznq/1Zr/LhNYqj/gZ4OdPBVawbvoIodEWaQXNr0cQS5ZYlI1VWvjYdpXqwAPwN0hOtTSUxVw==
X-Received: by 2002:a05:600c:3b0e:: with SMTP id m14mr7170994wms.118.1631261403703;
        Fri, 10 Sep 2021 01:10:03 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id j7sm322322wrr.27.2021.09.10.01.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 01:10:03 -0700 (PDT)
Date:   Fri, 10 Sep 2021 10:10:01 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 09/18] KVM: arm64: selftests: Add guest support to get
 the vcpuid
Message-ID: <20210910081001.4gljsvmcovvoylwt@gator>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-10-rananta@google.com>
 <20210909075643.fhngqu6tqrpe33gl@gator>
 <CAJHc60wRkUyKEdY0ok0uC7r=P0FME+Lb7oapz+AKbjaNDhFHyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHc60wRkUyKEdY0ok0uC7r=P0FME+Lb7oapz+AKbjaNDhFHyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 10:10:56AM -0700, Raghavendra Rao Ananta wrote:
> On Thu, Sep 9, 2021 at 12:56 AM Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Thu, Sep 09, 2021 at 01:38:09AM +0000, Raghavendra Rao Ananta wrote:
...
> > > +     for (i = 0; i < KVM_MAX_VCPUS; i++) {
> > > +             vcpuid = vcpuid_map[i].vcpuid;
> > > +             GUEST_ASSERT_1(vcpuid != VM_VCPUID_MAP_INVAL, mpidr);
> >
> > We don't want this assert if it's possible to have sparse maps, which
> > it probably isn't ever going to be, but...
> >
> If you look at the way the array is arranged, the element with
> VM_VCPUID_MAP_INVAL acts as a sentinel for us and all the proper
> elements would lie before this. So, I don't think we'd have a sparse
> array here.

If we switch to my suggestion of adding map entries at vcpu-add time and
removing them at vcpu-rm time, then the array may become sparse depending
on the order of removals.

Thanks,
drew

