Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82938F53C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhEXV7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhEXV7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 17:59:10 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF888C061756
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 14:57:41 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w127so24590166oig.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QOd1KfRYOgHgN+WbksAwHnKrFOkuvhhmy1/CWBQTUM=;
        b=KhP+msE1sBjTgPeZHuqohUHYU8q1MCHlCmd7BM0DG/QQPq0BVCAhBRoWQAvvPWXC3B
         dzIdRw0drYiWC6puPbIgYlYpn/RgzymNyAilhIgJHplegheMKxhJbEiyiZoetKiLi/mn
         ykAJ174khzSSndRTgw6U9AFmHJqWdsxK8JkbtQEwXXdc36S/CA52VJhna92gSZPmwv5R
         nA3R24Fgi6zEBCNS9WMqIu2SUly94l6303+0NMmlDms+eHSHwj63TutGiZcfguZfweaS
         orQsAc7kJ9A+u8KBtS9xkbgxtn6aqY6RxeQWOQi93tbqG6KQcnrL00+D/o/+n3fp0k32
         0EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QOd1KfRYOgHgN+WbksAwHnKrFOkuvhhmy1/CWBQTUM=;
        b=Qn1kleThdNk6GBZk80WUjFEO+VSjHyhpI7fPncXVwCF89CbENZ39nObw6zuAVAg9Ej
         u3w8x46OUOFXEOjLhf8JJDWYC7h0gysDnwVmb2zUS1ApEp8HUlmKNvaMKOOc9aOBjYDu
         dVWijC24C+RyNTLymYvLKvvRLeY4pZLx0APjnIkbpLw7f5k8CJ814ROfXRbhp+Edn0bU
         7t7OpkUP/e471fdC5kEGNgOYWdgrUWWgG5t7bGww36WxI0n7tJ+Eau8JxQQNq6nWO8Ps
         vxwhNpjM4Pvvs8RA89ccIWjhy1PJYrcFrgPayiqb5NOyQaFYA4Z3qPxQOvxF0+C7Udhs
         cdwg==
X-Gm-Message-State: AOAM532YP45/I6pMHFcvzizLNXcohtJDBdgsRJSRrmVi2q/q+QD1hZoc
        Ky5wGlHHPK/uLZ/dOGAU9FmqbK5zOMt9xa6NswcZ7w==
X-Google-Smtp-Source: ABdhPJy0YshGVdkHTmCXqcoHfIQ+x4WlPzk0E5xPuG+DSS7cOf2zkUjT30pxzPVVIfEn2OfQJJKGqrgDGo1sw/qbKs8=
X-Received: by 2002:aca:280a:: with SMTP id 10mr813875oix.13.1621893460868;
 Mon, 24 May 2021 14:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210207154256.52850-1-jing2.liu@linux.intel.com>
 <20210207154256.52850-3-jing2.liu@linux.intel.com> <YKwd5OTXr97Fxfok@google.com>
In-Reply-To: <YKwd5OTXr97Fxfok@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 24 May 2021 14:57:29 -0700
Message-ID: <CALMp9eTjgMDG2rKqKkb3WAsQXqfss1QEHWo5CJZHdd8r_XHRqg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/7] kvm: x86: Introduce XFD MSRs as passthrough to guest
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jing Liu <jing2.liu@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jing2.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 2:44 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Sun, Feb 07, 2021, Jing Liu wrote:
> > Passthrough both MSRs to let guest access and write without vmexit.
>
> Why?  Except for read-only MSRs, e.g. MSR_CORE_C1_RES, passthrough MSRs are
> costly to support because KVM must context switch the MSR (which, by the by, is
> completely missing from the patch).
>
> In other words, if these MSRs are full RW passthrough, guests with XFD enabled
> will need to load the guest value on entry, save the guest value on exit, and
> load the host value on exit.  That's in the neighborhood of a 40% increase in
> latency for a single VM-Enter/VM-Exit roundtrip (~1500 cycles => >2000 cycles).
>
> I'm not saying these can't be passhthrough, but there needs to be strong
> justification for letting the guest read/write them directly.

If we virtualize XFD, we have to context switch the guest/host values
on VM-entry/VM-exit, don't we? If we don't, we're forced to synthesize
the #NM on any instruction that would access a disabled state
component, and I don't think we have any way of doing that. We could
intercept a guest WRMSR to these MSRs, but it sounds like the guest
can still implicitly write to IA32_XFD_ERR, if we allow it to have a
non-zero IA32_XFD.

Perhaps the answer is "don't virtualize XFD."
