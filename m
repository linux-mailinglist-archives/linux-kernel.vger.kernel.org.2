Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74A838B873
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbhETUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhETUdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:33:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B17BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:32:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l70so12679658pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZgGiwCZiDA5AlawfvU9/HxtODB11utRbe57emXz5Cg=;
        b=knAtloNif+kXshJAVzClnchk5Rce2/SXSmqfZbvPPsGSHpV/F/diU1sRxPfz+uyqlp
         t+XpsTtEYn4DMPTpR7kOvBmG0X84msbQqWj0A8uffn0inG3MIXp8tN/YlaDCAYBtYaSd
         dZbNdxeLCKiFyJSXkrZSgPIT5Vuj1TBzjBJr2bZqEsEANJZsnZVXr+U/xxSJfB253Nn5
         h3JJnXKaswkgX7uDv2bQeXqWuE6qzqLozHupzqOI/yjbxgZrbIsplEqqcen9O5JHzBpt
         N8y1smqmaE1R/FNEy29gH0kGkRkuaPZTLgaESlAVfS/3BGxhduWlH+xKTdNwvM0WrPEf
         LOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZgGiwCZiDA5AlawfvU9/HxtODB11utRbe57emXz5Cg=;
        b=JCaIVdvdelUfTTCPWlkYEmPnaMogLHZQu+TMLYjLdOqiocTCFirdXHn1Sz/p9qka9j
         f4KnVMuo3v5korhtIIvlHiA/nBy5DgVV96JWMelH9EddzQon0s4Z8xliwS84dVI6M7Kd
         1VF/YoOOBzn+TmU1fiEr4SZOUbWZNQ5eB0Qql5nZZ8eO+i5qazo/0a7oatL+m1fWYQMv
         AscyfBKhJDplNEpVYW6d8fw1/etD7GYQMLE5iAHyDoI/Tr5Ig4qPvRr5T/aQgNGz76aZ
         412vjvitqHxbKp4nlFfot8pP4BfkLnSRp1MrqoMk9l7LOI5Ay6kPUhhG/sVeMVNO0Nj1
         gSXw==
X-Gm-Message-State: AOAM530NeetUJGHsP3PZJyTX0AI0L/p06POCWcFZk6IqFO0Kr40cnw7s
        G16Spoip1NddOkXdzb8o2uLsxMck7SE/voPfKxkNPA==
X-Google-Smtp-Source: ABdhPJztMR/zlmdndrA0TDZ5daDF+wDJ7q3+oeix1RSdrxGsSaZYr7wiTxcklqDuKe0DrhwHuV5Cw+yfUyqj9wzU/XA=
X-Received: by 2002:aa7:920d:0:b029:2d9:2ead:70dd with SMTP id
 13-20020aa7920d0000b02902d92ead70ddmr6164531pfo.67.1621542719721; Thu, 20 May
 2021 13:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210513234309.366727-1-almasrymina@google.com>
 <CAHS8izNkBvS9gkSjy8FbWBOPDynwr8PXXXbMHt_2=5sZJsa6-Q@mail.gmail.com>
 <09dc0712-48e8-8ba2-f170-4c2febcfff83@oracle.com> <CAHS8izN3+DwCMnVotW7UoiROKEpBh=i+n2jb+oMJQwbKeegx7Q@mail.gmail.com>
 <CAHS8izNECN6U4KDLS-jrtni6WMszK6rF1XjcWwwGAByb3pEr8A@mail.gmail.com> <61c78897-27a2-768b-f4fe-04e24b617ab6@oracle.com>
In-Reply-To: <61c78897-27a2-768b-f4fe-04e24b617ab6@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 20 May 2021 13:31:48 -0700
Message-ID: <CAHS8izOHs0ZYR-0FCsDS6nxYbnNfYJFzWKGwB_utBJ_9bswjkA@mail.gmail.com>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000cc939705c2c8d5fe"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cc939705c2c8d5fe
Content-Type: text/plain; charset="UTF-8"

On Thu, May 20, 2021 at 1:00 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 5/20/21 12:21 PM, Mina Almasry wrote:
> > On Thu, May 20, 2021 at 12:18 PM Mina Almasry <almasrymina@google.com> wrote:
> >>
> >> On Thu, May 13, 2021 at 5:14 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>>
> >>> How about this approach?
> >>> - Keep the check for hugetlbfs_pagecache_present in hugetlb_mcopy_atomic_pte
> >>>   that you added.  That will catch the race where the page was added to
> >>>   the cache before entering the routine.
> >>> - With the above check in place, we only need to worry about the case
> >>>   where copy_huge_page_from_user fails and we must drop locks.  In this
> >>>   case we:
> >>>   - Free the page previously allocated.
> >>>   - Allocate a 'temporary' huge page without consuming reserves.  I'm
> >>>     thinking of something similar to page migration.
> >>>   - Drop the locks and let the copy_huge_page_from_user be done to the
> >>>     temporary page.
> >>>   - When reentering hugetlb_mcopy_atomic_pte after dropping locks (the
> >>>     *pagep case) we need to once again check
> >>>     hugetlbfs_pagecache_present.
> >>>   - We then try to allocate the huge page which will consume the
> >>>     reserve.  If successful, copy contents of temporary page to newly
> >>>     allocated page.  Free temporary page.
> >>>
> >>> There may be issues with this, and I have not given it deep thought.  It
> >>> does abuse the temporary huge page concept, but perhaps no more than
> >>> page migration.  Things do slow down if the extra page allocation and
> >>> copy is required, but that would only be the case if copy_huge_page_from_user
> >>> needs to be done without locks.  Not sure, but hoping that is rare.
> >>
> >> Just following up this a bit: I've implemented this approach locally,
> >> and with it it's passing the test as-is. When I hack the code such
> >> that the copy in hugetlb_mcopy_atomic_pte() always fails, I run into
> >> this edge case, which causes resv_huge_pages to underflow again (this
> >> time permemantly):
> >>
> >> - hugetlb_no_page() is called on an index and a page is allocated and
> >> inserted into the cache consuming the reservation.
> >> - remove_huge_page() is called on this index and the page is removed from cache.
> >> - hugetlb_mcopy_atomic_pte() is called on this index, we do not find
> >> the page in the cache and we trigger this code patch and the copy
> >> fails.
> >> - The allocations in this code path seem to double consume the
> >> reservation and resv_huge_pages underflows.
> >>
> >> I'm looking at this edge case to understand why a prior
> >> remove_huge_page() causes my code to underflow resv_huge_pages.
> >>
> >
> > I should also mention, without a prior remove_huge_page() this code
> > path works fine, so it seems the fact that the reservation is consumed
> > before causes trouble, but I'm not sure why yet.
> >
>
> Hi Mina,
>
> How about quickly posting the code?  I may be able to provide more
> suggestions if I can see the actual code.

Sure thing, attached my patch so far. It's quite messy with prints
everywhere and VM_BUG_ON() in error paths that I'm not handling yet.
I've also hacked the code so that the hugetlb_mcopy_atomic_pte() copy
always fails so I exercise that code path.

> --
> Mike Kravetz

--000000000000cc939705c2c8d5fe
Content-Type: application/octet-stream; 
	name="0001-mm-hugetlb-fix-resv_huge_pages-underflow-on-UFFDIO_C.patch"
Content-Disposition: attachment; 
	filename="0001-mm-hugetlb-fix-resv_huge_pages-underflow-on-UFFDIO_C.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_koxcmqlb0>
X-Attachment-Id: f_koxcmqlb0

RnJvbSBmZjg2YzY5MGY5MjM2ZDhiYTc0Y2IyZWI2ZjUyOWI2MzU0YTk2MjIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5hIEFsbWFzcnkgPGFsbWFzcnltaW5hQGdvb2dsZS5jb20+
CkRhdGU6IFR1ZSwgMTEgTWF5IDIwMjEgMTc6MDE6NTAgLTA3MDAKU3ViamVjdDogW1BBVENIXSBt
bSwgaHVnZXRsYjogZml4IHJlc3ZfaHVnZV9wYWdlcyB1bmRlcmZsb3cgb24gVUZGRElPX0NPUFkK
CnRlc3QgcGFzc2VzLgoKV2l0aCBmb3JjZSBjb3B5IGZhaWwsIHRlc3QgZmFpbHMgcmVzdiB1bmRl
cmZsb3dzIHBlcm1lbmFudGx5LiBTZWVtcwpwYWdlcyBhcmUgYWRkZWQsIHJlbW92ZWQsIHRoZW4g
bm90IGZvdW5kIGluIGNhY2hlIGRvdWJsZSBjb25zdW1pbmcgdGhlCnJlc2VydmF0aW9uLgoKU2ln
bmVkLW9mZi1ieTogTWluYSBBbG1hc3J5IDxhbG1hc3J5bWluYUBnb29nbGUuY29tPgpDYzogQXhl
bCBSYXNtdXNzZW4gPGF4ZWxyYXNtdXNzZW5AZ29vZ2xlLmNvbT4KQ2M6IFBldGVyIFh1IDxwZXRl
cnhAcmVkaGF0LmNvbT4KQ2M6IGxpbnV4LW1tQGt2YWNrLm9yZwpDYzogTWlrZSBLcmF2ZXR6IDxt
aWtlLmtyYXZldHpAb3JhY2xlLmNvbT4KQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmc+CkNjOiBsaW51eC1tbUBrdmFjay5vcmcKQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcKCkNoYW5nZS1JZDogSWRhMjBmMzVmZGZhN2ZjZTU5ODU4MmRjZmExOTk4NDUx
MTVlYWFjMTgKLS0tCiBmcy9odWdldGxiZnMvaW5vZGUuYyB8ICAgNiArKysKIG1tL2h1Z2V0bGIu
YyAgICAgICAgIHwgMTI0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0KIDIgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2ZzL2h1Z2V0bGJmcy9pbm9kZS5jIGIvZnMvaHVnZXRsYmZzL2lub2RlLmMK
aW5kZXggYTJhNDIzMzVlOGZkLi5iYTBiM2ZlODhmMTggMTAwNjQ0Ci0tLSBhL2ZzL2h1Z2V0bGJm
cy9pbm9kZS5jCisrKyBiL2ZzL2h1Z2V0bGJmcy9pbm9kZS5jCkBAIC01MjUsNiArNTI1LDkgQEAg
c3RhdGljIHZvaWQgcmVtb3ZlX2lub2RlX2h1Z2VwYWdlcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBs
b2ZmX3QgbHN0YXJ0LAogCQkJICogdG8gYmUgYWRqdXN0ZWQuCiAJCQkgKi8KIAkJCVZNX0JVR19P
TihQYWdlUHJpdmF0ZShwYWdlKSk7CisJCQlwcmludGsoIiVzOiVkOiVzIHJlbW92aW5nIGh1Z2Ug
cGFnZSwgaWR4PSVkIGgtPnJlc3ZfaHVnZV9wYWdlcz0lZFxuIiwKKwkJCSAgICAgICBfX0ZJTEVf
XywgX19MSU5FX18sIF9fZnVuY19fLCBpbmRleCwKKwkJCSAgICAgICBoLT5yZXN2X2h1Z2VfcGFn
ZXMpOwogCQkJcmVtb3ZlX2h1Z2VfcGFnZShwYWdlKTsKIAkJCWZyZWVkKys7CiAJCQlpZiAoIXRy
dW5jYXRlX29wKSB7CkBAIC01MzIsNiArNTM1LDkgQEAgc3RhdGljIHZvaWQgcmVtb3ZlX2lub2Rl
X2h1Z2VwYWdlcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgbHN0YXJ0LAogCQkJCQkJCWlu
ZGV4LCBpbmRleCArIDEsIDEpKSkKIAkJCQkJaHVnZXRsYl9maXhfcmVzZXJ2ZV9jb3VudHMoaW5v
ZGUpOwogCQkJfQorCQkJcHJpbnRrKCIlczolZDolcyByZW1vdmVkIGh1Z2UgcGFnZSwgaWR4PSVk
IGgtPnJlc3ZfaHVnZV9wYWdlcz0lZFxuIiwKKwkJCSAgICAgICBfX0ZJTEVfXywgX19MSU5FX18s
IF9fZnVuY19fLCBpbmRleCwKKwkJCSAgICAgICBoLT5yZXN2X2h1Z2VfcGFnZXMpOwogCiAJCQl1
bmxvY2tfcGFnZShwYWdlKTsKIAkJCWlmICghdHJ1bmNhdGVfb3ApCmRpZmYgLS1naXQgYS9tbS9o
dWdldGxiLmMgYi9tbS9odWdldGxiLmMKaW5kZXggNjI5YWE0YzIyNTljLi4yZDliNTU3Y2JhZmEg
MTAwNjQ0Ci0tLSBhL21tL2h1Z2V0bGIuYworKysgYi9tbS9odWdldGxiLmMKQEAgLTkzLDYgKzkz
LDI4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBzdWJwb29sX2lzX2ZyZWUoc3RydWN0IGh1Z2VwYWdl
X3N1YnBvb2wgKnNwb29sKQogCXJldHVybiB0cnVlOwogfQogCisvKgorICogR2lnYW50aWMgcGFn
ZXMgYXJlIHNvIGxhcmdlIHRoYXQgd2UgZG8gbm90IGd1YXJhbnRlZSB0aGF0IHBhZ2UrKyBwb2lu
dGVyCisgKiBhcml0aG1ldGljIHdpbGwgd29yayBhY3Jvc3MgdGhlIGVudGlyZSBwYWdlLiAgV2Ug
bmVlZCBzb21ldGhpbmcgbW9yZQorICogc3BlY2lhbGl6ZWQuCisgKi8KK3N0YXRpYyB2b2lkIF9f
Y29weV9naWdhbnRpY19wYWdlKHN0cnVjdCBwYWdlICpkc3QsIHN0cnVjdCBwYWdlICpzcmMsCisJ
CQkJIGludCBucl9wYWdlcykKK3sKKwlpbnQgaTsKKwlzdHJ1Y3QgcGFnZSAqZHN0X2Jhc2UgPSBk
c3Q7CisJc3RydWN0IHBhZ2UgKnNyY19iYXNlID0gc3JjOworCisJZm9yIChpID0gMDsgaSA8IG5y
X3BhZ2VzOykgeworCQljb25kX3Jlc2NoZWQoKTsKKwkJY29weV9oaWdocGFnZShkc3QsIHNyYyk7
CisKKwkJaSsrOworCQlkc3QgPSBtZW1fbWFwX25leHQoZHN0LCBkc3RfYmFzZSwgaSk7CisJCXNy
YyA9IG1lbV9tYXBfbmV4dChzcmMsIHNyY19iYXNlLCBpKTsKKwl9Cit9CisKIHN0YXRpYyBpbmxp
bmUgdm9pZCB1bmxvY2tfb3JfcmVsZWFzZV9zdWJwb29sKHN0cnVjdCBodWdlcGFnZV9zdWJwb29s
ICpzcG9vbCwKIAkJCQkJCXVuc2lnbmVkIGxvbmcgaXJxX2ZsYWdzKQogewpAQCAtMTE2NSw2ICsx
MTg3LDcgQEAgc3RhdGljIHN0cnVjdCBwYWdlICpkZXF1ZXVlX2h1Z2VfcGFnZV92bWEoc3RydWN0
IGhzdGF0ZSAqaCwKIAlwYWdlID0gZGVxdWV1ZV9odWdlX3BhZ2Vfbm9kZW1hc2soaCwgZ2ZwX21h
c2ssIG5pZCwgbm9kZW1hc2spOwogCWlmIChwYWdlICYmICFhdm9pZF9yZXNlcnZlICYmIHZtYV9o
YXNfcmVzZXJ2ZXModm1hLCBjaGcpKSB7CiAJCVNldEhQYWdlUmVzdG9yZVJlc2VydmUocGFnZSk7
CisJCVdBUk5fT05fT05DRSghaC0+cmVzdl9odWdlX3BhZ2VzKTsKIAkJaC0+cmVzdl9odWdlX3Bh
Z2VzLS07CiAJfQogCkBAIC0yNDA1LDYgKzI0MjgsNyBAQCBzdHJ1Y3QgcGFnZSAqYWxsb2NfaHVn
ZV9wYWdlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAogCWludCByZXQsIGlkeDsKIAlzdHJ1
Y3QgaHVnZXRsYl9jZ3JvdXAgKmhfY2c7CiAJYm9vbCBkZWZlcnJlZF9yZXNlcnZlOworCXBnb2Zm
X3QgcGFnZWlkeCA9IHZtYV9odWdlY2FjaGVfb2Zmc2V0KGgsIHZtYSwgYWRkcik7CiAKIAlpZHgg
PSBoc3RhdGVfaW5kZXgoaCk7CiAJLyoKQEAgLTI1MDgsNiArMjUzMiw5IEBAIHN0cnVjdCBwYWdl
ICphbGxvY19odWdlX3BhZ2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCiAJCQlodWdldGxi
X2Nncm91cF91bmNoYXJnZV9wYWdlX3JzdmQoaHN0YXRlX2luZGV4KGgpLAogCQkJCQlwYWdlc19w
ZXJfaHVnZV9wYWdlKGgpLCBwYWdlKTsKIAl9CisJcHJpbnRrKCIlczolZDolcyBhbGxvY2F0ZWQg
cGFnZSBpZHg9JWQsIGRlZmVycmVkX3Jlc2VydmU9JWQsIGF2b2lkX3Jlc2VydmU9JWRcbiIsCisJ
ICAgICAgIF9fRklMRV9fLCBfX0xJTkVfXywgX19mdW5jX18sIHBhZ2VpZHgsIGRlZmVycmVkX3Jl
c2VydmUsCisJICAgICAgIGF2b2lkX3Jlc2VydmUpOwogCXJldHVybiBwYWdlOwogCiBvdXRfdW5j
aGFyZ2VfY2dyb3VwOgpAQCAtNDU3MSw2ICs0NTk4LDggQEAgc3RhdGljIHZtX2ZhdWx0X3QgaHVn
ZXRsYl9ub19wYWdlKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLAogCQkJaWYgKGh1Z2VfcHRlX25vbmUo
aHVnZV9wdGVwX2dldChwdGVwKSkpCiAJCQkJcmV0ID0gdm1mX2Vycm9yKFBUUl9FUlIocGFnZSkp
OwogCQkJc3Bpbl91bmxvY2socHRsKTsKKwkJCXByaW50aygiJXM6JWQ6JXMgZmFpbGVkIFxuIiwg
X19GSUxFX18sIF9fTElORV9fLAorCQkJICAgICAgIF9fZnVuY19fKTsKIAkJCWdvdG8gb3V0Owog
CQl9CiAJCWNsZWFyX2h1Z2VfcGFnZShwYWdlLCBhZGRyZXNzLCBwYWdlc19wZXJfaHVnZV9wYWdl
KGgpKTsKQEAgLTQ1NzgsOCArNDYwNywxMiBAQCBzdGF0aWMgdm1fZmF1bHRfdCBodWdldGxiX25v
X3BhZ2Uoc3RydWN0IG1tX3N0cnVjdCAqbW0sCiAJCW5ld19wYWdlID0gdHJ1ZTsKIAogCQlpZiAo
dm1hLT52bV9mbGFncyAmIFZNX01BWVNIQVJFKSB7CisJCQlwcmludGsoIiVzOiVkOiVzIGFkZGlu
ZyBwYWdlIHRvIGNhY2hlIGlkeD0lZCBtYXBwaW5nPSVweFxuIiwKKwkJCSAgICAgICBfX0ZJTEVf
XywgX19MSU5FX18sIF9fZnVuY19fLCBpZHgsIG1hcHBpbmcpOwogCQkJaW50IGVyciA9IGh1Z2Vf
YWRkX3RvX3BhZ2VfY2FjaGUocGFnZSwgbWFwcGluZywgaWR4KTsKIAkJCWlmIChlcnIpIHsKKwkJ
CQlwcmludGsoIiVzOiVkOiVzIGZhaWxlZCBhZGRpbmcgcGFnZSB0byBjYWNoZSBpZHg9JWRcbiIs
CisJCQkJICAgICAgIF9fRklMRV9fLCBfX0xJTkVfXywgX19mdW5jX18sIGlkeCk7CiAJCQkJcHV0
X3BhZ2UocGFnZSk7CiAJCQkJaWYgKGVyciA9PSAtRUVYSVNUKQogCQkJCQlnb3RvIHJldHJ5OwpA
QCAtNDg2OCw0NCArNDkwMSwxMDIgQEAgaW50IGh1Z2V0bGJfbWNvcHlfYXRvbWljX3B0ZShzdHJ1
Y3QgbW1fc3RydWN0ICpkc3RfbW0sCiAJCQkgICAgc3RydWN0IHBhZ2UgKipwYWdlcCkKIHsKIAli
b29sIGlzX2NvbnRpbnVlID0gKG1vZGUgPT0gTUNPUFlfQVRPTUlDX0NPTlRJTlVFKTsKLQlzdHJ1
Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZzsKLQlwZ29mZl90IGlkeDsKKwlzdHJ1Y3QgaHN0YXRl
ICpoID0gaHN0YXRlX3ZtYShkc3Rfdm1hKTsKKwlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGlu
ZyA9IGRzdF92bWEtPnZtX2ZpbGUtPmZfbWFwcGluZzsKKwlwZ29mZl90IGlkeCA9IHZtYV9odWdl
Y2FjaGVfb2Zmc2V0KGgsIGRzdF92bWEsIGRzdF9hZGRyKTsKIAl1bnNpZ25lZCBsb25nIHNpemU7
CiAJaW50IHZtX3NoYXJlZCA9IGRzdF92bWEtPnZtX2ZsYWdzICYgVk1fU0hBUkVEOwotCXN0cnVj
dCBoc3RhdGUgKmggPSBoc3RhdGVfdm1hKGRzdF92bWEpOwogCXB0ZV90IF9kc3RfcHRlOwogCXNw
aW5sb2NrX3QgKnB0bDsKLQlpbnQgcmV0OworCWludCByZXQgPSAtRU5PTUVNOwogCXN0cnVjdCBw
YWdlICpwYWdlOwogCWludCB3cml0YWJsZTsKLQotCW1hcHBpbmcgPSBkc3Rfdm1hLT52bV9maWxl
LT5mX21hcHBpbmc7Ci0JaWR4ID0gdm1hX2h1Z2VjYWNoZV9vZmZzZXQoaCwgZHN0X3ZtYSwgZHN0
X2FkZHIpOworCXVuc2lnbmVkIGxvbmcgcmVzdl90ZW1wID0gMDsKIAogCWlmIChpc19jb250aW51
ZSkgewogCQlyZXQgPSAtRUZBVUxUOwogCQlwYWdlID0gZmluZF9sb2NrX3BhZ2UobWFwcGluZywg
aWR4KTsKLQkJaWYgKCFwYWdlKQorCQlpZiAoIXBhZ2UpIHsKKwkJCXJldCA9IC1FTk9NRU07CiAJ
CQlnb3RvIG91dDsKKwkJfQogCX0gZWxzZSBpZiAoISpwYWdlcCkgewotCQlyZXQgPSAtRU5PTUVN
OworCQkvKiBJZiBhIHBhZ2UgYWxyZWFkeSBleGlzdHMsIHRoZW4gaXQncyBVRkZESU9fQ09QWSBm
b3IKKwkJICogYSBub24tbWlzc2luZyBjYXNlLiBSZXR1cm4gLUVFWElTVC4KKwkJICovCisJCWlm
IChodWdldGxiZnNfcGFnZWNhY2hlX3ByZXNlbnQoaCwgZHN0X3ZtYSwgZHN0X2FkZHIpKSB7CisJ
CQlyZXQgPSAtRUVYSVNUOworCQkJcHJpbnRrKCIlczolZDolcyBmb3VuZCBpbiBjYWNoZS4gaWR4
PSVkIG1hcHBpbmc9JXB4XG4iLAorCQkJICAgICAgIF9fRklMRV9fLCBfX0xJTkVfXywgX19mdW5j
X18sIGlkeCwKKwkJCSAgICAgICBkc3Rfdm1hLT52bV9maWxlLT5mX21hcHBpbmcpOworCQkJZ290
byBvdXQ7CisJCX0KKworCQlwcmludGsoIiVzOiVkOiVzIG5vdCBmb3VuZCBpbiBjYWNoZS4gQWxs
b2NhdGluZyBjb25zdW1pbmcgcmVzZXJ2YXRpb24gaWR4PSVkIG1hcHBpbmc9JXB4XG4iLAorCQkg
ICAgICAgX19GSUxFX18sIF9fTElORV9fLCBfX2Z1bmNfXywgaWR4LAorCQkgICAgICAgZHN0X3Zt
YS0+dm1fZmlsZS0+Zl9tYXBwaW5nKTsKIAkJcGFnZSA9IGFsbG9jX2h1Z2VfcGFnZShkc3Rfdm1h
LCBkc3RfYWRkciwgMCk7Ci0JCWlmIChJU19FUlIocGFnZSkpCisJCUJVR19PTihJU19FUlIocGFn
ZSkpOworCQlpZiAoSVNfRVJSKHBhZ2UpKSB7CisJCQlwcmludGsoIiVzOiVkOiVzIHBhZ2UgYWxs
b2NhdGlvbiBmYWlsZWRcbiIsIF9fRklMRV9fLAorCQkJICAgICAgIF9fTElORV9fLCBfX2Z1bmNf
Xyk7CiAJCQlnb3RvIG91dDsKKwkJfQogCisjaWYgMAogCQlyZXQgPSBjb3B5X2h1Z2VfcGFnZV9m
cm9tX3VzZXIocGFnZSwKLQkJCQkJCShjb25zdCB2b2lkIF9fdXNlciAqKSBzcmNfYWRkciwKLQkJ
CQkJCXBhZ2VzX3Blcl9odWdlX3BhZ2UoaCksIGZhbHNlKTsKKwkJCQkJICAgICAgIChjb25zdCB2
b2lkIF9fdXNlciAqKXNyY19hZGRyLAorCQkJCQkgICAgICAgcGFnZXNfcGVyX2h1Z2VfcGFnZSho
KSwgZmFsc2UpOworI2Vsc2UKKwkJcmV0ID0gLUVOT0VOVDsKKyNlbmRpZgogCiAJCS8qIGZhbGxi
YWNrIHRvIGNvcHlfZnJvbV91c2VyIG91dHNpZGUgbW1hcF9sb2NrICovCiAJCWlmICh1bmxpa2Vs
eShyZXQpKSB7CiAJCQlyZXQgPSAtRU5PRU5UOworCQkJcHJpbnRrKCIlczolZDolcyBjb3B5IGZh
aWxlZCwgZnJlZWluZyBwYWdlIGlkeD0lZFxuIiwKKwkJCSAgICAgICBfX0ZJTEVfXywgX19MSU5F
X18sIF9fZnVuY19fLCBpZHgpOworCQkJcmVzdl90ZW1wID0gaC0+cmVzdl9odWdlX3BhZ2VzOwor
CQkJcHV0X3BhZ2UocGFnZSk7CisKKwkJCS8qIFJlYWxsb2NhdGUgdGhlIHBhZ2Ugb3V0c2lkZSB0
aGUgcmVzZXJ2ZXMuICovCisJCQlzdHJ1Y3QgbWVtcG9saWN5ICptcG9sOworCQkJbm9kZW1hc2tf
dCAqbm9kZW1hc2s7CisJCQlnZnBfdCBnZnBfbWFzayA9IGh0bGJfYWxsb2NfbWFzayhoKTsKKwkJ
CWludCBub2RlID0gaHVnZV9ub2RlKGRzdF92bWEsIGRzdF9hZGRyLCBnZnBfbWFzaywgJm1wb2ws
CisJCQkJCSAgICAgJm5vZGVtYXNrKTsKKwkJCXJlc3ZfdGVtcCA9IGgtPnJlc3ZfaHVnZV9wYWdl
czsKKwkJCXBhZ2UgPSBhbGxvY19taWdyYXRlX2h1Z2VfcGFnZShoLCBnZnBfbWFzaywgbm9kZSwK
KwkJCQkJCSAgICAgICBub2RlbWFzayk7CisJCQlWTV9CVUdfT04oaC0+cmVzdl9odWdlX3BhZ2Vz
ICE9IHJlc3ZfdGVtcCk7CisJCQlpZiAoSVNfRVJSKHBhZ2UpKSB7CisJCQkJVk1fQlVHX09OKHRy
dWUpOworCQkJCXJldCA9IC1FTk9NRU07CisJCQkJcHJpbnRrKCIlczolZDolcyBmYWlsZWQgYWxs
b2NhdGluZyBtaWdyYXRlX2h1Z2VfcGFnZVxuIiwKKwkJCQkgICAgICAgX19GSUxFX18sIF9fTElO
RV9fLCBfX2Z1bmNfXyk7CisJCQkJZ290byBvdXQ7CisJCQl9CiAJCQkqcGFnZXAgPSBwYWdlOwog
CQkJLyogZG9uJ3QgZnJlZSB0aGUgcGFnZSAqLwogCQkJZ290byBvdXQ7CiAJCX0KIAl9IGVsc2Ug
ewotCQlwYWdlID0gKnBhZ2VwOworCQlpZiAoaHVnZXRsYmZzX3BhZ2VjYWNoZV9wcmVzZW50KGgs
IGRzdF92bWEsIGRzdF9hZGRyKSkgeworCQkJcHJpbnRrKCIlczolZDolcyBmb3VuZCBodWdlX3Bh
Z2UgaW4gY2FjaGUgaWR4PSVkIG1hcHBpbmc9JXB4XG4iLAorCQkJICAgICAgIF9fRklMRV9fLCBf
X0xJTkVfXywgX19mdW5jX18sIGlkeCwKKwkJCSAgICAgICBkc3Rfdm1hLT52bV9maWxlLT5mX21h
cHBpbmcpOworCQkJcHV0X3BhZ2UoKnBhZ2VwKTsKKwkJCXJldCA9IC1FRVhJU1Q7CisJCQlnb3Rv
IG91dDsKKwkJfQorCisJCXByaW50aygiJXM6JWQ6JXMgbm90IGZvdW5kIGluIGNhY2hlLCBhbGxv
Y2F0aW5nIGNvbnN1bWluZyByZXNlcnZhdGlvbiBpZHg9JWQgbWFwcGluZz0lcHhcbiIsCisJCSAg
ICAgICBfX0ZJTEVfXywgX19MSU5FX18sIF9fZnVuY19fLCBpZHgsCisJCSAgICAgICBkc3Rfdm1h
LT52bV9maWxlLT5mX21hcHBpbmcpOworCQlwYWdlID0gYWxsb2NfaHVnZV9wYWdlKGRzdF92bWEs
IGRzdF9hZGRyLCAwKTsKKwkJVk1fQlVHX09OKElTX0VSUihwYWdlKSk7CisJCV9fY29weV9naWdh
bnRpY19wYWdlKHBhZ2UsICpwYWdlcCwgcGFnZXNfcGVyX2h1Z2VfcGFnZShoKSk7CisJCXB1dF9w
YWdlKCpwYWdlcCk7CiAJCSpwYWdlcCA9IE5VTEw7CiAJfQogCkBAIC00OTI5LDkgKzUwMjAsMTQg
QEAgaW50IGh1Z2V0bGJfbWNvcHlfYXRvbWljX3B0ZShzdHJ1Y3QgbW1fc3RydWN0ICpkc3RfbW0s
CiAJCSAqIGh1Z2V0bGJfZmF1bHRfbXV0ZXhfdGFibGUgdGhhdCBoZXJlIG11c3QgYmUgaG9sZCBi
eQogCQkgKiB0aGUgY2FsbGVyLgogCQkgKi8KKwkJcHJpbnRrKCIlczolZDolcyBhZGRpbmcgcGFn
ZSB0byBjYWNoZSBpZHg9JWQgbWFwcGluZz0lcHhcbiIsCisJCSAgICAgICBfX0ZJTEVfXywgX19M
SU5FX18sIF9fZnVuY19fLCBpZHgsIG1hcHBpbmcpOwogCQlyZXQgPSBodWdlX2FkZF90b19wYWdl
X2NhY2hlKHBhZ2UsIG1hcHBpbmcsIGlkeCk7Ci0JCWlmIChyZXQpCisJCWlmIChyZXQpIHsKKwkJ
CXByaW50aygiJXM6JWQ6JXMgZmFpbGVkIGFkZGluZyB0byBjYWNoZVxuIiwgX19GSUxFX18sCisJ
CQkgICAgICAgX19MSU5FX18sIF9fZnVuY19fKTsKIAkJCWdvdG8gb3V0X3JlbGVhc2Vfbm91bmxv
Y2s7CisJCX0KIAl9CiAKIAlwdGwgPSBodWdlX3B0ZV9sb2NrcHRyKGgsIGRzdF9tbSwgZHN0X3B0
ZSk7Ci0tIAoyLjMxLjEuODE4Lmc0NmFhZDZjYjllLWdvb2cKCg==
--000000000000cc939705c2c8d5fe--
