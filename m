Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07541AA9E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbhI1IcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbhI1IcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:32:19 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0306C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:30:40 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v10so30038642ybq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 01:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=YC1wgD0VNpJuWIg7acNSUSoVGCMbs7Bt64MNcJV5n0A=;
        b=pNM9TIQ+O14NTiRBLLKnv2rCKJYD9NK3jpQGiY9lUGb+ra9vAiZ8fhxOO4R/mlWTWY
         J6L5/zau9I5leDqbKW9Wqy7QEda/z1nOuYNwWwip8126irHiigpuJ5Trvnq+u1fHDeON
         jmYEtsxRQUhBc5HG0fDePCQluJ1veyxB+xc++GQhb/YvHVPw029bpyb6rJA5AZHZ5PnS
         JyxkjHOTyoR+QtsOapGjKWL5Of1C7jwEL0vPvyPXPKCnSc1qz8JnrMOE6fwtv66IO/jM
         1I9E5bo9Zq+yJdseBzcFElH9QNgxKuv+9EQa8lML0QBj0DcyPyWlljCQjYFWSJw7qVfw
         qNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YC1wgD0VNpJuWIg7acNSUSoVGCMbs7Bt64MNcJV5n0A=;
        b=zDIdeqJFGhG1HxeytcCrbrMEraRubfI2LAGjZBA9MQL4loPy0rMcPbjcMMFPUSKGIQ
         NoPX+rZuHgCz1oxGcIHRc7hDKrBHIp5yGdD0iyzWv4rLf0/ScPeAzTKvss0MnLG8ILk9
         S886dEeznyeWutxcukEXw9oKoEifAS4PeDCpR6smuO8tMa3AFNea08CBCnyPHiLIuPyT
         uAfx1v4kGKvA7K/IWTiymHEGgnZ6aLVd9TQOSq69ranGvW/HckGoTc+bgmc+/4NJVybP
         PfSrKcCpKP+SS5MpwRcGMNbNFC/v+StajgUf91M9seHBghME664ujPTvu4OEdbkUNR1L
         tcUg==
X-Gm-Message-State: AOAM530DAiqF/2C2WgoyKLguVt4Kux4ZLhOcmYk1492rMf/JYRw/c55U
        6qq1slItErCZ74PXVAt5fPNzZnHd/QnPulBpvpENrmGkP5A=
X-Google-Smtp-Source: ABdhPJztWnmhrkywVsDxKtjw8dc8PCpw9as4hqpp4BS8GuFput/7/0aVkaGRSPs5OBNmxQ7g/h8PPA1x2U9tVZsPkSU=
X-Received: by 2002:a25:5604:: with SMTP id k4mr5384666ybb.359.1632817840206;
 Tue, 28 Sep 2021 01:30:40 -0700 (PDT)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 28 Sep 2021 10:30:37 +0200
Message-ID: <CAKXUXMyKJ+zRf_7FChSND8yOV+Ws+2QWUGnBksR-99EFC3GzYg@mail.gmail.com>
Subject: Remaining patches for "Drop ROHM BD70528 support"
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Matti,

I am tracking consistency of the MAINTAINERS file and noticed:

A few patches from your patch series, Drop ROHM BD70528 support,
https://lore.kernel.org/all/cover.1621937490.git.matti.vaittinen@fi.rohmeurope.com/,
have landed but not all.

As the update of the MAINTAINERS file (patch 9/9) has not been
included, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/power/supply/bd70528-charger.c
  warning: no file matches    F:    drivers/regulator/bd70528-regulator.c
  warning: no file matches    F:    drivers/watchdog/bd70528_wdt.c

Will you resend the remaining patches of that patch series for
inclusion in the next merge window?

Best regards,

Lukas
