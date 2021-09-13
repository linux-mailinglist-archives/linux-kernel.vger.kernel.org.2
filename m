Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6E3408AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 14:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbhIMMWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbhIMMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 08:22:42 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880FBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:21:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o11so9438103ljp.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 05:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkr8GOjoBt/sh+RCX4NVAn9v5w6wwN8N4sC5/LVecLA=;
        b=kR/uxi3CryVYq6q7Z20ITMsyt2ZmDDhJy7TgEY1iE0l+AtHmw88xgWRoWRsPPUv4Rw
         PnKdZmU6XqepvjmrbZfm2nGuJOyttz9JmGPLsg3ugLO+SddJndUxq8zUWLdrn3Dnmwg5
         dzu0/nmeGhi0RlG/Ri1O2Ibls+3dgHDmuUE5DtTN9TeT10viZ50AnSbztISK7U2CWBXN
         gUA4Pwx56w9AXs2w8rM3lXBOxqIXlc5BBIF9mrLYJozSuDWaeVB9PT4DU0VsXHd0k1/7
         IKqhOTVdqJpl97QlZwEuTNFJk7OGl0qM8l0T10lOeNY+wleTCZeJMy/OWIFiEol7uRHZ
         2BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkr8GOjoBt/sh+RCX4NVAn9v5w6wwN8N4sC5/LVecLA=;
        b=7kp0ca6OC9rSieQkUPH1EUR9DyKBbkFEauLxFUfyVsi/Um+D4pO63xPNTv5speykWS
         GRN77VeAyLD1aOz6Z0VNH2Ybey5CEU67cNpF/W1a0Dn7iL0KzV5tYDAozEtqXgzI62pJ
         EFXM7tb9+hd/TBtpIv17a0spBI8QHkT2X2y5LmLljvIeZz2gvq60aN/vCgXZSnpR8Lp8
         qobCx8nln1Lpr8lF5CMJz6GFpHiyKs0zx2kDJQfHVAct5c6YJB7Ak1R4LWag/lSsI5sB
         cst4WpP+/POLFKpGcEgj6//DIZXsVFINM31CNZxdf1sdK9SjdbQ7ssRITZDTHCGT6bYa
         t7Sg==
X-Gm-Message-State: AOAM530WCB8u/lPStTDnzt9QXFec38Suy8rJ1TlfaMQ13077IX2AzPRp
        3t88UL8oGlc5W285uJwUTRFIT+Pz6uBnOk5BpblMgw==
X-Google-Smtp-Source: ABdhPJxpRNZpvn+RgdwcF7pGsUajFGcjpWr1uruf5bZ9zplVRACTkUcrAX5PCEYsDxpjuH5xU3b2oY0Kk/miHbjUmz0=
X-Received: by 2002:a2e:154e:: with SMTP id 14mr10342555ljv.374.1631535684043;
 Mon, 13 Sep 2021 05:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210907123112.10232-1-justin.he@arm.com> <20210907123112.10232-3-justin.he@arm.com>
 <CAOQ_QsjOmHw+545J0T9i-nWV2bVGGEwHq5SPVvBOM-SHMXpP5g@mail.gmail.com> <AM6PR08MB4376DB4B908AC37DF24290CFF7D59@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376DB4B908AC37DF24290CFF7D59@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 13 Sep 2021 08:21:12 -0400
Message-ID: <CAOQ_QshF+N7Q=-cXAoMSW4Gcy7mr_oFVpye7fEBqPeR8+3mK0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: arm64: Add memcg accounting to KVM allocations
To:     Justin He <justin.he@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin,

On Thu, Sep 9, 2021 at 8:57 AM Justin He <Justin.He@arm.com> wrote:
>
> Hi Oliver, thanks for the review, please my comments below:
>
> > -----Original Message-----
> > From: Oliver Upton <oupton@google.com>
> > Sent: Wednesday, September 8, 2021 6:29 AM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>; James Morse <James.Morse@arm.com>;
> > Alexandru Elisei <Alexandru.Elisei@arm.com>; Suzuki Poulose
> > <Suzuki.Poulose@arm.com>; Xiaoming Ni <nixiaoming@huawei.com>; Lorenzo
> > Pieralisi <Lorenzo.Pieralisi@arm.com>; Kees Cook <keescook@chromium.org>;
> > Catalin Marinas <Catalin.Marinas@arm.com>; Nick Desaulniers
> > <ndesaulniers@google.com>; linux-kernel@vger.kernel.org; Liu Shixin
> > <liushixin2@huawei.com>; Sami Tolvanen <samitolvanen@google.com>; Will
> > Deacon <will@kernel.org>; kvmarm@lists.cs.columbia.edu; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH v2 2/2] KVM: arm64: Add memcg accounting to KVM
> > allocations
> >
> > Hi Jia,
> >
> > On Tue, Sep 7, 2021 at 7:33 AM Jia He <justin.he@arm.com> wrote:
> > >
> > > Inspired by commit 254272ce6505 ("kvm: x86: Add memcg accounting to KVM
> > > allocations"), it would be better to make arm64 KVM consistent with
> > > common kvm codes.
> > >
> > > The memory allocations of VM scope should be charged into VM process
> > > cgroup, hence change GFP_KERNEL to GFP_KERNEL_ACCOUNT.
> > >
> > > There remain a few cases since these allocations are global, not in VM
> > > scope.
> >
> > I believe there are more memory allocations that could be switched to
> > GFP_KERNEL_ACCOUNT. For non-pKVM kernels, we probably should charge
> > all stage-2 paging structure allocations to the VM process. Your patch
> > appears to only change the allocation of the kvm_pgtable structure,
> > but not descendent paging structures.
> >
> Do you mean kvm_hyp_zalloc_page() here?
> Seems kvm_hyp_zalloc_page() is in both global and VM scopes.

Doh! kvm_hyp_zalloc_page() is only for the hyp's page tables, hence I
believe your patch is correct as it stands. As such:

Reviewed-by: Oliver Upton <oupton@google.com>
