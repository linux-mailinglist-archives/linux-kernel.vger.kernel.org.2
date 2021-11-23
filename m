Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2603745AB44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 19:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbhKWSfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhKWSfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:35:13 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC1CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:32:04 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id e136so49407ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sWVtHaZi/e9UJUnkTaYofcMjEaLdDp/jPuX8rBQAchs=;
        b=nfFKmAZwvXAM3ASdqYnv4QRwJxyeMfTIoQtcS254MI36Gt2Ht8an01gHjneszrzERs
         Ui2ZFyHN3B1RmxuMcDtfSLEZ8BxmRj0GysG6G9D2OaOIkURKNyoUk+xW2aUrUD59KdmL
         LCNGzsxaxepXdiVgXd9JR7YMOXr8YWmBQomke0ErKHcm4E7dwY1NAc+f9TsmQ+YaZ/8X
         1Zkp9RRIcc9JpTpnf+HiPbY344nMNYCVmZCML3nd0YWbnMMgQZgCmQKt+r2rwGqrMDXn
         Mcp9Dj7imz/jAG37XeK9uC92zEhQ7aDC8Mbivm3uM7CmJ0nHJZ6E/tBv6OslKhUth4hg
         5WtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sWVtHaZi/e9UJUnkTaYofcMjEaLdDp/jPuX8rBQAchs=;
        b=KtEUT9WsWDxHNKONfKhj1IGyI6r0SOc/oK/C2ke/3n3JI7293Yt8ZUn0IBnoGiy7vB
         x++xZlVKevRVBanj7PRl2zN6m0X9rluvrvG2JngdygofoMvIutb+cTA6zomCFa+9zfXp
         bnpu7BOq6kRZ1koqsK3BYckXjUyQ1EtkKX1uj7LIvMxlfRUFHioVTLm09zns1Xc6TjvO
         at5BDkIbWkbJmWNXzY83pbeAjMiClrSdD1siSC0cmD6B+X8+KZczQDXpcn9+Xaoyxmf5
         u+l7YXtGBLyYZduuHckWKymRugWp9nI84qqUSNLhqmep3e1mi/OME+5aYU4zAC7tS0C0
         hYuw==
X-Gm-Message-State: AOAM531ZEl3djRMYIL5B93QBFZoqZPnA7tCW+I7IxaJaSgPs2w+YbLUx
        dD8ku+GSa2l2xRG6NUB2Ya7WBCjbzi2RoyllrKJeow==
X-Google-Smtp-Source: ABdhPJzD79MwgizGCt6LZiTbZtlpIJ5vPiTXvUDS/Do60Z2kHs5u3LD+wEQLzYsksrOBEYM4TrigBY1feOG3lG6S/TM=
X-Received: by 2002:a25:a169:: with SMTP id z96mr7882343ybh.491.1637692323881;
 Tue, 23 Nov 2021 10:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20211113012234.1443009-1-rananta@google.com> <20211113012234.1443009-3-rananta@google.com>
 <87zgpwcg0s.wl-maz@kernel.org>
In-Reply-To: <87zgpwcg0s.wl-maz@kernel.org>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Tue, 23 Nov 2021 10:31:53 -0800
Message-ID: <CAJHc60ysebqSukBLpZ9na7daoFr+sGB0PWw-_V5nFObjqdkSyg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/11] KVM: Introduce kvm_vcpu_has_run_once
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

Hello Marc,

On Mon, Nov 22, 2021 at 8:27 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 13 Nov 2021 01:22:25 +0000,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > Architectures such as arm64 and riscv uses vcpu variables
> > such as has_run_once and ran_atleast_once, respectively,
> > to mark if the vCPU has started running. Since these are
> > architecture agnostic variables, introduce
> > kvm_vcpu_has_run_once() as a core kvm functionality and
> > use this instead of the architecture defined variables.
> >
> > No functional change intended.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
>
> arm64 is moving away from this, see [1]. You also don't need any new
> state, as vcpu->pid gives you exactly what you need.

Thanks for the pointer. I can directly use this!
>
> Happy to queue additional patches on top if you want to deal with
> riscv.
>
Just to clarify, you mean get the kvm support for riscv on kvmarm-next?
If yes, then sure, I can make changes in riscv to use
vcpu_has_run_once() from your series.

Regards,
Raghavendra


> Thanks,
>
>         M.
>
> [1] https://lore.kernel.org/all/20211018211158.3050779-1-maz@kernel.org/
>
> --
> Without deviation from the norm, progress is not possible.
