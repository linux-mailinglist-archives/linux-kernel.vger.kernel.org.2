Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFBF35A84F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 23:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhDIVWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 17:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbhDIVWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 17:22:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 14:22:34 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so1924858otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eKiJGsS41OM2LzTLzRWAvNCxIXbD/ItwjPBDv4ZtkxA=;
        b=mHlUQMuOYIVYCC1kMQ0SrjgrkCKgVUwzg0Guh9H+Nn1AGqxOyfhqZ3BDor8CSB5pZi
         CFAmFrAKJbVklpQnLWe+TNWrwEKRFu9MNVUfccFFAOJAPbadPG7D/cDRVri8KtsfEY8Z
         FTLRYpnyg2UhhHuvwgsWksoF3CWExk2/EbvvVl7nvvuEDNGnmZkVybeNirMbw7Tf6m4T
         E3bGVB4so8jw7EHelrr/negJhwv0KMCF8H6wJVAM7JMdFZ1UuHDpdegektrR9QFpff2u
         ldb9IcgTZGL9IaQsNJMYFlZTUnEuTiQM0YTJN8++p+2/JY8Jbjer/8xGNk+8c8jClibn
         W8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=eKiJGsS41OM2LzTLzRWAvNCxIXbD/ItwjPBDv4ZtkxA=;
        b=N7bb3ZGOx33ouaC8pZbNov3Zuc7fPn7Y6C8NleSydKioPw2TmROqF4o96Xb22k+cE4
         mApaL16/nQ2xqTD0Y9ru+7JbPIGoJaw3HUS+PobmXMuVyfMFw73/1Cdc93/RV6eurd5u
         kpUvZB32sFC5USIz5Mycg3uEBN9mcGuTUHCod0s5H/HOt3h731ESSl0X6B+dQzmmPpjv
         Bxr84uMV6LGClxMpXFmh9VPqZHgipnER/SvHAg54cFJGnP5fR5eMuGUqpuaZAkHqTHcX
         QuOTj9RA3Yc4qmfTR9Yk6qmfKRdB9nE4caVgBkBKF9V9wKdZY46uDifVeT98f3rp1afe
         DelA==
X-Gm-Message-State: AOAM530Ru8MWvnNG+OlW2acaJTFaEkfMUSTmCX86jikG+l26dD/9DJ2V
        oV7vERS4rzlgsDZg+7DLoWWds2uOEIQTW0qHXug=
X-Google-Smtp-Source: ABdhPJycQbqIw3WyGhfbXxX1L7g/OZMBnfWjbBYg9F6M/43fR/F0ccQuXNS1Ne4i25Rxi31i/yse9kXrQde3pRa3vzc=
X-Received: by 2002:a9d:674c:: with SMTP id w12mr5566715otm.91.1618003353807;
 Fri, 09 Apr 2021 14:22:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7398:0:0:0:0:0 with HTTP; Fri, 9 Apr 2021 14:22:33 -0700 (PDT)
Reply-To: stephenbordeaux@yahoo.com
From:   Stephen Bordeaux <haluk4856923@gmail.com>
Date:   Fri, 9 Apr 2021 22:22:33 +0100
Message-ID: <CAPpJGViLFDLk6RcJw-=NcteMAYWecP6UxOM0t8UP1SnYCWDM1A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dia bom
Sou Stephen Bordeaux, advogado do escrit=C3=B3rio de advocacia de Bordeaux.
Entrei em contato com voc=C3=AA a respeito do patrim=C3=B4nio do Fundo do
Falecido Dr. Edwin, Oito Milh=C3=B5es e Quinhentos Mil D=C3=B3lares, a sere=
m
repatriados para sua conta. Al=C3=A9m disso, nesta transa=C3=A7=C3=A3o, que=
ro que
voc=C3=AA responda confidencialmente.
Stephen Bord=C3=A9us
