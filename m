Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2C405B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhIIQoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhIIQoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:44:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1D1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 09:43:44 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id z18so5128356ybg.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rBbbtBdxJo/z24uZXVl1WsJ9x865p3tX3wOkYNw8zI=;
        b=CxwyPEJx4brKYyNJfKH8xuVZVHNOb+imoHwqrC+m2OvLlX1CF4dc26BHqiDbb0sFdk
         FmFt0zmLzKgCa1DNQCsc6xZr9y3Z4pPNnzfIhUb3+16a9bNWy6ONfjK/aT8G5S4TT4x2
         SkyR9dYU1Bc3NWOfR/N8Xx4cdUqvv0TI5ThmKPXKlq0Dk9Zn2TJzowps8qXs4ziXJamP
         twWLDiVKUzt9dDskgQnZ+tuA0VajMO+0ZZb02gUUe6KXZatND7/Lkxi5UJx9cL/zyBl2
         9opFUHOSodvBlEv+qiApY+wGv/xCn72PWdKYkA+dJ2BOP4oZE/fSnYIKWCoQG3Sc2S3C
         kONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rBbbtBdxJo/z24uZXVl1WsJ9x865p3tX3wOkYNw8zI=;
        b=0AYRtLfFWBE8zb67d3wZTjQ9YzG5oOM60KoabPlpwvvyKGHgA4QJtWRbb07DS5X1jv
         lES5ibNykaWdF/ohrMgTudsILhwEKPEkamn7RPSLqWhMRLi448pgo1bZRYXCrHoWFocR
         WgPNGBxV4hMcMlo0kIPDANccWJDB1PlSRn0CXuwd5no1hSy3X1ajczBtir98Z1Jq9ihQ
         PPrk1JJhpqQ92VSTgONFnQLDsXNV2MZRxQ54Rj3b8cXBMAep/WYxbvsbkCReB8xELOHS
         Wg8mZaOS8tASTvYRRkD56/mJQcOpvmnaUnjLJgxLlY6kUs/PXqukS+DVNDax81akpEww
         z1eQ==
X-Gm-Message-State: AOAM530CHTm0wDNfrojTBPnxr1LCbqWc/HTFHxHhomUYmoMKtPdhB+a0
        luNPGyny8YcCe5k9b3k/ujnPwdXnvjdxxMz9t8RSDQ==
X-Google-Smtp-Source: ABdhPJxK5TixXHGpQ0HcjLdTV1bZ1SKePd5PRIPCrE5JXb/3IBGHK3nqLVQvIpatA9h6OifefO1lBmdtxEyNyano2rg=
X-Received: by 2002:a25:cd82:: with SMTP id d124mr5096262ybf.491.1631205823874;
 Thu, 09 Sep 2021 09:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com> <20210909013818.1191270-4-rananta@google.com>
 <20210909065612.d36255fur5alf6sl@gator>
In-Reply-To: <20210909065612.d36255fur5alf6sl@gator>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Thu, 9 Sep 2021 09:43:32 -0700
Message-ID: <CAJHc60y2i9AT5rEat0pK-h2BsNjzp_1tbqGAM5Lx=V3WfBBaMA@mail.gmail.com>
Subject: Re: [PATCH v4 03/18] KVM: arm64: selftests: Use read/write
 definitions from sysreg.h
To:     Andrew Jones <drjones@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 11:56 PM Andrew Jones <drjones@redhat.com> wrote:
>
> On Thu, Sep 09, 2021 at 01:38:03AM +0000, Raghavendra Rao Ananta wrote:
> > Make use of the register read/write definitions from
> > sysreg.h, instead of the existing definitions. A syntax
> > correction is needed for the files that use write_sysreg()
> > to make it compliant with the new (kernel's) syntax.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  .../selftests/kvm/aarch64/debug-exceptions.c  | 28 +++++++++----------
> >  .../selftests/kvm/include/aarch64/processor.h | 13 +--------
> >  2 files changed, 15 insertions(+), 26 deletions(-)
> >
>
> Same comment as Oliver, otherwise
>
Will fix.

Regards,
Raghavendra
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>
