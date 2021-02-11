Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02083182D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 02:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhBKA4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 19:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBKAvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:49 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F33AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 16:50:46 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id w1so2493380ilm.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 16:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qo+wFkhMOw4vBkKARIdSL+H1M6zkBiXdlsvhgUURo0U=;
        b=CGJwwvk+hj6NaZbgbq7gOkoa71jCtKCtUd2U6K7dzMuTI+JCIfWW34EwOG+EWZXZIe
         6XAVKMwQ1RkcNFVwJ4HaaKRbLo5jUS+j1/7hDFHe/QiVuLvd58UP4rFdTjEFhP4r6W21
         pvXim1o9QWpbQPkQWWx0Nb/ip6VHDqIU+8k5pwq8dK140FFJmcprGpw/vaompZFPFmwq
         4Z8kihH6IjjuaTqj1DtCN9v0hbg8jPmoe+Td7QY0s+eo2Aj13l3O5iDN0maM5bEnfIee
         yGTB7xDkMtBG5el6QB9PZyFuetpCIyzR4e4sgQn8F0u9/8KUIO99U2+Vxj2j/SeHsbql
         61QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qo+wFkhMOw4vBkKARIdSL+H1M6zkBiXdlsvhgUURo0U=;
        b=GjtmXSWPcoDrNuSjC92GfJYN07MEemNVBe6q4j3ywnOiVC2iPH/y9LN2ALGq4TCXBG
         0zXuUi8QqvU/4GtXPIzA8sQ7LwaZevhF4Ds4DJH2YViYzG8UqIGdCjZLPYPrakDzAhaT
         J6uV2+qrpLXrSqK4+0vYYKDjPLD7qYc0BHa/Sk05ZSSyFBtkq94WsFfBrqB6FurxUtLZ
         iVGrk64Xv06wUz4rhW2Q02GlmO5Serk6/xDFWqSwnnZYzRw8I17MyCQsxJJc1PkqKxZX
         SdDIYR2Vo9vjjxBDVzhGL1IH0X26zbAdAdQMrxSczqyHfeA5GjxEx9r87LKJkPFolAno
         eGTg==
X-Gm-Message-State: AOAM531ATTP+/0OErXEtp1yrxQp+en2XPDZy46cIMFjJeWd6BWmioofJ
        gFnKum3G+7Sign7EXIZSlqmiug6AuMauK2MhWKhN5Q==
X-Google-Smtp-Source: ABdhPJw2t174aZ4yAP0dy2NIZHoDN/JKC84DY22OXwPi2mc1JjhuZfpu9e/zmpv8ch2/1Khjy0gspt5SpkNqJMUhyJg=
X-Received: by 2002:a92:cbce:: with SMTP id s14mr3731880ilq.306.1613004645983;
 Wed, 10 Feb 2021 16:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20210210230625.550939-1-seanjc@google.com> <20210210230625.550939-2-seanjc@google.com>
In-Reply-To: <20210210230625.550939-2-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 10 Feb 2021 16:50:35 -0800
Message-ID: <CANgfPd8D8MRczwGFeaYv8CyTubMNmcnfwYjSAjQu19io9mHCjQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] KVM: selftests: Explicitly state indicies for
 vm_guest_mode_params array
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 3:06 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Explicitly state the indices when populating vm_guest_mode_params to
> make it marginally easier to visualize what's going on.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index d787cb802b4a..960f4c5129ff 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -154,13 +154,13 @@ _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
>                "Missing new mode strings?");
>
>  const struct vm_guest_mode_params vm_guest_mode_params[] = {
> -       { 52, 48,  0x1000, 12 },
> -       { 52, 48, 0x10000, 16 },
> -       { 48, 48,  0x1000, 12 },
> -       { 48, 48, 0x10000, 16 },
> -       { 40, 48,  0x1000, 12 },
> -       { 40, 48, 0x10000, 16 },
> -       {  0,  0,  0x1000, 12 },
> +       [VM_MODE_P52V48_4K]     = { 52, 48,  0x1000, 12 },
> +       [VM_MODE_P52V48_64K]    = { 52, 48, 0x10000, 16 },
> +       [VM_MODE_P48V48_4K]     = { 48, 48,  0x1000, 12 },
> +       [VM_MODE_P48V48_64K]    = { 48, 48, 0x10000, 16 },
> +       [VM_MODE_P40V48_4K]     = { 40, 48,  0x1000, 12 },
> +       [VM_MODE_P40V48_64K]    = { 40, 48, 0x10000, 16 },
> +       [VM_MODE_PXXV48_4K]     = {  0,  0,  0x1000, 12 },
>  };
>  _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
>                "Missing new mode params?");
> --
> 2.30.0.478.g8a0d178c01-goog
>
