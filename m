Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC20402BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbhIGP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345209AbhIGP0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:26:15 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D576C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 08:25:09 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id x23so5763202uav.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfHP2sgThQg8v8lbN+JggZp2tkzNElpWzdFKXLFCG6Q=;
        b=CjL6dPNn7z3OXHGFEWoI6jzNsXPr5UxuLKeWIUNRcv+4BVTpWYG3/Uhuy6WxSQX+5a
         zCAZFfkFMA2rVvsG+osJcjlvLByKHuE4Mf9hlernIpqK8Ptrxcd7l4DCITyB85wt8yUd
         9+Ow4qpzjpH2yODj7NoeC+N3GQd/EqTxTQsaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfHP2sgThQg8v8lbN+JggZp2tkzNElpWzdFKXLFCG6Q=;
        b=gcZNxZ9fMjvVAwM0TKNFSlQs1dhcMMwqSIt8NqdJo4gMqf1rgX+3TmcDrsQj0/bDaE
         Ri0RI2/Rjm7CFY9Ti2nOxJdL8E0AiDv922ky5VkjUapjx4yBAO1TjHIU2aIYao+XrdLz
         dPe6jsJHR+PSj2KjEm80Gkr2ddUdegOgMdUDjqzU4LWOpothBBw+UWhFk2LGg2G8zII0
         3c/5ZuMJvSSgUbIaq8C7kCQ1wCHFuWZmueM3etYGdzqK0hPv2n7xGoUqT6NtSJd+XsY1
         mSzaDxUsK4Jso+KVhPxQXjEjb4IoGq03krh5fduVwJAW5evF/1eRnl/Xw8NjWNTJZrdo
         q7Uw==
X-Gm-Message-State: AOAM533Zpg1eBi0SkGwQKZMSEoMW8yBNKRSuhsinY4nr2gpnh3oXg4V1
        7AYghhtypKYRHW/mf9KBxMJabZqskwaE89JwjT08Jw==
X-Google-Smtp-Source: ABdhPJyaSPIaBUI16PkzloKRKGzn7kYbkTsVtsV/EG3nkEafmSeiOXKMvyXw3/fFt4HAVmQwz1Au77pTUYJOQXvu7H4=
X-Received: by 2002:a9f:234a:: with SMTP id 68mr505653uae.13.1631028308416;
 Tue, 07 Sep 2021 08:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a4cc9405c95d0e1c@google.com>
In-Reply-To: <000000000000a4cc9405c95d0e1c@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Sep 2021 17:24:56 +0200
Message-ID: <CAJfpegvr1y9VTXb3Gm2F1Y9mZzWYAEYutV8kdhnD2Yyo8FTvcQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in fuse_reverse_inval_entry
To:     syzbot <syzbot+9f747458f5990eaa8d43@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000f13b0d05cb695ed9"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f13b0d05cb695ed9
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

--000000000000f13b0d05cb695ed9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-annotate-lock-in-inval_entry.patch"
Content-Disposition: attachment; 
	filename="fuse-annotate-lock-in-inval_entry.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kta842p30>
X-Attachment-Id: f_kta842p30

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IGZ1c2U6
IGFubm90YXRlIGxvY2sgaW4gZnVzZV9yZXZlcnNlX2ludmFsX2VudHJ5KCkKCkFkZCBtaXNzaW5n
IGlub2RlIGxvY2sgYW5ub3RhdGF0aW9uOyBmb3VuZCBieSBzeXpib3QuCgpSZXBvcnRlZC1ieTog
c3l6Ym90KzlmNzQ3NDU4ZjU5OTBlYWE4ZDQzQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KU2ln
bmVkLW9mZi1ieTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+Ci0tLQogZnMv
ZnVzZS9kaXIuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKLS0tIGEvZnMvZnVzZS9kaXIuYworKysgYi9mcy9mdXNlL2Rpci5jCkBAIC0x
MDcxLDcgKzEwNzEsNyBAQCBpbnQgZnVzZV9yZXZlcnNlX2ludmFsX2VudHJ5KHN0cnVjdCBmdXNl
CiAJaWYgKCFwYXJlbnQpCiAJCXJldHVybiAtRU5PRU5UOwogCi0JaW5vZGVfbG9jayhwYXJlbnQp
OworCWlub2RlX2xvY2tfbmVzdGVkKHBhcmVudCwgSV9NVVRFWF9QQVJFTlQpOwogCWlmICghU19J
U0RJUihwYXJlbnQtPmlfbW9kZSkpCiAJCWdvdG8gdW5sb2NrOwogCg==
--000000000000f13b0d05cb695ed9--
