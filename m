Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C645418D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 01:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhIZX3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 19:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhIZX3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 19:29:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1447DC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:27:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i4so68891819lfv.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to;
        bh=lEq5xChPAdXngs+SH25mBzooXWeOZIf27h0khry9/RI=;
        b=gqQ5dfffMsePztRuk1lljIIhtoGX9Zzw1bD/Lq45G7BHPjaKClSDdThTAY7st4y6gs
         UC9ata8d8ZLUyYC4O97MKfSRTPU5ECjTY40WOnLLwMXOJLYbNuwN1YSrHIeRh8K0RV0G
         UVwJcd5bw9ZHPbqM98sF5PE7LbNB6X5d6kgBk7EkIqLD8VZf0/xJAY0tVGy+onj/mKYw
         htqo4Rl9Jrd9HKmzttLsXIvES2nr3E/BQ2K9pIEIeytAM7YP82M4gQ6qPz6LW6fUFCIC
         bA/Z+0e5JjRmIQSouE9WZvOjNyd1KTl9FAjXDa5Z6wwwQkqy7OVkxfZ+HkXm8sqtoEq+
         RSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to;
        bh=lEq5xChPAdXngs+SH25mBzooXWeOZIf27h0khry9/RI=;
        b=nQfxrY6LHc1wkF9UY0T4rRrMTFpMf4nX0HQHekLqCjY0udcv9khY4wjocTPBf94i8o
         RAJyxR9CMEQKzLv5os4Jsr9MBNem16gt+KjnLjaB5gUY69Zd5aG3C5nE7qyaBlETka92
         jbAs2CvJN2SA69xl0ApxdIdQu5enji/YkZqnHTzE6M52GHb4HMeKMYueBDQsxDztkKW1
         A/9vbk6Gi18Jhn4aCQ44WOWPXt4cF5jYcQ2ONdFMRKj39UF60JgS7lbJQmfoOYC9wehQ
         VNpp9i4svP01f1L5y16i/3yOy4+R5fpvr6hE7Ry/tAYS/y8sG1vt3IHIFuHrj6cUuv4i
         80XA==
X-Gm-Message-State: AOAM531893ssRoIrmFf3sXUwnJWRMywD0vuaJAdBbUynJNei7pdoJ+W5
        OLOxPBdsLJztq7LcmdulVc8=
X-Google-Smtp-Source: ABdhPJxiE9tm7qfFT411QrtmCzUzMZcK9KUNKZqBon7uKzM2x2E/OPMZ9ZB3tIXbK2txNd9oG69Xqg==
X-Received: by 2002:a2e:7d15:: with SMTP id y21mr25860893ljc.70.1632698855227;
        Sun, 26 Sep 2021 16:27:35 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.245.149])
        by smtp.gmail.com with ESMTPSA id g7sm711036lfc.123.2021.09.26.16.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 16:27:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------mXjgco1H7Lu8J0e48IiMixSC"
Message-ID: <35d0ddc1-41cd-16fb-41ea-5529d19c04d2@gmail.com>
Date:   Mon, 27 Sep 2021 02:27:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [syzbot] memory leak in __mdiobus_register
Content-Language: en-US
To:     syzbot <syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000069acee05ccdbe5a7@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <00000000000069acee05ccdbe5a7@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------mXjgco1H7Lu8J0e48IiMixSC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/21 04:28, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d9fb678414c0 Merge tag 'afs-fixes-20210913' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=131c754b300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f0de362a1f17687e
> dashboard link: https://syzkaller.appspot.com/bug?extid=398e7dc692ddbbb4cfec
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145650d1300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105ccde7300000
> 

Looks like MDIOBUS_ALLOCATED indicated 2 states:

	1. Bus is only allocated
	2. Bus allocated and __mdiobus_register() fails, but
	   device_register() was called

These 2 cases should be handled separately, i.e. we need to call 
put_device() if device_register() was called.

To handle this situation we can add new state MDIOBUS_DEV_REGISTERED and 
handle it properly


Just for thoughts and syzbot testing

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


With regards,
Pavel Skripkin






--------------mXjgco1H7Lu8J0e48IiMixSC
Content-Type: text/plain; charset=UTF-8; name="ph"
Content-Disposition: attachment; filename="ph"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9tZGlvX2J1cy5jIGIvZHJpdmVycy9uZXQv
cGh5L21kaW9fYnVzLmMKaW5kZXggNTNmMDM0ZmMyZWY3Li5lZDc2NDYzOGI0NDkgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbmV0L3BoeS9tZGlvX2J1cy5jCisrKyBiL2RyaXZlcnMvbmV0L3Bo
eS9tZGlvX2J1cy5jCkBAIC01NDAsNiArNTQwLDggQEAgaW50IF9fbWRpb2J1c19yZWdpc3Rl
cihzdHJ1Y3QgbWlpX2J1cyAqYnVzLCBzdHJ1Y3QgbW9kdWxlICpvd25lcikKIAkJcmV0dXJu
IC1FSU5WQUw7CiAJfQogCisJYnVzLT5zdGF0ZSA9IE1ESU9CVVNfREVWX1JFR0lTVEVSRUQ7
CisKIAltdXRleF9pbml0KCZidXMtPm1kaW9fbG9jayk7CiAJbXV0ZXhfaW5pdCgmYnVzLT5z
aGFyZWRfbG9jayk7CiAKQEAgLTY0Nyw3ICs2NDksNyBAQCB2b2lkIG1kaW9idXNfZnJlZShz
dHJ1Y3QgbWlpX2J1cyAqYnVzKQogCQlyZXR1cm47CiAJfQogCi0JQlVHX09OKGJ1cy0+c3Rh
dGUgIT0gTURJT0JVU19VTlJFR0lTVEVSRUQpOworCUJVR19PTihidXMtPnN0YXRlICE9IE1E
SU9CVVNfVU5SRUdJU1RFUkVEICYmIGJ1cy0+c3RhdGUgIT0gTURJT0JVU19ERVZfUkVHSVNU
RVJFRCk7CiAJYnVzLT5zdGF0ZSA9IE1ESU9CVVNfUkVMRUFTRUQ7CiAKIAlwdXRfZGV2aWNl
KCZidXMtPmRldik7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BoeS5oIGIvaW5jbHVk
ZS9saW51eC9waHkuaAppbmRleCA3MzZlMWQxYTQ3YzQuLjQxZDJjY2RhY2Q1ZSAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9saW51eC9waHkuaAorKysgYi9pbmNsdWRlL2xpbnV4L3BoeS5oCkBA
IC0zNDMsNiArMzQzLDcgQEAgc3RydWN0IG1paV9idXMgewogCQlNRElPQlVTX1JFR0lTVEVS
RUQsCiAJCU1ESU9CVVNfVU5SRUdJU1RFUkVELAogCQlNRElPQlVTX1JFTEVBU0VELAorCQlN
RElPQlVTX0RFVl9SRUdJU1RFUkVELAogCX0gc3RhdGU7CiAKIAkvKiogQGRldjogS2VybmVs
IGRldmljZSByZXByZXNlbnRhdGlvbiAqLwo=
--------------mXjgco1H7Lu8J0e48IiMixSC--

