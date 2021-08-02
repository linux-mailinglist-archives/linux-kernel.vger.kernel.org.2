Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07533DDE48
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhHBROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhHBROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:14:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3468AC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 10:14:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u20so24853759ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=he6Iv2vu1/MdZd13CEk5ojnSMnvMUe+/GHqu+U8iJUY=;
        b=AhmqB/3VTwkaK+Vdbs9QMpxqcXKdEISPqWbVzsCqHq0HNY74VjUEDseelorzd+XzSs
         kcwhYhekXYRJVpY9PYl2MYjBBsNm8auotR7wfNLFjrcB8WUHcw+U0RgNUl4nqzOyoaK6
         Zwfws3D84/r7JuJXsHdq8rSSxjj5lVuTmcDBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=he6Iv2vu1/MdZd13CEk5ojnSMnvMUe+/GHqu+U8iJUY=;
        b=iIl+uoTr/ywUlaP0XqjMNj9Rpw0nAFeHvJKYjPPZvhSBq18pruWNuBEIh/tMEnEkUG
         G8vtF0kYODRk3FIXSAUXpRaRP8XjAeg79irnYC8qT1JH7m19WPbw75Vn5FB0AgWVoQv2
         HcbmFMPxKN54PM3H2Bpenk2b3douXH1N4y+SN0BhrLk/x55l9Vtsgpz1HrXoqZmSEm0U
         RDkUT6FCgBjOgi/tvThhjRzLEj5F9THxul970Z3GCV+X/R6FgmjB97YTEnC3LzovRXJ9
         bYiSZkZEzXXcc0CD9+28c8tDwrv4Wfq2hXyEXZXC7E3XKDPqVH92xLCesSjSo+vxr9wj
         Nizg==
X-Gm-Message-State: AOAM531OlW2ZLT5jlcUAqUsS6Vp25sHFWG9wpRxUG2U1Wj/z72XKOfyc
        RsnAqsM55ES4JI5bPJf6ZAHkmRhO0iwP6vRq
X-Google-Smtp-Source: ABdhPJyT0EibEhsX2ZczTXhJEIUsvFfd3z9flqEsda7tuV6xcKMILXZnX9+wSwqjy29/Y8Qfjv4zFw==
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr11807091ljc.281.1627924472339;
        Mon, 02 Aug 2021 10:14:32 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id c22sm1008559lfb.39.2021.08.02.10.14.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 10:14:31 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id a26so34925281lfr.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:14:31 -0700 (PDT)
X-Received: by 2002:a05:6512:2347:: with SMTP id p7mr13423297lfu.253.1627924470794;
 Mon, 02 Aug 2021 10:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210802024945.GA8372@xsang-OptiPlex-9020> <CAHk-=whr-zgf41B0BPsWnL-WWqhdk71rKffhV0fzdCuem3=SCQ@mail.gmail.com>
In-Reply-To: <CAHk-=whr-zgf41B0BPsWnL-WWqhdk71rKffhV0fzdCuem3=SCQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Aug 2021 10:14:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYu7f=itjJJTfAWdDN2Baz0whdU1bzxh_5RAfj+LyB3g@mail.gmail.com>
Message-ID: <CAHk-=whYu7f=itjJJTfAWdDN2Baz0whdU1bzxh_5RAfj+LyB3g@mail.gmail.com>
Subject: Re: [pipe] 3a34b13a88: hackbench.throughput -12.6% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Sandeep Patil <sspatil@android.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: multipart/mixed; boundary="000000000000cdb9ea05c896b35a"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cdb9ea05c896b35a
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 2, 2021 at 10:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sandeep, does something like the attached patch (written to be on top
> of the existing one) work for you?

.. and by "attached patch" I obviously meant the patch that wasn't attached.

It's here.

                 Linus

--000000000000cdb9ea05c896b35a
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kruw6pwy0>
X-Attachment-Id: f_kruw6pwy0

IGZzL3BpcGUuYyAgICAgICAgICAgICAgICAgfCAxNSArKysrKysrKystLS0tLS0KIGluY2x1ZGUv
bGludXgvcGlwZV9mc19pLmggfCAgMiArKwogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3BpcGUuYyBiL2ZzL3BpcGUuYwpp
bmRleCA5ZWY0MjMxY2NlNjEuLmUxNzA0YzE0YTkxOCAxMDA2NDQKLS0tIGEvZnMvcGlwZS5jCisr
KyBiL2ZzL3BpcGUuYwpAQCAtNDI5LDkgKzQyOSw2IEBAIHBpcGVfd3JpdGUoc3RydWN0IGtpb2Ni
ICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20pCiAjZW5kaWYKIAogCS8qCi0JICogRXBvbGwg
bm9uc2Vuc2ljYWxseSB3YW50cyBhIHdha2V1cCB3aGV0aGVyIHRoZSBwaXBlCi0JICogd2FzIGFs
cmVhZHkgZW1wdHkgb3Igbm90LgotCSAqCiAJICogSWYgaXQgd2Fzbid0IGVtcHR5IHdlIHRyeSB0
byBtZXJnZSBuZXcgZGF0YSBpbnRvCiAJICogdGhlIGxhc3QgYnVmZmVyLgogCSAqCkBAIC00NDAs
OSArNDM3LDkgQEAgcGlwZV93cml0ZShzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRl
ciAqZnJvbSkKIAkgKiBzcGFubmluZyBtdWx0aXBsZSBwYWdlcy4KIAkgKi8KIAloZWFkID0gcGlw
ZS0+aGVhZDsKLQl3YXNfZW1wdHkgPSB0cnVlOworCXdhc19lbXB0eSA9IHBpcGVfZW1wdHkoaGVh
ZCwgcGlwZS0+dGFpbCk7CiAJY2hhcnMgPSB0b3RhbF9sZW4gJiAoUEFHRV9TSVpFLTEpOwotCWlm
IChjaGFycyAmJiAhcGlwZV9lbXB0eShoZWFkLCBwaXBlLT50YWlsKSkgeworCWlmIChjaGFycyAm
JiAhd2FzX2VtcHR5KSB7CiAJCXVuc2lnbmVkIGludCBtYXNrID0gcGlwZS0+cmluZ19zaXplIC0g
MTsKIAkJc3RydWN0IHBpcGVfYnVmZmVyICpidWYgPSAmcGlwZS0+YnVmc1soaGVhZCAtIDEpICYg
bWFza107CiAJCWludCBvZmZzZXQgPSBidWYtPm9mZnNldCArIGJ1Zi0+bGVuOwpAQCAtNTc1LDgg
KzU3MiwxMSBAQCBwaXBlX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVy
ICpmcm9tKQogCSAqIFRoaXMgaXMgcGFydGljdWxhcmx5IGltcG9ydGFudCBmb3Igc21hbGwgd3Jp
dGVzLCBiZWNhdXNlIG9mCiAJICogaG93IChmb3IgZXhhbXBsZSkgdGhlIEdOVSBtYWtlIGpvYnNl
cnZlciB1c2VzIHNtYWxsIHdyaXRlcyB0bwogCSAqIHdha2UgdXAgcGVuZGluZyBqb2JzCisJICoK
KwkgKiBFcG9sbCBub25zZW5zaWNhbGx5IHdhbnRzIGEgd2FrZXVwIHdoZXRoZXIgdGhlIHBpcGUK
KwkgKiB3YXMgYWxyZWFkeSBlbXB0eSBvciBub3QuCiAJICovCi0JaWYgKHdhc19lbXB0eSkgewor
CWlmICh3YXNfZW1wdHkgfHwgcGlwZS0+cG9sbF91c2FnZSkgewogCQl3YWtlX3VwX2ludGVycnVw
dGlibGVfc3luY19wb2xsKCZwaXBlLT5yZF93YWl0LCBFUE9MTElOIHwgRVBPTExSRE5PUk0pOwog
CQlraWxsX2Zhc3luYygmcGlwZS0+ZmFzeW5jX3JlYWRlcnMsIFNJR0lPLCBQT0xMX0lOKTsKIAl9
CkBAIC02MzksNiArNjM5LDkgQEAgcGlwZV9wb2xsKHN0cnVjdCBmaWxlICpmaWxwLCBwb2xsX3Rh
YmxlICp3YWl0KQogCXN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUgPSBmaWxwLT5wcml2YXRl
X2RhdGE7CiAJdW5zaWduZWQgaW50IGhlYWQsIHRhaWw7CiAKKwkvKiBFcG9sbCBoYXMgc29tZSBo
aXN0b3JpY2FsIG5hc3R5IHNlbWFudGljcywgdGhpcyBlbmFibGVzIHRoZW0gKi8KKwlwaXBlLT5w
b2xsX3VzYWdlID0gMTsKKwogCS8qCiAJICogUmVhZGluZyBwaXBlIHN0YXRlIG9ubHkgLS0gbm8g
bmVlZCBmb3IgYWNxdWlyaW5nIHRoZSBzZW1hcGhvcmUuCiAJICoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvcGlwZV9mc19pLmggYi9pbmNsdWRlL2xpbnV4L3BpcGVfZnNfaS5oCmluZGV4IDVk
MjcwNWYxZDAxYy4uZmM1NjQyNDMxYjkyIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3BpcGVf
ZnNfaS5oCisrKyBiL2luY2x1ZGUvbGludXgvcGlwZV9mc19pLmgKQEAgLTQ4LDYgKzQ4LDcgQEAg
c3RydWN0IHBpcGVfYnVmZmVyIHsKICAqCUBmaWxlczogbnVtYmVyIG9mIHN0cnVjdCBmaWxlIHJl
ZmVycmluZyB0aGlzIHBpcGUgKHByb3RlY3RlZCBieSAtPmlfbG9jaykKICAqCUByX2NvdW50ZXI6
IHJlYWRlciBjb3VudGVyCiAgKglAd19jb3VudGVyOiB3cml0ZXIgY291bnRlcgorICoJQHBvbGxf
dXNhZ2U6IGlzIHRoaXMgcGlwZSB1c2VkIGZvciBlcG9sbCwgd2hpY2ggaGFzIGNyYXp5IHdha2V1
cHM/CiAgKglAZmFzeW5jX3JlYWRlcnM6IHJlYWRlciBzaWRlIGZhc3luYwogICoJQGZhc3luY193
cml0ZXJzOiB3cml0ZXIgc2lkZSBmYXN5bmMKICAqCUBidWZzOiB0aGUgY2lyY3VsYXIgYXJyYXkg
b2YgcGlwZSBidWZmZXJzCkBAIC03MCw2ICs3MSw3IEBAIHN0cnVjdCBwaXBlX2lub2RlX2luZm8g
ewogCXVuc2lnbmVkIGludCBmaWxlczsKIAl1bnNpZ25lZCBpbnQgcl9jb3VudGVyOwogCXVuc2ln
bmVkIGludCB3X2NvdW50ZXI7CisJdW5zaWduZWQgaW50IHBvbGxfdXNhZ2U7CiAJc3RydWN0IHBh
Z2UgKnRtcF9wYWdlOwogCXN0cnVjdCBmYXN5bmNfc3RydWN0ICpmYXN5bmNfcmVhZGVyczsKIAlz
dHJ1Y3QgZmFzeW5jX3N0cnVjdCAqZmFzeW5jX3dyaXRlcnM7Cg==
--000000000000cdb9ea05c896b35a--
