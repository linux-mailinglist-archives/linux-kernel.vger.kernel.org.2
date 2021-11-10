Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D875644C2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhKJOYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 09:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhKJOYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 09:24:36 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A685C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:21:49 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y3so6877010ybf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 06:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NaPyQN8h+QNIaGWgSK1Ju4oHZx8p02hK+6cB8hHbFvc=;
        b=OOc8gfast4fmC0CJrITF0gylRkAsjBs2ZPN+ABaN+wUhA/+6BSX9sJ5Pevqpt2BKXh
         iaon5q87ML2uhUOo6EvO4B0CDdX8bw2wcDiPMLeTrd1EODpkB8DGW+K/PmhQeOqYBLmp
         U2I/SyUHdtK7rEDHUbUTxHX/ntWLbQBd3b3xQP61L6byqJtogFwMZpw6SyxyU5D69lzf
         70guxG26eBaWl9Xt3b2HPtC0b78VnaVlBGzLCSRgt9rufIz+KjuD/tY20HB1/N8K86qq
         HFhOIU/VGwhDChz7YBnh3/KKSjMM8y97IX4Y5Nd3f0dVM91PNuBjmoIG7SQWr/bLY+1l
         u4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=NaPyQN8h+QNIaGWgSK1Ju4oHZx8p02hK+6cB8hHbFvc=;
        b=GfNHWLLe1pVY+rPHbEOp3f6DLuPQT9sSskqaKQkb9HFeYaJaZOc17rlKLbS/AKS9DH
         mc56dzHHDlrTPbQ7dB5dNIGjgqpwZaLG4r8QF1k3E6POnvC7YSFTmVlxKWYfHhgVJaGJ
         rNLLojEtpAKsEtJYmfDbiOqVPaqXDWAk3ttb79hrgHwu+A+iMi8vepjHDcccuj91fQPO
         Xl3XnT0RVSGnF4gOIb/dWpNOzAeY5PdErt/eR2k2rsxzuftuQ/bvnj1sLQWLp/TPqdyb
         U0m2X2UM4dwjW+mHDDU6KXQ4VQHgxNEfkIrejqYXk23Q2MkIbRb0g4f44nZLGUUUSrIc
         NCgw==
X-Gm-Message-State: AOAM533hod9lOffUFyNXAppt1f6nK61iwL3qX0ytK++bX/Vy7SwFYaQf
        ATVzFkMNX8HzyM6Vxcsofi07pm4XbJ0VBrtPm+g=
X-Google-Smtp-Source: ABdhPJwqZRXdYpqNZvxDeKU7RX5m+UZygzFk++PtSchlzTQdmQb8SgSkIhExVcAfV+SwPFj/exrjm1Cvr1Qf7KqxH5U=
X-Received: by 2002:a05:6902:100b:: with SMTP id w11mr18760357ybt.64.1636554108230;
 Wed, 10 Nov 2021 06:21:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:608d:b0:1df:be6:e7b5 with HTTP; Wed, 10 Nov 2021
 06:21:47 -0800 (PST)
Reply-To: peterhams23@yahoo.com
From:   Peter Hans <usafroeuropeane@gmail.com>
Date:   Wed, 10 Nov 2021 15:21:47 +0100
Message-ID: <CANKDqyEH7-Z5Wo2UKJVdCBfNuVte2OEZ_h0j1MEpfMmcj4wu7Q@mail.gmail.com>
Subject: =?UTF-8?Q?ACHTUNG_BEG=C3=9CNSTIGTER?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Diese E-Mail wird Ihnen aufgrund unserer Sicherheitsma=C3=9Fnahmen
zugesandt und unsere j=C3=BCngsten Aufzeichnungen zeigen, dass Sie Anspruch
auf eine optionale R=C3=BCckzahlung von siebenhundertf=C3=BCnfzigtausend
US-Dollar haben, die in der auf Ihren Namen und Ihre E-Mail-Adresse
registrierten Apex-Bank gefunden wurden Konto, war Ihr nicht
beanspruchtes Erbe / Gewinn / (verlorenes Geld, das Ihnen geschuldet
wurde) und wartet darauf, ohne Anspr=C3=BCche =C3=BCbertragen zu werden.

In Anbetracht dieser Entwicklung, Ihr Rat, uns auf dieser E-Mail
peterhams23@yahoo.com mit Ihrem

Vollst=C3=A4ndiger rechtlicher Name.....................
Direkttelefon .................................
Und Postanschrift ..................................

f=C3=BCr eine m=C3=B6gliche Gegenleistung, damit wir die =C3=9Cbertragung s=
ofort an
Ihre Position bearbeiten k=C3=B6nnen.

Vielen Dank und in Erwartung Ihrer dringenden Antwort

Mit freundlichen Gr=C3=BC=C3=9Fen,

Herr Peter G. Hans
Sektion/Hilfe
USAf=C3=BCrEurop=C3=A4isches Debitabgleichsb=C3=BCro
ID 447 Gro=C3=9Fbritannien-London.
