Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9C4399D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFCIyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:54:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:30147 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhFCIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:54:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622710351; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J6TdhyTF+AoWmVYwJc4Jgyzc0HmItXEPxlP65b2Iv7bRTCzHXcjsrr+x5fAzEzBgiK
    ZUmwJ8p5mNh+96NMqHsLLNH9FRoIP4D04HXn96jT7nNzEVLIzxEdubVsTdwUVtKAx4Mw
    5eDgG+mI9571JCZ6LdW7QPL5TT4Rs1c5n5FJaVXkVPhTGXsdABtMasDc8nT4V1Dk2bGH
    nTGaxPOfF6H6PXVTOeGizTX2BzNpDZRlvBUPuu+Wh6NOqyT3cnEwop9tRZf6Jxr8wH2W
    9Mr/cXgEcKIOOB5CTWsCiyTBPcA/eII4AXsC2cnPuX+2w411y102DcC/GCZlSlfUSgLx
    JAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622710351;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/W9qC4+y9jkbIHXZBd0f8s2Rxzk/YFSxBp40KORcHRY=;
    b=NM9H8lfzzyqzVEkwThtF+Tm9UmTdPGf5txcR6hDtnK5eAVpqTJ22hAbawv21wd1+xL
    A3IgbLtHL3+O8u/wv2Ye0ZxWDhEc5XAVr35cvvkaprKqkWwoZarb6p06ZoQr2PAnwMrm
    yLZSMmzdwXvmxa8J2B8c6TOfSIluPZYuGFMGNoIl4GH51N/8GVnJAay7p1Z6/DovSeCF
    L1sG8ySVggnrEi0uav7aa2tERPj0blolAyVjC8dX5rYk3SnEIjTZuboEMAadlwC0HTM2
    kdgUAAb51bcRg065/VKbWgxMFTyjx3xPm+E9Ji+n3jUPetMccwEfKorHtUd9hfaUkqnD
    nihQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622710351;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/W9qC4+y9jkbIHXZBd0f8s2Rxzk/YFSxBp40KORcHRY=;
    b=a2BmaCMOuPU0qX9zZgvQ8sWm95VI5wm6bDwbEe65NQ3UK4QSlasXn1wF8a1/kKyS76
    ypM8+eHdIj1nUoyEwd5Z4C5asZCB1x2bNeJ54bmau3LpEUNz5mc5+iAUR5y2hfTHOVmG
    11uZJZt7Qr0nGd33aKOhV589LWvFdBHDbqvzILreDr0Zc50KI9S+rv7A03AOgKd81AXm
    WnFKFxD8EUvsn9zoKj/lpokvXlE9CJ4K/1JaQH8Y5vSoLzU8NlrQ1ZraEqRwdLTXhYus
    rkWMBIHvDlbMplUfZe6X5h2Qnma4uZzU6bUNDVIjphIU25z53kYH5zOwUkhGQoQ2yDV1
    D72A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6OIkHH"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x538qU65k
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 3 Jun 2021 10:52:30 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v4 0/3] extcon: sm5502: Add support for SM5504
Date:   Thu,  3 Jun 2021 10:52:19 +0200
Message-Id: <20210603085222.89465-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for SM5504 to the existing extcon-sm5502
driver. SM5502 and SM5504 are fairly similar so support for SM5504 can
be added with a few simple changes to the code.

I tested this patch series on both SM5502 (Samsung Galaxy A5 2015)
and SM5504 (Samsung Galaxy S4 Mini Value Edition) and it seems to work
just fine for both.

---
Changes in v4:
  - Add NULL check for .parse_irq (suggested by Chanwoo Choi)
  - Add Rob's Acked-by: on the dt-bindings patch
Changes in v3:
  - Drop patch 1-4 (already applied)
  - Avoid if (type == TYPE_SM5504) everywhere in the code, instead
    introduce a struct sm5502_type that encodes chip-specific information.
Changes in v2: Fix compile warning in last patch

v3: https://lore.kernel.org/lkml/20210601200007.218802-1-stephan@gerhold.net/
v2: https://lore.kernel.org/lkml/20210531133438.3511-1-stephan@gerhold.net/
v1: https://lore.kernel.org/lkml/20210520112334.129556-1-stephan@gerhold.net/

Stephan Gerhold (3):
  dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
  extcon: sm5502: Refactor driver to use chip-specific struct
  extcon: sm5502: Add support for SM5504

 .../extcon/siliconmitus,sm5502-muic.yaml      |   6 +-
 drivers/extcon/Kconfig                        |   2 +-
 drivers/extcon/extcon-sm5502.c                | 200 +++++++++++++++---
 drivers/extcon/extcon-sm5502.h                |  82 ++++++-
 4 files changed, 252 insertions(+), 38 deletions(-)

-- 
2.31.1

