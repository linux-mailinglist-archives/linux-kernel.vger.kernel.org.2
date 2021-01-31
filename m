Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441A4309941
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhAaANd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhAaANb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:13:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66BDC061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:12:50 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id e2so14128190lfj.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQhP8eD8DaUVEdOJdM5E7OMw7FrTyZO6tdMoNlRzA5U=;
        b=sYFfAQxsoTC49Rlqs6y5EXQpiTeknGNAYT8hiHx7fEwpMsmQ6k2njNgAeBZp28Yn1t
         Do42/MyMbEdDiGiBMATiK8ZRrQaG27v516VvQALMmKm5nOCemDoQK2vrL2izpqLZ937b
         /sLF9F/MEt1CBj7ZozjW3WNCz7ome8xZ7/dPkwDcpweY+1AWs1kvrfw+iDx4+qyU+rqC
         hN56K+QlR9Hx6B+I2J6K/hzWjncF8kXTDz58hS+CHH3VZqLWj8cSY2H9h69zhKOp/56T
         MRjMIc4knkoIsaI87iGa9pOmnCio60D333FYtd2kSspPd/Fpp7w87/OEPWV1X2Vbjz+Q
         VdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MQhP8eD8DaUVEdOJdM5E7OMw7FrTyZO6tdMoNlRzA5U=;
        b=l25o7CKGGKjHCLYKgaLWY8LsjQqKUUeqHnfzSznA2s0uP8+OqVtywwKmsfcbO2lFwZ
         vD1kRTj9mdOrqcrZO64XY8kPVSmPVmmNERHRpH8Gq6iIdi5cDhjfNTGXZkI3Nj8h9ILQ
         KdKYdwAJq7pRBHj0EArmKM3OmT2g0RH87xBVHXVNkbQppYp6nO5JDR3YbK71QtkG6hsj
         fnxyaGHFECAgkHEHu/3gQRNCh0M4YwB0PrYsQyxWlnJYiQkD53RRsItTrKvB1+slHDAx
         xdzfiy9fLWcgJM0iWoY5mkIyThTdLiQXPgdaMc/o3rD7Fzu1BV7KyGf21N1C3oHifbp3
         B2LQ==
X-Gm-Message-State: AOAM533jHb8PCL8iN/8a8tDHJtdlSWUYRyMT5z0BIsrJDlvffDQp9dsu
        8EMuxD4pdrPZOs53lIiNB6mbO73hku4=
X-Google-Smtp-Source: ABdhPJxDlcB+JAsLzS+r+RYiFQzSQTx48+aXya8sc/tHfZj4f3URdOOn9/cCbW0W//3Cuwj+0QRpsQ==
X-Received: by 2002:ac2:5f41:: with SMTP id 1mr5563045lfz.65.1612051968840;
        Sat, 30 Jan 2021 16:12:48 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id t2sm2503716lfl.141.2021.01.30.16.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:12:48 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/2] ALSA: Constify static attribute_group structs
Date:   Sun, 31 Jan 2021 01:12:39 +0100
Message-Id: <20210131001241.2278-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify two static attribute_group structs that are never modified.
These two were the only static non-const ones in sound/.

Rikard Falkeborn (2):
  ALSA: ac97: Constify static struct attribute_group
  ALSA: hda: Constify static attribute_group

 sound/ac97/bus.c       | 2 +-
 sound/hda/hdac_sysfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.30.0

