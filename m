Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72032361468
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhDOV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbhDOV7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:59:15 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 14:58:51 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso1509064otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TS/T6BhQTib7rhqu+BkkOlINUb8326KpIVMIZIBfyRs=;
        b=Uk+6Z/v7I1+QPVozlnRfwxkdFxgIRoz0Ks6iwhFGDjAT/wm66qj1hDI67/z8f9w9D0
         Ll1HqqfDw4cGQIzPAR4PfRzkAH6rELzC7gp6A0pMEB61tOLXInvabrFujzLviCF1xEH5
         DbS+DAkfUAi4vfAIp8V6UQFalhVnxCHAyzostoGpvgEAdQaCCuDStYPngZqUm41bgE2G
         faC64Chg8HFACqviUSUEboKjQJlzlHdq4GU3he045WOAxjUZf2o0BqJI2wlKrYqkPMB4
         BzX1z6fr6AObpeuKT2GBuj7/mF+cfdUyx8We8lf9uS+P8j1oJRMuYoa4zs70owIUNAUx
         HqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TS/T6BhQTib7rhqu+BkkOlINUb8326KpIVMIZIBfyRs=;
        b=G6v/r5cnJaHgUrIP0aoLtcurGJWJZeHUcAdYhjS6/1ildNPTyF1wwiY112MYcrWdTj
         TenNtA4zoweBB4bga87FqzHQBafWGRX5KUPIVvMD0hUBqa9bPpZItRYWfHdoRrhS/da9
         z/U1Y+rPrgm1TXRt1hVzZdSPjeAn1k4zcn2LW7ix7gEBtMj4IMc/b/AwcCao48j6O8Hx
         xUGOZU1wd93LdugzM0m9BiQIoLDc++ahFaJZ7xBYHphy1m7UOzpP89UM7TOE7Rvk47Kz
         rE2xTgXH3+bJzkC5rRexKEBmpwB0YOXSi0m65JwRqprSiuHERYOvyii51N0pg4w2d4sj
         FraQ==
X-Gm-Message-State: AOAM530gN8isrd9D9vb5VEef71XWwwaKelZ2Q8hYw7A6QYcJQbdgv5iG
        jzXVuvWvXgJN3vsV18OsClzMCRT0H/kyM7qaWyGn5w==
X-Google-Smtp-Source: ABdhPJzCgZ9EkYnkd7FsmrKt+LBuBwVNbW9sg5zrNYIsNaphOJoqPRKqun/xV8h0fHvxDpnchA6eDUK2nyz+Y2ndux0=
X-Received: by 2002:a9d:aa4:: with SMTP id 33mr1021366otq.295.1618523930945;
 Thu, 15 Apr 2021 14:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210412222050.876100-1-seanjc@google.com> <20210412222050.876100-4-seanjc@google.com>
In-Reply-To: <20210412222050.876100-4-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 15 Apr 2021 14:58:39 -0700
Message-ID: <CALMp9eRmpm3HPUjizYXp27drY0xtWhSrsec51W7QkSHWADayNQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: Add proper lockdep assertion in I/O bus unregister
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 3:23 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Convert a comment above kvm_io_bus_unregister_dev() into an actual
> lockdep assertion, and opportunistically add curly braces to a multi-line
> for-loop.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/kvm_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index ab1fa6f92c82..ccc2ef1dbdda 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4485,21 +4485,23 @@ int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
>         return 0;
>  }
>
> -/* Caller must hold slots_lock. */
>  int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
>                               struct kvm_io_device *dev)
>  {
>         int i, j;
>         struct kvm_io_bus *new_bus, *bus;
>
> +       lockdep_assert_held(&kvm->slots_lock);
> +
>         bus = kvm_get_bus(kvm, bus_idx);
>         if (!bus)
>                 return 0;
>
> -       for (i = 0; i < bus->dev_count; i++)
> +       for (i = 0; i < bus->dev_count; i++) {
>                 if (bus->range[i].dev == dev) {
>                         break;
>                 }
> +       }
Per coding-style.rst, neither the for loop nor the if-block should have braces.

"Do not unnecessarily use braces where a single statement will do."

Stylistic nits aside,

Reviewed-by: Jim Mattson <jmattson@google.com>
