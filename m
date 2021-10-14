Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4F42DFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhJNRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhJNRHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:07:52 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686FC061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:05:47 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id z126so9289049oiz.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNVnmuPNKyFIckVE0YBGKFzR1HCh0b1pNQzlea+6Pz4=;
        b=AUhnxIoCUA+DK0Lbp0wxKlMYMQL53L5DKu/4zbJwthexiWx8NbBn+BOp123rMKYCmi
         ehOj0tQ0u7ip8zpCUlzDNeCAx28/MKWvI/cLB/oyez4dYGovEIcvC1gi0AAUwYxPcuk0
         eJKzdMh1DpGa8YypX0S2JC6UuUedWOMrEUHpqEAKb/SV0I4wQL4kx5GrJ+rarIJof5Xz
         UQOL3BMb84HHN8FZfqLDakZDcdqDLhJdKdrRHTYKBTDStCuxVMExiuPj3oW8Q3JShd9/
         Z/r46QLGMFvT80xbthnb/treYOWylCtoO2Z71mEfda+0zeQyuEHSks7IQYjKrhlaVCC9
         1hQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNVnmuPNKyFIckVE0YBGKFzR1HCh0b1pNQzlea+6Pz4=;
        b=oLBdgzh1nI7j5RpgKCkuPhLALyGnZ+mdAn1JgUJtqHRzsMoKPIEOXzc5qDoeR0ewus
         FT3MqkAeqiRPmT1X0iepJfWnF45NwuKqAYa6zWIDf+2sZ8X38DmduLhJ4Q6svc/21nRC
         2XDbYmQoOxbMOfI4O5pJa6+CyErxmz28G+NOx6qTNPFAwOmUoCety7NZjlgpjzVEXe9b
         5AdTfBvavPXHFK2ps9Zd27DMB3wFaj8+to8AIGVbgmoHGHprVM47qbtGJa4pV+hnwUsq
         ipTOztWafrTAvs1PE+ic+IgcFPvZsMq6B39xYjKQlfkaH2J5kR+Jz2sPFZ0AxYgv/3yc
         V7oQ==
X-Gm-Message-State: AOAM532UwPmA26zzdRLtgiLx1YpEUTTms6KTMYsjed38Kp5q0VFAqGkf
        ksFyZ3v/ZReCYQGQPwMSFzk8KIH5pR1rH+CxcwNZhw==
X-Google-Smtp-Source: ABdhPJyV/NagICrFVPuucYtUXT79OzMSGc4IPATtATzbIXJG2j9N8BDCMhg0y84uRKl0ineZZsfk7HzGjuGsHkIFAXw=
X-Received: by 2002:aca:f008:: with SMTP id o8mr1745419oih.2.1634231146393;
 Thu, 14 Oct 2021 10:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211011194615.2955791-1-vipinsh@google.com> <YWSdTpkzNt3nppBc@google.com>
 <CALMp9eRzPXg2WS6-Yy6U90+B8wXm=zhVSkmAym4Y924m7FM-7g@mail.gmail.com> <YWhgxjAwHhy0POut@google.com>
In-Reply-To: <YWhgxjAwHhy0POut@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 14 Oct 2021 10:05:35 -0700
Message-ID: <CALMp9eQ4y+YO7THjfpHzJPmoODkUqoPUURaBvL+OdGjZhAMuTA@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Add a wrapper for reading INVPCID/INVEPT/INVVPID
 type
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vipin Sharma <vipinsh@google.com>, pbonzini@redhat.com,
        dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 9:54 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Oct 11, 2021, Jim Mattson wrote:
> > On Mon, Oct 11, 2021 at 1:23 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Mon, Oct 11, 2021, Vipin Sharma wrote:
> > > > -     if (type > 3) {
> > > > +     if (type > INVPCID_TYPE_MAX) {
> > >
> > > Hrm, I don't love this because it's not auto-updating in the unlikely chance that
> > > a new type is added.  I definitely don't like open coding '3' either.  What about
> > > going with a verbose option of
> > >
> > >         if (type != INVPCID_TYPE_INDIV_ADDR &&
> > >             type != INVPCID_TYPE_SINGLE_CTXT &&
> > >             type != INVPCID_TYPE_ALL_INCL_GLOBAL &&
> > >             type != INVPCID_TYPE_ALL_NON_GLOBAL) {
> > >                 kvm_inject_gp(vcpu, 0);
> > >                 return 1;
> > >         }
> >
> > Better, perhaps, to introduce a new function, valid_invpcid_type(),
> > and squirrel away the ugliness there?
>
> Oh, yeah, definitely.  I missed that SVM's invpcid_interception() has the same
> open-coded check.
>
> Alternatively, could we handle the invalid type in the main switch statement?  I
> don't see anything in the SDM or APM that architecturally _requires_ the type be
> checked before reading the INVPCID descriptor.  Hardware may operate that way,
> but that's uArch specific behavior unless there's explicit documentation.

Right. INVVPID and INVEPT are explicitly documented to check the type
first, but INVPCID is not.
