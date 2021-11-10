Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8838844BAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 04:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhKJDsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 22:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhKJDsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 22:48:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4CC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 19:45:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so431330pjr.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 19:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kE7conhGwlDchql6TUuzI3SKW5A/9f27/zONhyNotjE=;
        b=ghN8MuxFashQf2xTxaMzOG3TvvsHlnxCwUP782NhHELGj8f16T9Iyl8DyXVACHdTmu
         rnZnXOaxC+gdu0OJKUeFPuCr3sUNr/YalYD6kfvA/oS/0i8zhsxFaZSKVS/ADAf6AS0w
         NyeGR6Osh6kR7W7C6Ax2Gzc4usIlUd0WRA2/LQAYqx1flZ+hkOO0APZ9y33vdZBzwSVn
         XYxLTstPgFhIpN89dV0Z54nS5sm8vK0qh1Bv2HLtaR7fQcVUXz775ug4pRGFd4/XFRl1
         4YvCdSbb4MrVgiWRDmzBusg1gaV/3Mgpp3gJr9v5ZxD5XHWJOaD+P/NdnfqwZJl2c9iJ
         Kuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kE7conhGwlDchql6TUuzI3SKW5A/9f27/zONhyNotjE=;
        b=zxHytJEhH2eLduB08NK98YZnQHmtiI55xFk6McbrSxPKfZjxVV9bv+DSylVTx/HW/h
         dcbtqzScTprX+61GzAeD8hxQkagMJnJgsgH0BEE69Bq2ZBLy4c7ywk9yrNzojyeyo7EB
         5DrCWX8rQ9HzB5dWBStiahkNWWNAOj9w9/BbCWGwMDgR4wXNKcfu8XBBPbYFuINAbCPE
         FEz3YSJnEoE0QPU1NBXE1aVk810wxVNnEhIwFhwNtnF+T91K0COLf2tU5BYOYGHXFVYJ
         36w/opI8L7bs25t2SGdjoTsaefY2LSPSi3XGQWBhHdKkh8OSPXhnhG0OEnl7FULOhWwZ
         FjTw==
X-Gm-Message-State: AOAM531ENyntW8G12S3e8NB4RmyA0lAPY90rPzRDq9dMPmdCnbx7fuOk
        ELzHhqfPb8kIPrrvpA2OL0+kQ7/yS1c=
X-Google-Smtp-Source: ABdhPJx4trwJ/AUKNPouFhukvbKiawlY+HdLm3vVDl1fqvWkFQsV8nVPVQ7t9wxF4ct4gJ4DHrXAKg==
X-Received: by 2002:a17:90a:b783:: with SMTP id m3mr13511973pjr.183.1636515928469;
        Tue, 09 Nov 2021 19:45:28 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:46a:f117:d5ee:c3e5:104f:c135])
        by smtp.gmail.com with ESMTPSA id q6sm5995293pgn.42.2021.11.09.19.45.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 19:45:27 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     oder_chiou@realtek.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, allen_lin@richtek.com
Subject: [PATCH v2 0/3] ASoC: rt9120: Fix settings and make compatible with rt9120s
Date:   Wed, 10 Nov 2021 11:45:18 +0800
Message-Id: <1636515921-31694-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series add the below changes
- Fix the wrong ocp level setting.
- Fix clock auto sync issue.
- Make the driver compatible with rt9120s

ChiYuan Huang (3):
  ASoC: rt9120: Update internal ocp level to the correct value
  ASoC: rt9120: Fix clock auto sync issue when fs is the multiple of 48
  ASoC: rt9120: Add the compatibility with rt9120s

 sound/soc/codecs/rt9120.c | 58 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 10 deletions(-)

-- 
2.7.4

