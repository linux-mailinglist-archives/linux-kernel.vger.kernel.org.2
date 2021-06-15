Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBC73A87D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhFORgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:36:35 -0400
Received: from mx-lax3-3.ucr.edu ([169.235.156.38]:33557 "EHLO
        mx-lax3-3.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhFORfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:35:32 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2021 13:35:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1623778408; x=1655314408;
  h=mime-version:from:date:message-id:subject:to;
  bh=W/Agxa+mpwusp9Cgi9SCSo4oM2dq2tyEp2RYhM5gf80=;
  b=of2J/U4K69fRAzbHaYlGbQmF3wK0z4gx/4qBL+EAmfx3pfGLpOi1TIyx
   yVEukCWal6SUifx5jC5bQv5LhM7vSvx6PgBCyi3lVUiJZ61mJgncath2t
   86TYeFkW/u62uz4AoF0V4tj3JGmzFBbrhlBUk1OX7SvoKrvuaiZ1bmeqA
   V3B1Gn5dyf2R/hXLMhy91yAYQJbN0NGeNSlUH0XRm0dHQ4CxWV9XDEZK5
   hyT6S9WPVb6TQS1MhHkOIshwwIra4ydZJJiXJks6pNL/xsBpU60LqN3wa
   4h8MQqdJrjbu9wIDkQgmtAUbbb9hywF65Rbtf0PLN7yU/Hsx//U1b2xiU
   w==;
IronPort-SDR: 8pflOy0liILJl0EDB4Cm7Y8KhRFAK2BnNR7by/jc7vcVlsBwUsEWe+kDeZwutJXU/DhrlcPXev
 g5/jFF8TgMCP+JIs+dSSC2adFruCxpfSv34yVjjrkOfxHQ0miGFO9+oJOMwqgigt5qD29PIwzY
 Q4LiQIxKYqNnKgAIYlCJ2Jxromdmu0WXm6F7j/RbUq4a6/MzI1mXcA4UTkL2utBaUW8fB8Aw76
 6lILXr6CCB2AYonBj6716B2tKr5G2w+yTVC5B4JLVsUmQD+rK6QJ36QeTAcH8kYiiE9u/ogqfm
 ygY=
X-IPAS-Result: =?us-ascii?q?A2FuAwBJ4shgf0XYVdFaHgEBCxIMQIFMC4N4bIRIlSgBk?=
 =?us-ascii?q?maFP4F8AgkBAQEPQQQBAYc7AiU0CQ4CBAEBAQEDAgMBAQEBBQEBBgEBAQEBA?=
 =?us-ascii?q?QUEAQECEAEBboUvRoI4IoQNEXwPAiYCJBIBBQEjEiKFV5x3gQQ9izKBMoEBi?=
 =?us-ascii?q?CcBCQ2BYhJ+KocJgmeEIYIpgUuCN3SEC4NQgmQEgxh7E4N2AQEBnjOcYAEGA?=
 =?us-ascii?q?oMDG514K5RqkHsBLYYzjnSkTRAjgTGCFTMaJX8GZ4FLUBkOjisWjkwkLzgCB?=
 =?us-ascii?q?goBAQMJhxWCRwEB?=
IronPort-PHdr: A9a23:e0qkehS1COgIm0JD4N54mS5kHtpsorKfAWYlg6HPa5pwe6iut67vI
 FbYra00ygOQDMOAsa0P1LGempujcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffgFFiCCzbL9sL
 hi6ogfcu8cLioZ+N6g9zQfErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q
 6BWAzQgKGA1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVTmk8
 qxmTgLjhiUaOD4j6GzYhcx+gqxYrhy8uRJw35XZYJ2JOPdkYq/RYc8WSGhHU81MVyJBGIS8b
 44XAuUDPOZZron9p0YJrRCjBgasBPngyj5VjXLx3aw70uQhHhvH3AA8A94Dvm/ZrMjpO6cIS
 +y60rTHzSjaYv5QxDzy55TGfAo7rvGQQbJ/b9DRyU83Gg7EilidtJLoMT2b2OkQrmWV7/RsW
 f+xh2Mjtg18ozehy8Ujh4XXh48Z1FTJ+Tl3zYopJ9C2RlN3bNC4HZZUuSyXMZZ9TMA6Q2xwp
 io21rkLtYS4cSUK0pgr2QPTZv2df4WJ5h/uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE1Kr
 i9ZktnUsXANygDT5tCHSvRj+keh3i6C1wXJ5eFFJUA4jLLbK5w8zrIpmJoesEDOEjX5mEXxi
 6+WeUEk9fay5+v7ZbXmo4eQN45yig7gLqQjgtKzDfg8PwQUXGWW+f6w2KP+8UD4WrlHj/k7n
 rHcsJ/AJMQboqC5AxVS0oYm8xu+Dzan0NQCknkGMF5JZByKgpP0O17SOvD0F+mwjEmxkDtz3
 fDJIqXhAonRLnjEiLrhebd960hByAs81Nxf5IxbCqsHIP3tXk/8r8LYDhAnPAyu2ernC8ty1
 pkYWW2RBq+VKqTSsUWH5rFnH+7ZaIoUpCzsbeQi/fntjXgnsVAYdKitm5AQbTTwGvVgPlXcY
 Hz0n8spD2gHpEw9QfbshVnEViRcIz62XqQh9nQ4BZigAIPrWI+gmvqC0T29E5kQYXpJWX6WF
 nK9RoSWW+oLIBCSK84pxi0WVbGgE9d6/Qylrkn3x6cxfbmcwTERqZ+2jIs93ObUjxxnrVRJ
IronPort-HdrOrdr: A9a23:OacMl6/ED+z31F8QRXNuk+DRI+orL9Y04lQ7vn2ZKCYlFfBw+P
 re/8jzuSWVtN9zYhAdcLK7Scu9qBrnnPYf3WB7B8bGYOCJghrNEGig1+bfKv/bcREWOtQz6U
 6oScQRNOHN
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="51716136"
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2021 10:26:20 -0700
Received: by mail-pj1-f69.google.com with SMTP id z3-20020a17090a4683b029015f6c19f126so77302pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OYK6lzODuclGPxJjXdB4mgKjdrNpwT3xXkrS1G/arSg=;
        b=rQxhmAkrXzlm8UbGeeymaEFa7Y3X5Z1HwaAEkOdC4D67WDxXHgN2IDzHZhMOn5AXQw
         BuEtoJa5bNAjEYNRlotJxp3mKdomcbLppWjb4c0CP12Tbetw2YPQs1CzBAgqH2j/fkxc
         uhEdIiQPjZBWeppl3Zx2A5ySN/+5AEgbAKNnssFCKovx4klRbM0neKfGiqHvwJY5N9zt
         f/4BJEzfj8wTLEPm1QMnFTk8sUEBkyKcCFjXFyBmLqzihyqPDWRAe/DFXmg4MUnBvLok
         mEbRmCH7JNaalv4jzabxPAaiY2QaDHgPQGNsCoKalSvb4fMOaEZN5zIrS2qJY1AIH7bY
         xV+Q==
X-Gm-Message-State: AOAM532ttY0FuViKsO/PTY0GkbarzBat6WXJfcKit/y7QymAgdvNPvxg
        8+Dro72dvKHnrnUJSShT7rzJRGocCect+B602lNSH4QR9ZjmVUuabEvMxOCNUL+kToqxAedMWE0
        XIyOJw2LHD2+3bmA9EW4IRp4LlwiSAYGp4FNbYi+8zA==
X-Received: by 2002:a63:805:: with SMTP id 5mr543993pgi.353.1623777980105;
        Tue, 15 Jun 2021 10:26:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCZQDekeP9cckWRs4Qg7Emd8mJjO8LA9Ll72Yzdgd0bVHJTbot+A9NY9vUzYbgiuUR37w81ZzzBWssd47GWmI=
X-Received: by 2002:a63:805:: with SMTP id 5mr543973pgi.353.1623777979808;
 Tue, 15 Jun 2021 10:26:19 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Tue, 15 Jun 2021 10:26:09 -0700
Message-ID: <CABvMjLRuGPgEJ3Ef7=sBk3m3oa+3HuyV9mVY0ZCYuHK=rJRA4w@mail.gmail.com>
Subject: [PATCH] Input: hideep - fix the uninitialized use in hideep_nvm_unlock()
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function hideep_nvm_unlock(), variable "unmask_code" could
be uninitialized if hideep_pgm_r_reg() returns error, however, it
is used in the later if statement after an "and" operation, which
is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/input/touchscreen/hideep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/hideep.c
b/drivers/input/touchscreen/hideep.c
index ddad4a82a5e5..49b713ad4384 100644
--- a/drivers/input/touchscreen/hideep.c
+++ b/drivers/input/touchscreen/hideep.c
@@ -363,7 +363,7 @@ static int hideep_enter_pgm(struct hideep_ts *ts)

 static void hideep_nvm_unlock(struct hideep_ts *ts)
 {
-       u32 unmask_code;
+       u32 unmask_code = 0;

        hideep_pgm_w_reg(ts, HIDEEP_FLASH_CFG, HIDEEP_NVM_SFR_RPAGE);
        hideep_pgm_r_reg(ts, 0x0000000C, &unmask_code);
-- 
2.17.1
