Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10707308E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhA2Ubh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhA2U31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:29:27 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BDAC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:28:41 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i187so14258720lfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKLIyX25iKnuVKUfMGkqydZ4j+fzDI/x2+u6Osjlfzg=;
        b=RNnKvqMs5X7rMlrzvksstcZxv1h5xi/0tiNSyUnQ0Qw821fC4tLxajbT68MeMNxNw9
         prDS4lSuSq4PpXbwW5H/BrJyPRGbTSnbe30L7BHGva2UMgWrChWWVbkeKU/ITtOhHmHX
         LWPTUX+4wovRj0w3oqreB1AppyLBQB9OkpqTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKLIyX25iKnuVKUfMGkqydZ4j+fzDI/x2+u6Osjlfzg=;
        b=Ei4LvAuNr+U6Sr06AWjhzQz3LZt0izeI2pcXW2/AK1LW8o4S9rfLFZ9Q/TkRwgC9ph
         f0VRmhAa3DvsS0Vp+9/tkK+LLBZxwG7rqTQkNa93Wlj2d6DFEIziMXvlKe0Y3dXdhlXm
         kEmv8ZNEBD2bo45a8ak8DZcci2S4PkvvIX+jM6i+FaRaPZoJ9RS4Pwv7KwdmJtcSanMI
         6vQaTsBDKnrQ1HNDOOeicpZyH4LaMntQ0nuV+yHTLur9hYxPtoaI9t8QL89AX1JAvHDp
         X13gUnMK3SgGRL/Wx0jm2528UHzIetC9dx0hiJlcoNq58mclpu2vVmVcTQ9PPO03sgey
         AusQ==
X-Gm-Message-State: AOAM530eBnmlmTdG31EUQIp375hnxQ+myBmdVKFbwDjmU+Dj4oH057Rp
        SRXRwHjwlqnf/qDtnDPo0jf0Lydsvv/LYA==
X-Google-Smtp-Source: ABdhPJwYyBc50kCFa7dQebxp5qGS4izQym97OjB0z13UFecpqxHw3diJsWxnRT2IJ1XLMdfmRbh9pg==
X-Received: by 2002:a05:6512:4c9:: with SMTP id w9mr2857983lfq.437.1611952119373;
        Fri, 29 Jan 2021 12:28:39 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id e28sm2106184lfn.112.2021.01.29.12.28.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 12:28:37 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id p21so14248756lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:28:37 -0800 (PST)
X-Received: by 2002:ac2:4436:: with SMTP id w22mr2813506lfl.41.1611952116987;
 Fri, 29 Jan 2021 12:28:36 -0800 (PST)
MIME-Version: 1.0
References: <ce392dc6-d77f-b74c-8569-9a04ef8ad2d6@redhat.com>
 <CAHk-=wg6AG=1YjDC2gSspPYjEPWqDXkXaiaoPZS6X=Rg_XRUsw@mail.gmail.com>
 <98e2806d-81af-baf7-00f4-5a43870ff514@redhat.com> <8723f53e-9954-e0d2-16ce-933f53c776c3@redhat.com>
 <CAHk-=wifZZe44kGbeupwEo33J6DNiG=zGXpH9QW3AobiyjBf6A@mail.gmail.com> <CAHk-=whUWjLqe1=4O5B=PwfhwxUDqg7C7b0Yq50+bG-Jtvov6Q@mail.gmail.com>
In-Reply-To: <CAHk-=whUWjLqe1=4O5B=PwfhwxUDqg7C7b0Yq50+bG-Jtvov6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jan 2021 12:28:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXRFCTp5TVOa1WnXNwMDRv+tzKuBM44NLRs+_0UvUVYw@mail.gmail.com>
Message-ID: <CAHk-=wjXRFCTp5TVOa1WnXNwMDRv+tzKuBM44NLRs+_0UvUVYw@mail.gmail.com>
Subject: Re: [5.11 regression] "tty: implement write_iter" breaks TIOCCONS
To:     Hans de Goede <hdegoede@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000005423b405ba0fd980"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005423b405ba0fd980
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 29, 2021 at 12:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's fairly easy to work around in this in the tty layer by just
> avoiding that function entirely, so I'll cook up a patch to do that.
> But I'm adding the appropriate people to the participants here because
> this really is very subtle if you ever hit it.

Here's the patch to make the tty layer just do the redirection
entirely internally, avoiding that mis-designed vfs_iocb_iter_write()
function.

Hans, does this fix things for you? I'm pretty confident it will, but
always best to double-check..

                 Linus

--0000000000005423b405ba0fd980
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kkiqnlm20>
X-Attachment-Id: f_kkiqnlm20

IGRyaXZlcnMvdHR5L3R0eV9pby5jIHwgMjAgKysrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdHR5L3R0eV9pby5jIGIvZHJpdmVycy90dHkvdHR5X2lvLmMKaW5kZXggYmY3YmU4ZTY5
NzQ1Li5kOGE2OGY2YTBmZGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3R0eV9pby5jCisrKyBi
L2RyaXZlcnMvdHR5L3R0eV9pby5jCkBAIC0xMDkyLDkgKzEwOTIsOCBAQCB2b2lkIHR0eV93cml0
ZV9tZXNzYWdlKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIGNoYXIgKm1zZykKICAqCXdyaXRlIG1l
dGhvZCB3aWxsIG5vdCBiZSBpbnZva2VkIGluIHBhcmFsbGVsIGZvciBlYWNoIGRldmljZS4KICAq
LwogCi1zdGF0aWMgc3NpemVfdCB0dHlfd3JpdGUoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3Qg
aW92X2l0ZXIgKmZyb20pCitzdGF0aWMgc3NpemVfdCBmaWxlX3R0eV93cml0ZShzdHJ1Y3QgZmls
ZSAqZmlsZSwgc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20pCiB7Ci0J
c3RydWN0IGZpbGUgKmZpbGUgPSBpb2NiLT5raV9maWxwOwogCXN0cnVjdCB0dHlfc3RydWN0ICp0
dHkgPSBmaWxlX3R0eShmaWxlKTsKICAJc3RydWN0IHR0eV9sZGlzYyAqbGQ7CiAJc3NpemVfdCBy
ZXQ7CkBAIC0xMTE3LDYgKzExMTYsMTEgQEAgc3RhdGljIHNzaXplX3QgdHR5X3dyaXRlKHN0cnVj
dCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICpmcm9tKQogCXJldHVybiByZXQ7CiB9CiAK
K3N0YXRpYyBzc2l6ZV90IHR0eV93cml0ZShzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3Zf
aXRlciAqZnJvbSkKK3sKKwlyZXR1cm4gZmlsZV90dHlfd3JpdGUoaW9jYi0+a2lfZmlscCwgaW9j
YiwgZnJvbSk7Cit9CisKIHNzaXplX3QgcmVkaXJlY3RlZF90dHlfd3JpdGUoc3RydWN0IGtpb2Ni
ICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpCiB7CiAJc3RydWN0IGZpbGUgKnAgPSBOVUxM
OwpAQCAtMTEyNiw5ICsxMTMwLDEzIEBAIHNzaXplX3QgcmVkaXJlY3RlZF90dHlfd3JpdGUoc3Ry
dWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpCiAJCXAgPSBnZXRfZmlsZShy
ZWRpcmVjdCk7CiAJc3Bpbl91bmxvY2soJnJlZGlyZWN0X2xvY2spOwogCisJLyoKKwkgKiBXZSBr
bm93IHRoZSByZWRpcmVjdGVkIHR0eSBpcyBqdXN0IGFub3RoZXIgdHR5LCB3ZSBjYW4gY2FuCisJ
ICogY2FsbCBmaWxlX3R0eV93cml0ZSgpIGRpcmVjdGx5IHdpdGggdGhhdCBmaWxlIHBvaW50ZXIu
CisJICovCiAJaWYgKHApIHsKIAkJc3NpemVfdCByZXM7Ci0JCXJlcyA9IHZmc19pb2NiX2l0ZXJf
d3JpdGUocCwgaW9jYiwgaXRlcik7CisJCXJlcyA9IGZpbGVfdHR5X3dyaXRlKHAsIGlvY2IsIGl0
ZXIpOwogCQlmcHV0KHApOwogCQlyZXR1cm4gcmVzOwogCX0KQEAgLTIzNzQsNiArMjM4MiwxMiBA
QCBzdGF0aWMgaW50IHRpb2Njb25zKHN0cnVjdCBmaWxlICpmaWxlKQogCQkJZnB1dChmKTsKIAkJ
cmV0dXJuIDA7CiAJfQorCWlmIChmaWxlLT5mX29wLT53cml0ZV9pdGVyICE9IHR0eV93cml0ZSkK
KwkJcmV0dXJuIC1FTk9UVFk7CisJaWYgKCEoZmlsZS0+Zl9tb2RlICYgRk1PREVfV1JJVEUpKQor
CQlyZXR1cm4gLUVCQURGOworCWlmICghKGZpbGUtPmZfbW9kZSAmIEZNT0RFX0NBTl9XUklURSkp
CisJCXJldHVybiAtRUlOVkFMOwogCXNwaW5fbG9jaygmcmVkaXJlY3RfbG9jayk7CiAJaWYgKHJl
ZGlyZWN0KSB7CiAJCXNwaW5fdW5sb2NrKCZyZWRpcmVjdF9sb2NrKTsK
--0000000000005423b405ba0fd980--
