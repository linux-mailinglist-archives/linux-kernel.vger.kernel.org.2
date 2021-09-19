Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1735D410D3C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhISUMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhISUMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:12:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE02C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 13:11:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y28so57231558lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 13:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Y1JTruAJiennqoKHSUt8zJ7tlZwEeJ6qUN4lC6KPvo=;
        b=ehQ47qxGSjYDaFqSk0LCuI2qANt8PLjKw6PwpbOXWSlxRA/h0M5OMRXDRqluaBmYbC
         vz6ApeZPd2IeoRTE95yGaXVTnczEcFC3sErMCst05kDI63YNF0dioPU19cMBqpr5uwEG
         C+I2SYENPDrSOQhX8edzTf4ARVhZeE03vE0bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Y1JTruAJiennqoKHSUt8zJ7tlZwEeJ6qUN4lC6KPvo=;
        b=uhStBVTu6r9WzrOXVRjm7+SgjrOYw2ofeodrXGZxBoxzsHuoz4nfnZfKlDyD0eu8sQ
         IffWNtPRs2xoh/5uIl49rPAHRLz3y/hzM1tQDXd3BqB6RbH35SmOd5rQYeyS5GzQaJ0q
         aLLIkaxvRRBruMVAczTp8TqTUqJizRSKpe2oeIhrrJrLdD3ag9Xd/ixSkdjAWa6NMrr0
         vyQQ3bLCVcr1Of+JGyx/+qY7vDqhDDSOLJpwu23s+He0Jkmly+IcO9eSZh/nFyb7tPlu
         j6WE8P/6ejrWM69Y4DKdn2nFAbPOGhHhFWqixh0RzArZquSulqhqbU/3KgwPc66o2LLT
         JHKg==
X-Gm-Message-State: AOAM533o0kljPVaqPWhFYJupMd4UZUfn1AknDQYoE9i7l4Q7KOskcffS
        +QD+c6Wxb22mi79XeEEK1zKCOMoBmn9K477Dm34=
X-Google-Smtp-Source: ABdhPJzFQUQgWmeQQHTm+DYX//X2f7eqwmgOQUNKdnmG1eofV6yc7CaeUjRCvxePGi9Xi2vxUkMknQ==
X-Received: by 2002:a05:6512:750:: with SMTP id c16mr17023246lfs.21.1632082263873;
        Sun, 19 Sep 2021 13:11:03 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j23sm691696lja.125.2021.09.19.13.11.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 13:11:02 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id x27so58180032lfu.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 13:11:02 -0700 (PDT)
X-Received: by 2002:a2e:7f1c:: with SMTP id a28mr18900378ljd.56.1632082261923;
 Sun, 19 Sep 2021 13:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <163207602242.947088.16824174748243890514.tglx@xen13>
In-Reply-To: <163207602242.947088.16824174748243890514.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Sep 2021 13:10:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFY6Ys0bOrUUsocp_1YHt_9aEBi9CtPt4N0bRUTY8+5Q@mail.gmail.com>
Message-ID: <CAHk-=wiFY6Ys0bOrUUsocp_1YHt_9aEBi9CtPt4N0bRUTY8+5Q@mail.gmail.com>
Subject: Re: [GIT pull] locking/urgent for v5.15-rc2
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000077913705cc5ec3ed"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000077913705cc5ec3ed
Content-Type: text/plain; charset="UTF-8"

On Sun, Sep 19, 2021 at 11:28 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> -       atomic_add(READER_BIAS - bias, &rwb->readers);
> +       /*
> +        * _release() is needed in case that reader is in fast path, pairing
> +        * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
> +        */
> +       (void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);

Ugh. This really needs fixing.

atomic_add() is already much more than release-ordered on x86, and
atomic_add_return_release() is much more expensive on some uarchs.

I think it should be easy to add a atomic_add_release() function, and
it might be as simple as the attached patch, allowing architectures to
add their own arch_atomic_add_release() as needed.

I've pulled this, but please don't do things like the above hack.

            Linus

--00000000000077913705cc5ec3ed
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ktrnmmkb0>
X-Attachment-Id: f_ktrnmmkb0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL2F0b21pYy5oICAgICAgICAgICAgICAgfCAyICsrCiBpbmNs
dWRlL2xpbnV4L2F0b21pYy9hdG9taWMtYXJjaC1mYWxsYmFjay5oIHwgNCArKysrCiBpbmNsdWRl
L2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1bWVudGVkLmggIHwgNyArKysrKysrCiAzIGZpbGVz
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9hdG9taWMuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2F0b21pYy5oCmluZGV4IDVlNzU0
ZTg5NTc2Ny4uNmM1ODE0MTc3YzczIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9h
dG9taWMuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9hdG9taWMuaApAQCAtNTUsNiArNTUs
OCBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgYXJjaF9hdG9taWNfYWRkKGludCBpLCBh
dG9taWNfdCAqdikKIAkJICAgICA6ICJpciIgKGkpIDogIm1lbW9yeSIpOwogfQogCisjZGVmaW5l
IGFyY2hfYXRvbWljX2FkZF9yZWxlYXNlIGFyY2hfYXRvbWljX2FkZAorCiAvKioKICAqIGFyY2hf
YXRvbWljX3N1YiAtIHN1YnRyYWN0IGludGVnZXIgZnJvbSBhdG9taWMgdmFyaWFibGUKICAqIEBp
OiBpbnRlZ2VyIHZhbHVlIHRvIHN1YnRyYWN0CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2F0
b21pYy9hdG9taWMtYXJjaC1mYWxsYmFjay5oIGIvaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWlj
LWFyY2gtZmFsbGJhY2suaAppbmRleCBhM2RiYTMxZGYwMWUuLmFlNDM3ZDk2MWJkMSAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWljLWFyY2gtZmFsbGJhY2suaAorKysgYi9p
bmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtYXJjaC1mYWxsYmFjay5oCkBAIC0xNjUsNiArMTY1
LDEwIEBAIGFyY2hfYXRvbWljX3NldF9yZWxlYXNlKGF0b21pY190ICp2LCBpbnQgaSkKICNkZWZp
bmUgYXJjaF9hdG9taWNfc2V0X3JlbGVhc2UgYXJjaF9hdG9taWNfc2V0X3JlbGVhc2UKICNlbmRp
ZgogCisjaWZuZGVmIGFyY2hfYXRvbWljX2FkZF9yZWxlYXNlCisjZGVmaW5lIGFyY2hfYXRvbWlj
X2FkZF9yZWxlYXNlICh2b2lkKWFyY2hfYXRvbWljX2FkZF9yZXR1cm5fcmVsZWFzZQorI2VuZGlm
CisKICNpZm5kZWYgYXJjaF9hdG9taWNfYWRkX3JldHVybl9yZWxheGVkCiAjZGVmaW5lIGFyY2hf
YXRvbWljX2FkZF9yZXR1cm5fYWNxdWlyZSBhcmNoX2F0b21pY19hZGRfcmV0dXJuCiAjZGVmaW5l
IGFyY2hfYXRvbWljX2FkZF9yZXR1cm5fcmVsZWFzZSBhcmNoX2F0b21pY19hZGRfcmV0dXJuCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1bWVudGVkLmggYi9p
bmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1bWVudGVkLmgKaW5kZXggYTBmNjU0Mzcw
ZGEzLi40ODViODk4MDRiOWQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvYXRvbWljL2F0b21p
Yy1pbnN0cnVtZW50ZWQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1
bWVudGVkLmgKQEAgLTU2LDYgKzU2LDEzIEBAIGF0b21pY19hZGQoaW50IGksIGF0b21pY190ICp2
KQogCWFyY2hfYXRvbWljX2FkZChpLCB2KTsKIH0KIAorc3RhdGljIF9fYWx3YXlzX2lubGluZSB2
b2lkCithdG9taWNfYWRkX3JlbGVhc2UoaW50IGksIGF0b21pY190ICp2KQoreworCWluc3RydW1l
bnRfYXRvbWljX3JlYWRfd3JpdGUodiwgc2l6ZW9mKCp2KSk7CisJYXJjaF9hdG9taWNfYWRkX3Jl
bGVhc2UoaSwgdik7Cit9CisKIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgaW50CiBhdG9taWNfYWRk
X3JldHVybihpbnQgaSwgYXRvbWljX3QgKnYpCiB7Cg==
--00000000000077913705cc5ec3ed--
