Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFDC35D90B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbhDMHh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbhDMHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EDFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:37:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n38so10897256pfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wj/P641sD/e5hD8zFgOUD41DvnEOt3Hc9lA4lyfQJw=;
        b=NK3frzvdW3ud3kjLPx4OsxwMpdZ1NjA1NtsDL9Y1kDzUCyA32byROcomS1jI6UhsLO
         jumgwA75Emo0ROYheWpVPfZ/C5rYerF2GHo2NonsePo8L3sC2HoiiZLL/gkJ7K+A5zaN
         U0VnIbLj2yAV4Bf4g4JnEIgugsP7kjexCtZ6m2KptQAtYP+AvEKPDslfDpsNme6TNDRx
         7TNmPbOSunzhVPYTuoYw17dO0F16ilR/XgW0QyHqofKiPgoQ4dLzdVrcEpoROrSKSARS
         J/VKSZWS92NKEb12CvcWuVYTy4CAK5T6v8HFJjemsJRuLvKOA9zkPkn104cvDjOSTiAd
         9c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wj/P641sD/e5hD8zFgOUD41DvnEOt3Hc9lA4lyfQJw=;
        b=m1URs5RmZDl3K+bjN5mtMnJMWvUdmzS13MW4iFWfLJOBx/4RfF4JjU2rzurUTWrkRU
         WukJznb3qbHguaXL6XkvZFnX17PEWEW49EHYJQbSMYMg7JQ2o624TO3oSRMWEtiqjVVX
         VKuUVdNC9+kXhJLvWgQ9xPT2pHFTr7FxII6pJPFYV7ewORxlaL0ZPEhsEx3ZcOy+80zD
         1KImd2nMgEyV1xF+HAHIpaGDj3cOjuMyDS3yZvU7iUl6cMJyCUK/2pIZ0WTO3yq0M+mw
         EQqhoXFauChymRj+Zr44yXUAviE34ReNDM1p6oyfTHaSE80bePG0ZBBd8SRzJV0BGOS8
         KC7A==
X-Gm-Message-State: AOAM532g+B2mH4gsbviEKrQl14bvKzauLQlSaBvWwOHaesM5lE+AuHH3
        EE0dnNFS9Z06QXK3dV2cNWQ=
X-Google-Smtp-Source: ABdhPJyS7ftMEF/xsFmdK0Wat9VKq3jB5YuLN83Faf1UBZGxDO180LmfYZFu98qs8MOXunX6jK9DkQ==
X-Received: by 2002:a62:5bc1:0:b029:20d:69a5:189 with SMTP id p184-20020a625bc10000b029020d69a50189mr6216012pfb.57.1618299422983;
        Tue, 13 Apr 2021 00:37:02 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:71d7:d843:bfe8:bec7])
        by smtp.gmail.com with ESMTPSA id a3sm1349068pjq.36.2021.04.13.00.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:37:02 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH 0/3] rseq: minor optimizations
Date:   Tue, 13 Apr 2021 00:36:54 -0700
Message-Id: <20210413073657.2308450-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

rseq is a heavy user of copy to/from user data in fast paths.
This series tries to reduce the cost.

Eric Dumazet (3):
  rseq: optimize rseq_update_cpu_id()
  rseq: remove redundant access_ok()
  rseq: optimise for 64bit arches

 kernel/rseq.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.31.1.295.g9ea45b61b8-goog

