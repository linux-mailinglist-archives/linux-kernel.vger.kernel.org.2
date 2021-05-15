Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D69D381B19
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhEOUwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 16:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhEOUwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 16:52:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C258C061573;
        Sat, 15 May 2021 13:51:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k10so3452726ejj.8;
        Sat, 15 May 2021 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nD4KmsDMUkEUKKIBOvAk9bAQ3hbSzjXm6+efyP8kl18=;
        b=hSpxZc82y+5vB4apH2zZUzUFie/W6GIdC8lj2sf9E2gHpI5DJ+yblJDyt6mW7Zzio6
         fjsH0GorvfYPPlFiCS4ldNiimed8lJrjn2uD6GpfojwmADu+8lq13c1BzUUVUTLb+A0x
         i5OsSah1aRNk102pxkJcHLDGYwt+ypRsh4dEjmGRjO+n3w4uLfOq0VUS+ntQYVBA67kb
         VYvKb4IryWXYJCB3vVm7zfxGiUM7Tez0cFoxEFXQwhC7IWR5Yo0EI75lrJR8lE5jKm0v
         zrhWe5KOZqmRCrE6w29XDYXvUJslioILXaJ1+MHvja7Xgi84OHP6rBbItg27TKmB/ITM
         7tXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nD4KmsDMUkEUKKIBOvAk9bAQ3hbSzjXm6+efyP8kl18=;
        b=rkucuyd3TAwWoQ2Kj/NuByh3yrG6CNO06V7XhLPHkeUDURfaD4kSnhokehucde/84e
         ZuvnPmiqGGExdtUe0Gg93ZNvhA7SQK6A4RcQj9AO4UZyz/bRODloQ/sc8errXso3RFJV
         YozsOR4z2lsnbzFIvO7IuFqnZHaDptt18DXpngy/fjtHWGTIpTtz5krSFnIiFnlJ0mN5
         X5ug4lPRNfuhyxjhnoAoLt+JDuajcc6TPVRO/AGlNehaRer1qkH1PkwlC0z9Xg7eRwF0
         HqxPxpKDlL63dCQql2EdHRH9/jyK+AtcSyuRhWh38vX90aCorXq8u9sIrh/DY2BatK5O
         kpBA==
X-Gm-Message-State: AOAM5334kopSh6nRKLlpazHLX51B6neLrlhXMlGG5fwv6J6q/cew2v2O
        om6QccIZNc7/hLSh3fJNZ1o=
X-Google-Smtp-Source: ABdhPJwqOiPQZp37c7+SnQuH9bLDHhgBAi6r0DPiQAYqKsx1tCa7jHrpKxuHwBsFcLSKOn88cg4cpg==
X-Received: by 2002:a17:907:969e:: with SMTP id hd30mr37860431ejc.501.1621111881088;
        Sat, 15 May 2021 13:51:21 -0700 (PDT)
Received: from ubuntu.localdomain (bbcs-125-250.pub.wingo.ch. [144.2.125.250])
        by smtp.gmail.com with ESMTPSA id j14sm5866939eja.49.2021.05.15.13.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 13:51:20 -0700 (PDT)
From:   Chun-Hung Tseng <henrybear327@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chun-Hung Tseng <henrybear327@gmail.com>
Subject: [PATCH v3] Documentation: scheduler: fixed a typo in sched-nice-design.rst
Date:   Sun, 16 May 2021 04:51:18 +0800
Message-Id: <20210515205118.116359-1-henrybear327@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed a spelling error in the documentation.

Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
---
 Documentation/scheduler/sched-nice-design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-nice-design.rst b/Documentation/scheduler/sched-nice-design.rst
index 0571f1b47e64..3511d86575e7 100644
--- a/Documentation/scheduler/sched-nice-design.rst
+++ b/Documentation/scheduler/sched-nice-design.rst
@@ -60,7 +60,7 @@ within the constraints of HZ and jiffies and their nasty design level
 coupling to timeslices and granularity it was not really viable.
 
 The second (less frequent but still periodically occurring) complaint
-about Linux's nice level support was its assymetry around the origo
+about Linux's nice level support was its asymmetry around the origo
 (which you can see demonstrated in the picture above), or more
 accurately: the fact that nice level behavior depended on the _absolute_
 nice level as well, while the nice API itself is fundamentally
-- 
2.25.1

