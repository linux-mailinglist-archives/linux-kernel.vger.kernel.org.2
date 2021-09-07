Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD530402A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhIGOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhIGOFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:05:09 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55282C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 07:04:03 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id e20so2098457uam.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTa4HJUTB1E1dZjIkPVAASLfWDZL+qHUwuV+ayrSHns=;
        b=inAAuNIv+kI+xZOAB3EPk8wdYMUUsfj7bQDBPvEPuHgsxCGL2nhDmG3LE+HhdOcbOw
         lPrIDz7iTpgssZaKhgNCT6GVLHco2hYg/6mfEZyi3olJMD+CwWd7XLW4+7mfs5dKEIZE
         R9VG+5TLBrqOJb5NQyugyhRxUhAmbs9ehI2Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTa4HJUTB1E1dZjIkPVAASLfWDZL+qHUwuV+ayrSHns=;
        b=Lwrab52HMcHrxmZZyy8VQXlAeHw6/JqAk2A0bHPRWxxmGe5BA4Z0dDDCf+2GWMLRjc
         50YvJ1hdja4+BM3TaTKPEH0w5t9QBt+PmPVh1vRSe21/xU/+lIuDVMyGHsag4fHUhBRP
         GkpJvHq40pGN0hasulgcKTOUJjVFL+3S/KPZpCc7lY23NdTPwNR8yVoPF30ZUa1bYhde
         pMBx3CyKKU9gkqoPDRCs4URsSyneOJwaxiIACxnwtfbo+QJNQ2aYKfCL+hRkICCjNn3d
         jLegg5P1jD+iwQsy5K+JdGVNJOrVqkjtxqGBdrkq9uPZk8D67TgI/6LtDKNlxxOsVAo1
         mdZg==
X-Gm-Message-State: AOAM531PZVidmaO3uZ8Y8ieWnSCLVuQLKst/6wIQ5dTMoemIaiInL7F1
        TkLuuue1tJZn+JxdkuQwPf4Cuamrd5W0My7EFkhbyQ==
X-Google-Smtp-Source: ABdhPJzHZPZRuPRuZt20E9scsXEEBlFoT3cMFyw+EIRxLSIpN/j+ITmscvSnHyr2vYNsPuKFUBnq1obCZEM2sWB3bBc=
X-Received: by 2002:a9f:234a:: with SMTP id 68mr43793uae.13.1631023442512;
 Tue, 07 Sep 2021 07:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006dd93205cad885e5@google.com>
In-Reply-To: <0000000000006dd93205cad885e5@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Sep 2021 16:03:49 +0200
Message-ID: <CAJfpegvOa5cT5eRTsaMtAJ0YfZ1ob_kuW-NNK-emu3ncp2pK7A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in ovl_create_real
To:     syzbot <syzbot+75eab84fd0af9e8bf66b@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000e9785505cb683cfb"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e9785505cb683cfb
Content-Type: text/plain; charset="UTF-8"

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

--000000000000e9785505cb683cfb
Content-Type: text/x-patch; charset="US-ASCII"; name="ovl-test.patch"
Content-Disposition: attachment; filename="ovl-test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kta57rjk0>
X-Attachment-Id: f_kta57rjk0

ZGlmZiAtLWdpdCBhL2ZzL292ZXJsYXlmcy9kaXIuYyBiL2ZzL292ZXJsYXlmcy9kaXIuYwppbmRl
eCAxZmVmYjJiODk2MGUuLjBmNmMxMGVjNTZjMSAxMDA2NDQKLS0tIGEvZnMvb3ZlcmxheWZzL2Rp
ci5jCisrKyBiL2ZzL292ZXJsYXlmcy9kaXIuYwpAQCAtMTUwLDYgKzE1MCw5IEBAIHN0YXRpYyBp
bnQgb3ZsX21rZGlyX3JlYWwoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKipuZXdk
ZW50cnksCiAJaWYgKGxpa2VseSghZF91bmhhc2hlZChkZW50cnkpKSkKIAkJcmV0dXJuIDA7CiAK
Kwlwcl9pbmZvKCJ1bmhhc2hlZCBkZW50cnkgYWZ0ZXIgbWtkaXIgKCVzKVxuIiwKKwkJZGVudHJ5
LT5kX3NiLT5zX3R5cGUtPm5hbWUpOworCiAJLyoKIAkgKiB2ZnNfbWtkaXIoKSBtYXkgc3VjY2Vl
ZCBhbmQgbGVhdmUgdGhlIGRlbnRyeSBwYXNzZWQKIAkgKiB0byBpdCB1bmhhc2hlZCBhbmQgbmVn
YXRpdmUuIElmIHRoYXQgaGFwcGVucywgdHJ5IHRvCkBAIC0yMDksNyArMjEyLDEwIEBAIHN0cnVj
dCBkZW50cnkgKm92bF9jcmVhdGVfcmVhbChzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRy
eSAqbmV3ZGVudHJ5LAogCQkJZXJyID0gLUVQRVJNOwogCQl9CiAJfQotCWlmICghZXJyICYmIFdB
Uk5fT04oIW5ld2RlbnRyeS0+ZF9pbm9kZSkpIHsKKwlpZiAoIWVyciAmJiAhbmV3ZGVudHJ5LT5k
X2lub2RlKSB7CisJCXByX3dhcm4oIm5lZ2F0aXZlIGRlbnRyeSBhZnRlciBta2RpciAoJXMpXG4i
LAorCQkJbmV3ZGVudHJ5LT5kX3NiLT5zX3R5cGUtPm5hbWUpOworCQlXQVJOX09OKDEpOwogCQkv
KgogCQkgKiBOb3QgcXVpdGUgc3VyZSBpZiBub24taW5zdGFudGlhdGVkIGRlbnRyeSBpcyBsZWdh
bCBvciBub3QuCiAJCSAqIFZGUyBkb2Vzbid0IHNlZW0gdG8gY2FyZSBzbyBjaGVjayBhbmQgd2Fy
biBoZXJlLgo=
--000000000000e9785505cb683cfb--
