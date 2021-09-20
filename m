Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693EA4127F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 23:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhITV2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 17:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhITV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 17:26:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2BAC0A20F4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:26:40 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i4so71250472lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nE+YhwBpmtKRwExAlF3CDkUsM9iXgTu0ihnJ8iXQwC8=;
        b=MBfVN880DNUqsHCZkEJgIhIjvD7J4S1fFkuVLPeDR2YTbp7XKtWZLQcnzbxL2CHEgr
         XZJz/JgRuSSTd2hqkwLOX/knwNFv3YyuOXJ7bKhN/uzCPeZEp6FwzgwezApRj/TtKpDG
         KlVgEEARiIiZQUc4R7mi9dh2RO45Gfi3N5KNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nE+YhwBpmtKRwExAlF3CDkUsM9iXgTu0ihnJ8iXQwC8=;
        b=QshtjCsW6/g1C8Ih3iYj/iErJLUOFYT+wmBtnwh0/oVF6ky/yVmgqyljf6zd+2GC80
         08LfUQ3K5uthCbkW+9yI3uLjkzAAQppf3Y18ZW2b2ZQz0VMFiEZSRzQm8+Zb6YbnYBzY
         RB8JailWrRmNVlWQdHwISU5exbZnuwpTP3JxU3hHRCG6X/BoufK8zw2SX88rerRdbZRd
         gwnc5djUOfsFP+zgQUppusqxuI5pPnDE7jZGPw1VOhu+2jwkSvUVr6EdcT5QTuj9vf9f
         Ul8ZNrJFeeGQlJKFuWp1KaVp2xjS8e27eoXJ4nYlxFAyY44oPWb4EhGEEHTAsgW6Z905
         HhnA==
X-Gm-Message-State: AOAM533xmHoaOffoafPWTBUtfZEqBNOqQKN8BwMvH6755VpcJTClaaQR
        EcJWKE+ptjfKrzaNFgKg5i0FhftrQQHCt8+c
X-Google-Smtp-Source: ABdhPJzSynp3TyIOoKjPRLfQ+FQVVcrmqbkNimtXl2D799wWBin2n63+bHDZEOKnqREjmrz7TeqMDw==
X-Received: by 2002:a05:6512:1383:: with SMTP id p3mr20200755lfa.648.1632158798725;
        Mon, 20 Sep 2021 10:26:38 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 1sm266900lfq.49.2021.09.20.10.26.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 10:26:38 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id z24so44623804lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:26:37 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr20212192lfb.141.1632158797578;
 Mon, 20 Sep 2021 10:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210920121208.54732-1-arnd@kernel.org>
In-Reply-To: <20210920121208.54732-1-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 10:26:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=CZ_fsUwDQCBbgPB4MTFx1ywgyERjFb7DNUk9Pix_Nw@mail.gmail.com>
Message-ID: <CAHk-=wi=CZ_fsUwDQCBbgPB4MTFx1ywgyERjFb7DNUk9Pix_Nw@mail.gmail.com>
Subject: Re: [PATCH] [RFC v2] qnx: avoid -Wstringop-overread warning, again
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Anders Larsen <al@alarsen.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000058eefd05cc7095bb"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000058eefd05cc7095bb
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 20, 2021 at 5:12 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> +               /*
> +                * work around gcc-11.x using the first field it observes
> +                * to determing the actual length
> +                * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
> +                */
> +               char __empty[0];
> +               char de_name[];

Ugh. That looks _really_ hacky.

It sounds like we can avoid the gcc bug if we just always use
"de->de_name[]". Then we don't need to depend on magical behavior
about one particular gcc version and a strange empty array in front of
it.

IOW, something like the attached simpler thing that just does that
"always use de_name[]" and has a comment about why we don't do the
natural thing

Also, just what version of gcc is the broken one? You say "gcc-11",
but I certainly don't see it with _my_ version of gcc-11, so can we
(just for that comment) document more precisely what version you have
(or possibly what config you use to trigger it).

                Linus

--00000000000058eefd05cc7095bb
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ktsx70h20>
X-Attachment-Id: f_ktsx70h20

IGZzL3FueDQvZGlyLmMgfCAyNyArKysrKysrKysrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Zz
L3FueDQvZGlyLmMgYi9mcy9xbng0L2Rpci5jCmluZGV4IDJhNjY4NDRiN2ZmOC4uZDYwODA2ZWZl
MDkwIDEwMDY0NAotLS0gYS9mcy9xbng0L2Rpci5jCisrKyBiL2ZzL3FueDQvZGlyLmMKQEAgLTIw
LDEyICsyMCwyNCBAQAogICogZGVwZW5kaW5nIG9uIHRoZSBzdGF0dXMgZmllbGQgaW4gdGhlIGxh
c3QgYnl0ZS4gVGhlCiAgKiBmaXJzdCBieXRlIGlzIHdoZXJlIHRoZSBuYW1lIHN0YXJ0IGVpdGhl
ciB3YXksIGFuZCBhCiAgKiB6ZXJvIG1lYW5zIGl0J3MgZW1wdHkuCisgKgorICogQWxzbywgZHVl
IHRvIGEgYnVnIGluIGdjYywgd2UgZG9uJ3Qgd2FudCB0byB1c2UgdGhlCisgKiByZWFsIChkaWZm
ZXJlbnRseSBzaXplZCkgbmFtZSBhcnJheXMgaW4gdGhlIGlub2RlIGFuZAorICogbGluayBlbnRy
aWVzLCBidXQgYWx3YXlzIHRoZSAnZGVfbmFtZVtdJyBvbmUgaW4gdGhlCisgKiBmYWtlIHN0cnVj
dCBlbnRyeS4KKyAqCisgKiBTZWUKKyAqCisgKiAgIGh0dHBzOi8vZ2NjLmdudS5vcmcvYnVnemls
bGEvc2hvd19idWcuY2dpP2lkPTk5NTc4I2M2CisgKgorICogZm9yIGRldGFpbHMgLSBidXQgYmFz
aWNhbGx5IGdjYyB3aWxsIHRha2UgdGhlIHNpemUgb2YKKyAqIHRoZSAnbmFtZScgYXJyYXkgZnJv
bSBvbmUgb2YgdGhlIHVzZWQgZW50cmllcyByYW5kb21seS4KICAqLwogdW5pb24gcW54NF9kaXJl
Y3RvcnlfZW50cnkgewogCXN0cnVjdCB7Ci0JCWNoYXIgZGVfbmFtZTsKLQkJY2hhciBkZV9wYWRb
NjJdOwotCQljaGFyIGRlX3N0YXR1czsKKwkJY29uc3QgY2hhciBkZV9uYW1lWzQ4XTsKKwkJdTgg
ZGVfcGFkWzE1XTsKKwkJdTggZGVfc3RhdHVzOwogCX07CiAJc3RydWN0IHFueDRfaW5vZGVfZW50
cnkgaW5vZGU7CiAJc3RydWN0IHFueDRfbGlua19pbmZvIGxpbms7CkBAIC01MywyOSArNjUsMjYg
QEAgc3RhdGljIGludCBxbng0X3JlYWRkaXIoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBkaXJf
Y29udGV4dCAqY3R4KQogCQlpeCA9IChjdHgtPnBvcyA+PiBRTlg0X0RJUl9FTlRSWV9TSVpFX0JJ
VFMpICUgUU5YNF9JTk9ERVNfUEVSX0JMT0NLOwogCQlmb3IgKDsgaXggPCBRTlg0X0lOT0RFU19Q
RVJfQkxPQ0s7IGl4KyssIGN0eC0+cG9zICs9IFFOWDRfRElSX0VOVFJZX1NJWkUpIHsKIAkJCXVu
aW9uIHFueDRfZGlyZWN0b3J5X2VudHJ5ICpkZTsKLQkJCWNvbnN0IGNoYXIgKm5hbWU7CiAKIAkJ
CW9mZnNldCA9IGl4ICogUU5YNF9ESVJfRU5UUllfU0laRTsKIAkJCWRlID0gKHVuaW9uIHFueDRf
ZGlyZWN0b3J5X2VudHJ5ICopIChiaC0+Yl9kYXRhICsgb2Zmc2V0KTsKIAotCQkJaWYgKCFkZS0+
ZGVfbmFtZSkKKwkJCWlmICghZGUtPmRlX25hbWVbMF0pCiAJCQkJY29udGludWU7CiAJCQlpZiAo
IShkZS0+ZGVfc3RhdHVzICYgKFFOWDRfRklMRV9VU0VEfFFOWDRfRklMRV9MSU5LKSkpCiAJCQkJ
Y29udGludWU7CiAJCQlpZiAoIShkZS0+ZGVfc3RhdHVzICYgUU5YNF9GSUxFX0xJTkspKSB7CiAJ
CQkJc2l6ZSA9IHNpemVvZihkZS0+aW5vZGUuZGlfZm5hbWUpOwotCQkJCW5hbWUgPSBkZS0+aW5v
ZGUuZGlfZm5hbWU7CiAJCQkJaW5vID0gYmxrbnVtICogUU5YNF9JTk9ERVNfUEVSX0JMT0NLICsg
aXggLSAxOwogCQkJfSBlbHNlIHsKIAkJCQlzaXplID0gc2l6ZW9mKGRlLT5saW5rLmRsX2ZuYW1l
KTsKLQkJCQluYW1lID0gZGUtPmxpbmsuZGxfZm5hbWU7CiAJCQkJaW5vID0gKCBsZTMyX3RvX2Nw
dShkZS0+bGluay5kbF9pbm9kZV9ibGspIC0gMSApICoKIAkJCQkJUU5YNF9JTk9ERVNfUEVSX0JM
T0NLICsKIAkJCQkJZGUtPmxpbmsuZGxfaW5vZGVfbmR4OwogCQkJfQotCQkJc2l6ZSA9IHN0cm5s
ZW4obmFtZSwgc2l6ZSk7CisJCQlzaXplID0gc3RybmxlbihkZS0+ZGVfbmFtZSwgc2l6ZSk7CiAJ
CQlRTlg0REVCVUcoKEtFUk5fSU5GTyAicW54NF9yZWFkZGlyOiUuKnNcbiIsIHNpemUsIG5hbWUp
KTsKLQkJCWlmICghZGlyX2VtaXQoY3R4LCBuYW1lLCBzaXplLCBpbm8sIERUX1VOS05PV04pKSB7
CisJCQlpZiAoIWRpcl9lbWl0KGN0eCwgZGUtPmRlX25hbWUsIHNpemUsIGlubywgRFRfVU5LTk9X
TikpIHsKIAkJCQlicmVsc2UoYmgpOwogCQkJCXJldHVybiAwOwogCQkJfQo=
--00000000000058eefd05cc7095bb--
