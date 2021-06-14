Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62C93A659D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhFNLl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbhFNL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:29:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3820C0611FA;
        Mon, 14 Jun 2021 04:24:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso12776846wmh.4;
        Mon, 14 Jun 2021 04:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KkYDjNEVEUYWRsNoTrKu5VhSupn5YZcqZPCCTeGuQLE=;
        b=SB4A5QIKc6qUAIZ+jcYTcKSADf/lridtue5zfa/P6SM+1kOjyKfrklP91/CMSjRNzR
         FynuIjnZPCci+QQn0SK0sShi1pWnLXkGAklnpAScfFmbnL/wQZfGWIyGq4Dw8f8oHJ1Y
         CZB0XafCi4mOGZuv54cunVkatH4ZfMZZXyJp1gn3p/+xATYw99s4o3zf/2YsdxtsJoI8
         rIdIGGw7EhlfR283JEt8yLGA9ljL3qnfpXl5MnpEuMvTjV5ZnYqjXUTcZFNDwFQpUpqh
         XtE/V6bBXuZarkV06b81erWIbPuo9t/nIuFPuk4SY8R1NzlrrCk5GnJ0/eNFtpCYznqi
         SPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KkYDjNEVEUYWRsNoTrKu5VhSupn5YZcqZPCCTeGuQLE=;
        b=dCPrTEA7U7y+FijX6SOTFjeF0BZdrSR1OBhU/m8/wqOAUo3dMQgxKN2yMTtsshN8Gf
         IfW/EUKAIik2vXGXRnQY8m8M2WKhu0ZhSBCpg8lD1AgGF8HZlOSbYqf2/Rp5VsMJSOz7
         pbkI7MqFI0n+h9ysFlubTXPXu2SThj136Bg/oMfYQnnOuxw9ArQhfTq9jP93onS00Jcc
         VL5qSKyvryLZwY7p4hNvkjBsslFHefgpB8GZ9uy02uoz2oJOodicAyV7MSkLOQ0kLlyj
         OgqwvPmMFMRpWefLztq5FXHl2z9dGBniveMZ0yueF8JOkXiOTeR5N/HG3Wa52TW//vVM
         4l9Q==
X-Gm-Message-State: AOAM531bV8MokqAO57BXxTsZxzHwxlY10V53ReIAEZRgps4oCIh8KE/F
        JB8YY0+sA3P80o3+XVSb2/E=
X-Google-Smtp-Source: ABdhPJwMRKNNvHww700Fm13czmA35T1evBYSuPXN6rQDjEwkAhz/muPptE2GB5DfPED68EPgBqHnvw==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr32257413wmc.96.1623669839413;
        Mon, 14 Jun 2021 04:23:59 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d62:e800:a8e7:80e:6e34:237d])
        by smtp.gmail.com with ESMTPSA id w13sm17269485wrc.31.2021.06.14.04.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 04:23:58 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yu Chen <chenyu56@huawei.com>,
        Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 0/3] Rectify file references for dt-bindings in MAINTAINERS
Date:   Mon, 14 Jun 2021 13:23:46 +0200
Message-Id: <20210614112349.26108-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

here is a patch series that cleans up some file references for dt-bindings
in MAINTAINERS. It applies cleanly on next-20210611.

This is a v2 of the still relevant patches from the first submission
of the patch series (see Links) send out 2021-03-15 and resent on 2021-04-19.


Could you pick this series for your devicetree bindings tree?

No functional change, just cleaning up MAINTAINERS.

Lukas

Link: https://lore.kernel.org/lkml/20210315160451.7469-1-lukas.bulwahn@gmail.com/
Link: https://lore.kernel.org/lkml/20210419092609.3692-1-lukas.bulwahn@gmail.com/

Adjustment from original to resend version:
  - drop subsumed patches

Adjustment to resend version:
  - add Fixes-tags as requested by Nobuhiro Iwamatsu

Lukas Bulwahn (3):
  MAINTAINERS: rectify entry for ARM/TOSHIBA VISCONTI ARCHITECTURE
  MAINTAINERS: rectify entry for HIKEY960 ONBOARD USB GPIO HUB DRIVER
  MAINTAINERS: rectify entry for INTEL KEEM BAY DRM DRIVER

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.17.1

