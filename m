Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627D53612A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhDOTCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbhDOTCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:02:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403CFC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 12:02:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e2so8305505plh.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R52iZL1L9KqJgEWpExv7ouTigPv6Zx7wXSBW6AjHwPs=;
        b=utf/YiOzjBL0iVBIQg2jAT9f2krElonv9hcbJS3QdBTyZIbxS+iQ/UG7WA7mAxvunR
         vBr/8KDLVgcuA1GVyEPFtWDO/Gu1PgfeIdB3qAYaz08sRSwrmBzczMr5ChI2esy29s/j
         j1QVf7mmysHQr64WyuxFAwT5jX1N3VhLlR6/EPujvZNUqa7RJLc1JTjWoYHV+4eLSGIt
         Qg9GdjZpQIT5BU4YNzm8ZTmG/FaAfJiI4roUly6g8c4SWU6wGA7Tku+Ej00VzPBS7w7R
         AD9M/DwTBC51n96bvjEZ3q/zGJJIjLGY0+E2XgNGG8zHAaB0ZKP9BdFC0wz8Ctl03ATb
         CY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R52iZL1L9KqJgEWpExv7ouTigPv6Zx7wXSBW6AjHwPs=;
        b=PItdBrCo4AKF+UjUfraxn7hgA4LnWPSMnsYtUukFNydkF+WiHgvTm24x5wEHjIeCIB
         0PIqB1zVRMc4GgscDlTac3Zcu4z7xXQQjRrJTU9zNrw2P/rUOJkXRLh3VnaNj1dgrCK2
         RPbNI0j/A4J+bh2hAfG7I83JWoIGqb3yFNiZ5q2ZQy3unJQMva/0D3v/rYkUfGqVYy4M
         scmhHDt578A7WpsY31gdoMCoCf5NLPwPG8UPRspVzttbYDcmyWuTtZa+EwzS/bV1kwLB
         yWJfQrrQjmKYD83k4N7+FizE0/E33VbuFtvw1LqY89oHXhJstHfre5uW+rEV7FaU8585
         kmgA==
X-Gm-Message-State: AOAM531RNnxGSUJ3uL+ZGvZk8vYH+mWHMG18Hz4VEBcNSDRUqM1I6xBB
        qNHhePgxT4ojdcP+wyaP6pO2xg==
X-Google-Smtp-Source: ABdhPJwykZccVfcNPJlfkdZVNAS2TiaDYUg0/Z/RUjq6MflZ2cUByG6FKy73whSmVytQIR9DvDo1zg==
X-Received: by 2002:a17:902:e843:b029:eb:8aff:360 with SMTP id t3-20020a170902e843b02900eb8aff0360mr2055758plg.1.1618513328394;
        Thu, 15 Apr 2021 12:02:08 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id i17sm2764960pfd.84.2021.04.15.12.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 12:02:07 -0700 (PDT)
Date:   Thu, 15 Apr 2021 19:02:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2 0/3] KVM: Properly account for guest CPU time
Message-ID: <YHiNq2ofctPfSUds@google.com>
References: <1618298169-3831-1-git-send-email-wanpengli@tencent.com>
 <YHXUFJuLXY8VZw3B@google.com>
 <CANRm+CzDW_5SPM0131OvRn3UPBp1nahxCykCP61XWeUpYeHU5Q@mail.gmail.com>
 <YHeNpUd1ZO1JVaAf@google.com>
 <CANRm+Cxp47Howwusf04WyL5S0AJQx817wcq5BXBvO-U2p-D5OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+Cxp47Howwusf04WyL5S0AJQx817wcq5BXBvO-U2p-D5OQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021, Wanpeng Li wrote:
> On Thu, 15 Apr 2021 at 08:49, Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Wed, Apr 14, 2021, Wanpeng Li wrote:
> > > On Wed, 14 Apr 2021 at 01:25, Sean Christopherson <seanjc@google.com> wrote:
> > > >
> > > > On Tue, Apr 13, 2021, Wanpeng Li wrote:
> > > > > The bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=209831
> > > > > reported that the guest time remains 0 when running a while true
> > > > > loop in the guest.
> > > > >
> > > > > The commit 87fa7f3e98a131 ("x86/kvm: Move context tracking where it
> > > > > belongs") moves guest_exit_irqoff() close to vmexit breaks the
> > > > > tick-based time accouting when the ticks that happen after IRQs are
> > > > > disabled are incorrectly accounted to the host/system time. This is
> > > > > because we exit the guest state too early.
> > > > >
> > > > > This patchset splits both context tracking logic and the time accounting
> > > > > logic from guest_enter/exit_irqoff(), keep context tracking around the
> > > > > actual vmentry/exit code, have the virt time specific helpers which
> > > > > can be placed at the proper spots in kvm. In addition, it will not
> > > > > break the world outside of x86.
> > > >
> > > > IMO, this is going in the wrong direction.  Rather than separate context tracking,
> > > > vtime accounting, and KVM logic, this further intertwines the three.  E.g. the
> > > > context tracking code has even more vtime accounting NATIVE vs. GEN vs. TICK
> > > > logic baked into it.
> > > >
> > > > Rather than smush everything into context_tracking.h, I think we can cleanly
> > > > split the context tracking and vtime accounting code into separate pieces, which
> > > > will in turn allow moving the wrapping logic to linux/kvm_host.h.  Once that is
> > > > done, splitting the context tracking and time accounting logic for KVM x86
> > > > becomes a KVM detail as opposed to requiring dedicated logic in the context
> > > > tracking code.
> > > >
> > > > I have untested code that compiles on x86, I'll send an RFC shortly.
> > >
> > > We need an easy to backport fix and then we might have some further
> > > cleanups on top.
> >
> > I fiddled with this a bit today, I think I have something workable that will be
> > a relatively clean and short backport.  With luck, I'll get it posted tomorrow.
> 
> I think we should improve my posted version instead of posting a lot
> of alternative versions to save everybody's time.

Ya, definitely not looking to throw out more variants.  I'm trying to stack my
cleanups on your code, while also stripping down your patches to the bare minimum
to minimize both the backports and the churn across the cleanups.  It looks like
it's going to work?  Fingers crossed :-)
