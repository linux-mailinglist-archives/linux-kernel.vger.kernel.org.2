Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4D448187
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbhKHOZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbhKHOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:25:38 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB34C061714
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 06:22:54 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h23so17035666ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 06:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=gfXQRJw316yobkzzkYLYou9RkmlANYcgKrYiE97bu0GKyf0T5zNbcDIiLx/DE6ews/
         MKotVT7g2FNpod8ZsFI9g1GKIrIuWl+m+5j8B6tQ8w7cu+0aU1xRSiuQtcfsxEXO6Z3f
         8Kw2dehpBJyexKs51lpY9Q1H02lWk62TGlzXS1XgITWHLchQ16rjKG8t3QDmC9io98VC
         zrWD4DIvS5gDWBZbCm0/tBHqUGVmUbcSZW/mSITbJeOtbjUszuG3S0VHTOm9TJSQettL
         4fZy7gDW8yi2apERJzvT+GC7xQJoSRtbCVPIsm4HrznULHha1S/MlwsSiS2rLwgRtMgl
         JEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=KODX23d002YAkuZn8I86WoW+51v5p1yqpCruSVNBFU9x9i8wxwCANGCjKzLoUQjymA
         iMLn6JOt8mgy+Kx3+JPSjFQd4+vIwBTJC0IxRGkq+t5s36xlEL+4uRNmWS/WNO4BP38W
         2FNz2z6OqaCsQf1NFsphvGVjSXRSxA3Atft7zOHLIzuHOOnblJd+aT0BTMpLQAQmB8eX
         W7HxTJOIPhMkaj+y4iXCSz50SZcV6rOhI9x5Q2R+aU5Z+v0e/FKZmQdMTj8RQ70m3uG4
         LU4EBnv4sYLr9aGpb14wKm+xWjzhlcuuCrGyHi+6FoSTMIOxwhEhlg6Cq3QcNqv2h8+F
         uSRA==
X-Gm-Message-State: AOAM5315FY5cWIs4jPv4YjvaCgXW37JxN6DKbTByQNkWEXHfmfb6pjcU
        efZqOjmUgIxBkhbi5785pvzNp2//ckJ0IVhk+8w=
X-Google-Smtp-Source: ABdhPJzrJjdweTv8ngarGJc9ZBDUHON8vayiLxypsTqWoxa368R3+7T/s8iFaEOUDjkUbgT0eO87lFfHmu1ssc3yhXQ=
X-Received: by 2002:a05:6e02:1989:: with SMTP id g9mr200294ilf.61.1636381373903;
 Mon, 08 Nov 2021 06:22:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a92:cac5:0:0:0:0:0 with HTTP; Mon, 8 Nov 2021 06:22:53 -0800 (PST)
Reply-To: fms333166@yandex.com
From:   frank martins <fms333166@gmail.com>
Date:   Mon, 8 Nov 2021 06:22:53 -0800
Message-ID: <CAOGziQLrL4UZBjqAApWopiK=YBWf4jF7=qoXe5bmptcyjQBBZQ@mail.gmail.com>
Subject: =?UTF-8?Q?Ich_warte_immer_noch_auf_Ihre_Antwort_auf_meine_zahl?=
        =?UTF-8?Q?reichen_unbeantworteten_E=2DMails_an_Sie_bez=C3=BCglich_Ihres_Fami?=
        =?UTF-8?Q?lienerbschaftsfonds_=288=2C5_Millionen_US=2DDollar=29=2E_Bitte_best=C3=A4t?=
        =?UTF-8?Q?igen_Sie_mir_diesen_Brief_f=C3=BCr_weitere_Details=2E_Gr=C3=BC=C3=9Fe=2E_Mit?=
        =?UTF-8?Q?_freundlichen_Gr=C3=BC=C3=9Fen_Herr_Frank_Martins=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


