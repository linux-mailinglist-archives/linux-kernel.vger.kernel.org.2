Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EFA355EA8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 00:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbhDFWRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 18:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbhDFWRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:17:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1997C061756
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 15:16:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ay2so8312956plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bojTtlznyYPCxw+AjA1Z5iDQKyp0kAN0WptY4bExVu4=;
        b=hpOLE67wFT0yf2eHMBO9zLlhNCbFgbPn/GE6fchXDoUiteKDsDS24LBbbCoFslqm6l
         1czPWf3YoZBKM6lBpyXolkgUwIunYZWZ92IynweM45YVG/EkJHjcZxkMLDn9cJngc1GM
         5uKEbVffD8USZzPqD/9FoknfAQrqA9oMow1DlNkxZiOSG8KN9q0O6yaBFvhygm3P+tPq
         ZmcKcKxOTCt4H0KKCdD2OjzgVKzXiEdH4P48iFPBpYMP3zRv4AO+rwm6LMSGX7lq/iY4
         RZ65zmr4r2N7dFng4QYHXdItgh3QIH2GNxwOW9sK1ixMm2+01xCnqrhp0uDQ/TwSKOc1
         EmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bojTtlznyYPCxw+AjA1Z5iDQKyp0kAN0WptY4bExVu4=;
        b=CVHKKHn17gxdL5C3dBQ1+O4K0ekQnZVpI0Iv8PO29//OWI6z5gW4d3Sd5sot+W109/
         rHD0XtW3u9r43nRSQOHopFQ6+Mv/i4JoafQnjaVDtprbJdD2KlEjfyFyuE+UfSfXqxsW
         sIyUuIZTI7DAECep4iTnzx1m3thsSYy4DrSQaJXEkhHpJNMm9dACLLPTBQ8N54jd30SC
         5nr7UM1BmS/vLicIfz4KrwwhC7bossSGOdDF2S16RPd1BpJ0xUtWwamJBtO0lcaYLWuF
         1B3S7ABKxyqch7/sH2zyE3Rkn9SVO3jZcqjsxQg04KQIl/haf24R87H7cKNm0NGtHoQE
         rx5w==
X-Gm-Message-State: AOAM532nESM3a5Y9a45NDr6ueRyjnMp3SZbfw6ZjtbUiQIkMvv8HRpBl
        LNJTp+huKEZm0RiWsnJmKU4QvDFruleBzA==
X-Google-Smtp-Source: ABdhPJzdXP2WsQ4v6Ljr3lRlzQKRqGmdd8eik0Z6HJEYb6vMt9hoAr6+n/QJjUG3kXnkQpCdrmgDxA==
X-Received: by 2002:a17:90a:d3d8:: with SMTP id d24mr297113pjw.166.1617747413006;
        Tue, 06 Apr 2021 15:16:53 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id x9sm13515537pfd.158.2021.04.06.15.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 15:16:52 -0700 (PDT)
Date:   Tue, 6 Apr 2021 22:16:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] KVM: X86: Properly account for guest CPU time when
 considering context tracking
Message-ID: <YGzd0PndH3ovXD+H@google.com>
References: <1617011036-11734-1-git-send-email-wanpengli@tencent.com>
 <YGILHM7CHpjXtxaH@google.com>
 <CANRm+CxXAt7z5H1v_Zpjg44Ka09eWc7gaJ7HRq9USUurjqrG3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANRm+CxXAt7z5H1v_Zpjg44Ka09eWc7gaJ7HRq9USUurjqrG3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021, Wanpeng Li wrote:
> On Tue, 30 Mar 2021 at 01:15, Sean Christopherson <seanjc@google.com> wrote:
> >
> > +Thomas
> >
> > On Mon, Mar 29, 2021, Wanpeng Li wrote:
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 32cf828..85695b3 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -6689,7 +6689,8 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
> > >        * into world and some more.
> > >        */
> > >       lockdep_hardirqs_off(CALLER_ADDR0);
> > > -     guest_exit_irqoff();
> > > +     if (vtime_accounting_enabled_this_cpu())
> > > +             guest_exit_irqoff();
> >
> > This looks ok, as CONFIG_CONTEXT_TRACKING and CONFIG_VIRT_CPU_ACCOUNTING_GEN are
> > selected by CONFIG_NO_HZ_FULL=y, and can't be enabled independently, e.g. the
> > rcu_user_exit() call won't be delayed because it will never be called in the
> > !vtime case.  But it still feels wrong poking into those details, e.g. it'll
> > be weird and/or wrong guest_exit_irqoff() gains stuff that isn't vtime specific.
> 
> Could you elaborate what's the meaning of "it'll be weird and/or wrong
> guest_exit_irqoff() gains stuff that isn't vtime specific."?

For example, if RCU logic is added to guest_exit_irqoff() that is needed
irrespective of vtime, then KVM will end up with different RCU logic depending
on whether or not vtime is enabled.  RCU is just an example.  My point is that
it doesn't seem impossible that there would be something in the future that
wants to tap into the guest->host transition.

Maybe that never happens and the vtime check is perfectly ok, but for me, the
name guest_exit_irqoff() doesn't sound like something that should hinge on
time accounting being enabled.
