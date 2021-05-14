Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994A2380FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhENSZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhENSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:25:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21ECC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:23:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x19so44345211lfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbsFzf/6uE8/vghKo6cKrHWCyJcOabDGOcn6Hrn7dcI=;
        b=DCYZozQrMzknue6/EWuFmrYFlWMetVMt8Dmq65ypZNXDxu9hQw677RZsR4yZkbfMQ4
         Y6pwoY9/eto3ToMEMFwHALm0FAO4vO38F5ORdjb5yDrn1Zh541QjFzH+HhSGLWO0Oa12
         i7jcZ6xtUujNIIebz2U6mVmVFv84z0I3tn664=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbsFzf/6uE8/vghKo6cKrHWCyJcOabDGOcn6Hrn7dcI=;
        b=tTSgp1ItRJRr/H2rce3aTErRAuc2BwXz+3L4C6osY/cFhzSLrQIIuWnHb8CR/cYet4
         Nx1CsLgYOTCPlbpGxvjOlKWcxU232jgjfsf2r/7ykDPD5yTruInOD4lo92goiNQ6S13e
         RVzMtrYP3Q8746JYTSZs7jm0Ycem8EPtd5v6bnbuoRjgRpDKu69C5nhqkz01wP3ETVXM
         2qm2PLNs3MzEFs9z3haWi07P0L5rXTrh6hTovX9IJaDIeDdHpV43z8+GrOEb8R/OS/PV
         7cxE72BYIduV4u55nw4DUJqvJ2clE6GuTpT7zFTtT+V+mUiCy60dyYZHr6Lm/CnxRG6u
         ogBw==
X-Gm-Message-State: AOAM530/0t/VYPddt0RBNz5GQCF8IIQgvBzYycOrl7nZT7VYrwTrZedL
        5fVLAC2AZjWYxyRGwUDaeJbGlN28hAHSOtSkaPw=
X-Google-Smtp-Source: ABdhPJx3OktAZdWq5eS5kjlzCygokzt/YpYdADNOA7F2cxmI8jjPY2YoCXlFLwdh8832cpl6MOaLgQ==
X-Received: by 2002:a05:6512:3d2:: with SMTP id w18mr32948574lfp.573.1621016626843;
        Fri, 14 May 2021 11:23:46 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id b20sm867384lfp.308.2021.05.14.11.23.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 11:23:45 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id z13so44319626lft.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:23:45 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr32461268lfs.377.1621016624959;
 Fri, 14 May 2021 11:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006bbd0c05c14f1b09@google.com> <6e21483c-06f6-404b-4018-e00ee85c456c@i-love.sakura.ne.jp>
 <87d928e4-b2b9-ad30-f3f0-1dfb8e4e03ed@i-love.sakura.ne.jp>
 <05acdda8-dc1c-5119-4326-96eed24bea0c@i-love.sakura.ne.jp>
 <CAHk-=wguwhFpjhyMtDaH2hhjoV62gDgByC=aPyTrW9CkM5hqvA@mail.gmail.com> <CAHk-=whN=zrJ8BOLaGsJDH8d3sXLEoXA2DVsCq40OAUc1npOOw@mail.gmail.com>
In-Reply-To: <CAHk-=whN=zrJ8BOLaGsJDH8d3sXLEoXA2DVsCq40OAUc1npOOw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 11:23:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=winm7rEueQ2moqMZWWNNywu_9eVUrT7g0a30C8fhJojTQ@mail.gmail.com>
Message-ID: <CAHk-=winm7rEueQ2moqMZWWNNywu_9eVUrT7g0a30C8fhJojTQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: vga16fb: fix OOB write in vga16fb_imageblit()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Antonino A. Daplas" <adaplas@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001b409405c24e5891"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001b409405c24e5891
Content-Type: text/plain; charset="UTF-8"

On Fri, May 14, 2021 at 10:37 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, something like this would seem fairly simple and straightforward:

Proper patch in case syzbot can test this..

                  Linus

--0000000000001b409405c24e5891
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-vt-don-t-allow-text-mode-resizing-when-in-KD_GRAPHIC.patch"
Content-Disposition: attachment; 
	filename="0001-vt-don-t-allow-text-mode-resizing-when-in-KD_GRAPHIC.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_koon84w90>
X-Attachment-Id: f_koon84w90

RnJvbSBiMzNjYTE5NWNlY2VhNDc4NzY4ZGUzNTNiM2FlOTc2YzA3YTY1NjE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IEZyaSwgMTQgTWF5IDIwMjEgMTE6MDY6MTIgLTA3MDAKU3ViamVjdDog
W1BBVENIXSB2dDogZG9uJ3QgYWxsb3cgdGV4dC1tb2RlIHJlc2l6aW5nIHdoZW4gaW4gS0RfR1JB
UEhJQ1MgbW9kZQoKVGhlIFZUIGxheWVyIGl0c2VsZiBqdXN0IGtlZXBzIHRyYWNrIG9mIHRoZSB1
bmRlcmx5aW5nIHRleHQgY29udGVudHMKanVzdCBmaW5lLCBidXQgaWYgdGhlIHVuZGVybHlpbmcg
aGFyZHdhcmUgZHJpdmVyIGhhcyBhIGNvbl9yZXNpemUoKQpmdW5jdGlvbiwgd2UgY2FuJ3QganVz
dCBpZ25vcmUgaXQgd2hlbiBpbiBLRF9HUkFQSElDUyBtb2RlLgoKU28ganVzdCByZWZ1c2UgdG8g
ZG8gYSB0ZXh0IG1vZGUgcmVzaXplIGlmIHdlJ3JlIG5vdCBpbiB0ZXh0IG1vZGUuCgpSZXBvcnRl
ZC1ieTogVGV0c3VvIEhhbmRhIDxwZW5ndWluLWtlcm5lbEBpLWxvdmUuc2FrdXJhLm5lLmpwPgpS
ZXBvcnRlZC1ieTogc3l6Ym90IDxzeXpib3QrMWYyOWUxMjZjZjQ2MWM0ZGUzYjNAc3l6a2FsbGVy
LmFwcHNwb3RtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIGRyaXZlcnMvdHR5L3Z0L3Z0LmMgfCA3ICsrKysr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3R0eS92dC92dC5jIGIvZHJpdmVycy90dHkvdnQvdnQuYwppbmRleCAw
MTY0NWU4N2IzZDUuLmYyNGU2MjdiNzQwMiAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvdnQvdnQu
YworKysgYi9kcml2ZXJzL3R0eS92dC92dC5jCkBAIC0xMTcxLDggKzExNzEsMTMgQEAgc3RhdGlj
IGlubGluZSBpbnQgcmVzaXplX3NjcmVlbihzdHJ1Y3QgdmNfZGF0YSAqdmMsIGludCB3aWR0aCwg
aW50IGhlaWdodCwKIAkvKiBSZXNpemVzIHRoZSByZXNvbHV0aW9uIG9mIHRoZSBkaXNwbGF5IGFk
YXBhdGVyICovCiAJaW50IGVyciA9IDA7CiAKLQlpZiAodmMtPnZjX21vZGUgIT0gS0RfR1JBUEhJ
Q1MgJiYgdmMtPnZjX3N3LT5jb25fcmVzaXplKQorCWlmICh2Yy0+dmNfc3ctPmNvbl9yZXNpemUp
IHsKKwkJLy8gSWYgd2UgaGF2ZSBhIHJlc2l6ZSBmdW5jdGlvbiBidXQgYXJlIGluIEtEX0dSQVBI
SUNTIG1vZGUsCisJCS8vIHdlIGNhbid0IGFjdHVhbGx5IGRvIGEgcmVzaXplIGFuZCBuZWVkIHRv
IGVycm9yIG91dC4KKwkJaWYgKHZjLT52Y19tb2RlID09IEtEX0dSQVBISUNTKQorCQkJcmV0dXJu
IC1FSU5WQUw7CiAJCWVyciA9IHZjLT52Y19zdy0+Y29uX3Jlc2l6ZSh2Yywgd2lkdGgsIGhlaWdo
dCwgdXNlcik7CisJfQogCiAJcmV0dXJuIGVycjsKIH0KLS0gCjIuMzEuMS4zNjUuZ2EyYTA1YTM5
YzUKCg==
--0000000000001b409405c24e5891--
