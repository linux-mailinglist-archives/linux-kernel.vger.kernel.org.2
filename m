Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED436BF02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 07:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhD0FoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 01:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhD0FoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 01:44:06 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9413C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:43:23 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id x54-20020a05683040b6b02902a527443e2fso3238195ott.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 22:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=SBoQA4Uv7DLmSIXEW0MEX4XHroR9+cpW7ygxQxARLAo=;
        b=kHaLqDb9tPK/cTtDQL0jqdvZRKyp6ozWs6a07TXO50e4DzhJRW54tzEwyPqkOd+Idu
         Xvl17n/e7iD87kfE0YkYBAdQLD9mL5bOeEh5hkOL3zP+TpdiDzWhOD887gBXvphNHgRc
         zzt/V0DygwckYPy3lCMyBQOeeuJcoWVX2mb9IrgiC/AZDMAZ7Vq4r8dkJKLuK9F3iYr3
         Tn9H5Cs3VmpFCzOXzTTYLxmWedMHZ8xc6BXzyy1FvNTr3qFh9SCzxyNamEvwADo1s6yF
         m1y3o5G1g2oX+iwea+tzpr+bLoNX2MPGWXtjaSDEFs8iuygZGozipJ7ADWhxAF3H/jHV
         FLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=SBoQA4Uv7DLmSIXEW0MEX4XHroR9+cpW7ygxQxARLAo=;
        b=oK4l3mXlDnBRvI8zqZi2ILcJ5mvL6sRQXhJKj6ubvkxkpHVq0cqaJWfYi7e6HMLMO6
         KKKZufNGF5JRb4xUiSG7oenNfc88YzLcKfJHBb4h7WiBG2w96CqHzeRpAYc/TOJrPZ9a
         Ot0A3H2YcbvhtFFBNfElq/YzVdTNF5FYhF5duLmnQd/+Tvwp5a5Zy5+UZL1fTjLeY2l2
         1vjA5H6GNdpjfhh4dbdmfOqcBu7grYFJUwSPOeNUdWzlbeHUBftq0jL1KlTBYHUJNchO
         RP12sF/8rtozciqBaiIqAIebRKfEjVZLIjEvx/X41THauOLbVWVGUIyt7vjiZni4McIi
         03sw==
X-Gm-Message-State: AOAM531m9/iakO+buUJpfQfF4jwIn1XoMQXRwFjSyTzXyeXocpkVRKoQ
        vACaFfgm8Goiyf30TWoK19pcsw==
X-Google-Smtp-Source: ABdhPJya10WMSePhh0RjJp+JfqVWDnjJc4mpDe4nyTacE//ULLCUor9Qa2qpxCv7Y/GWwHemTSmQeA==
X-Received: by 2002:a9d:7b42:: with SMTP id f2mr4567984oto.267.1619502203160;
        Mon, 26 Apr 2021 22:43:23 -0700 (PDT)
Received: from localhost ([2601:8c4:0:1be::1e4])
        by smtp.gmail.com with ESMTPSA id g3sm1097006otq.50.2021.04.26.22.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 22:43:19 -0700 (PDT)
Date:   Mon, 26 Apr 2021 22:43:18 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
cc:     pbonzini@redhat.com, anup@brainfault.org,
        Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        graf@amazon.com, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 00/17] KVM RISC-V Support
In-Reply-To: <mhng-d64da1be-bacd-4885-aaf2-fea3c763418c@palmerdabbelt-glaptop>
Message-ID: <5b988c4e-25e9-f2b9-b08d-35bc37a245e4@sifive.com>
References: <mhng-d64da1be-bacd-4885-aaf2-fea3c763418c@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021, Palmer Dabbelt wrote:

> On Wed, 31 Mar 2021 02:21:58 PDT (-0700), pbonzini@redhat.com wrote:
> 
> > Palmer, are you okay with merging RISC-V KVM?  Or should we place it in
> > drivers/staging/riscv/kvm?
> 
> I'm certainly ready to drop my objections to merging the code based on 
> it targeting a draft extension, but at a bare minimum I want to get a 
> new policy in place that everyone can agree to for merging code.  I've 
> tried to draft up a new policy a handful of times this week, but I'm not 
> really quite sure how to go about this: ultimately trying to build 
> stable interfaces around an unstable ISA is just a losing battle.  I've 
> got a bunch of stuff going on right now, but I'll try to find some time 
> to actually sit down and finish one.
> 
> I know it might seem odd to complain about how slowly things are going 
> and then throw up another roadblock, but I really do think this is a 
> very important thing to get right.  I'm just not sure how we're going to 
> get anywhere with RISC-V without someone providing stability, so I want 
> to make sure that whatever we do here can be done reliably.  If we don't 
> I'm worried the vendors are just going to go off and do their own 
> software stacks, which will make getting everyone back on the same page 
> very difficult.

I sympathize with Paolo, Anup, and others also.  Especially Anup, who has 
been updating and carrying the hypervisor patches for a long time now.  
And also Greentime, who has been carrying the V extension patches.  The 
RISC-V hypervisor specification, like several other RISC-V draft 
specifications, is taking longer to transition to the officially "frozen" 
stage than almost anyone in the RISC-V community would like.

Since we share this frustration, the next questions are: 

- What are the root causes of the problem?  

- What's the right forum to address the root causes?

To me, the root causes of the problems described in this thread aren't 
with the arch/riscv kernel maintenance guidelines, but rather with the 
RISC-V specification process itself.  And the right forum to address 
issues with the RISC-V specification process is with RISC-V International 
itself: the mailing lists, the participants, and the board of directors.  
Part of the challenge -- not simply with RISC-V, but with the Linux kernel 
or any other community -- is to ensure that incentives (and disincentives) 
are aligned with the appropriately responsible parts of the community.  
And when it comes to specification development, the right focus to align 
those incentives and disincentives is on RISC-V International.

The arch/riscv patch acceptance guidelines are simply intended to ensure 
that the definition of what is and isn't RISC-V remains clear and 
unambiguous.  Even though the guidelines can result in short-term pain, 
the intention is to promote long-term stability and sustainable 
maintainability - particularly since the specifications get baked into 
hardware.  We've observed that attempting to chase draft specifications 
can cause significant churn: for example, the history of the RISC-V vector 
specification illustrates how a draft extension can undergo major, 
unexpected revisions throughout its journey towards ratification.  One of 
our responsibilities as kernel developers is to minimize that churn - not 
simply for our own sanity, or for the usability of RISC-V, but to ensure 
that we remain members in good standing of the broader kernel community.  
Those of us who were around for the ARM32 and ARM SoC kernel accelerando 
absorbed strong lessons in maintainability, and I doubt anyone here is 
interested in re-learning those the hard way.

RVI states that the association is open to community participation.  The 
organizations that have joined RVI, I believe, have a strong stake in the 
health of the RISC-V ecosystem, just as the folks have here in this 
discussion.  If the goal really is to get quality specifications out the 
door faster, then let's focus the energy towards building consensus 
towards improving the process at RISC-V International.  If that's 
possible, the benefits won't only accrue to Linux developers, but to the 
entire RISC-V hardware and software development community at large.  If 
nothing else, it will be an interesting test of whether RISC-V 
International can take action to address these concerns and balance them 
with those of other stakeholders in the process.


- Paul
