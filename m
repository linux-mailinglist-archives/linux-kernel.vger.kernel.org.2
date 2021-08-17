Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2D93EEDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbhHQN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbhHQN5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:57:53 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692C1C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 06:57:20 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id a21so12852072ioq.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=s8D7gGg9S/pJ8oDNOjp//qcsaR6xJRAtBuYGCYePxV8=;
        b=GV1935s84r9sTK2s8ausEimzVf8W2/oXiwlibBgGBBZgiLYn0MHx8rm2d/1bkS18ta
         woui9gpMyyjKRsDGjpJq4NLLkLypa9EjwmCATnyH5bocSmvuI5+tWrU+u8hYxaDFoA8T
         bwCVbQ2pE94EhRhl7RTnSvo5wmJHU8w0X7hIuNx175vZqEWEaeG0KdgQRjTj0PkGo3mZ
         C0oZvesw4+6aQhE9LOuHxwHeoMxDD4cbjyVNREEQd18AVo1HSyhsSMaHsgxFXh1y8v51
         jVaDpAguk5q8RZg49Abl4RJq7lMGs8m+w27TGU/naKI015nwCCr3/8LKL7dY9f3dpTIx
         cpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=s8D7gGg9S/pJ8oDNOjp//qcsaR6xJRAtBuYGCYePxV8=;
        b=hRZETHks+OQm0nUBdyHax/c2QvE2C2FMP7fq7sj6jipq6WavhlvbXMoWrq1YsRryzr
         z1ZPWqh19wUiw1ml+rMvklc5gFF/7ILZZ5xetLWmkJtjGg1YhtS3NHR3Vs1KYjPQMzfM
         xhY8vo4vZ6LLBOjA7aCaRGe+IIW2XXJnVEznBsSFjBCOKz5oE2SZoDOJqNs55V2MqnT8
         s06q+vbvdvlkXUVLmfLCQNUQaU3hhwlXsoApuq3oQD3Kn0vcFZHUln89sPN1rpcEcYbK
         Jp7PpV15auZjxCk40+rqwEAX8pesLykC8vaNu20kzkxO7AYpPmrdkcM/ZgKEX0Nk6yKs
         u3sg==
X-Gm-Message-State: AOAM533jzXtYi415Lr8El3O/v7DmOhrbqxdoZ3bOYmqFPIyX4QnBqcDg
        AVSGhCS0FvwtQ9cSMWks56AwAOfk8l/ai0aLtMk=
X-Google-Smtp-Source: ABdhPJyKqJvAILTBCiGEFUpfcM6O607Kk4tNJkmk77/Zg0VDYDB71XzVvEOAopcNJnityCFRhaAEBcpXTE/LHODcn4I=
X-Received: by 2002:a5e:a81a:: with SMTP id c26mr2992573ioa.15.1629208639891;
 Tue, 17 Aug 2021 06:57:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1a0b:0:0:0:0 with HTTP; Tue, 17 Aug 2021 06:57:19
 -0700 (PDT)
Reply-To: gabrieledgal76@gmail.com
From:   Gabriel Edgal <zealandn762@gmail.com>
Date:   Tue, 17 Aug 2021 06:57:19 -0700
Message-ID: <CACLd0ohPG5g541N6FfbEuqHMva41tg3bqj3hd3CnbQovN=43UA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
K=C3=A6re ven.

Jeg er hr. Gabriel Edgal, jeg er chefens interne revisor i Btci bank,
jeg vil have dig til at blive l=C3=A6st for at modtage overf=C3=B8rslen p=
=C3=A5 $ 9,5
millioner dollars, som vil blive delt mellem to af 50:50. Fonden blev
deponeret i vores bank af en af min afd=C3=B8de klient, der b=C3=A6rer det =
samme
efternavn med dig, og han d=C3=B8de med hele sin familie i bilulykke.
Grunden til, at jeg har kontaktet dig, er, at du b=C3=A6rer samme navn med
den afd=C3=B8de klient, og jeg vil invitere dig som udenlandsk partner til
at st=C3=A5 som de n=C3=A6rmeste p=C3=A5r=C3=B8rende til den afd=C3=B8de ku=
nde, s=C3=A5 vi vil g=C3=B8re
krav p=C3=A5 den deponerede fond og del det mellem to af os 50: 50 hver.
Jeg vil gerne have, at du svarer mig med det samme for flere detaljer.

Med venlig hilsen,

Hr. Gabriel Edgal
