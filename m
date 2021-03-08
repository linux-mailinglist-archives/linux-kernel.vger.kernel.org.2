Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53AE33148B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhCHRTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhCHRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:18:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35894C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:18:56 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id i14so3396477pjz.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i01z+yWtb+vdUaL5+BrI34M7EnFKtdDCRzjL0lcAeYY=;
        b=ON7u8LHggTokvFN5Nq2PjWRkypQnUzgQhFGHg3vQpeJdRdt8V/FKfZ+iHowtgb1gKZ
         VEarluffGlUDNrL5K4xunhpOv7p6NEbV3ESY2FdSo+T83NayE6S14NL29aTzpqGm4B18
         ohP0JOA2InFXNfeG1xX2NvmE6pwXDgLzrtSGjXcRqBW19uEPG1tWnooWJxQmIULmvOBl
         PgspaByIJ+EGOjyCQiDJKxMzkoWnH/sYrhLEBu74ck+MURgPn+zDtFe0FI4UtrBC67AI
         Fspd/iqaETRTXXdQUSgMqhUDBsn4F2H6Fcfr+ZwLeK1G3oxOHYc1bf96kJyO/dZqDdpy
         gbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i01z+yWtb+vdUaL5+BrI34M7EnFKtdDCRzjL0lcAeYY=;
        b=pa6jc8pA0gc6eyiR6F1hj/8tDa9vsHmwLbT7Qd7nT6QPbirSWnVN03bPHvy1Czt8zG
         wTPWMXJdo1v1XitdkEcZ7f53N3VxIQBn8sQSZBkt4q5ryj4SWoqfxaQMYiaouV9gtdKv
         9ogTAILs0Vmuw86oOZxYAOPBK6g1LF0Fx0xypVsftknytpPmCa8j4anKKbi8msPcsnYn
         jRJgbqVkcETehGY/mIwW8d/Tj8BxWIhRooRJcxWZ4dQGKAAc58793T8l4nJUx9NB2nBl
         ortapxhewDzB/bLz4JITMtV0Mcc9Kn1D0+VT8b+GcJGMji41IFGdRYWOUmgHStEs8LbX
         5OTQ==
X-Gm-Message-State: AOAM531IPH7aMFKvJr3qbftd53SoISMvlOki79XDHPeom38uVVY9ZsmF
        v73wel/kER/Bg8fOH0nDOjWT0Q==
X-Google-Smtp-Source: ABdhPJw34C+eLCDYdINMNYOS81+NWeEi5oPxeTBEuuCYZCcQ2Q19Jlf8rRd7F17e0NNz9rLhPlTEAA==
X-Received: by 2002:a17:902:a9cb:b029:e2:f64e:b778 with SMTP id b11-20020a170902a9cbb02900e2f64eb778mr21687222plr.39.1615223935515;
        Mon, 08 Mar 2021 09:18:55 -0800 (PST)
Received: from google.com ([2620:15c:f:10:cc8b:42a0:da69:7e82])
        by smtp.gmail.com with ESMTPSA id y63sm10117577pfy.68.2021.03.08.09.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:18:54 -0800 (PST)
Date:   Mon, 8 Mar 2021 09:18:48 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: Connect 'npt' module param to KVM's internal
 'npt_enabled'
Message-ID: <YEZceKJLrFwt93AA@google.com>
References: <20210305021637.3768573-1-seanjc@google.com>
 <106d2e650647408a901dfbec53f1b89cc36b2906.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <106d2e650647408a901dfbec53f1b89cc36b2906.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021, Maxim Levitsky wrote:
> On Thu, 2021-03-04 at 18:16 -0800, Sean Christopherson wrote:
> > Directly connect the 'npt' param to the 'npt_enabled' variable so that
> > runtime adjustments to npt_enabled are reflected in sysfs.  Move the
> > !PAE restriction to a runtime check to ensure NPT is forced off if the
> > host is using 2-level paging, and add a comment explicitly stating why
> > NPT requires a 64-bit kernel or a kernel with PAE enabled.
> 
> Let me ask a small question for a personal itch.
> 
> Do you think it is feasable to allow the user to enable npt/ept per guest?
> (the default should still of course come from npt module parameter)

Feasible, yes.  Worth the extra maintenance, probably not.  It's a niche use
case, and only viable if you have a priori knowledge of the guest being run.
I doubt there are more than a few people in the world that meet those criteria,
and want to run multiple VMs, and also care deeply about the performance
degregation of the other VMs.

> This weekend I checked it a bit and I think that it shouldn't be hard
> to do.
> 
> There are some old and broken OSes which can't work with npt=1
> https://blog.stuffedcow.net/2015/08/win9x-tlb-invalidation-bug/
> https://blog.stuffedcow.net/2015/08/pagewalk-coherence/
> 
> I won't be surprised if some other old OSes
> are affected by this as well knowing from the above 
> that on Intel the MMU speculates less and doesn't
> break their assumptions up to today.
> (This is tested to be true on my Kabylake laptop)

Heh, I would be quite surprised if Intel CPUs speculate less.  I wouldn't be
surprised if the old Windows behavior got grandfathered into Intel CPUs because
the buggy behavior worked on old CPUs and so must continue to work on new CPUs.

> In addition to that, on semi-unrelated note,
> our shadowing MMU also shows up the exact same issue since it
> also caches translations in form of unsync MMU pages.
> 
> But I can (and did disable) this using a hack (see below)
> and this finally made my win98 "hobby" guest actually work fine 
> on AMD for me.
> 
> I am also thinking to make this "sync" mmu mode to be 
> another module param (this can also be useful for debug,
> see below)
> What do you think?
> 
> On yet another semi-unrelated note,
> A "sync" mmu mode affects another bug I am tracking,
> but I don't yet understand why:
> 
> I found out that while windows 10 doesn't boot at all with 
> disabled tdp on the host (npt/ept - I tested both) 
>  the "sync" mmu mode does make it work.

Intel and AMD?  Or just AMD?  If both architectures fail, this definitely needs
to be debugged and fixed.  Given the lack of bug reports, most KVM users
obviously don't care about TDP=0, but any bug in the unsync code likely affects
nested TDP as well, which far more people do care about.

> I was also able to reproduce a crash on Linux 
> (but only with nested migration loop)

With or without TDP enabled?
