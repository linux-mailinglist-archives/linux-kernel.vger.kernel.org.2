Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8393E3468
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhHGJrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhHGJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:47:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99ABC0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:46:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so26376535pjr.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Mozi9talEt/mI/l6KvxWbDISyLan2Xy8GUlPURIr5DU=;
        b=aMQO+4gcdWmQkXxeuKofbMTIHowkfCM0OYTabnI+bi5wV6Y05CPxWRDSD0Brczn1I8
         WaRxuqZFqxcRmzDk0Te72bzjpbEOxF+qsFXAn9W6SC+Izi/kZO77dhLqqqpYkD3mw69q
         39YBy4MbyzPh+mUTKHVreBsq+MpXSOyldB2nVqGi0BrhYNTGAbYa3jxNRhzHB4m50czU
         off+fqzjgZMOmGeHBUCTYIcbASXzOrGSFTZrySn5WZ/C5ZWoZ41FhasgVpbb+k826yJm
         D0pq19UiQ+11dmg4bUOdt3o6f0200tT93Mv19Vo9D8Y2C5/e9eka9O5cu5TIZeLGSAa9
         /0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Mozi9talEt/mI/l6KvxWbDISyLan2Xy8GUlPURIr5DU=;
        b=T3+UG8Rx6ipPf9DmzQW/c+F1fiFOifXV3+zPBFOGAPxVtOctbyGZPOHhgpPAJPnTP5
         f3NlMf1VfzFBVRGbcO1DRbC2ZFa5uBTisSRlQmGv8k+5oR2N7AgF/x/sW4ObgWvFkxXS
         4J+l+rnRcmRZ44RuYS9OE7eNi0uYbTy+8ny0Zo+6wrTqAgYA0lbazmNNdJluj/HO0Ov/
         BEEm4bc137FJ8UNLAd0BinmTd4dTT51ZYDctnImkZ8bXJnU2Mx+Ipwl/PUi2l2O/J3sn
         Lb09iqk3S4E8wAtdv2hXaM7WzE4JKyIKbGaVvQzE1kjQ4KMzeEj6ysYxEvT41BFQA79p
         Y/Uw==
X-Gm-Message-State: AOAM533ArW/kxKW66F2QRDMDG+seHKZjTbAyyCrFAQRcfVOU0d4G9B9J
        S5VXmBSpyoLE1R6diHTYMbdgR9Cu4HphaWMXmRY=
X-Google-Smtp-Source: ABdhPJyBZrmHcxTp8EiZ/N6O/K5k88k1ZX4EENwDNdagborpzR1O1KIzFkpZrcs9MpGApGeYmIQBHfPrh6T4lTHb+7o=
X-Received: by 2002:a63:211c:: with SMTP id h28mr744025pgh.83.1628329604234;
 Sat, 07 Aug 2021 02:46:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:fa91:0:0:0:0 with HTTP; Sat, 7 Aug 2021 02:46:43
 -0700 (PDT)
Reply-To: georgemike7031@gmail.com
From:   george mike <eddywilliam0002@gmail.com>
Date:   Sat, 7 Aug 2021 11:46:43 +0200
Message-ID: <CAP8JzxKv2CDJdmGL3n2=5qxi38qxHKCwJXZt-eBcBsPM5vdFUw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

Mein Name ist George Mike, ich bin von Beruf Rechtsanwalt. Ich m=C3=B6chte
dir anbieten
der n=C3=A4chste Angeh=C3=B6rige meines Klienten. Sie erben die Summe von (=
8,5
Millionen US-Dollar)
Dollar, die mein Mandant vor seinem Tod auf der Bank hinterlie=C3=9F.

Mein Mandant ist ein B=C3=BCrger Ihres Landes, der mit seiner Frau bei
einem Autounfall gestorben ist
und einziger Sohn. Ich habe Anspruch auf 50% des Gesamtfonds, w=C3=A4hrend
50% dies tun werden
sein f=C3=BCr dich.
Bitte kontaktieren Sie meine private E-Mail hier f=C3=BCr weitere
Details:georgemike7031@gmail.com

Vielen Dank im Voraus,
Herr George Mike,
