Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF8836156E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhDOWXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhDOWWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:22:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056D6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:22:31 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so24037484otb.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0m+cAK9JPHIfvCanrRu/4pUSWFajFyQFaaOgIPQz14=;
        b=qQwjbVAsoEqltGxG+c3hA0vTRT5utcab6OGdtyxZomJm8QmXhPq7Y1tJkgKnlrAonp
         LJMw+LH3iZ3wboT/Qzh+I+XlvHw+uiR7Y+YwA4rLyfDYyYGP3slnVHLxXMOyFdOB9jYh
         yVliNVnoZTJA5Yvqt0My7pxXdWhP4CxcSY3pc01f+p4ydSd36pX7hC9B1HTY1/ABbq2l
         r7MlleZ0ghh2e3MYNC7lzRfdZ0Gb/9elCYCNGPluIcyor7ti3B11EEw7JRPH9E3tZlUF
         QBW8/dknQrrXfkPUowyUZ+SqVtgAosWTbmB0KebaPY5RIGGRISSWO0s+GwB2iumWmKLB
         eYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0m+cAK9JPHIfvCanrRu/4pUSWFajFyQFaaOgIPQz14=;
        b=ua4DAZIA97+AMlFxO1XMeUQaSBD16I+ZaFWm4gdeZXaaIHDi5mbXm1QyOTeUg112nd
         xT90+bkiEhDkgAnfMWxlLZxOK16M9Z4TJBof0RJ2Ko7qw7mMXgZYsAPIQI+onbVDvfBS
         fCieomUnNJIi7AGt+XE9Qg+/0kh5XfgWjE5oyTvroG0RiIrn8N6VOewzO2EnJUr4YR7t
         +NzEsLY0WCko4qdN1ks7X8KlEBRDH48DmKVNns2KK/8T1zRWfhCTZSMzpmSIiyefEsWh
         eWYP7Q2UrCEA/WuXRd9VPcx/MQwmuPhcsQzWZsJ8WqgMVi0Op1z6pxmBiLoOJrf7umN6
         D++w==
X-Gm-Message-State: AOAM533QkuL1owrP9qwo9gisdWmwr5YIM4RZQwj3gP9MtQWxTTOHqyge
        hfw8nkzpczMgTI69eyiDrhhotfjO6UOEHdW68o02NQ==
X-Google-Smtp-Source: ABdhPJzd9cQG1A4xj/GqZHUBP1vAFkoXIb8px0aoyqKLhuelwd20DhOqClsEM5tNBciFzsDX+nI2A4RSlV4RbpmhAQ4=
X-Received: by 2002:a9d:2f29:: with SMTP id h38mr1139856otb.241.1618525350189;
 Thu, 15 Apr 2021 15:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210412222050.876100-1-seanjc@google.com> <20210412222050.876100-3-seanjc@google.com>
In-Reply-To: <20210412222050.876100-3-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 15 Apr 2021 15:22:19 -0700
Message-ID: <CALMp9eSQuDXg4nU0xmD7VHFnWpvsqGJ1SLudTf0nzx+nggk7DA@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: Stop looking for coalesced MMIO zones if the bus
 is destroyed
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 3:21 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Abort the walk of coalesced MMIO zones if kvm_io_bus_unregister_dev()
> fails to allocate memory for the new instance of the bus.  If it can't
> instantiate a new bus, unregister_dev() destroys all devices _except_ the
> target device.   But, it doesn't tell the caller that it obliterated the
> bus and invoked the destructor for all devices that were on the bus.  In
> the coalesced MMIO case, this can result in a deleted list entry
> dereference due to attempting to continue iterating on coalesced_zones
> after future entries (in the walk) have been deleted.
>
> Opportunistically add curly braces to the for-loop, which encompasses
> many lines but sneaks by without braces due to the guts being a single
> if statement.
>
> Fixes: f65886606c2d ("KVM: fix memory leak in kvm_io_bus_unregister_dev()")
> Cc: stable@vger.kernel.org
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
