Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336A533D833
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhCPPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbhCPPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:51:12 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F35C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:51:12 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m186so19057234qke.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQaNVzbe+0y3DChgI07Ew0lz4KfYQWP+fk0Zunh0+3E=;
        b=iD5OzHSybORfccWQBLTsLyAqg2DV2Y8UMZ9bA+J/hefbDq3Ae9oKdMOO3qIFThQBkO
         WFPDn4oKeMnHMgjPS1Ct2iNNXDQSL/06mOQDCHXHD9pq2tDMTJjYCPVPFTUX652PVrdP
         A65CPbAMYYP9FpdNP0vbpexHkGQNO4FVgsDZ8ZPdFtMAawoB/MbjTImEzpO61Ib9EnA3
         lJhkS1NU2V76DapRrXIpEWIvKWe8YvlLYjTz15UTMlWNi0YWItFNE+qb9/QvIk0ovrLI
         XGJzkXXEYzjNHW03+kCrmFOHrWYCfiJNH7760gQdM178yzNtTikdp6ls2x73tjjdzxiS
         uRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQaNVzbe+0y3DChgI07Ew0lz4KfYQWP+fk0Zunh0+3E=;
        b=ptIs7KleFFcboW2lIANViHpvTGi2Yfvf78OpFVvDaWD8Wuo1j+0N1ytWRL4JuvbwSW
         oJ9dnFEJhPZxaxiTjk8N+45PKkSwfFviolCKXeWuXi5pKmUk7P1MTpEKusU1QfbkZq/o
         +tRlUPz44+a2rLQx+mbz5y6zHRIzZyaVAHJov0SZBcWuxO4hrDQpSa8KRVyK3vApbfzN
         5gBqx2bhl5IWcFnzW6mwj2TI2gfp90zqnX8gljJ5F48THlm+G1fM3ntu84vEHVpl7LAE
         6OHXsyK8ZcPGLJ4giGFXfezZFjIKxuEWpurLAATAlBt1uZd6omScTdCkErmPwAuJsfMk
         k60g==
X-Gm-Message-State: AOAM531XH3uQhVkbflfpGJyFeoVor6W9+T5oNP149Cyrhizk1+S6v4QW
        QDPUXAhUrrm0XWBTp1btEr0=
X-Google-Smtp-Source: ABdhPJzPqVaRBtKbLwZbZ3LmOclY0tRQJwmy80Gdcsayc17uGi1798KbCfG+fPRbowMEkTTSHOnCTA==
X-Received: by 2002:a37:7985:: with SMTP id u127mr196534qkc.333.1615909871386;
        Tue, 16 Mar 2021 08:51:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1ee])
        by smtp.gmail.com with ESMTPSA id p17sm10298758qtx.71.2021.03.16.08.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:51:11 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH 0/1] Display raw event in perf mem report
Date:   Tue, 16 Mar 2021 08:51:02 -0700
Message-Id: <20210316155103.568872-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In doing some memory trace analysis I've noticed a lack of a way to
disambiguate loads from stores in perf mem report. In order to address
this I've added the raw event name to the output.

Please let me know if there's some better way to achieve this instead.

Dan Schatzberg (1):
  perf: display raw event for mem report

 tools/perf/builtin-mem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.30.2

