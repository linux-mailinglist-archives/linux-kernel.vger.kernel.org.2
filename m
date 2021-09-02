Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FBB3FF396
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347247AbhIBSym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbhIBSy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:54:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25B3C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 11:53:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq28so6482280lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3cxyL9Tlf0A8OUkJsk3pi4jzzMr5KvAck0t+WC1GK0=;
        b=iJNWEwOHkzKi8Knu9Iio+Dab8ggreKIblCRRgyHXfpTveV3pjRbas56xLTsHYrPCDk
         tUEeZA0BjFf3rdBlGbFrafI7wtWv90RNG90ceJ7XoFlsIHPkSOEza0Kio3i8i5o8R+Gp
         2yLztoD7TwwatWEJyZC9G+lQ8nA0jrneqbEc/5L81JdHYIxDsWKAmR1WII32gviCyirr
         vh9MPjU/PRHFwEIqGB+Kv+Jbf0zFW0JegPy+CowKXCL9QV2jKRPOX+5tVmHON372++tq
         auJq8mlgCvw+o+MyQ9Za1RDVOIvh/3vHGai1nXUt/BCbD7/A8yTP4/QZeCjcUmnp94FP
         zi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3cxyL9Tlf0A8OUkJsk3pi4jzzMr5KvAck0t+WC1GK0=;
        b=Lm1T77wBdpQuIaVFIbak2/lNnG19MmGR68CEwbm/3HEOj3o5aRJMOvld1vwAryUs7P
         TCvjio/4NWP0Up0wj7SegMo2ozGrKmXgK3iA7IEHFhTIuemdwH4OgeexnEVf3/ys5bHO
         cpAq/Fl/0KjN+kMyuFVkJNvIZAZ1Ia2vs9DgKt8QFp5E+glTRr71kJ3UbsyvRLLRre4V
         DX8YzPeWDWBQ8kEbwNYSB7RLiMsJ2jyC4SWMYnUcVsxMRvCpizt47Knss0ZeyFjeg340
         pCXxgCENNwQyuY30vE7rEZe53N6ZqwzDhA7p5ZU7AOcGKCu94ik3GtZ+V+IT+oJvnbSZ
         YC3Q==
X-Gm-Message-State: AOAM533HH2m91aMJuDo6twVnNrJJ83uNLb3vz4Jhx57sim+hTIbLZSlK
        pzQivXffvJpViT2Yp6qs82w4yQYuqMpw/1jFz1SLLw==
X-Google-Smtp-Source: ABdhPJzjtP8sxmfbdZxZlntr3Tc7G8mynCvx/H6xXcyY9l+mD75cOdccyiG0CqNRYcOgdTxZOXCtYmioSJkElGYHT2A=
X-Received: by 2002:a05:6512:3b12:: with SMTP id f18mr3260148lfv.423.1630608805872;
 Thu, 02 Sep 2021 11:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210902181751.252227-1-pgonda@google.com> <YTEbyYilbrLL9JSV@google.com>
In-Reply-To: <YTEbyYilbrLL9JSV@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 2 Sep 2021 12:53:13 -0600
Message-ID: <CAMkAt6rAnftQvtiu3bF+TUBEELucrZ+GmD83s+Y_3T3hPaLv6w@mail.gmail.com>
Subject: Re: [PATCH 0/2 V7] Add AMD SEV and SEV-ES intra host migration support
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, Marc Orr <marcorr@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 12:45 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Please Cc the cover letter to anyone that was Cc'd on one or more patches.  That's
> especially helpful if some recipients aren't subscribed to KVM.  Oh, and Cc lkml
> as well, otherwise I believe lore, patchwork, etc... won't have the cover letter.

Add CCs here. Thanks.

>
> On Thu, Sep 02, 2021, Peter Gonda wrote:
> > Intra host migration provides a low-cost mechanism for userspace VMM
> > upgrades.  It is an alternative to traditional (i.e., remote) live
> > migration. Whereas remote migration handles moving a guest to a new host,
> > intra host migration only handles moving a guest to a new userspace VMM
> > within a host.  This can be used to update, rollback, change flags of the
> > VMM, etc. The lower cost compared to live migration comes from the fact
> > that the guest's memory does not need to be copied between processes. A
> > handle to the guest memory simply gets passed to the new VMM, this could
> > be done via /dev/shm with share=on or similar feature.
> >
> > The guest state can be transferred from an old VMM to a new VMM as follows:
> > 1. Export guest state from KVM to the old user-space VMM via a getter
> > user-space/kernel API 2. Transfer guest state from old VMM to new VMM via
> > IPC communication 3. Import guest state into KVM from the new user-space
> > VMM via a setter user-space/kernel API VMMs by exporting from KVM using
> > getters, sending that data to the new VMM, then setting it again in KVM.
> >
> > In the common case for intra host migration, we can rely on the normal
> > ioctls for passing data from one VMM to the next. SEV, SEV-ES, and other
> > confidential compute environments make most of this information opaque, and
> > render KVM ioctls such as "KVM_GET_REGS" irrelevant.  As a result, we need
> > the ability to pass this opaque metadata from one VMM to the next. The
> > easiest way to do this is to leave this data in the kernel, and transfer
> > ownership of the metadata from one KVM VM (or vCPU) to the next. For
> > example, we need to move the SEV enabled ASID, VMSAs, and GHCB metadata
> > from one VMM to the next.  In general, we need to be able to hand off any
> > data that would be unsafe/impossible for the kernel to hand directly to
> > userspace (and cannot be reproduced using data that can be handed safely to
> > userspace).
> >
> > For the intra host operation the SEV required metadata, the source VM FD is
> > sent to the target VMM. The target VMM calls the new cap ioctl with the
> > source VM FD, KVM then moves all the SEV state to the target VM from the
> > source VM.
