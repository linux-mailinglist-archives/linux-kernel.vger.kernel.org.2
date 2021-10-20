Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0CB434B19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJTMZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 08:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhJTMZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 08:25:19 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E0EC06161C;
        Wed, 20 Oct 2021 05:23:04 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id r4-20020a4aa2c4000000b002b6f374cac9so1952134ool.6;
        Wed, 20 Oct 2021 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnpSTKaVxWeLwjg6JGO5JCxJHBUSE+8ki8bjGqS/oL8=;
        b=M5OAz7D3STdY5Eqg6qqLhbe94UPlkuJP16z1PvrH0eg7gGN73m4BUVPD1LEmD0QCGI
         sFCx5+aLAfHx1a9ivYk2Q83QJCG7gQIyf8Ga1yWdJrk7pJs7ZQlMCyUl4k7O3zaJ137w
         GgRCFgalWPmorsJmNOV02gkdHI/ILvFuQvaPMMwY0iZCEQIAkgnK4vkun4zD7nqoRtdu
         v6XxV951i7bMR/OoLkEbQ1Mvq4mREZAmpxBnSyqWyv/V0EJOQbWwX48iUsG5qYxxlyMQ
         5Y3pO0F2EJ+MhKH3QAcJsYO/rjMvh/I7bT6up2YcMmlvdOUA0OpBvaB0kN27B9kV4NjD
         Dp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnpSTKaVxWeLwjg6JGO5JCxJHBUSE+8ki8bjGqS/oL8=;
        b=oN/+CHAH5elso2jSBRfABMYyUKzr6tOlQdpa7OflLhoGd8lvem2omsSucdB1zeIkjY
         0ni4Nk/acjBzHvxkWJMuNswl2Fu3V+HeEGkkzU8z58YEzn6jxM+n1Lru0slFKfE+0JKD
         1stHYju1upAYwBAaB8y5Mm1CegY/pD1uWg2vuDL+A2rrAUV4VltJt7v4dyQFltFvow5c
         K46KiZlquCR8YGExaCqPJh1z1dwhd9KhhIcLPR7nlrXqNAoHEo7HTYOy62mvAimHox0W
         aqkUUQNGyMQ7H8thVNgwv4+uKAQRr0YpuRZLdeJUfvhuPvuC6xXZFCCeML/wjbr3ku3p
         /9qw==
X-Gm-Message-State: AOAM532ozf78tQgYRdWAAtPwCvhXJQgoA6CgDOF0/PPDRRThliFUYykc
        kG8shNUjvpN79CCQxwr+fX6kde0+aJt08hC3kEQ=
X-Google-Smtp-Source: ABdhPJwi60I+gGronRWQVJkldYpoSJJehKfYgLhGeop7ohHFjqVK2o+mX0tEzOhu1WuDUia0D4B2s7boTyNF/pLmjkQ=
X-Received: by 2002:a4a:52ce:: with SMTP id d197mr9487161oob.83.1634732584377;
 Wed, 20 Oct 2021 05:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211020120726.4022086-1-pizhenwei@bytedance.com>
In-Reply-To: <20211020120726.4022086-1-pizhenwei@bytedance.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Wed, 20 Oct 2021 20:22:53 +0800
Message-ID: <CANRm+CxAVA-L0wjm72eohXXWvh9fS7wVFzfKHuEjrsiRFuk9fg@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm: Introduce boot parameter no-kvm-pvipi
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 at 20:08, zhenwei pi <pizhenwei@bytedance.com> wrote:
>
> Although host side exposes KVM PV SEND IPI feature to guest side,
> guest should still have a chance to disable it.
>
> A typicall case of this parameter:
> If the host AMD server enables AVIC feature, the flat mode of APIC
> get better performance in the guest.

Hmm, I didn't find enough valuable information in your posting. We
observe AMD a lot before.
https://lore.kernel.org/all/CANRm+Cx597FNRUCyVz1D=B6Vs2GX3Sw57X7Muk+yMpi_hb+v1w@mail.gmail.com/T/#u

    Wanpeng
