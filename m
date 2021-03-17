Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA6633FBBB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 00:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCQXOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 19:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQXNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:13:53 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2561AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 16:13:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z25so5252143lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 16:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVkqRMI0ahGC11V2DRBFaX+v+O88uX9jjkq1wIMGDAA=;
        b=Ch+F8nNRlTfyjKAzofL0cRwItdfovAzFW7vYbLgWJ7xrQTXk7DiWE93fE7uPfozHZf
         A4TV8T22Cy1l3ongzr77Az2/3rCrZbd3jSEpZPhmbqJB6nYUoFHh+cb4QSsDLbfFg0Xl
         reW8e+tbp0A5ukHDSbKerzC74d2cKhUotxw8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVkqRMI0ahGC11V2DRBFaX+v+O88uX9jjkq1wIMGDAA=;
        b=lNkw89t6nvMnnlOlpiBTGdH9LqQIRgrcZdniauCvjroO5ChInUBExvRAdfk74qJ+fW
         sl9xoBCgtW8zV2TWaop0BGDwTGX3qUi+Wv1E0sh1DFSz5HDKHQyt6jfM7Hx5yWQ7jINY
         GE3lkTRIQQAnSW+BJy3i6RLR9q5eavWvNRTqwF5CMseshQyN5Qdt0W/sJ/8Y4s+0LPwE
         IwoPAd/FBY9QY9/AyjXshWN8ABy9nOngUDWPckLO8tGTGVqF+aEOQNbpfC6iok5bHY3i
         xDtj4GPnDR2wOCJ//lonm/M5DlYUYdoZOAu5b29ieFQMTmoumaeFn9p5IarM0Q+PZYFE
         p6Eg==
X-Gm-Message-State: AOAM531uk5iW41Bk1z79xxOEpl6ulNzk1cUebLNTpNGg/7kA5G6KLpZE
        rf7B4ofXrQCt2DYIYw7hf12Ssa29VdZdug==
X-Google-Smtp-Source: ABdhPJzFq6knG+Oe8q4Nof6z9fAYvK6MAZnnlc8BXWXZ7rNPWsYPJ7MZPoT7IFyoIIx4MBq7CQBrmQ==
X-Received: by 2002:a2e:921a:: with SMTP id k26mr3209251ljg.149.1616022830796;
        Wed, 17 Mar 2021 16:13:50 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d13sm18849lfi.247.2021.03.17.16.13.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 16:13:48 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s17so5248771ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 16:13:48 -0700 (PDT)
X-Received: by 2002:a2e:864d:: with SMTP id i13mr3572254ljj.48.1616022828351;
 Wed, 17 Mar 2021 16:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210317075427.587806-1-npiggin@gmail.com> <89cb49c0-2736-dd4c-f401-4b88c22cc11f@rasmusvillemoes.dk>
 <1615977781.fijkhk7ep5.astroid@bobo.none> <CAHk-=whKnamUnZaJQ+fcqYoLJfc8QB8dv6=2P7o-XPBDOtbF3w@mail.gmail.com>
 <1616017462.cmzed2nj60.astroid@bobo.none>
In-Reply-To: <1616017462.cmzed2nj60.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Mar 2021 16:13:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgycEJkRApK+Cd2BOuy9Wqb054zN8FO1JY21q6Ao4qRNQ@mail.gmail.com>
Message-ID: <CAHk-=wgycEJkRApK+Cd2BOuy9Wqb054zN8FO1JY21q6Ao4qRNQ@mail.gmail.com>
Subject: Re: [PATCH v2] Increase page and bit waitqueue hash size
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a26ca905bdc3a235"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a26ca905bdc3a235
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 17, 2021 at 3:23 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Might take some time to get a system and run tests. We actually had
> difficulty recreating it before this patch too, so it's kind of
> hard to say _that_ was the exact case that previously ran badly and
> is now fixed. We thought just the statistical nature of collisions
> and page / lock contention made things occasionally line up and
> tank.

Yeah, it probably depends a lot on the exact page allocation patterns
and just bad luck.  Plus the actual spinlocks will end up with false
sharing anyway, so you might need to have both contention on multiple
pages on the same hash queue _and_ perhaps some action on other pages
that just hash close-by so that they make the cache coherency protocol
have to work harder..

And then 99% of the time it all just works out fine, because we only
need to look at the hashed spinlocks when we have any contention on
the page lock in the first place, and that generally should be
something we should avoid for other reasons.

But it is perhaps also a sign that while 256 entries is "ridiculously
small", it might be the case that it's not necessarily much of a real
problem in the end, and I get the feeling that growing it by several
orders of magnitude is overkill.

In fact, the problems we have had with the page wait queue have often
been because we did too much page locking in the first place.

I actually have a couple of patches in my "still thinking about it
tree" (that have been there for six months by now, so maybe not
thinking too _actively_ about it) which remove some overly stupid page
locking.

For example, look at "do_shared_fault()". Currently __do_fault()
always locks the result page. Then if you have a page_mkwrite()
function, we immediately unlock it again. And then we lock it again in
do_page_mkwrite().

Does that particular case matter? I really have no idea. But we
basically lock it twice for what looks like absolutely zero reason
other than calling conventions.

Bah. I'll just attach my three "not very actively thinking about it"
patches here in case anybody else wants to not actively think about
them.

I've actually been running these on my own machine since October,
since the kernel I actually boot on my main desktop always includes my
"thinking about it" patches.

The two first patches should fix the double lock thing I mentioned.

The third patch should be a no-op right now, but the thinking is
outlined in the commit message: why do we even lock pages in
filemap_fault? I'm not actually convinced we need to. I think we could
return an unputodate page unlocked, and instead do the checking at pte
install time (I had some discussions with Kirill about instead doing
it at pte install time, and depending entirely on memory ordering
constraints wrt page truncation that *does* take the page lock, and
then does various other checks - including the page mapcount and
taking the ptl lock - under that lock).

Anyway, I don't mind the "make the hash table larger" regardless of
this, but I do want it to be documented a bit more.

               Linus

--000000000000a26ca905bdc3a235
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-move-final-page-locking-out-of-__do_fault-helper-.patch"
Content-Disposition: attachment; 
	filename="0001-mm-move-final-page-locking-out-of-__do_fault-helper-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kme1xgj00>
X-Attachment-Id: f_kme1xgj00

RnJvbSBlZmRjM2ZlYWRiNDkzYWU3ZjI0YzU3M2M4Yjg2M2Q3YTUxMTE3MzkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMTMgT2N0IDIwMjAgMTA6MjI6MDAgLTA3MDAKU3ViamVjdDog
W1BBVENIIDEvM10gbW06IG1vdmUgZmluYWwgcGFnZSBsb2NraW5nIG91dCBvZiBfX2RvX2ZhdWx0
KCkgaGVscGVyCiBpbnRvIGNhbGxlcnMKClRoZSBvbGQgc2VtYW50aWNzIG9mIG91ciBfX2RvX2Zh
dWx0KCkgaGVscGVyIHdhcyB0aGF0IGl0IGFsd2F5cyBsb2NrZWQKdGhlIHBhZ2UgdW5sZXNzIHRo
ZXJlIHdhcyBhbiBlcnJvciAob3IgdW5sZXNzIHRoZSBmYXVsdGluZyBoYWQgYWxyZWFkeQpoYW5k
bGVkIGEgQ09XIGV2ZW50KS4KClRoYXQgdHVybnMgb3V0IHRvIGJlIGEgbWlzdGFrZS4gIE5vdCBh
bGwgY2FsbGVycyBhY3R1YWxseSB3YW50IHRoZSBwYWdlCmxvY2tlZCBhdCBhbGwsIGFuZCB0aGV5
IG1pZ2h0IGFzIHdlbGwgY2hlY2sgdGhlIHNhbWUgVk1fRkFVTFRfTE9DS0VEIGJpdAp0aGF0IF9f
ZG9fZmF1bHQoKSBpdHNlbGYgY2hlY2tlZCB3aGV0aGVyIHRoZSBwYWdlIGlzIGFscmVhZHkgbG9j
a2VkIG9yCm5vdC4KClRoaXMgY2hhbmdlIG9ubHkgbW92ZXMgdGhhdCBmaW5hbCBwYWdlIGxvY2tp
bmcgb3V0IGludG8gdGhlIGNhbGxlcnMsIGJ1dAppbnRlbnRpb25hbGx5IGRvZXMgbm90IGFjdHVh
bGx5IGNoYW5nZSBhbnkgb2YgdGhlIGxvY2tpbmcgc2VtYW50aWNzOiB0aGUKY2FsbGVycyB3aWxs
IG5vdCBqdXN0IGRvIHRoYXQgZmluYWwgcGFnZSBsb2NraW5nIHRoZW1zZWx2ZXMgaW5zdGVhZC4K
ClRoYXQgbWVhbnMgdGhhdCBmdXR1cmUgcGF0Y2hlcyBtYXkgdGhlbiBkZWNpZGUgdG8gbm90IGxv
Y2sgdGhlIHBhZ2UKYWZ0ZXIgYWxsLCBidXQgdGhpcyBpcyBqdXN0IHByZXBhcmF0aW9uIGZvciBh
bnkgc3VjaCBmdXR1cmUgY2hhbmdlLgoKU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRv
cnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIG1tL21lbW9yeS5jIHwgMjAgKysrKysr
KysrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggNWVm
YTA3ZmI2Y2RjLi4xZTI3OTZkNjhlNDMgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21t
L21lbW9yeS5jCkBAIC0zNjQ3LDExICszNjQ3LDYgQEAgc3RhdGljIHZtX2ZhdWx0X3QgX19kb19m
YXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKIAkJcmV0dXJuIFZNX0ZBVUxUX0hXUE9JU09OOwog
CX0KIAotCWlmICh1bmxpa2VseSghKHJldCAmIFZNX0ZBVUxUX0xPQ0tFRCkpKQotCQlsb2NrX3Bh
Z2Uodm1mLT5wYWdlKTsKLQllbHNlCi0JCVZNX0JVR19PTl9QQUdFKCFQYWdlTG9ja2VkKHZtZi0+
cGFnZSksIHZtZi0+cGFnZSk7Ci0KIAlyZXR1cm4gcmV0OwogfQogCkBAIC0zOTQwLDYgKzM5MzUs
MTEgQEAgc3RhdGljIHZtX2ZhdWx0X3QgZG9fcmVhZF9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZt
ZikKIAlpZiAodW5saWtlbHkocmV0ICYgKFZNX0ZBVUxUX0VSUk9SIHwgVk1fRkFVTFRfTk9QQUdF
IHwgVk1fRkFVTFRfUkVUUlkpKSkKIAkJcmV0dXJuIHJldDsKIAorCWlmICh1bmxpa2VseSghKHJl
dCAmIFZNX0ZBVUxUX0xPQ0tFRCkpKQorCQlsb2NrX3BhZ2Uodm1mLT5wYWdlKTsKKwllbHNlCisJ
CVZNX0JVR19PTl9QQUdFKCFQYWdlTG9ja2VkKHZtZi0+cGFnZSksIHZtZi0+cGFnZSk7CisKIAly
ZXQgfD0gZmluaXNoX2ZhdWx0KHZtZik7CiAJdW5sb2NrX3BhZ2Uodm1mLT5wYWdlKTsKIAlpZiAo
dW5saWtlbHkocmV0ICYgKFZNX0ZBVUxUX0VSUk9SIHwgVk1fRkFVTFRfTk9QQUdFIHwgVk1fRkFV
TFRfUkVUUlkpKSkKQEAgLTM5NzEsNiArMzk3MSwxMSBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkb19j
b3dfZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYpCiAJaWYgKHJldCAmIFZNX0ZBVUxUX0RPTkVf
Q09XKQogCQlyZXR1cm4gcmV0OwogCisJaWYgKHVubGlrZWx5KCEocmV0ICYgVk1fRkFVTFRfTE9D
S0VEKSkpCisJCWxvY2tfcGFnZSh2bWYtPnBhZ2UpOworCWVsc2UKKwkJVk1fQlVHX09OX1BBR0Uo
IVBhZ2VMb2NrZWQodm1mLT5wYWdlKSwgdm1mLT5wYWdlKTsKKwogCWNvcHlfdXNlcl9oaWdocGFn
ZSh2bWYtPmNvd19wYWdlLCB2bWYtPnBhZ2UsIHZtZi0+YWRkcmVzcywgdm1hKTsKIAlfX1NldFBh
Z2VVcHRvZGF0ZSh2bWYtPmNvd19wYWdlKTsKIApAQCAtMzk5NCw2ICszOTk5LDExIEBAIHN0YXRp
YyB2bV9mYXVsdF90IGRvX3NoYXJlZF9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKIAlpZiAo
dW5saWtlbHkocmV0ICYgKFZNX0ZBVUxUX0VSUk9SIHwgVk1fRkFVTFRfTk9QQUdFIHwgVk1fRkFV
TFRfUkVUUlkpKSkKIAkJcmV0dXJuIHJldDsKIAorCWlmICh1bmxpa2VseSghKHJldCAmIFZNX0ZB
VUxUX0xPQ0tFRCkpKQorCQlsb2NrX3BhZ2Uodm1mLT5wYWdlKTsKKwllbHNlCisJCVZNX0JVR19P
Tl9QQUdFKCFQYWdlTG9ja2VkKHZtZi0+cGFnZSksIHZtZi0+cGFnZSk7CisKIAkvKgogCSAqIENo
ZWNrIGlmIHRoZSBiYWNraW5nIGFkZHJlc3Mgc3BhY2Ugd2FudHMgdG8ga25vdyB0aGF0IHRoZSBw
YWdlIGlzCiAJICogYWJvdXQgdG8gYmVjb21lIHdyaXRhYmxlCi0tIAoyLjMwLjAuMzUyLmdmNmEw
NTY4NGU2Cgo=
--000000000000a26ca905bdc3a235
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-mm-don-t-lock-the-page-only-to-immediately-unlock-it.patch"
Content-Disposition: attachment; 
	filename="0002-mm-don-t-lock-the-page-only-to-immediately-unlock-it.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kme1xjgl1>
X-Attachment-Id: f_kme1xjgl1

RnJvbSAxYjJiMDYxZjYyMmVhNjA5MjRlYmE4ODY5NzUxODMzMDZhYTU2OTcyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMTMgT2N0IDIwMjAgMTA6NDM6MDUgLTA3MDAKU3ViamVjdDog
W1BBVENIIDIvM10gbW06IGRvbid0IGxvY2sgdGhlIHBhZ2UsIG9ubHkgdG8gaW1tZWRpYXRlbHkg
dW5sb2NrIGl0CiBhZ2FpbiBmb3IgZG9fcGFnZV9ta3dyaXRlKCkKCk91ciBwYWdlIGxvY2tpbmcg
ZHVyaW5nIGZhdWx0IGhhbmRsaW5nIGEgYml0IG1lc3N5LCBhbmQgdGhlIHNoYXJlZCBmYXVsdApj
b2RlIGluIHBhcnRpY3VsYXIgd2FzIGxvY2tpbmcgdGhlIHBhZ2Ugb25seSB0byBpbW1lZGlhdGVs
eSB1bmxvY2sgaXQKYWdhaW4gYmVjYXVzZSBkb19wYWdlX21rd3JpdGUoKSB3YW50ZWQgaXQgdW5s
b2NrZWQuCgpXZSBrZWVwIHRoZSAiZGlkIHdlIGxvY2sgaXQiIHN0YXRlIGFyb3VuZCBpbiB0aGUg
Vk1fRkFVTFRfTE9DS0VEIGJpdCwgc28KbGV0J3MganVzdCB1c2UgdGhhdCBrbm93bGVkZ2UsIGFu
ZCBub3QgZmlyc3QgbG9jayBpdCBpZiBpdCB3YXNuJ3QKbG9ja2VkLCBvbmx5IHRvIHRoZW4gdW5s
b2NrIGl0IGFnYWluLgoKSXQgd291bGQgYmUgZXZlbiBiZXR0ZXIgdG8gdHJhbnNmZXIgdGhlICJk
aWQgd2UgYWxyZWFkeSBsb2NrIHRoaXMgcGFnZSIKaW5mb3JtYXRpb24gaW50byBkb19wYWdlX21r
d3JpdGUoKSwgYmVjYXVzZSB0aGF0IGZ1bmN0aW9uIHdpbGwgYWN0dWFsbHkKd2FudCB0byBsb2Nr
IGl0IGV2ZW50dWFsbHkgYW55d2F5LCBidXQgbGV0J3MganVzdCBjbGVhbiB1cCBvbmUgdGhpbmcg
YXQKYSB0aW1lLgoKU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4
LWZvdW5kYXRpb24ub3JnPgotLS0KIG1tL21lbW9yeS5jIHwgMjAgKysrKysrKysrKysrKystLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggMWUyNzk2ZDY4ZTQzLi5k
N2UzMDI3M2JlZjEgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21tL21lbW9yeS5jCkBA
IC0zOTk5LDI1ICszOTk5LDMzIEBAIHN0YXRpYyB2bV9mYXVsdF90IGRvX3NoYXJlZF9mYXVsdChz
dHJ1Y3Qgdm1fZmF1bHQgKnZtZikKIAlpZiAodW5saWtlbHkocmV0ICYgKFZNX0ZBVUxUX0VSUk9S
IHwgVk1fRkFVTFRfTk9QQUdFIHwgVk1fRkFVTFRfUkVUUlkpKSkKIAkJcmV0dXJuIHJldDsKIAot
CWlmICh1bmxpa2VseSghKHJldCAmIFZNX0ZBVUxUX0xPQ0tFRCkpKQotCQlsb2NrX3BhZ2Uodm1m
LT5wYWdlKTsKLQllbHNlCi0JCVZNX0JVR19PTl9QQUdFKCFQYWdlTG9ja2VkKHZtZi0+cGFnZSks
IHZtZi0+cGFnZSk7Ci0KIAkvKgogCSAqIENoZWNrIGlmIHRoZSBiYWNraW5nIGFkZHJlc3Mgc3Bh
Y2Ugd2FudHMgdG8ga25vdyB0aGF0IHRoZSBwYWdlIGlzCiAJICogYWJvdXQgdG8gYmVjb21lIHdy
aXRhYmxlCiAJICovCiAJaWYgKHZtYS0+dm1fb3BzLT5wYWdlX21rd3JpdGUpIHsKLQkJdW5sb2Nr
X3BhZ2Uodm1mLT5wYWdlKTsKKwkJLyogZG9fcGFnZV9ta3dyaXRlKCkgd2FudHMgdGhlIHBhZ2Ug
dW5sb2NrZWQgKi8KKwkJaWYgKHJldCAmIFZNX0ZBVUxUX0xPQ0tFRCkgeworCQkJdW5sb2NrX3Bh
Z2Uodm1mLT5wYWdlKTsKKwkJCXJldCAmPSB+Vk1fRkFVTFRfTE9DS0VEOworCQl9CisKIAkJdG1w
ID0gZG9fcGFnZV9ta3dyaXRlKHZtZik7CiAJCWlmICh1bmxpa2VseSghdG1wIHx8CiAJCQkJKHRt
cCAmIChWTV9GQVVMVF9FUlJPUiB8IFZNX0ZBVUxUX05PUEFHRSkpKSkgewogCQkJcHV0X3BhZ2Uo
dm1mLT5wYWdlKTsKIAkJCXJldHVybiB0bXA7CiAJCX0KKworCQkvKiBEaWQgZG9fcGFnZV9ta3dy
aXRlKCkgbG9jayB0aGUgcGFnZSBhZ2Fpbj8gKi8KKwkJcmV0IHw9IHRtcCAmIFZNX0ZBVUxUX0xP
Q0tFRDsKIAl9CiAKKwlpZiAodW5saWtlbHkoIShyZXQgJiBWTV9GQVVMVF9MT0NLRUQpKSkKKwkJ
bG9ja19wYWdlKHZtZi0+cGFnZSk7CisJZWxzZQorCQlWTV9CVUdfT05fUEFHRSghUGFnZUxvY2tl
ZCh2bWYtPnBhZ2UpLCB2bWYtPnBhZ2UpOworCiAJcmV0IHw9IGZpbmlzaF9mYXVsdCh2bWYpOwog
CWlmICh1bmxpa2VseShyZXQgJiAoVk1fRkFVTFRfRVJST1IgfCBWTV9GQVVMVF9OT1BBR0UgfAog
CQkJCQlWTV9GQVVMVF9SRVRSWSkpKSB7Ci0tIAoyLjMwLjAuMzUyLmdmNmEwNTY4NGU2Cgo=
--000000000000a26ca905bdc3a235
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-mm-do_cow_fault-does-not-need-the-source-page-to-be-.patch"
Content-Disposition: attachment; 
	filename="0003-mm-do_cow_fault-does-not-need-the-source-page-to-be-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kme1xm4i2>
X-Attachment-Id: f_kme1xm4i2

RnJvbSA3Y2Y1YWQ4MTY0MTIxNGQyYzRiYjY0MDRiNjQ0MzZhNzg3NzkxNzQ5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMTMgT2N0IDIwMjAgMTE6MDA6MzMgLTA3MDAKU3ViamVjdDog
W1BBVENIIDMvM10gbW06IGRvX2Nvd19mYXVsdCgpIGRvZXMgbm90IG5lZWQgdGhlIHNvdXJjZSBw
YWdlIHRvIGJlCiBsb2NrZWQKClRoaXMgcmVtb3ZlcyB0aGUgImxvY2sgaWYgaXQgd2Fzbid0IGxv
Y2tlZCIgbG9naWMgZnJvbSBkb19jb3dfZmF1bHQoKSwKc2luY2Ugd2UncmUgbm90IGV2ZW4gZ29p
bmcgdG8gaW5zdGFsbCB0aGF0IHBhZ2UgaW50byB0aGUgZGVzdGluYXRpb24KYWRkcmVzcyBzcGFj
ZSAoZmluaXNoX2ZhdWx0KCkgd2lsbCB1c2UgLT5jb3dfcGFnZSByYXRoZXIgdGhhbiAtPnBhZ2Up
LAphbmQgY29weWluZyB0aGUgc291cmNlIHBhZ2UgZG9lcyBub3QgbmVlZCB0aGUgc291cmNlIHRv
IGJlIGxvY2tlZC4KClNvIGluc3RlYWQgb2YgZG9pbmcgImxvY2sgaWYgaXQgd2Fzbid0IGxvY2tl
ZCIgZm9sbG93ZWQgYnkgYW4KdW5jb25kaXRpb25hbCB1bmxvY2sgb2YgdGhlIHBhZ2UsIGp1c3Qg
ZG8gInVubG9jayBpZiBpdCB3YXMgbG9ja2VkIi4KCk9mIGNvdXJzZSwgc2luY2UgYWxsIHRoZSBu
b3JtYWwgZmlsZSBtYXBwaW5nIC0+ZmF1bHQoKSBoYW5kbGVycwpjdXJyZW50bHkgbG9jayB0aGUg
cGFnZSB0aGV5IHJldHVybiAoc2VlIGZpbGVtYXBfZmF1bHQoKSBmb3IgZGV0YWlscyksCmFsbCBv
ZiB0aGlzIGlzIHByZXR0eSBtdWNoIHRoZW9yZXRpY2FsLgoKQnV0IHRoaXMgaXMgdGhlIHJpZ2h0
IHRoaW5nIHRvIGRvIC0gbWFraW5nIHN1cmUgd2UgaG9sZCB0aGUgcGFnZSBsb2NrCndoZW4gd2Ug
cmVhbGx5IGRvbid0IGlzIGp1c3QgY29uZnVzaW5nIGFuZCB3cm9uZy4gIEFuZCB0aGlzIHByZXBh
cmVzIHRoZQp3YXkgZm9yIGFueSBmdXR1cmUgY2hhbmdlcyB0byBmaWxlbWFwX2ZhdWx0KCkgd2hl
cmUgd2UgZ28gIk9oLCB3ZQphY3R1YWxseSBfZG9uJ3RfIG5lZWQgdG8gbG9jayB0aGUgcGFnZSBm
b3IgdGhpcyBjYXNlIGF0IGFsbCIuCgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9y
dmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ci0tLQogbW0vbWVtb3J5LmMgfCA5ICsrKy0tLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9tbS9tZW1vcnkuYyBiL21tL21lbW9yeS5jCmluZGV4IGQ3ZTMwMjczYmVmMS4uNDQ2
NTNiNWIyYWY2IDEwMDY0NAotLS0gYS9tbS9tZW1vcnkuYworKysgYi9tbS9tZW1vcnkuYwpAQCAt
Mzk3MSwxNiArMzk3MSwxMyBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkb19jb3dfZmF1bHQoc3RydWN0
IHZtX2ZhdWx0ICp2bWYpCiAJaWYgKHJldCAmIFZNX0ZBVUxUX0RPTkVfQ09XKQogCQlyZXR1cm4g
cmV0OwogCi0JaWYgKHVubGlrZWx5KCEocmV0ICYgVk1fRkFVTFRfTE9DS0VEKSkpCi0JCWxvY2tf
cGFnZSh2bWYtPnBhZ2UpOwotCWVsc2UKLQkJVk1fQlVHX09OX1BBR0UoIVBhZ2VMb2NrZWQodm1m
LT5wYWdlKSwgdm1mLT5wYWdlKTsKLQogCWNvcHlfdXNlcl9oaWdocGFnZSh2bWYtPmNvd19wYWdl
LCB2bWYtPnBhZ2UsIHZtZi0+YWRkcmVzcywgdm1hKTsKIAlfX1NldFBhZ2VVcHRvZGF0ZSh2bWYt
PmNvd19wYWdlKTsKIAorCWlmIChyZXQgJiBWTV9GQVVMVF9MT0NLRUQpCisJCXVubG9ja19wYWdl
KHZtZi0+cGFnZSk7CisKIAlyZXQgfD0gZmluaXNoX2ZhdWx0KHZtZik7Ci0JdW5sb2NrX3BhZ2Uo
dm1mLT5wYWdlKTsKIAlwdXRfcGFnZSh2bWYtPnBhZ2UpOwogCWlmICh1bmxpa2VseShyZXQgJiAo
Vk1fRkFVTFRfRVJST1IgfCBWTV9GQVVMVF9OT1BBR0UgfCBWTV9GQVVMVF9SRVRSWSkpKQogCQln
b3RvIHVuY2hhcmdlX291dDsKLS0gCjIuMzAuMC4zNTIuZ2Y2YTA1Njg0ZTYKCg==
--000000000000a26ca905bdc3a235--
