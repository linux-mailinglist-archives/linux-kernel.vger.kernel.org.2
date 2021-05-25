Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999C938F9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhEYFL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhEYFLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:11:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 22:09:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e11so36426095ljn.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 22:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UOMx5+28RlRg9sdHtPpeFxBXs7+mTy/X9upWhP7PZp8=;
        b=vgMr6dB++UKouqjyL9Wwrs+iuqJuxj9qT0IYEQe2jCCp9iZOhh6EUNd4QEpVc4OyuX
         8bWNc4f9MDmo4vVBtga2WmTWDwHsJGHtjKFVx/kplQT2Ehpc09U2yLZTBp2l3KinA5HZ
         gM6t6aMFWdohhaTbHo+GBNOTWuh8IjGUHh/E6nJjd7w5uSV/YD1hPJUODM32dODYjQKB
         xPmL9Orq1xjWDwx8oDDq9L8TDava4RN4Y4rTyAZ8Y9iJzft1AKMI75UQVJAsOkY5/tlM
         +zNAEqhtvFhfAiQEvNZG05jOj3hByl7mhYCb8VHYesLrggj3gR7Zm1GOirVapjBO2vMO
         JEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=UOMx5+28RlRg9sdHtPpeFxBXs7+mTy/X9upWhP7PZp8=;
        b=d2zf7qrU70kgR02BWWEPCjipbE9LR/ymyqRcFMEL1Ns0631ETtSdGfiBHE44vAUSGN
         QsYecFoB7CoWMcf/QvU7uoq5OgFhmOuNUqw9WLn+Qn979WxVpQOBQzaagdU9Dj4JXe2f
         56rtcTILRCzLF4gBb+KHt+J7qsHfhG2+GN1JesDshu8qE28Gwv2eK/p5KCR4Fzdq/xaG
         U6Qo/eQkb528uT3VawBoNCFN7s6jEuX7vLIHFWWYD4YGOFDbjREFvoBqTn0a/E1XpfI+
         jfwjBmd5geJm3KsL2k6+x1boRCQMQqAagskVr3+jymExqG/LFqpjk4hC0gAg9PAdy8mY
         8KsA==
X-Gm-Message-State: AOAM530nYq3FRAQJXO9YqojHtGZGDojEjhaxIfrLR0i1MM+EEMyI+QQu
        gHQyu2U1Z6qZF8EN5UPNp+PLmlV7e4RgigvJ47M=
X-Google-Smtp-Source: ABdhPJxhoSl5ZBaB7NwXKQghdf7yt0VZUFkm0yQhdwHTEPfmj++JctAWCKmPchTOaKC2W6twkKb3CQp97q62HFy+53o=
X-Received: by 2002:a2e:7115:: with SMTP id m21mr20195187ljc.33.1621919393465;
 Mon, 24 May 2021 22:09:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: hon.barr.desmond.williams.chambers@gmail.com
Sender: willgod492@gmail.com
Received: by 2002:a05:6512:1192:0:0:0:0 with HTTP; Mon, 24 May 2021 22:09:52
 -0700 (PDT)
From:   Hon Barrister Desmond williams 
        <hon.barr.desmond.william2021@gmail.com>
Date:   Tue, 25 May 2021 06:09:52 +0100
X-Google-Sender-Auth: 8EntixG0ZSG6MPmhfDuqNSOYeXU
Message-ID: <CABB9BwAJj4J4cpQG6p-P=d9wpuknO5_Rohae7knUB_8E9-bhYA@mail.gmail.com>
Subject: Re:Hon.Barr.Desmond Williams. Esq, urgent reply.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,

Greetings!

Compliment of the day, do accept my apologies if my mail does not meet
your personal ethics, in due respect I want to introduce myself and
this business opportunity to you. My name is Hon Barrister Desmond
Williams Esq. Of Williams Chambers & Associate, a personal attorney to
my late client. I wish to know if we can work together.

I would like you to stand as the next of kin to my late client who has
an account valued 4.5million United States dollars, with a deposit
bank. She died without any registered next of kin and the funds now
have an open beneficiary mandate.

The board of directors of her Bank adopted a resolution and I was
mandated to provide her next of kin as her personal attorney for the
payment of this money or else the fund will be diverted to the
government treasury=E2=80=99s account as an abandoned property.

Fortunately, it=E2=80=99s very easy for me to back you up with certify
attestation certification on your name to make you become her official
next of kin. Your seriousness will permit me to send you more details
on how you will execute this fund into your bank account, kindly
indicate your interest immediately.

I will give you more details once you reply back with the information
as stated below:

1. Full name........
2. Address......
3. Country.......
4. Gender/age......
5. Mobile n=C2=B0......
6. Occupation.....
7. E-mail address....

I look urgently to get your response as soon as possible.

Yours sincerely,
Barr Desmond Williams. Esq.
