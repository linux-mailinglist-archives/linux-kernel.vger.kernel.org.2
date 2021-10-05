Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03AB422F73
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 19:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhJER5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 13:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhJER5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:57:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E373C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 10:55:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x4so2833692pln.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQVAxhOUBeupXyB4EccZXaFK5tXREsXGl1r0zXiqsCM=;
        b=ofAokO2OZsXlhzGoZ3a202kn6+z2RQt+4hVQpaOdm+1eH9TyFsuOGifa2YdXtPmM06
         kSwBnaJgCtgliFYpsBe4/4Ks4fNcF2MPuCsAg8SLp/+JcXuRK2jvJ19uJNFmYHqJAfpD
         +BW6DmOd88ni7op25i+Oh4dH0N1p+atl3Zoyi9Ms8ZXfan0BVpba9MUlJec6v24yMwDp
         m/mhREXcLYZmO5Qwxz/RNEPeDciAUKpj4PgL5J37gy45Pnat7GtpZzg7GlC6GkbXZ4LC
         pMxCpBKdY+qv6SKX64hoWWYwDp7RSfWlnkmKqqC0uncJeU8ZUmWYGt/SWUhqQizU0vp+
         0nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQVAxhOUBeupXyB4EccZXaFK5tXREsXGl1r0zXiqsCM=;
        b=kuxrWiHF8oTCXuT9CC/csYOQx6PRJ6MPaxK7nkJJvF+hL8IKGI89sFL7KlTgPyq0Bo
         U1UUWv64yFbrsu1HnLcHC2XpYjkAnxqdvLBGBDgu9N2n4HH4NR3s9u9k1UFgL0x4PlDj
         L6irguAbK0W4l7qGEe66NnITPRXknq9UjeShDcY/0B/nPyfj5I4fDvsEa2b0ik5GJWlP
         2ZfCdpQ8bgoHwdiaiq/HUWN/nM5P08Nbu/fNpekVuoyqla6oj5Ha5mHFa+Tv82RHxrgf
         fM8V1um6yPSgBKEtz1Mf4hR3v4X9OiImlt3GF+r+38t+h9YM9p97cpAYv4F6tvVziFaR
         ydSQ==
X-Gm-Message-State: AOAM532b2bpv8qdg24/Tor9KhhNnhGquNoSMIvJH/ZrdOT6MoDy167CR
        b0ejRIFivrWx16KzotlPCHBnLA==
X-Google-Smtp-Source: ABdhPJzTYVGXDbvz383qSuFMoIlsiaI4Wf5MgnbJFt4d1EgGHIJa8eFD34m2K3sarZE5PY+A5lKpyQ==
X-Received: by 2002:a17:90a:bb13:: with SMTP id u19mr5429052pjr.42.1633456546715;
        Tue, 05 Oct 2021 10:55:46 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s14sm3660433pfg.50.2021.10.05.10.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:55:46 -0700 (PDT)
Date:   Tue, 5 Oct 2021 17:55:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Colin King <colin.king@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        David Stevens <stevensd@chromium.org>, kvm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KVM: x86: Fix allocation sizeof argument
Message-ID: <YVyRnV9cMLzazBx6@google.com>
References: <20211001110106.15056-1-colin.king@canonical.com>
 <YVxyNgyyxA7EnvJb@google.com>
 <ebd506ba-05cc-99d7-ece5-34bd67fc2430@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd506ba-05cc-99d7-ece5-34bd67fc2430@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021, Paolo Bonzini wrote:
> On 05/10/21 17:41, Sean Christopherson wrote:
> > >   			if (*gfn_track == NULL) {
> > >   				mutex_unlock(&kvm->slots_arch_lock);
> > Hrm, this fails to free the gfn_track allocations for previous memslots.  The
> > on-demand rmaps code has the exact same bug (it frees rmaps for previous lpages
> > in the_current_  slot, but does not free previous slots).
> 
> That's not a huge deal because the syscall is failing.  So as long as it's
> not leaked forever, it's okay.  The problem is the
> WARN_ON(slot->arch.rmap[i]), or the missing check in
> kvm_page_track_enable_mmu_write_tracking, but that's easily fixed.  I'd even
> remove the call to memslot_rmaps_free.

It can be leaked forever though, e.g. if userspace invokes KVM_RUN over and over
on -ENOMEM.  That would trigger the WARN_ON(slot->arch.rmap[i]) and leak the
previous allocation.  I think it would be safe to change that WARN_ON to a
check-and-continue, i.e. to preserve the previous allocation

> > And having two separate flows (and flags) for rmaps vs. gfn_track is pointless,
> > and means we have to maintain two near-identical copies of non-obvious code.
> 
> I was thinking the separate flow (not so much the flag) is needed because,
> if KVMGT is enabled, gfn_track is allocated unconditionally. rmaps are added
> on top of that if shadow paging is enabled; but
> kvm_page_track_create_memslot will have already created the counter,
> including the one for KVM_PAGE_TRACK_WRITE.
> 
> But looking at the code again, I guess you could call
> kvm_page_track_enable_mmu_write_tracking inside alloc_all_memslots_rmaps
> (with a little bit of renaming), and with that the flag would go away.

Yes, and reuse the control flow, which is what I really care about since that's
the part that both features get wrong.
 
> I'll take a look tomorrow, but I'd rather avoid reverting the patch.

I can poke at it too if you don't have time.  I wasn't suggesting a full revert,
rather a "drop and pretend it never got applied", with a plan to apply a new
version instead of fixing up the current code.
