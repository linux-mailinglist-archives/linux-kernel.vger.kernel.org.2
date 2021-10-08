Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFC74263EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 06:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhJHEwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 00:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJHEwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 00:52:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C8C061570;
        Thu,  7 Oct 2021 21:50:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ls18so6622492pjb.3;
        Thu, 07 Oct 2021 21:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=dQvWqpd/3Ixk1BH86MpPJQ+yUHdjySlHvST/lPNe1C4=;
        b=Ovb1m3ooLxAOlI2LIrwDmKVAwwXTG6aBjZAiOM+hiYh4fqDEycaymEZckvxCWQuHkN
         TnIK6ZbmLZ29EsbQtZuyfMOuNymobir8U6J+kNpyqQs+mJnr8km9Csn5eLcs/rjlRfpm
         qlWEw4nyPi0JacVXycf0T+MWz/rONcs3OXCy1jjSUcQSY4E9lAbDZYs0RjnsUnb7Q4d6
         kxtwNT1KQDDIIDwxZwDgngKYCVE3n6faSBbvlG3jwf9cg+SmZQFh32WKhDrnwdox3F04
         PL6ptx+Hq/iuPKrIWE03IGjBHr7QxYU5fZOA51qGLXtfZfdwv9s6ZWC9FPf88SI525bt
         xPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dQvWqpd/3Ixk1BH86MpPJQ+yUHdjySlHvST/lPNe1C4=;
        b=UoHeAT5w0slGEJqxU+j9sk9w3uDDOqOLDh7XhhmiOit5YmruOBfpkYHDKcVknfY+A9
         tsAJCOJZHuIPisTYxQPQvbuQ14VdoEVEIES/4kqbHDpsfDxYc8H7qP3yD+fHuxX2qAW/
         ydJI3olJJdVD5ekrMtP2emQ3+nWh5iBr44+IhxNnL7rNsOL+lSmEb99+1U10WB95IWLf
         4AFwI+9CLaOBGgvpMa6o2rU+ULEY8rANhLyN0GxSAn53TT43HnmUjnzDaa61IzG4SPYk
         3XYX2Zm3ShmeILGCg68Vr46G4qAWpAQufh4/pQ4xkqaiabpiMRAaqelsFcxISSK9s2es
         gH9A==
X-Gm-Message-State: AOAM530elIKIRzTquPA3Bqod8rbSgKNjHvJQ9TXF/UckXVae1ameMEov
        WC0m9sRtG6VV6xD2+sb3WSpxQ4JmV9Y=
X-Google-Smtp-Source: ABdhPJwycbw3qKJr4+vydLE2ml1mi+Dz7Kz6aNk7DU0X0uJ1eTEIvOZGy26o6/zBY3MpcJLLRx8YOA==
X-Received: by 2002:a17:90a:19d2:: with SMTP id 18mr9715941pjj.62.1633668624447;
        Thu, 07 Oct 2021 21:50:24 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:5014:1d07:e136:b921:8d67])
        by smtp.gmail.com with ESMTPSA id f4sm885182pgn.93.2021.10.07.21.50.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 21:50:23 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     oder_chiou@realtek.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org, allen_lin@richtek.com
Subject: [PATCH v3 0/2] ASoC: rt9120: Add Richtek RT9120 supprot
Date:   Fri,  8 Oct 2021 12:50:10 +0800
Message-Id: <1633668612-25524-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series Add the Richtek RT9120 support.

In v3:
- Add dvdd regulator binding to check the dvdd voltage domain.
- Refine sdo_select_text.
- Use switch case in 'internal_power_event' function.
- Remove the volume and mute initially write in component probe.
- Remove the mute API. It's no need by HW design.

In v2:
- Add missing #sound-dai-cells property.

ChiYuan Huang (2):
  ASoC: dt-bindings: rt9120: Add initial bindings
  ASoC: rt9120: Add rt9210 audio amplifier support

 .../devicetree/bindings/sound/richtek,rt9120.yaml  |  59 +++
 sound/soc/codecs/Kconfig                           |  10 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/rt9120.c                          | 489 +++++++++++++++++++++
 4 files changed, 560 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/richtek,rt9120.yaml
 create mode 100644 sound/soc/codecs/rt9120.c

-- 
2.7.4

