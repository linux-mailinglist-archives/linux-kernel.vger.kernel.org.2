Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D7E3EFA25
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhHRFfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbhHRFfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:35:33 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16610C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 22:34:59 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a93so3002257ybi.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 22:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oArnLMTQqldNbGF40M9RtBDw2/jMJew2fkb3kvR/Bfc=;
        b=C2I89mzESqBhtaTGMdJXIaBuQWw27iVRRrGh7tMOEAJauxdFFpGOD/iDnmlxaxOyqs
         AIr7j/loUsNwvx5K72IT8b/svkfclmuOueaaeR/Looen5I4Cgi0JeibKE+52F488QPjE
         oTEWJNzUh20go7hVgi/RKm4eLphefaXiF96I9upfP5bEEiHafgZXyRc5RBp7WFW93DG6
         tx/v2N4VBdpIZs/AgdUeGlvt1xPSqDzLV4tV4Es6+s6OfGEnceGj+uqmoRq0Y2cujOta
         69SEqbt6FAC0CDb1h7S0LcSz9TuPGCMxy03XCfjla68cw5/c8buczbIKOjuKC+rYG1U+
         kS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oArnLMTQqldNbGF40M9RtBDw2/jMJew2fkb3kvR/Bfc=;
        b=OExPZDG2VbMc24PMHP+oTyxCZcK19+huHEXGjXd8eDbwLrRdwhIUNLOGec7gS8y8cE
         VqrBncmYLZQOsFQuQWxJe0kKRJ1oL5rypkQBa+uX+5oYpggNEqy3omg1L9ZFTSf8jndS
         YLbS/xrXeZQZCb2rYoVvn9y1TbUxjX2esqOEXWTLuHyczE5FmtFJ0aUCU4hwlzBDHPF+
         +OwodmMWwsFeBLGubi6YszAUjMKe+o4QOGI2S532ltRZFnlSGZ1v0es7QSO8IKXfWGuB
         qaUCzUi0ay06GoaFsRQQkBJNMWoZFobyrMf9GsVsj1HGfParMgFFlAFNl/hWdmdS9/Rg
         +cNw==
X-Gm-Message-State: AOAM531SiFZobw9KEquK58sfkZBeOmhsbdmEEFXiHv/7BYfulOa4N9l4
        EQrhAZJIwJpl2Pik7zUJ/Hg2eR3cvU7ruRpYth9ndQ==
X-Google-Smtp-Source: ABdhPJw/Y63NyJI5+GyNLrLyeqm3peSh99PQpe07K+FpkXQhhIj7kz7yttCML29c0OiS3zeBFxN6YEqNyVgr5oOrcXc=
X-Received: by 2002:a25:1687:: with SMTP id 129mr9277576ybw.114.1629264898205;
 Tue, 17 Aug 2021 22:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210816202441.4098523-1-mizhang@google.com> <c66484d2-3524-d061-1e65-70dab0703cc3@redhat.com>
 <CAL715WJ4aREKC-5dOoNSuZi4qm6PqmoqYN+CVm9Y-cEwQZ7mow@mail.gmail.com> <f703fbb6-2585-95e6-9bc4-d24580d6f1f5@amd.com>
In-Reply-To: <f703fbb6-2585-95e6-9bc4-d24580d6f1f5@amd.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 17 Aug 2021 22:34:47 -0700
Message-ID: <CAL715WKYFy2nDSaPJZm0DtwnM3X6y+1xG0np4DWiWELFKPR6cQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] clean up interface between KVM and psp
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alper Gun <alpergun@google.com>,
        Borislav Petkov <bp@alien8.de>,
        David Rienjes <rientjes@google.com>,
        Marc Orr <marcorr@google.com>, Peter Gonda <pgonda@google.com>,
        Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I have no objection to move those functions in SEV drv.
>
> With build fix
>
> Acked-by: Brijesh Singh <brijesh.singh@amd.com>
>
Thanks for the ack. Will fix all build issues in the next version.

> I was trying to keep all the guest management commands functions within
> KVM because no other driver needs it. Having said that, we made
> exception for the decommission and activate so we can cleanup the
> firmware resource in non-process context.
>
Yes, ACTIVATE  / DECOMMISSION is one case that illustrates the need to
care about their internal relationship. And there is another case,
which is the serialization requirement between DF_FLUSH and
DEACTIVATE. This requires KVM to maintain an extra RWSEM. So I feel
that it would be good to hide these details away from KVM even if KVM
is the only user.

Thanks.
-Mingwei
