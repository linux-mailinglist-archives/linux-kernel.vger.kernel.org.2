Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E360453D01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 01:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhKQADq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhKQADp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:03:45 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5EBC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 16:00:47 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id x10so774044ioj.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 16:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOFxpbsen8nPqTeqSo361npcO0lO5WfjbVEq5WA1p4s=;
        b=bsBYe0njsZbAabWIqadKHZU8aBU1sCevBg+DkbIiEnH7pobGuZgC3STY5jOFjwqNw7
         aHAHcMxbrbsqpBZognuXh2VVNY+kxh5ow+0x1wuGHOE7HB/3BOFydHJ7n9trRVBntgay
         cI8jiqwt+InH6GT3g+rebsS/OXbJVbWx85hxLbfHyjlPU88J9auIuxG//pYIWwJKUf4U
         i3/Y1JVcKHTzMoJN/LAQjMkzIdm7FcyT2u0fyaXGYKH0E/91p1CjVp5nP8EAjQdy7huz
         iBXc3CO+T/QchZPoiFs/zx/LT2QdunPsvmvindiRssNiAghRTq3yQtq+Veb0HT7bklKt
         rsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOFxpbsen8nPqTeqSo361npcO0lO5WfjbVEq5WA1p4s=;
        b=KOGzv66IEL5FY1PmPfNv2X+F1U+kfyob1xqsV0WtNL4Sv5sNMAQf/L4ObuniZB628q
         sl5OgCUHrsyjezJmL5PGnKZicKZ/CWsApVqd03kaL4zzMe2Z3/ft4Xwom4Uns5W7Ne6T
         GHFTLnzWtv5XdtHXypm437U+0K36DfJCuSJRTHhoQjH+1plHmmVCGFjogm/engEwBaEc
         uE0B1HHYTr9bRrvZs5FKQlPrDmSgtXycH3iGnceMgpXVFDBlHirvkK+RNEmAQqlICBEZ
         Jgkf5Vv67YaO7z1YvYnQnRGKANU35TeakDnTbfi8NG1GtdEJlNH1/KmMfTDvnIWrkawd
         4jXQ==
X-Gm-Message-State: AOAM531EC/sp5i+B48bzbq8m0pXi+DkS0/iJWJ3fCmj8bO+/oOq0m7NL
        vQfzAoWIoytBZXfbD2uPyQpKvNwnE1WuNKI3Rf8D+g==
X-Google-Smtp-Source: ABdhPJyVU+0cZOp5JWeB9edtsbej4gfVqsznY9+Lzz+CyPS7rl5N6t5Wz93Q7YdKjMBDBp7e4KaNZl/YJCNdDkE+fh4=
X-Received: by 2002:a5e:cb0d:: with SMTP id p13mr7941568iom.71.1637107246952;
 Tue, 16 Nov 2021 16:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20211116235733.3774702-1-almasrymina@google.com>
In-Reply-To: <20211116235733.3774702-1-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 16 Nov 2021 16:00:35 -0800
Message-ID: <CAHS8izM0EjNmyc25fOqsU03G84+nGeyWoXo+oJWC5TQx52OH9A@mail.gmail.com>
Subject: Re: [PATCH v1] hugetlb, userfaultfd: Fix reservation restore on
 userfaultfd error
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Xu <weixugc@google.com>,
        James Houghton <jthoughton@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ea6ef005d0f0bbf3"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ea6ef005d0f0bbf3
Content-Type: text/plain; charset="UTF-8"

Hi Mike,

On Tue, Nov 16, 2021 at 3:57 PM Mina Almasry <almasrymina@google.com> wrote:
>
> Currently in the is_continue case in hugetlb_mcopy_atomic_pte(), if we
> bail out using "goto out_release_unlock;" in the cases where idx >=
> size, or !huge_pte_none(), the code will detect that new_pagecache_page
> == false, and so call restore_reserve_on_error().
> In this case I see restore_reserve_on_error() delete the reservation,
> and the following call to remove_inode_hugepages() will increment
> h->resv_hugepages causing a 100% reproducible leak.
>

Attached is the .c file with the 100% repro.

> We should treat the is_continue case similar to adding a page into the
> pagecache and set new_pagecache_page to true, to indicate that there is
> no reservation to restore on the error path, and we need not call
> restore_reserve_on_error().
>
> Cc: Wei Xu <weixugc@google.com>
>
> Fixes: c7b1850dfb41 ("hugetlb: don't pass page cache pages to restore_reserve_on_error")
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reported-by: James Houghton <jthoughton@google.com>

Not sure if this is a Cc: stable issue. If it is, I can add in v2.

> ---
>  mm/hugetlb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e09159c957e3..25a7a3d84607 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5741,6 +5741,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>                 page = find_lock_page(mapping, idx);
>                 if (!page)
>                         goto out;
> +               /*
> +                * Set new_pagecache_page to true, as we've added a page to the
> +                * pagecache, but userfaultfd hasn't set up a mapping for this
> +                * page yet. If we bail out before setting up the mapping, we
> +                * want to indicate to restore_reserve_on_error() that we've
> +                * added the page to the page cache.
> +                */
> +               new_pagecache_page = true;
>         } else if (!*pagep) {
>                 /* If a page already exists, then it's UFFDIO_COPY for
>                  * a non-missing case. Return -EEXIST.
> --
> 2.34.0.rc1.387.gb447b232ab-goog

--000000000000ea6ef005d0f0bbf3
Content-Type: text/x-csrc; charset="US-ASCII"; name="hugetlb-leak-test.c"
Content-Disposition: attachment; filename="hugetlb-leak-test.c"
Content-Transfer-Encoding: base64
Content-ID: <f_kw2rcol80>
X-Attachment-Id: f_kw2rcol80

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIu
aD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdHJp
bmcuaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgojaW5jbHVk
ZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgojaW5jbHVkZSA8bGludXgvdXNl
cmZhdWx0ZmQuaD4KCiNpZm5kZWYgVUZGRF9GRUFUVVJFX01JTk9SX0hVR0VUTEJGUwojZGVmaW5l
IFVGRkRfRkVBVFVSRV9NSU5PUl9IVUdFVExCRlMgKDEgPDwgOSkKI2VuZGlmCgojaWZuZGVmIFVG
RkRJT19SRUdJU1RFUl9NT0RFX01JTk9SCiNkZWZpbmUgVUZGRElPX1JFR0lTVEVSX01PREVfTUlO
T1IgKChfX3U2NCkxIDw8IDIpCiNlbmRpZgoKI2lmbmRlZiBVRkZESU9fQ09OVElOVUVfTU9ERV9E
T05UV0FLRQojZGVmaW5lIFVGRkRJT19DT05USU5VRV9NT0RFX0RPTlRXQUtFICgodWludDY0X3Qp
MSA8PCAwKQojZW5kaWYKCnN0cnVjdCB1ZmZkaW9fY29udGludWUgewoJc3RydWN0IHVmZmRpb19y
YW5nZSByYW5nZTsKCXVpbnQ2NF90IG1vZGU7CglpbnQ2NF90IGJ5dGVzX21hcHBlZDsKfTsKCgoj
aWZuZGVmIFVGRkRJT19DT05USU5VRQojZGVmaW5lIF9VRkZESU9fQ09OVElOVUUgKDB4MDcpCiNk
ZWZpbmUgVUZGRElPX0NPTlRJTlVFIF9JT1dSKFVGRkRJTywgX1VGRkRJT19DT05USU5VRSwgc3Ry
dWN0IHVmZmRpb19jb250aW51ZSkKI2VuZGlmCgojaWZuZGVmIFVGRkRfUEFHRUZBVUxUX0ZMQUdf
TUlOT1IKI2RlZmluZSBVRkZEX1BBR0VGQVVMVF9GTEFHX01JTk9SICgxIDw8IDIpCiNlbmRpZgoK
aW50IHVzZXJmYXVsdGZkKGludCBtb2RlKSB7CglyZXR1cm4gc3lzY2FsbChfX05SX3VzZXJmYXVs
dGZkLCBtb2RlKTsKfQoKaW50IG1haW4oKSB7CgoJaW50IGZkID0gb3BlbigiL21udC9odWdlL3Rl
c3QiLCBPX1JEV1IgfCBPX0NSRUFUIHwgU19JUlVTUiB8IFNfSVdVU1IpOwoJaWYgKGZkID09IC0x
KSB7CgkJcGVycm9yKCJvcGVuaW5nIHRtcGZpbGUgaW4gaHVnZXRsYmZzLW1vdW50IGZhaWxlZCIp
OwoJCXJldHVybiAtMTsKCX0KCgljb25zdCBzaXplX3QgbGVuX2h1Z2VwYWdlID0gNTEyICogNDA5
NjsgLy8gMk1CCgljb25zdCBzaXplX3QgbGVuID0gMiAqIGxlbl9odWdlcGFnZTsKCWlmIChmdHJ1
bmNhdGUoZmQsIGxlbikgPCAwKSB7CgkJcGVycm9yKCJmdHJ1bmNhdGUgZmFpbGVkIik7CgkJcmV0
dXJuIC0xOwoJfQoJaW50IHVmZmQgPSB1c2VyZmF1bHRmZChPX0NMT0VYRUMgfCBPX05PTkJMT0NL
KTsKCWlmICh1ZmZkIDwgMCkgewoJCXBlcnJvcigidWZmZCBub3QgY3JlYXRlZCIpOwoJCXJldHVy
biAtMTsKCX0KCgljaGFyICpodmEgPSAoY2hhciopKG1tYXAoTlVMTCwgbGVuLCBQUk9UX05PTkUs
IE1BUF9QUklWQVRFIHwgTUFQX0FOT05ZTU9VUywgLTEsIDApKTsKCWlmIChodmEgPT0gTUFQX0ZB
SUxFRCkgewoJCXBlcnJvcigibW1hcCBodmEgZmFpbGVkIik7CgkJcmV0dXJuIC0xOwoJfQoKCWNo
YXIgKnByaW1hcnkgPSAoY2hhciopKG1tYXAoaHZhLCBsZW4sIFBST1RfUkVBRCB8IFBST1RfV1JJ
VEUsIE1BUF9TSEFSRUQsIGZkLCAwKSk7CglpZiAocHJpbWFyeSA9PSBNQVBfRkFJTEVEKSB7CgkJ
cGVycm9yKCJtbWFwIHByaW1hcnkgZmFpbGVkIik7CgkJcmV0dXJuIC0xOwoJfQoKCWNoYXIgKnNl
Y29uZGFyeSA9IChjaGFyKikobW1hcChodmEsIGxlbiwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwg
TUFQX1NIQVJFRCwgZmQsIDApKTsKCWlmIChwcmltYXJ5ID09IE1BUF9GQUlMRUQpIHsKCQlwZXJy
b3IoIm1tYXAgc2Vjb25kYXJ5IGZhaWxlZCIpOwoJCXJldHVybiAtMTsKCX0KCglzdHJ1Y3QgdWZm
ZGlvX2FwaSBhcGk7CglhcGkuYXBpID0gVUZGRF9BUEk7CglhcGkuZmVhdHVyZXMgPSBVRkZEX0ZF
QVRVUkVfTUlOT1JfSFVHRVRMQkZTIHwgVUZGRF9GRUFUVVJFX01JU1NJTkdfSFVHRVRMQkZTOwoJ
aWYgKGlvY3RsKHVmZmQsIFVGRkRJT19BUEksICZhcGkpID09IC0xKSB7CgkJcGVycm9yKCJVRkZE
SU9fQVBJIGZhaWxlZCIpOwoJCXJldHVybiAtMTsKCX0KCgltZW1zZXQocHJpbWFyeSArIGxlbl9o
dWdlcGFnZSwgMCwgbGVuX2h1Z2VwYWdlKTsKCglzdHJ1Y3QgdWZmZGlvX3JlZ2lzdGVyIHJlZzsK
CXJlZy5yYW5nZS5zdGFydCA9ICh1bnNpZ25lZCBsb25nKXByaW1hcnk7CglyZWcucmFuZ2UubGVu
ID0gbGVuOwoJcmVnLm1vZGUgPSBVRkZESU9fUkVHSVNURVJfTU9ERV9NSU5PUiB8IFVGRkRJT19S
RUdJU1RFUl9NT0RFX01JU1NJTkc7CglyZWcuaW9jdGxzID0gMDsKCWlmIChpb2N0bCh1ZmZkLCBV
RkZESU9fUkVHSVNURVIsICZyZWcpID09IC0xKSB7CgkJcGVycm9yKCJyZWdpc3RlciBmYWlsZWQi
KTsKCQlyZXR1cm4gLTE7Cgl9CgoJbWVtc2V0KHNlY29uZGFyeSwgMCwgbGVuKTsKCglzdHJ1Y3Qg
dWZmZGlvX2NvbnRpbnVlIGNvbnQgPSB7CgkJLnJhbmdlID0gKHN0cnVjdCB1ZmZkaW9fcmFuZ2Up
IHsKCQkJLnN0YXJ0ID0gKHVpbnQ2NF90KXByaW1hcnksCgkJCS5sZW4gPSBsZW4sCgkJfSwKCQku
bW9kZSA9IDAsCgkJLmJ5dGVzX21hcHBlZCA9IDAsCgl9OwoJaWYgKGlvY3RsKHVmZmQsIFVGRkRJ
T19DT05USU5VRSwgJmNvbnQpIDwgMCkgewoJCXBlcnJvcigiVUZGRElPX0NPTlRJTlVFIGZhaWxl
ZCIpOwoJCXByaW50ZigiTWFwcGVkICVkIGJ5dGVzXG4iLCBjb250LmJ5dGVzX21hcHBlZCk7Cgl9
CgoJY2xvc2UodWZmZCk7CgltdW5tYXAoc2Vjb25kYXJ5LCBsZW4pOwoJbXVubWFwKHByaW1hcnks
IGxlbik7CgltdW5tYXAoaHZhLCBsZW4pOwoKCWNsb3NlKGZkKTsKCgkvLyBBZnRlciB0aGlzIHVu
bGluaywgYSBodWdlcGFnZSB3aWxsIGJlIGxlYWtlZC4KCWlmICh1bmxpbmsoIi9tbnQvaHVnZS90
ZXN0IikgPCAwKSB7CgkJcGVycm9yKCJ1bmxpbmsgZmFpbGVkIik7Cgl9CgoJcmV0dXJuIDA7Cn0K
--000000000000ea6ef005d0f0bbf3--
