Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCCA3A343B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFJToq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:44:46 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:43564 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFJToo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:44:44 -0400
Received: by mail-lj1-f179.google.com with SMTP id r14so6466130ljd.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ubXcbWgPRSI/FTTW821ibjosi1m1kp9EFIWEYpojr7U=;
        b=bZ1vnoT4gwchAfrORftPU/AdkdJzWMgCfShdVVXXijvp8wDeUduK7IBl//RUT2Ulm6
         XHwuXVz/fsjsDcz4/BqhCamb74xI5Th27omkUefoltHlyZNm8IN025o/5HJtRgCTEN5C
         XqraxBQxk3IbfMlBbb/rG1fSyDxIiTuTaPetc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ubXcbWgPRSI/FTTW821ibjosi1m1kp9EFIWEYpojr7U=;
        b=oO7yOqVrNlSP7wlBZQclQOzoppiPzrDYRfY5Q/39x65YuWuGpRqkgbs4ZAZXpRr3aF
         YlC+0zGXBAAl7oSBWN0AZaxM40e8INbH2wDmA0tJdMazNa94LIn/5nrr8p8XKg6enXRs
         kcz8Sl2PP1v23RTZCekovxeaKkk5hYW0I1Qa8vzvLbYUP80KEDU+TXnQMH3CHAehI0Ht
         1aNE/jcn8TneM8lNoTcLBSVUK7JOA7RVU2k/J3ra19Z6Ma1PcXu/AQ7sSh5vO1sNV5ht
         3kZtCJbraJdFZsy+itZNY00xubpR2Cz6K6XV6Dmq6dxYGvJ9fklD1wOo9buM+zP1lgwW
         DOJw==
X-Gm-Message-State: AOAM530afX8viBSXW+vVzVHMxfGQRKbNoBehaRvuP07Acv2LrJlWd4/g
        FyTVZpwXfoFYc1mA55UVYlqWDNyAydyR3WCYsVs=
X-Google-Smtp-Source: ABdhPJwu0Flg8jLTF93E+yDP9YlEIm8qm2FnAxMSttX81e1c9FnTmx5lE4ACDL0H9V/aH3yXktg/3g==
X-Received: by 2002:a2e:824c:: with SMTP id j12mr158638ljh.490.1623354107214;
        Thu, 10 Jun 2021 12:41:47 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m29sm382701lfp.203.2021.06.10.12.41.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 12:41:45 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id n17so6520262ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:41:43 -0700 (PDT)
X-Received: by 2002:a05:651c:383:: with SMTP id e3mr174508ljp.220.1623354103227;
 Thu, 10 Jun 2021 12:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local> <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
In-Reply-To: <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jun 2021 12:41:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKAdWpSav4+qYT4_LDSQm=7pO8RqKEoQoJsyDVtTCk3Q@mail.gmail.com>
Message-ID: <CAHk-=wiKAdWpSav4+qYT4_LDSQm=7pO8RqKEoQoJsyDVtTCk3Q@mail.gmail.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb) stable/for-linus-5.12)
To:     =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Dominique MARTINET <dominique.martinet@atmark-techno.com>,
        Jianxiong Gao <jxgao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukas Hartmann <lukas@mntmn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Content-Type: multipart/mixed; boundary="000000000000ab0cc405c46e9439"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ab0cc405c46e9439
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2021 at 7:52 AM Horia Geant=C4=83 <horia.geanta@nxp.com> wr=
ote:
>
> Documentation/core-api/dma-api.rst explicitly allows for partial syncs:
> Synchronise a single contiguous or scatter/gather mapping for the CPU
> and device. With the sync_sg API, all the parameters must be the same
> as those passed into the single mapping API. With the sync_single API,
> you can use dma_handle and size parameters that aren't identical to
> those passed into the single mapping API to do a partial sync.
>
> AFAICS commit 16fc3cef33a0 ("swiotlb: don't modify orig_addr in swiotlb_t=
bl_sync_single")
> is breaking this functionality.

How about a patch like the attached? Does that fix things for you.

Christoph? Comments - that commit removed the offset calculation
entirely, because the old

        (unsigned long)tlb_addr & (IO_TLB_SIZE - 1)

was wrong, but instead of removing it, I think it should have just
fixed it to be

        (tlb_addr - mem->start) & (IO_TLB_SIZE - 1);

instead. That way the slot offset always matches the slot index calculation=
.

I also made it then take the offset into account for the alloc_size checks.

Does this UNTESTED patch perhaps do the right thing?

                    Linus

--000000000000ab0cc405c46e9439
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kprb3vx00>
X-Attachment-Id: f_kprb3vx00

IGtlcm5lbC9kbWEvc3dpb3RsYi5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL3N3aW90bGIuYyBiL2tlcm5lbC9k
bWEvc3dpb3RsYi5jCmluZGV4IDhjYTdkNTA1ZDYxYy4uZjYzZDE1ZTk0ZDM1IDEwMDY0NAotLS0g
YS9rZXJuZWwvZG1hL3N3aW90bGIuYworKysgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwpAQCAtMzQy
LDYgKzM0Miw3IEBAIHN0YXRpYyB2b2lkIHN3aW90bGJfYm91bmNlKHN0cnVjdCBkZXZpY2UgKmRl
diwgcGh5c19hZGRyX3QgdGxiX2FkZHIsIHNpemVfdCBzaXplCiB7CiAJc3RydWN0IGlvX3RsYl9t
ZW0gKm1lbSA9IGlvX3RsYl9kZWZhdWx0X21lbTsKIAlpbnQgaW5kZXggPSAodGxiX2FkZHIgLSBt
ZW0tPnN0YXJ0KSA+PiBJT19UTEJfU0hJRlQ7CisJdW5zaWduZWQgbG9uZyBvZmZzZXQgPSAodGxi
X2FkZHIgLSBtZW0tPnN0YXJ0KSAmIChJT19UTEJfU0laRSAtIDEpOwogCXBoeXNfYWRkcl90IG9y
aWdfYWRkciA9IG1lbS0+c2xvdHNbaW5kZXhdLm9yaWdfYWRkcjsKIAlzaXplX3QgYWxsb2Nfc2l6
ZSA9IG1lbS0+c2xvdHNbaW5kZXhdLmFsbG9jX3NpemU7CiAJdW5zaWduZWQgbG9uZyBwZm4gPSBQ
Rk5fRE9XTihvcmlnX2FkZHIpOwpAQCAtMzUwLDYgKzM1MSwxNCBAQCBzdGF0aWMgdm9pZCBzd2lv
dGxiX2JvdW5jZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90IHRsYl9hZGRyLCBzaXpl
X3Qgc2l6ZQogCWlmIChvcmlnX2FkZHIgPT0gSU5WQUxJRF9QSFlTX0FERFIpCiAJCXJldHVybjsK
IAorCWlmIChvZmZzZXQgPiBhbGxvY19zaXplKSB7CisJCWRldl9XQVJOX09OQ0UoZGV2LCAxLAor
CQkJIkJ1ZmZlciBvdmVyZmxvdyBkZXRlY3RlZC4gT2Zmc2V0OiAlbHUuIE1hcHBpbmcgc2l6ZTog
JXp1LlxuIiwKKwkJCW9mZnNldCwgc2l6ZSk7CisJCXJldHVybjsKKwl9CisJYWxsb2Nfc2l6ZSAt
PSBvZmZzZXQ7CisJb3JpZ19hZGRyICs9IG9mZnNldDsKIAlpZiAoc2l6ZSA+IGFsbG9jX3NpemUp
IHsKIAkJZGV2X1dBUk5fT05DRShkZXYsIDEsCiAJCQkiQnVmZmVyIG92ZXJmbG93IGRldGVjdGVk
LiBBbGxvY2F0aW9uIHNpemU6ICV6dS4gTWFwcGluZyBzaXplOiAlenUuXG4iLAo=
--000000000000ab0cc405c46e9439--
