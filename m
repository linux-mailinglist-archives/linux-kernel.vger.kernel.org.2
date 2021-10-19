Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9484333A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbhJSKj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhJSKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:39:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98720C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:37:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so46963809wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FZvIm3rqsw9MtMgTyCQhjlomP50swDXOySBREOTm/vI=;
        b=lqYGu2It0lmJamUsz5mnal87KJQz57uMl5CRfvm+18bc0CrT5eJE8uEG4IZUc6pnlA
         0sa+wUeQ53R1NMnsWdqyPTf2jltUrEtvss2u5/ih3XNjAlzXUyJaDlCgyUVnPvErq74f
         vL9rk/t1TV3G/Hds1jdViWa7qiwJT5HVmJkFCphsskZhjKZ5Tyu4gVEN61xP7ablAl9Z
         s9CFQ4xovQfHK78E7Ex3F96417dJdj95RCH9xZMUFW2r4dKqU5OKMTQBHZKkgIDjm7yK
         AhIJ6qHYOa8jtn1P1bt+NaN3tJPfyg4wE1/qN7DCSiASNquPcopCqr6Pm9P6vCeScyyP
         CFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FZvIm3rqsw9MtMgTyCQhjlomP50swDXOySBREOTm/vI=;
        b=JBE/XT67Tq2qTCkr1EjWjSgtLX/Pt0SeXlmuO0M0PHc+R9pRLVgAxMTwJZ2QEfCo9N
         zIYdBU/jqBkTV+HOu5Xl+qAZEtzFoQ4yQn2TmrT9XqS6aEzutoee+wKG6OB3R7sBqaiL
         XhVI+EDIIAJ/DiRL5FASwQfCILmA4WORV+KtJXeFVnFbcjTqQ4ozgs3YEJpxswX2/eGD
         cKpfNqrATQpKEPTrI0Ur8GGkfhfz53S8Io5PppCjqP9FEuBsraY7iY7dm1UY4O+W+Pof
         3ogjh1ROOmwlc5abObfri9+4FMGAFCGR1vWnAPtW7xIAmYAx6YuM/KUS5A5yTl/IjiCg
         lfHQ==
X-Gm-Message-State: AOAM531PJ2RuawReLaq5IcfoCMkzv8BxBqJrOqoaFLTd7NFcpb3ONQr9
        Sds3oyUbwOrURzQUGTnm8rhIlQ==
X-Google-Smtp-Source: ABdhPJyz22mwvAWldVTIrGk4wME1SD0IDfWLY0SLLrHbF7nyxwa1vm+zUEcoU6By6FC1N6CX2KlqsQ==
X-Received: by 2002:adf:a2d7:: with SMTP id t23mr44228280wra.156.1634639830990;
        Tue, 19 Oct 2021 03:37:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
        by smtp.gmail.com with ESMTPSA id n68sm1829366wmn.13.2021.10.19.03.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 03:37:10 -0700 (PDT)
Date:   Tue, 19 Oct 2021 11:37:08 +0100
From:   Quentin Perret <qperret@google.com>
To:     Andrew Walbran <qwandor@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 01/16] KVM: arm64: Introduce do_share() helper for memory
 sharing between components
Message-ID: <YW6f1OxgsY4y16/N@google.com>
References: <20211013155831.943476-1-qperret@google.com>
 <20211013155831.943476-2-qperret@google.com>
 <CA+_y_2HnBqL4wSzxLMwxONj4wMMDT15wOAieb6moN0q474=ENQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_y_2HnBqL4wSzxLMwxONj4wMMDT15wOAieb6moN0q474=ENQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Friday 15 Oct 2021 at 16:11:49 (+0100), Andrew Walbran wrote:
> On Wed, 13 Oct 2021 at 16:58, 'Quentin Perret' via kernel-team
> > +struct pkvm_mem_transition {
> > +       u64                             nr_pages;
> > +
> > +       struct {
> > +               enum pkvm_component_id  id;
> > +               u64                     addr;
> Is this the physical address or the IPA of the initiator? It would be
> good to have a comment explaining.

That's the address in the initiator's address space. For the host and
guests that'll be an IPA (which also happens to be the same as the PA
for the host) and for the hypervisor that'll be an EL2 VA.

But yes, a comment won't hurt, so I'll add something.

<snip>
> > +static int check_share(struct pkvm_page_req *req,
> > +                      struct pkvm_page_share_ack *ack,
> > +                      struct pkvm_mem_share *share)
> > +{
> > +       if (!addr_is_memory(req->phys))
> > +               return -EINVAL;
> > +
> > +       if (req->initiator.state == PKVM_PAGE_OWNED &&
> > +           ack->completer.state == PKVM_NOPAGE) {
> > +               return 0;
> > +       }
> > +
> > +       if (req->initiator.state != PKVM_PAGE_SHARED_OWNED)
> > +               return -EPERM;
> > +
> > +       if (ack->completer.state != PKVM_PAGE_SHARED_BORROWED)
> > +               return -EPERM;
> > +
> > +       if (ack->completer.phys != req->phys)
> > +               return -EPERM;
> > +
> > +       if (ack->completer.prot != share->prot)
> > +               return -EPERM;
> I guess this is the workaround you mentioned for the fact that the
> host can share the same page twice? It might be worth adding a comment
> to explain that that's what's going on.

Yep, that's what is going on here. But FWIW I'm currently reworking the
way we refcount pages in v2, which will now become the host's
responsibility. So, that should simplify things quite a bit at EL2, and
make all of the above go away :-)

Cheers,
Quentin
