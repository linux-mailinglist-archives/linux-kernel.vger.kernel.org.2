Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6892F36C9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbhD0QxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbhD0QxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:53:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A1DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:52:17 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z13so13737127lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWgiXXfQaK0E33cCutMhNkSO5fLITDBcM8ObK3fClQs=;
        b=JSoo1Q6Ux6YVilEdDbBvktfmzKgysH8k6pccBG6Qan8acirVHJn4ANbg4FH2qQ4Pou
         DojPQcZAWe1Pf17RFLfyAgzQSfqa26ZYj+nYt9DhnbJYYfefGNCaCv8u70BhOf7menPv
         tPpOwGsgE/DLkHJ9nUE/mt+94Rx8RnOP2eSLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWgiXXfQaK0E33cCutMhNkSO5fLITDBcM8ObK3fClQs=;
        b=ZobkAbv8KO7Qsl+Yqlsl7cqqO7jINMdbs1EFyLQfZvzpGR/MA28x0WZIrNZnEwJNKe
         jipDbKtC+57kLAElbcpxYW5svwA0TCuJYxDYAnoZpwYcU8DQANIySpm5NpY1ZpUbeihD
         rrH4Jez734cf3KaI3eVXHCTiKvEJTvascUlTArTQy+KFGThRx/j82hDd9E5O2Vwp65Zt
         Y46xoGKtMuDhV7AsqGncWsg+hNk4awqq4NmDhQ7QubrWoVLQWjcbY9Iyq3XoQuk+nQ0H
         n1La3oBUgCe4FgQ/r49yf3OXYEBkPeFJWWBxLO2ORzuCKuWq/DSe3Jy07WdTEnJHn8bV
         7LOw==
X-Gm-Message-State: AOAM533BOmb9jQpPbYilLAYVWsqeibmnxzT4ZQxxST7wo/jBxqLqmhKk
        XOSQqVk22IRbqrJsNx+waIifHjetf8cgoSPD
X-Google-Smtp-Source: ABdhPJzoSV1Vfa0r4Le4odtbfuBBUVd6LDDgGR9YujyvB1CYyPhnWIBPZ0nco0fzfkRr6vboVs3pMQ==
X-Received: by 2002:a05:6512:b25:: with SMTP id w37mr17584753lfu.272.1619542336270;
        Tue, 27 Apr 2021 09:52:16 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h1sm89203lfv.291.2021.04.27.09.52.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 09:52:15 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id a5so31975366ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:52:14 -0700 (PDT)
X-Received: by 2002:a2e:880f:: with SMTP id x15mr15524458ljh.507.1619542334557;
 Tue, 27 Apr 2021 09:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
In-Reply-To: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Apr 2021 09:51:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
Message-ID: <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
Subject: Re: Sealed memfd & no-fault mmap
To:     Simon Ser <contact@emersion.fr>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Content-Type: multipart/mixed; boundary="0000000000008cfa7505c0f7158a"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008cfa7505c0f7158a
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 27, 2021 at 1:25 AM Simon Ser <contact@emersion.fr> wrote:
>
> Rather than requiring changes in all compositors *and* clients, can we
> maybe only require changes in compositors? For instance, OpenBSD has a
> __MAP_NOFAULT flag. When passed to mmap, it means that out-of-bound
> accesses will read as zeroes instead of triggering SIGBUS. Such a flag
> would be very helpful to unblock the annoying SIGBUS situation.
>
> Would something among these lines be welcome in the Linux kernel?

Hmm. It doesn't look too hard to do. The biggest problem is actually
that we've run out of flags in the vma (on 32-bit architectures), but
you could try this UNTESTED patch that just does the MAP_NOFAULT thing
unconditionally.

NOTE! Not only is it untested, not only is this a "for your testing
only" (because it does it unconditionally rather than only for
__MAP_NOFAULT), but it might be bogus for other reasons. In
particular, this patch depends on "vmf->address" not being changed by
the ->fault() infrastructure, so that we can just re-use the vmf for
the anonymous case if we get a SIGBUS.

I think that's all ok these days, because Kirill and Peter Xu cleaned
up those paths, but I didn't actually check. So I'm cc'ing Kirill,
Peter and Will, who have been working in this area for other reasons
fairly recently.

Side note: this will only ever work for non-shared mappings. That's
fundamental. We won't add an anonymous page to a shared mapping, and
do_anonymous_page() does verify that. So a MAP_SHARED mappign will
still return SIGBUS even with this patch (although it's not obvious
from the patch - the VM_FAULT_SIGBUS will just be re-created by
do_anonymous_page()).

So if you want a _shared_ mapping to honor __MAP_NOFAULT and insert
random anonymous pages into it, I think the answer is "no, that's not
going to be viable".

So _if_ this works for you, and if it's ok that only MAP_PRIVATE can
have __MAP_NOFAULT, and if Kirill/Peter/Will don't say "Oh, Linus,
you're completely off your rocker and clearly need to be taking your
meds", something like this - if we figure out the conditional bit -
might be doable.

That's a fair number of "ifs".

Ok, back to the merge window for me, I'll be throwing away this crazy
untested patch immediately after hitting "send". This is very much a
"throw the idea over to other people" patch, in other words.

            Linus

--0000000000008cfa7505c0f7158a
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ko09ogpl0>
X-Attachment-Id: f_ko09ogpl0

IG1tL21lbW9yeS5jIHwgMTkgKysrKysrKysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMg
Yi9tbS9tZW1vcnkuYwppbmRleCA1NTA0MDVmYzNiNWUuLmJiZWRlNmI1MmY3YSAxMDA2NDQKLS0t
IGEvbW0vbWVtb3J5LmMKKysrIGIvbW0vbWVtb3J5LmMKQEAgLTQzMTIsMTAgKzQzMTIsMjEgQEAg
c3RhdGljIHZtX2ZhdWx0X3QgaGFuZGxlX3B0ZV9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikK
IAl9CiAKIAlpZiAoIXZtZi0+cHRlKSB7Ci0JCWlmICh2bWFfaXNfYW5vbnltb3VzKHZtZi0+dm1h
KSkKLQkJCXJldHVybiBkb19hbm9ueW1vdXNfcGFnZSh2bWYpOwotCQllbHNlCi0JCQlyZXR1cm4g
ZG9fZmF1bHQodm1mKTsKKwkJaWYgKCF2bWFfaXNfYW5vbnltb3VzKHZtZi0+dm1hKSkgeworCQkJ
dm1fZmF1bHRfdCByZXQgPSBkb19mYXVsdCh2bWYpOworCQkJaWYgKHJldCAmIFZNX0ZBVUxUX1JF
VFJZKQorCQkJCXJldHVybiByZXQ7CisJCQlpZiAoIShyZXQgJiBWTV9GQVVMVF9TSUdCVVMpKQor
CQkJCXJldHVybiByZXQ7CisvKiBGSVhNRSEgV2UgZG9uJ3QgaGF2ZSBhIFZNX05PRkFVTFQgYml0
ICovCisjaWYgMAorCQkJLyogU2VlIGlmIHdlIHNob3VsZCB0dXJuIGEgU0lHQlVTIGludG8gYW4g
YW5vbnltb3VzIHBhZ2UgKi8KKwkJCWlmICghKHZtYS0+dm1fZmxhZ3MgJiBWTV9OT0ZBVUxUKSkK
KwkJCQlyZXR1cm4gcmV0OworI2VuZGlmCisvKiBGYWxsIGJhY2sgb24gZG9fYW5vbnltb3VzX3Bh
Z2UoKSBpbnN0ZWFkIG9mIFNJR0JVUyAqLworCQl9CisJCXJldHVybiBkb19hbm9ueW1vdXNfcGFn
ZSh2bWYpOwogCX0KIAogCWlmICghcHRlX3ByZXNlbnQodm1mLT5vcmlnX3B0ZSkpCg==
--0000000000008cfa7505c0f7158a--
