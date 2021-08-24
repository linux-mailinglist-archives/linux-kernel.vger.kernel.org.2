Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81853F6884
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbhHXR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbhHXR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:59:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A43BC0E064E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:39:45 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id d16so39015193ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+/lXLW+84+cEx++etuMHYzjE555zjCwFj9ti+8XnFM=;
        b=DYuypqUtCTHwP1gqnv1cHe73NDXkrWWzprn+z3WkSF/xMLGndxcx5sQAqfuw85Hq69
         brpoCeGUw0o2oW/bLZ4Tpnnhv0LqQeJthBqAQtcUtbCGiEv/ToxXF3JDSle3ocjJMAEC
         gQ7y9C32QFTtR4Tb6IlJuBdWDO4rMoUkKcSXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+/lXLW+84+cEx++etuMHYzjE555zjCwFj9ti+8XnFM=;
        b=ohBn/5Ps601XhvSOrQxS5NWxJ2uy0RNHmY/mhS40FjmLZ2aaPEIOFQBqAtL52h3u9b
         TiTGOTThbowXIuDugWVVhaTtDURBU0RNkZNZdTqOC9YE2mrcj2jwQBffpxZDOkI8lrfW
         pAuzyiAX4DK6oJB8eBFc37MLHlx/B6h0QcmF5Mbw+m8u4X+8yLamTLWpVEFRJb+/VUbl
         jaUdYVIyZEFe3iJRNgH1E4QmgTcEGO6s7vLaVdVKBX/UktDYt+yWjphdD08Y1jov4R9u
         1gq5sTRcdeNo2HMTxemqok5L5I1HewJZxXmlt738e7Fi0Hi37JIDVRv0LCu9UwfEYuc4
         YZwg==
X-Gm-Message-State: AOAM531ikAg6XtCuMg0t3hjHwCd+S3yEinRN+tPioAPxhyMnJ33cs0Ha
        MiLwmNfzkdOiM5DjU/AAtUpeMInGejQOplcg
X-Google-Smtp-Source: ABdhPJygk24F9mVrUFzp+RInw6d4Y64BdI9rSGFrkUuIitjeZIhtEUwu3sp3JEs4FbOqR4cxi6loMQ==
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr32636097ljc.251.1629826783426;
        Tue, 24 Aug 2021 10:39:43 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z7sm1807573lft.302.2021.08.24.10.39.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:39:41 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id p15so1172261ljn.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:39:41 -0700 (PDT)
X-Received: by 2002:a2e:8808:: with SMTP id x8mr33404195ljh.220.1629826781193;
 Tue, 24 Aug 2021 10:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210824151337.GC27667@xsang-OptiPlex-9020> <CAHk-=wjEdeNW8bPNhwRCkMu6zLKjE2vQ=WL_6bQtc9YnaKt0bw@mail.gmail.com>
 <CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com>
In-Reply-To: <CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 10:39:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrSmiwUfSGt1RPy5KJ_TLBTP5DB0-vT=PCxQY4C7uANA@mail.gmail.com>
Message-ID: <CAHk-=wgrSmiwUfSGt1RPy5KJ_TLBTP5DB0-vT=PCxQY4C7uANA@mail.gmail.com>
Subject: Re: [pipe] 3b844826b6: stress-ng.sigio.ops_per_sec -99.3% regression
To:     kernel test robot <oliver.sang@intel.com>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Sandeep Patil <sspatil@android.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: multipart/mixed; boundary="00000000000056e19405ca519ebf"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000056e19405ca519ebf
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 24, 2021 at 10:32 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We could do the same ugly thing for FASYNC that we do for EPOLLET -
> make it always fasync on new data, exactly because the previous SIGIO
> might not have emptied the buffer completely.

The patch would be something like the attached (UNTESTED!)

                  Linus

--00000000000056e19405ca519ebf
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ksqcrs750>
X-Attachment-Id: f_ksqcrs750

IGZzL3BpcGUuYyB8IDIwICsrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9waXBlLmMgYi9m
cy9waXBlLmMKaW5kZXggNjc4ZGVlMmE4MjI4Li42ZDQzNDJiYWQ5ZjEgMTAwNjQ0Ci0tLSBhL2Zz
L3BpcGUuYworKysgYi9mcy9waXBlLmMKQEAgLTM2MywxMCArMzYzLDkgQEAgcGlwZV9yZWFkKHN0
cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykKIAkJICogX3ZlcnlfIHVubGlr
ZWx5IGNhc2UgdGhhdCB0aGUgcGlwZSB3YXMgZnVsbCwgYnV0IHdlIGdvdAogCQkgKiBubyBkYXRh
LgogCQkgKi8KLQkJaWYgKHVubGlrZWx5KHdhc19mdWxsKSkgeworCQlpZiAodW5saWtlbHkod2Fz
X2Z1bGwpKQogCQkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlX3N5bmNfcG9sbCgmcGlwZS0+d3Jfd2Fp
dCwgRVBPTExPVVQgfCBFUE9MTFdSTk9STSk7Ci0JCQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5j
X3dyaXRlcnMsIFNJR0lPLCBQT0xMX09VVCk7Ci0JCX0KKwkJa2lsbF9mYXN5bmMoJnBpcGUtPmZh
c3luY193cml0ZXJzLCBTSUdJTywgUE9MTF9PVVQpOwogCiAJCS8qCiAJCSAqIEJ1dCBiZWNhdXNl
IHdlIGRpZG4ndCByZWFkIGFueXRoaW5nLCBhdCB0aGlzIHBvaW50IHdlIGNhbgpAQCAtMzg1LDEy
ICszODQsMTEgQEAgcGlwZV9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVy
ICp0bykKIAkJd2FrZV9uZXh0X3JlYWRlciA9IGZhbHNlOwogCV9fcGlwZV91bmxvY2socGlwZSk7
CiAKLQlpZiAod2FzX2Z1bGwpIHsKKwlpZiAod2FzX2Z1bGwpCiAJCXdha2VfdXBfaW50ZXJydXB0
aWJsZV9zeW5jX3BvbGwoJnBpcGUtPndyX3dhaXQsIEVQT0xMT1VUIHwgRVBPTExXUk5PUk0pOwot
CQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3dyaXRlcnMsIFNJR0lPLCBQT0xMX09VVCk7Ci0J
fQogCWlmICh3YWtlX25leHRfcmVhZGVyKQogCQl3YWtlX3VwX2ludGVycnVwdGlibGVfc3luY19w
b2xsKCZwaXBlLT5yZF93YWl0LCBFUE9MTElOIHwgRVBPTExSRE5PUk0pOworCWtpbGxfZmFzeW5j
KCZwaXBlLT5mYXN5bmNfd3JpdGVycywgU0lHSU8sIFBPTExfT1VUKTsKIAlpZiAocmV0ID4gMCkK
IAkJZmlsZV9hY2Nlc3NlZChmaWxwKTsKIAlyZXR1cm4gcmV0OwpAQCAtNTY1LDEwICs1NjMsOSBA
QCBwaXBlX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQog
CQkgKiBiZWNvbWUgZW1wdHkgd2hpbGUgd2UgZHJvcHBlZCB0aGUgbG9jay4KIAkJICovCiAJCV9f
cGlwZV91bmxvY2socGlwZSk7Ci0JCWlmICh3YXNfZW1wdHkpIHsKKwkJaWYgKHdhc19lbXB0eSkK
IAkJCXdha2VfdXBfaW50ZXJydXB0aWJsZV9zeW5jX3BvbGwoJnBpcGUtPnJkX3dhaXQsIEVQT0xM
SU4gfCBFUE9MTFJETk9STSk7Ci0JCQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMs
IFNJR0lPLCBQT0xMX0lOKTsKLQkJfQorCQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRl
cnMsIFNJR0lPLCBQT0xMX0lOKTsKIAkJd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlX2V4Y2x1c2l2
ZShwaXBlLT53cl93YWl0LCBwaXBlX3dyaXRhYmxlKHBpcGUpKTsKIAkJX19waXBlX2xvY2socGlw
ZSk7CiAJCXdhc19lbXB0eSA9IHBpcGVfZW1wdHkocGlwZS0+aGVhZCwgcGlwZS0+dGFpbCk7CkBA
IC01OTEsMTAgKzU4OCw5IEBAIHBpcGVfd3JpdGUoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3Qg
aW92X2l0ZXIgKmZyb20pCiAJICogRXBvbGwgbm9uc2Vuc2ljYWxseSB3YW50cyBhIHdha2V1cCB3
aGV0aGVyIHRoZSBwaXBlCiAJICogd2FzIGFscmVhZHkgZW1wdHkgb3Igbm90LgogCSAqLwotCWlm
ICh3YXNfZW1wdHkgfHwgcGlwZS0+cG9sbF91c2FnZSkgeworCWlmICh3YXNfZW1wdHkgfHwgcGlw
ZS0+cG9sbF91c2FnZSkKIAkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlX3N5bmNfcG9sbCgmcGlwZS0+
cmRfd2FpdCwgRVBPTExJTiB8IEVQT0xMUkROT1JNKTsKLQkJa2lsbF9mYXN5bmMoJnBpcGUtPmZh
c3luY19yZWFkZXJzLCBTSUdJTywgUE9MTF9JTik7Ci0JfQorCWtpbGxfZmFzeW5jKCZwaXBlLT5m
YXN5bmNfcmVhZGVycywgU0lHSU8sIFBPTExfSU4pOwogCWlmICh3YWtlX25leHRfd3JpdGVyKQog
CQl3YWtlX3VwX2ludGVycnVwdGlibGVfc3luY19wb2xsKCZwaXBlLT53cl93YWl0LCBFUE9MTE9V
VCB8IEVQT0xMV1JOT1JNKTsKIAlpZiAocmV0ID4gMCAmJiBzYl9zdGFydF93cml0ZV90cnlsb2Nr
KGZpbGVfaW5vZGUoZmlscCktPmlfc2IpKSB7Cg==
--00000000000056e19405ca519ebf--
