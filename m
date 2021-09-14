Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B1540B723
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhINSsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 14:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhINSs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:48:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6646AC061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:47:08 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y6so534209lje.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xneKBAqlxDQOaEQA2mIeUw2gUAM26ROug0ElrNbX+h0=;
        b=TuDdYN4cnsSSFOCn87hQrwIkD0tYeX0OEGY4njPw6/N8hsqYRCnJoQn5HrrvBggKCZ
         W6rk3WH0WDGwuqDsaz9GACfK5KexEIiCtHhKOnYh8Br+ryj9GeMkEE7149dq4dnK3cIl
         GbVEJRbPmRwk4SLpXi+RkqYqyL1hyQTaqUurDApBFcJLxsrBR7hApABvkc3UaCDvSzh+
         5F2/KooFPD5xBwSaY3AVEEKTH6nQi4uqcgCpJgH2X+rLU92nyGWkMXk1eLUt9cMkdBrK
         ArfbXDAvCJsvymf71frMuSeWg965yxWA2dSq3R0jwrxcIq7nyWCEnheuRuWF4opRf7H7
         B1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xneKBAqlxDQOaEQA2mIeUw2gUAM26ROug0ElrNbX+h0=;
        b=x8endaXDkkHKAWIzEYML7tIue8DdVP8wXwXYvsnbuL/xu/9SNBrHPHHar2VoQIXmaz
         ks7raqCR9oHY8busYFmSn/pq1X6EoDfYV8ysEKPK6K7uSeBpjHePB7T4Y/Ac5I0YFlG/
         UXH/d9VkLws0sZGFmlE2Q13WEaVFxG0eHnqRWfapfguOPpwvQnJL0dVg3mZLVuqIJpSO
         zfY3lzKjrva7Hbb7Igi3BjkSyNu6aUBR6kCKbSJdLpHzDWlV0hgP0/5wmY93LNOetvT4
         iashx1oEDZ8m/2hA26t8lY2adn66km8/4OovT/7fxYVoJN7iY1xGh97OX7x3xa0zR/Eg
         XFlg==
X-Gm-Message-State: AOAM531OcDxakdgJcUv8LLdtcKqD6QCbmaEPwoh1P0MXLQzDT0naJIB1
        M6B4c0ezSVdyw4Jr4e5A/urE8X8yDRCuTCwC7QNamA==
X-Google-Smtp-Source: ABdhPJx9TkD1ztkZNFs9nsgve+eEPbsWeqzhntnMC3qtvaAvap01tmmXJNUa9dmDhdqMx7AA06qafNYkSZKIF/HTOAw=
X-Received: by 2002:a05:651c:54c:: with SMTP id q12mr17453992ljp.369.1631645226425;
 Tue, 14 Sep 2021 11:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210914171551.3223715-1-pgonda@google.com> <YUDcvRB3/QOXSi8H@google.com>
 <CAMkAt6opZoFfW_DiyJUREBAtd8503C6j+ZbjS9YL3z+bhqHR8Q@mail.gmail.com> <YUDsy4W0/FeIEJDr@google.com>
In-Reply-To: <YUDsy4W0/FeIEJDr@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 14 Sep 2021 12:46:54 -0600
Message-ID: <CAMkAt6r9W=bTzLkojjAuc5VpwJnSzg7+JUp=rnK-jO88hSKmxw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Disable KVM_CAP_VM_COPY_ENC_CONTEXT_FROM for SEV-ES
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, Marc Orr <marcorr@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Tempelman <natet@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:41 PM Sean Christopherson <seanjc@google.com> wrote:
>
> -stable, for giggles
>
> On Tue, Sep 14, 2021, Peter Gonda wrote:
> > On Tue, Sep 14, 2021 at 11:32 AM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Tue, Sep 14, 2021, Peter Gonda wrote:
> > > > Copying an ASID into new vCPUs will not work for SEV-ES since the vCPUs
> > > > VMSAs need to be setup and measured before SEV_LAUNCH_FINISH. Return an
> > > > error if a users tries to KVM_CAP_VM_COPY_ENC_CONTEXT_FROM from an
> > > > SEV-ES guest.
> > >
> > > What happens if userspace does KVM_CAP_VM_COPY_ENC_CONTEXT_FROM before the source
> > > has created vCPUs, i.e. before it has done SEV_LAUNCH_FINISH?
> >
> > That's not enough. If you wanted to be able to mirror SEV-ES you'd
> > also need to call LAUNCH_UPDATE_VMSA on the mirror's vCPUs before
> > SEV_LAUNCH_FINISH. That is do-able but I was writing a small change to
> > fix this bug. If mirroring of SEV-ES is wanted it's a much bigger
> > change.
>
> Is it doable without KVM updates?  If so, then outright rejection may not be the
> correct behavior.

I do not think so. You cannot call KVM_SEV_LAUNCH_UPDATE_VMSA on the
mirror because svm_mem_enc_op() blocks calls from the mirror. So
either you have to update vmsa from the mirror or have the original VM
read through its mirror's vCPUs when calling
KVM_SEV_LAUNCH_UPDATE_VMSA. Not sure which way is better but I don't
see a way to do this without updating KVM.

>
> > > Might be worth noting that the destination cannot be an SEV guest, and therefore
> > > can't be an SEV-ES guest either.
> >
> > sev_guest() implies sev_es_guest() so I think this case is covered.
>
> Yes, I was suggesting calling that out in the changelog so that readers/reviewers
> don't worry about that case.
>
> > > Cc: stable@vger.kernel.org
>
> > Oops. I'll update in the V2 if needed. Added to this thread for now.
>
> FWIW, you don't actually need to Cc stable, just including it in the changelog is
> sufficient as the script automagic will pick it up when it hits Linus' tree.

Ack. I'll send out a V2 with updated changelog after we've settled on
the first issue.
