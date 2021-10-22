Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21614374DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhJVJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhJVJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:40:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F9EC061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s19so773472wra.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrLGl5J1Fh0jBQ3bl4JSYt92D3B2FEdMHUQ1wG7PfLM=;
        b=BtXoJwbcssnAYaQiLN8TVnM1N6szpyGOWkHG+klTa3lYOOK7SD3bPMJDQKr6ugldKa
         X/h9RaNBWNhhtyeBkwfFRal8W/0PQ0B1mjP30ce/cPPuEnL+LUG2uZ0BGGd/WpRsvEsz
         xSq4RWDb7IShOmcOz6hISkeHC+11R/RMrUa0JM6YjQ7tSkoiMKzbWaUJMntFOzobl+K9
         Kq/K9KupUqJMp7dGpN9sKIcvsAUSl1s8QTvOvXIKgHAGDYj9wOF1jpQLRR6BBDchJnkF
         ZB+T/8hxFtpE9CB8ICqjQ97sWQ3fZDDTpe8II5D/pzZRslyedOQbrqsWTZ5MXW6eIfuP
         vgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrLGl5J1Fh0jBQ3bl4JSYt92D3B2FEdMHUQ1wG7PfLM=;
        b=vYudT29FUCqbmFttoFde5hLlc6dmHa/Ijwa2zNMHOMqpNNPOkMxzYAGmfrAlHtkfY/
         9jyzq9pwlgRqX5PpzYTJx6ZTLkp0bppI9FwHWbCACpmgY+ikHOAgWFlgPRS5niY1r4sK
         z4/Hed97Knas/+XsqbxWLixWHx/Pm8y0yqO/2gVkasRe2JMXpd8tpKHBQ0STc6d34+fs
         cQNeDz9fcl5Q19rcJQPr8wJE46VYizX2YnmN4ShL3STRFsYkMdXT7SJcGRsYzxhBWAZ3
         3vGHfU1gRDcLm0hJ7NAM3d9SARxu89COm0TpSj++EXm+WOj28obZuuFDFF090/GFXc5e
         PlrQ==
X-Gm-Message-State: AOAM532k30NcNdKYmtRkt7jcWie+FJfVc7rWN5OUQd1XmPyK74VDy2SL
        DfxZQxNgrWvRlnEAzEmiOu2PXpteOfhXQwXI
X-Google-Smtp-Source: ABdhPJy23x8Y3fnkzITNiQKGVTYLReIhfCXxeOtizg8lIJkcKVMmu/UXzVLHBvyi2TOdL7Whq6Pfkg==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr15034248wrq.6.1634895461773;
        Fri, 22 Oct 2021 02:37:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id r15sm1643602wru.9.2021.10.22.02.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:37:41 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 0/5] staging: vt6655: `RFvWriteWakeProgSyn` variables rename
Date:   Fri, 22 Oct 2021 10:37:13 +0100
Message-Id: <cover.1634826774.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is a preparation work for `RFvWriteWakeProgSyn`
refactoring. It includes removal of Hungarian notation in
local variables and function parameters and changing them
to use snake case.

Karolina Drobnik (5):
  staging: vt6655: Rename `ii` variable
  staging: vt6655: Rename `byInitCount` variable
  staging: vt6655: Rename `bySleepCount` variable
  staging: vt6655: Rename `uChannel` variable
  staging: vt6655: Rename `byRFType` variable

 drivers/staging/vt6655/rf.c | 60 ++++++++++++++++++-------------------
 drivers/staging/vt6655/rf.h |  2 +-
 2 files changed, 31 insertions(+), 31 deletions(-)

-- 
2.30.2

