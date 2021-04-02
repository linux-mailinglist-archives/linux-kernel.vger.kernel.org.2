Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8268D3526D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 09:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhDBHFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 03:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhDBHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:05:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D044C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 00:05:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d191so2081466wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 00:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQ625klfh3Fu0bPfG0eM7p7qamwBlgMDg+4fzOfYx68=;
        b=KJ2I2AwNqAjWOCWzeFkjR8b5LpvmCWUx4RorVrzOUkwZNyEqREkzp/qhlJYjwn7D6p
         Q1pfp92+jokwRBu6HGEivrp4a0MV+yY4NJkibe9eX6pVqHdqpsUrgePLjWul4cnJjjHk
         GNWtmc2AEj9MYa3h7EIFKks3grfzNfW4a6kXhztSAeGdkQcyBV7KLgDqPmjDjJett3bS
         LJ6NDRpqSFKD27LudkiK+BQJVvdcK0tX0/qbjgIg5TC7LGdbN8w12DU7WZrAf8sJQT4c
         fe3A1MtWFnqe+seQxAg2Q3UUi3o1/9VYvMXTs1tK+3MNhUknhF1lMHtNLkZ4LnIblITT
         asvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zQ625klfh3Fu0bPfG0eM7p7qamwBlgMDg+4fzOfYx68=;
        b=GlT/euuZvRTtbtd9HqGBNBEVQ57ODqqkN4U6cGJ2D2QL8oR5Z2ab/y5ohdDVPGyiQu
         3a59U/GlnWERvhO+Xfc8KLf1VAVv8ZpY5fYsdrYxtyWOgOdrmv5YUB/0iDfjI40bdMyF
         wkP749PDtLYtkOBpRkkSifGbhD8SS0Qb6BIyWsye5nVQ82i7DHN5FWC6UnVvg3IYbW13
         49fY2eH9RHoG+PZcUKU3P8yUS7bsFKphimMmXM3aka7dUc+mtJYFeRxS60ol90Q1RHvk
         3rC5ZUd1bZusSGxJQklGDrUBumaNr96t0r/x8gOUNzo6oseBLdzkgp8i0ZfhwsOCP+Hv
         16lQ==
X-Gm-Message-State: AOAM532mId+ponF4lY+70aym9TPB96eNYX0deAC5Ydow1XD3wxXweCAv
        3bxvQSkUWpg/sdOQchotALk=
X-Google-Smtp-Source: ABdhPJz39SlZN6ooYDatmXMYZ0ZGc+whbhGaJGZVUwOR8CYzY2SB+KYJ1HRI2+6BXdwdvlO5HjYdBg==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr11496340wml.7.1617347122387;
        Fri, 02 Apr 2021 00:05:22 -0700 (PDT)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id o14sm2699760wrh.88.2021.04.02.00.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 00:05:22 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 524502360238; Fri,  2 Apr 2021 16:05:17 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, corbet@lwn.net, rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] tools: Fix a typo in kernel-chktaint
Date:   Fri,  2 Apr 2021 16:05:14 +0900
Message-Id: <20210402070514.336376-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in kernel-chktaint

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/debugging/kernel-chktaint | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 607b2b280945..719f18b1edf0 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -25,7 +25,7 @@ if [ "$1"x != "x" ]; then
 	elif  [ $1 -ge 0 ] 2>/dev/null ; then
 		taint=$1
 	else
-		echo "Error: Parameter '$1' not a positive interger. Aborting." >&2
+		echo "Error: Parameter '$1' not a positive integer. Aborting." >&2
 		exit 1
 	fi
 else
-- 
2.25.0

