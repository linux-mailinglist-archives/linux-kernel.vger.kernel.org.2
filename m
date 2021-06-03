Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D939A9FC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFCS1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhFCS1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:27:23 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D746C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 11:25:38 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id p17so9485599lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yrZQXkdoWWUth91gvSrDmAM3rcJ5jau3LD6S8sHHrE=;
        b=gkR0j3P/e9anWMAAzOG92R2BRdjIWlcLHPCDChWlOGqnJaz0+Qapx/QB8tuetiHiLa
         pApFXNfaBQHl1JPVrc5YeamoGvFC963PMzsbyIHRnLn4JEK7WnSBLFslEPF/9i84DqDU
         2G1JcwH8LYKBmJsEWWHWGdS86Fq7CrthuiDI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yrZQXkdoWWUth91gvSrDmAM3rcJ5jau3LD6S8sHHrE=;
        b=uDp7kfLK6JTg7KdJX4lkbaGZ17Yfc4acV5fKCp459nlmZhxWd94MyUdjJt5A9Tnj0V
         1ZICPDA6TP9IC9sryE7bPszPIt0xXYNgyu3RZ4Xq8/ppH17aHJzFZ5xbIOSJ5fvsQfmX
         LpUY0He9NE5TjS2ZMO0ZBvR0uvc89FoKNzvceMO+jopeVkc+XQnJrHmK60JzIFZ/z79a
         lP5YcpjsJzgBLXJC6dAFLlIJVcvUjXGIx8gUa6MLyDcsb6PEQxvsEZFuqV9y4HpgMvNO
         Fvc0UmBfd2Emncmnjah6u/hQBVXAtlgFwfZi2wde5dmY3gv5eZ7ovy0c2UqEJVupV6ka
         Pd0g==
X-Gm-Message-State: AOAM531B00uWIZ9+Vc8WAwwo8NnW9c61Yxw8xO0JAtWM8soj2KWIHfNa
        4ykRF4fUWJrNs/SySPMAo6rPiNkZJrh6Wozr
X-Google-Smtp-Source: ABdhPJw3tvhFT3br6X1LibIiYp0IOiyZvHDxeujIexwO7H5R5QuIQbjB/dkkZ182rjHoMCZX+3gvcQ==
X-Received: by 2002:a19:8b57:: with SMTP id n84mr165230lfd.13.1622744733211;
        Thu, 03 Jun 2021 11:25:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c17sm383599lfi.295.2021.06.03.11.25.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 11:25:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w33so10253711lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:25:32 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr151892lfs.377.1622744732051;
 Thu, 03 Jun 2021 11:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
 <1622589753-9206-3-git-send-email-mlin@kernel.org> <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
 <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org> <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Jun 2021 11:25:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com>
Message-ID: <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
To:     Hugh Dickins <hughd@google.com>
Cc:     Ming Lin <mlin@kernel.org>, Simon Ser <contact@emersion.fr>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000050d9e705c3e0b31f"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000050d9e705c3e0b31f
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 2, 2021 at 5:46 PM Hugh Dickins <hughd@google.com> wrote:
>
> Ideally you can simply call do_anonymous_page() from __do_fault()
> in the VM_FAULT_SIGBUS on VM_NOSIGBUS case.

Heh.

We're actually then back to my original patch.

That one doesn't handle shared mappings (even read-only ones), for the
simple reason that do_anonymous_page() refuses to insert anonymous
pages into a shared mapping, and has

        /* File mapping without ->vm_ops ? */
        if (vma->vm_flags & VM_SHARED)
                return VM_FAULT_SIGBUS;

at the very top.

But yes, if we just remove that check, I think my original patch
should actually "JustWork(tm)".

I'm attaching it again, with old name and old commentary (ie that

    /* FIXME! We don't have a VM_NOFAULT bit */

should just be replaced with that VM_NOSIGBUS bit instead, and the
#if'ed out region should be enabled.

Oh, and we need to think hard about one more case: mprotect().

In particular, I think the attached patch fails horribly for the case
of a shared mapping that starts out read-only, then inserts a zero
page, then somebody does mprotect(MAP_WRITE), and then writes to the
page. I haven't checked what the write protect fault handler does, but
I think that for a shared mapping it will just make the page dirty and
writable.

Which would be horribly wrong for VM_NOSIGBUS.

So that support infrastructure that adds MAP_NOSIGBUS, and checks that
it is only done on a read-only mapping, also has to make sure that it
clears the VM_MAYWRITE bit when it sets VM_NOSIGBUS.

That way mprotect can't then later make it writable.

Hugh, comments on this approach?

Again: this patch is my *OLD* one, I didn't try to update it to the
new world order. It requires

 - Ming's MAP_NOSIGBUS ccode

 - removal of that "File mapping without ->vm_ops" case

 - that FIXME fixed and name updated

 - and that VM_MAYWRITE clearing if VM_NOSIGBUS is set, to avoid the
mprotect issue.

Hmm?

                  Linus

--00000000000050d9e705c3e0b31f
Content-Type: text/x-patch; charset="US-ASCII"; name="VM_NOSIGBUS.patch"
Content-Disposition: attachment; filename="VM_NOSIGBUS.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kph87e4o0>
X-Attachment-Id: f_kph87e4o0

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
--00000000000050d9e705c3e0b31f--
