Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D20420421
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 23:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhJCVvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 17:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhJCVvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 17:51:54 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C9C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 14:50:06 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id b34so10938862uad.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NDL3z5DiLqt+3E7IEqAYwscgPcvqEFW1R6PEVvZKhBQ=;
        b=hWx1oG3lU2X7Tuj3crQW0IyO/gxmkbhWNNaV2ejSGdwcGXRPYrEWBlJ6+eYodJAGhS
         qYn8+Um9XHelsIxbPwPsUqpHxLEvseN7nVCqYQCHoNyvWnGkHgkZB1hAqOY9ZpTtEHoH
         M7C8jXLJv9vtKTMlSh0N8HUED2librDTxg/RvC9BIGrkWtaLPbOotXz6e2bUmcAqDS/z
         WMtHUSBK/MMJ2ReUmQFcPsCC+uL0/LnAonusMHYAnphelRTn0yqem9AlNBXGKI8kcpnQ
         TQ0fndIPx/3ZTnI75YQBPOgp2DnR6eDMxzknxbeB0ciHmztrdEbjIXGlLV+kV7OzDcd/
         ptrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=NDL3z5DiLqt+3E7IEqAYwscgPcvqEFW1R6PEVvZKhBQ=;
        b=lmdtQy07f6PvQZsR66DlCh03SXo46b1gC0BAfPtqFvN7nBvHm7Cv0vrAieUeC8gJeG
         HZ9QXuOU6GFQXSUfLVRK7qT1JDiNtfZD18TbV7ktkfSZM5QaKPnhCEsxQFUCA5HfZbb4
         Ju9eiP7L5b7Jd0Q+o4+kDVbykPj1U41/TZ7cL0Y+Ikjb7EoMlJ/gNgKYG7Hm8QWvq5Ys
         KrMy/Vql+geUCW5Nark8ANs7yeqCo5G8/yFczn7zuDP8gaz2VPtQQBQL066B0EyveBl2
         i2Sg7JvTb/uTwxp7r8PLwT1eDE7p0ACStNTg1YPVKa1iEADFXSzvQtYhvLZ0NtyA8pVN
         vVEg==
X-Gm-Message-State: AOAM532233B97uS3x6Srslg/obxzzpK0pZnDhKfp9KJDjCWz+Zh5O4+K
        JGDay1mKIqBe1yX/m53QEG9C3BMV1VVOgNumAa0=
X-Google-Smtp-Source: ABdhPJyOzx6vU4EfUFDQvcxIGquZe0Q9auOhA3NuVvgAvdDK91ZzgBCdpX/KjZrTeBZiKso43j535AOlXjboBAThCmQ=
X-Received: by 2002:a9f:2371:: with SMTP id 104mr4563296uae.80.1633297805271;
 Sun, 03 Oct 2021 14:50:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrsdaniella.kyle@yandex.com
Sender: munasalemmustapha@gmail.com
Received: by 2002:ab0:2356:0:0:0:0:0 with HTTP; Sun, 3 Oct 2021 14:50:04 -0700 (PDT)
From:   Mrs Daniella Kyle <mrsdaniellakyle6@gmail.com>
Date:   Sun, 3 Oct 2021 14:50:04 -0700
X-Google-Sender-Auth: SpyL4fbwLUgD2KjR37_2gWA5PzE
Message-ID: <CAKASgyLdgOBX72Kd0X4ozdcicFZmD+Jnci4L22eJLLpNESy4uA@mail.gmail.com>
Subject: Re:ATM Visa card compensation, Thanks for your past effort
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

This message may actually come to you as surprises today, To be very
honest with you, It is a joyful moment for me and my family right now,
so therefore am using this opportunity to inform you that have
successfully move to Vietnam where am currently living with my
business partner who assisted me to complete the transfer, but due to
the willingness and acceptance you showed during my pain have decided
to willingly compensated you and show my gratitude to you with these
sum of $950,000.00 Nine Hundred and fifty Thousand US Dollars).

I want you to accept this amount it=E2=80=99s from the bottom of my heart,
have issued the check and instructed the bank to roll the fund on a
master card for security reasons, you can use the card to withdraw
money from any ATM machine worldwide with a maximum of US$10,000 per
day. My bank account manager said you can receive the card and use it
anywhere in this global world.

Go ahead contact the Global ATM Alliance directly with this below
information. Email Address:   maastercarddeptme20@yahoo.com

The Company Name: ........... ....... Global Alliance Burkina Faso
Company Address; ...... 01BP 23 Rue Des Grands Moulins.Ouagadougou, Burkina=
 Faso
Email Address: ..... [maastercarddeptme20@yahoo.com]
Name of Manager In charge: Mrs Zoure Gueratou

Presently, I am very busy here in Vietnam because of the investment
projects which I and my new partner are having at hand, I have given
instructions to the ATM Visa card office on your behalf to release the
ATM card which I gave to you as compensation. Therefore feel free and
get in touch with her and she will send the card and the pin code to
you in your location in order for you to start withdrawing the
compensation money without delay.

Let me know as soon you received the card together with the pin code.

Thank you
Yours Sincerely
Daniela Angelo Kyle
