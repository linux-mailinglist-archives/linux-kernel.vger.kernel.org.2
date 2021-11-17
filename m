Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1284F453FED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 06:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhKQFWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 00:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhKQFWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 00:22:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1856AC061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:19:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so2078419wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 21:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1d/5wtm71BxoVBGiN8Ljzm4+t2qVpUjd2wk4O1QdlZM=;
        b=is70FHBLk+aTfX+yq501gaOQXJHxBX/bHha7TNgjAQrDphwxIgoK4Bc53VhkfQwYL+
         ZW/d5b0vzyJ+IYLi0KnBNKGiCkB+36HIxZxwDFwRymp7y5EVdQ5Bo9owDCoRM5110bvV
         a2kExAtzJgPUaW5Xr91KxEHQaCuMFLRgSDwZ5gksGWkPIVY3swFg4wzEoYy86SWG9cUY
         zigjkTuLzGpEnGojvRm07sdTY2gueOOqQTBQ/5az7MVXSJnPoChlFYrpXUXcdW50jWnv
         GOiZP6C86ssD9cXEXbcJELdOxbP0xPNUNDDxYKIHBxducQO05aPHmcXYkwLw62Jz3yoe
         PAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1d/5wtm71BxoVBGiN8Ljzm4+t2qVpUjd2wk4O1QdlZM=;
        b=6f8SyvjkTkUYhKZf2yvBVa0BHzGnD+yGl6qK5DT9/VigVuhu15tb9bCq6bWayxi8Zw
         uAO/gdNPwl5ePchiCqD5pe5vN99v4ifVyqUqVZYmqQOON7aUFyJ3bTj41X/QTM6uaTdt
         lS8+LrRJwIrJndnOMS/hf8IVfIzKmuMSfSfPpn4Z+2YATq+VVm5QRTPsQ73k0K7N4i3x
         4NutLQPV0Cd4DUlHAjvVtv72CSGwT8pYTTj+8moYLXBEbWYh6k+SFpaELED4l3+z8Nl/
         bJT2T4gW7NSJU0CTEKX5vpoxkZID676jyWVoEjGXZJKPNW+BFCI4p+xwFsskTOYZrlFL
         1khw==
X-Gm-Message-State: AOAM532j3cIUa12Gz2zEgGtV3Mg9y7diDXYOpUsJ1Xn3dYIe34OqBSll
        Vd5i7G3W6lREzyzc3w+IccWFzRXMoQcpG3zuwAqtJQ==
X-Google-Smtp-Source: ABdhPJyX4D/T4vRXx/HipXx4SprKAXckD0tm/8XOGI5AS8e44ypJEyDGyO3Mwf5JU3a7gaQ2ZR/pHy5q3RZ5nBLhh9A=
X-Received: by 2002:a5d:4846:: with SMTP id n6mr15955941wrs.249.1637126360414;
 Tue, 16 Nov 2021 21:19:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637064577.git.mchehab+huawei@kernel.org>
 <32b3693314f3914f10a42dea97ad6e06292fcd4a.1637064577.git.mchehab+huawei@kernel.org>
 <34e691ec-a58d-c86b-a2ef-6fa4f0385b69@redhat.com> <CAAhSdy0JRTwmr+EdSEr3ng1gfDpqnF7m3ejC2AydjAgu0mEQLw@mail.gmail.com>
 <8a762a6b-4ad8-211f-f350-ba65f8e77b64@redhat.com>
In-Reply-To: <8a762a6b-4ad8-211f-f350-ba65f8e77b64@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 17 Nov 2021 10:49:08 +0530
Message-ID: <CAAhSdy1ZijNE-JDj62KU1GbNjxu4UQQbpuz4P0wK+1orOyBMKA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Documentation: update vcpu-requests.rst reference
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kvm-riscv@lists.infradead.org, KVM General <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:35 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/16/21 15:01, Anup Patel wrote:
> > On Tue, Nov 16, 2021 at 6:24 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> On 11/16/21 13:11, Mauro Carvalho Chehab wrote:
> >>> Changeset 2f5947dfcaec ("Documentation: move Documentation/virtual to Documentation/virt")
> >>> renamed: Documentation/virtual/kvm/vcpu-requests.rst
> >>> to: Documentation/virt/kvm/vcpu-requests.rst.
> >>>
> >>> Update its cross-reference accordingly.
> >>>
> >>> Fixes: 2f5947dfcaec ("Documentation: move Documentation/virtual to Documentation/virt")
> >>> Reviewed-by: Anup Patel <anup.patel@wdc.com>
> >>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >>> ---
> >>>
> >>> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> >>> See [PATCH 0/4] at: https://lore.kernel.org/all/cover.1637064577.git.mchehab+huawei@kernel.org/
> >>>
> >>>    arch/riscv/kvm/vcpu.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> >>> index e3d3aed46184..fb84619df012 100644
> >>> --- a/arch/riscv/kvm/vcpu.c
> >>> +++ b/arch/riscv/kvm/vcpu.c
> >>> @@ -740,7 +740,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> >>>                 * Ensure we set mode to IN_GUEST_MODE after we disable
> >>>                 * interrupts and before the final VCPU requests check.
> >>>                 * See the comment in kvm_vcpu_exiting_guest_mode() and
> >>> -              * Documentation/virtual/kvm/vcpu-requests.rst
> >>> +              * Documentation/virt/kvm/vcpu-requests.rst
> >>>                 */
> >>>                vcpu->mode = IN_GUEST_MODE;
> >>>
> >>>
> >>
> >> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> >
> > Thanks Paolo, let me know if you want me to include this patch
> > as part of the fixes I have collected.
>
> I think Mauro will handle it, but you can pick it as well.

Okay, I will let Mauro handle it.

Thanks,
Anup

>
> Paolo
>
