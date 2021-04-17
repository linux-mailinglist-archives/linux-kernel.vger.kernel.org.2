Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C14363129
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 18:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhDQQ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbhDQQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 12:27:49 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30888C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:27:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o16so34465572ljp.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJwvm5Q5+ockDf6u3DaRu4ljbIeOieaqkufPDQnk1AU=;
        b=MD7JEdg9LjVjs5eRuO9c1Qio1fzn1ZVgzjEx88mcuMlS75Ytl95hCLewS19zxPGgBK
         QJaIxm686i3EboowyTIt0msSjEDRYa6AvTTGt3wBYLz3++yVPWv0HOBQGBFduTK4AuhM
         m+epdptG3VQoZ8uKJw2YUUzCeEf7jFbZi0GMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJwvm5Q5+ockDf6u3DaRu4ljbIeOieaqkufPDQnk1AU=;
        b=o8kYm703MOXqv4gwEIjs8DqBmKJjN8pTL3j9EihdVNR0oGWivsAbo6aNiHmEGGV8Dl
         gpA1Pe2JYeF3W/MJpt2qK1uV6rUT4oGOTiioRA/ibtomhE34681AMozUG9p1goqaM6HL
         JXsZR5IpEi1OOajIlWyvozcBT1kkdTTdyv8o5gD9kQ+AWlrbcT6z7XLRNGd2GCVc8wPM
         vCL/p/SWxy9XYGJU+0Crqa/1gdTmRzHQhQ78l2xIoYwgXpCqfCIMXB24/Nl/IRXgY60x
         TiJ+YLafgSAcoFiDCtkbFUvOfu9zmBa6ivBWczpkFf+k6WnyhH1Fn4cBAhKBICOSP7Rt
         arRQ==
X-Gm-Message-State: AOAM531uHnAeuv7sDOKY+SqweMXEuSVNVXxYEDKFsxDiAnY44u/b40ug
        qUOevMIxPgks4CmlhuX7XUO86HJAKpIUJPZv
X-Google-Smtp-Source: ABdhPJxFZ2n4qzOIOkJwtd2cg1FdDX9RPMYIdkTMidmp0KFPkaurDU4OxQeUw+N/zmdXjidT36M0zw==
X-Received: by 2002:a2e:87c9:: with SMTP id v9mr5904448ljj.321.1618676841285;
        Sat, 17 Apr 2021 09:27:21 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id x23sm804127lff.162.2021.04.17.09.27.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 09:27:20 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id i10so13564964lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:27:20 -0700 (PDT)
X-Received: by 2002:a05:6512:1192:: with SMTP id g18mr6439868lfr.421.1618676840422;
 Sat, 17 Apr 2021 09:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210416192413.1514419-1-eric.dumazet@gmail.com>
 <CAHk-=wjbvzCAhAtvG0d81W5o0-KT5PPTHhfJ5ieDFq+bGtgOYg@mail.gmail.com> <CAHk-=wgdyusj4Sz6zVOGvD8pNiYmPik3t4-o0TXB9cTUgz_0uw@mail.gmail.com>
In-Reply-To: <CAHk-=wgdyusj4Sz6zVOGvD8pNiYmPik3t4-o0TXB9cTUgz_0uw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Apr 2021 09:27:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYVZZpqDGH2Q=kMOyOqBhpbt8t8JdEWZHDGrPiV=_ifA@mail.gmail.com>
Message-ID: <CAHk-=wjYVZZpqDGH2Q=kMOyOqBhpbt8t8JdEWZHDGrPiV=_ifA@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: small optimization in unsafe_copy_to_user()
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: multipart/mixed; boundary="00000000000014ade305c02d9269"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000014ade305c02d9269
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 17, 2021 at 9:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Side note: I'm, looking at the readdir cases that I wrote, and I have
> to just say that is broken too. So "stones and glass houses" etc, and
> I'll have to fix that too.

In particular, the very very old OLD_READDIR interface that only fills
in one dirent at a time didn't call verify_dirent_name(). Same for the
compat version.

This requires a corrupt filesystem to be an issue (and even then,
most/all would have the length of a directory entry in an 'unsigned
char', so even corrupt filesystems would generally never have a
negative name length).

So I don't think it's an issue in _practice_, but at the same time it
is very much an example of the same issue that put_cmsg() has in
net-next: unsafe user copies should be fully guarded and not have some
"but this would never happen because callers would never do anything
bad".

Al - fairly trivial patch applied, comments?

             Linus

--00000000000014ade305c02d9269
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_knlybvem0>
X-Attachment-Id: f_knlybvem0

IGZzL3JlYWRkaXIuYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZnMvcmVhZGRpci5jIGIvZnMvcmVhZGRpci5jCmluZGV4IDE5NDM0YjNj
OTgyYy4uMDllOGVkN2Q0MTYxIDEwMDY0NAotLS0gYS9mcy9yZWFkZGlyLmMKKysrIGIvZnMvcmVh
ZGRpci5jCkBAIC0xNTAsNiArMTUwLDkgQEAgc3RhdGljIGludCBmaWxsb25lZGlyKHN0cnVjdCBk
aXJfY29udGV4dCAqY3R4LCBjb25zdCBjaGFyICpuYW1lLCBpbnQgbmFtbGVuLAogCiAJaWYgKGJ1
Zi0+cmVzdWx0KQogCQlyZXR1cm4gLUVJTlZBTDsKKwlidWYtPnJlc3VsdCA9IHZlcmlmeV9kaXJl
bnRfbmFtZShuYW1lLCBuYW1sZW4pOworCWlmIChidWYtPnJlc3VsdCA8IDApCisJCXJldHVybiBi
dWYtPnJlc3VsdDsKIAlkX2lubyA9IGlubzsKIAlpZiAoc2l6ZW9mKGRfaW5vKSA8IHNpemVvZihp
bm8pICYmIGRfaW5vICE9IGlubykgewogCQlidWYtPnJlc3VsdCA9IC1FT1ZFUkZMT1c7CkBAIC00
MDUsNiArNDA4LDkgQEAgc3RhdGljIGludCBjb21wYXRfZmlsbG9uZWRpcihzdHJ1Y3QgZGlyX2Nv
bnRleHQgKmN0eCwgY29uc3QgY2hhciAqbmFtZSwKIAogCWlmIChidWYtPnJlc3VsdCkKIAkJcmV0
dXJuIC1FSU5WQUw7CisJYnVmLT5yZXN1bHQgPSB2ZXJpZnlfZGlyZW50X25hbWUobmFtZSwgbmFt
bGVuKTsKKwlpZiAoYnVmLT5yZXN1bHQgPCAwKQorCQlyZXR1cm4gYnVmLT5yZXN1bHQ7CiAJZF9p
bm8gPSBpbm87CiAJaWYgKHNpemVvZihkX2lubykgPCBzaXplb2YoaW5vKSAmJiBkX2lubyAhPSBp
bm8pIHsKIAkJYnVmLT5yZXN1bHQgPSAtRU9WRVJGTE9XOwo=
--00000000000014ade305c02d9269--
