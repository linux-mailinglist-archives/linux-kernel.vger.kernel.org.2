Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CBF381411
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 01:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhENXHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 19:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhENXHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 19:07:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182E8C061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 16:06:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v6so323213ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Owdkm20O79PlykIyit66QYvMD3Y28QrpwNYI4FamRhg=;
        b=YNmOydQi9rcAD8YxKva1QHfQhxtA8KCFr3emQ6It1PF/3EpSfAxhtQNxG5+IgDCKnq
         lEgrdDox696tElk4oTEQ785XzFGkuZIrnEYbIdWsSFGw2CfbZW2tfa6k6/kgIDd5dTdy
         4U74cjzRA99jtTCMlHqe+AXvlkVm8vfuXXiv5Y4zUArKtnYAobp5MP/y3nXIbIkRxXuE
         yItew7LU9UwT9att2SmGw+Ze//F/4w+3eNv9ISw8szGhTUpSA8l5eaxKmALI5YjtcGOm
         kE58UX08P96mZgz6vMXQjTEmFiVLCuey/XbxkJz4Ri/IAnMSfxFwZD4obHnUj5YXOMYm
         fqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Owdkm20O79PlykIyit66QYvMD3Y28QrpwNYI4FamRhg=;
        b=iGv+D4ci1kQQicEDorEq0R0OwGli1JzTkszGTTdkd/LxHI4t4QtOUd/V/tgJcieZOD
         dJVB2nJ22seqny2bAoVNoLvH1ro0WB8BhM2wcw1FOGVqq2Cg8aFMNyYc7re+R1waXXHR
         KeJ9JeB8wwdzdQg5T20/DchBML61PGOuW2Mi9fAI6OkLZ46KZ7/gs0Hbz2/rYHnCdQp8
         IKRs36ZLN/OkzIP0NAEjFe02mF+AINUIRLSNwf+nDLo3buDxJ+ILUamElkqMygXtyG8K
         uhQm5JbPzwFsJnMLFGbaiWOkYWBKEay0quk0VN6pvZSDmaX4C6vrnXAnYrCeFQnjkNG9
         B9hQ==
X-Gm-Message-State: AOAM530GBwr0eCja700Ap3ZtiXP1R5QxHkDO0aZ2U9BwmYlhkijN+Hhb
        aFJoyu7OqT4qiz3/RfZmEi7H4+0WpcahYAGLFxE4tg==
X-Google-Smtp-Source: ABdhPJw1LckCubjtA+4YC+4+xrdHdl6i4QmJ3KwgSsYPI/Kvl9K54AOy0cEIEYHOBAQCILITBdBe7CW7HNGUvdQwbDU=
X-Received: by 2002:a2e:a365:: with SMTP id i5mr40075227ljn.344.1621033583251;
 Fri, 14 May 2021 16:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <f8811b3768c4306af7fb2732b6b3755489832c55.1621020158.git.thomas.lendacky@amd.com>
In-Reply-To: <f8811b3768c4306af7fb2732b6b3755489832c55.1621020158.git.thomas.lendacky@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 14 May 2021 17:06:11 -0600
Message-ID: <CAMkAt6qJqTvM0PX+ja3rLP3toY-Rr4pSUbiFKL1GwzYZPG6f8g@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Do not terminate SEV-ES guests on GHCB
 validation failure
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm list <kvm@vger.kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 1:22 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> Currently, an SEV-ES guest is terminated if the validation of the VMGEXIT
> exit code and parameters fail. Since the VMGEXIT instruction can be issued
> from userspace, even though userspace (likely) can't update the GHCB,
> don't allow userspace to be able to kill the guest.
>
> Return a #GP request through the GHCB when validation fails, rather than
> terminating the guest.

Is this a gap in the spec? I don't see anything that details what
should happen if the correct fields for NAE are not set in the first
couple paragraphs of section 4 'GHCB Protocol'.
