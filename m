Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD64373246
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhEDWXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEDWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:23:36 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380DBC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:22:40 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h6so108285ila.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LN0Jxirp3aL8KJIouQxgprM57cmetO1/VQKLGXGGyIw=;
        b=YyXe71cXI6Obd5kemD7c+QN93aTeeLPhwvaWEJIDL+s+XfYBmI//5oqQmqfFGx9S84
         tRkyx+NUWW+ZxTXSIo1nSuWFMSEVXFFS2fimSiEEXCn3q3tpwgIInv9phyzi33dmUP4s
         qv0XtsZA+JN7l8eEqHAIEQKVKM04p7i+gvl9VXLRnU9QmA1TCa6au2H1qElKhMG0gtqJ
         bsDba/dmfN5Isqlx4Ft6zKfeVc8V1dJT9wbdb1ofy1iMoZF6tEEMSPa3cioZJtcU90Pw
         qnEOG8oKzqol3c3UH+V+RggHXQSb7kxuOy6Xj8p082PHsmqlf59W+73KQhaP9H47ujzk
         Kdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LN0Jxirp3aL8KJIouQxgprM57cmetO1/VQKLGXGGyIw=;
        b=jje2Bh4P9UkWA5WSnj2gXp5CBWIIwW6Klnxrk+i1ISzfRD14yNc4T67s983LjHkDMz
         iWOxiu5gpWUlhmep5ldLU/0BTTXC2Z+CcMLbjZTX6k7VeAVYYbqEI4E8GaHy/EqqMx7R
         xruwK9fE8y3LXNduPEhP/1Ihep80wOQQyg9MlVRO+yWShw6bLJSnRe1VPmwS9enep24T
         PUqGWf8OdWCPGqtgD7IhMWxeMVEcGk/qDgdgIUT27ug77Nwpskb0bQ1Ph2UX9A7uNf0J
         fl0qjI/k7sJmMOHUhYg5VLjU0RCz/99NJ6fPNdI9An0C2UWOF44TKuUsbpQlK7TDL+Xs
         DDbQ==
X-Gm-Message-State: AOAM5335CgTzJl4nANO6YNxR1BOx0WTCrAGJJ7AKlgwdHAmt5/uu0pyF
        G5K91FsAXuOdzAPMVYa1l2o=
X-Google-Smtp-Source: ABdhPJwwZXj9Trt3BfcoIdcvan8edyTyJ0zbT9FQEv9OimaK6WHpnlUpA9zC5Jce+wZJ7EeaulkpfQ==
X-Received: by 2002:a92:cd52:: with SMTP id v18mr15235393ilq.308.1620166959453;
        Tue, 04 May 2021 15:22:39 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id j19sm1626337iok.51.2021.05.04.15.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 15:22:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 0/2] DYNAMIC_DEBUG for 5.13
Date:   Tue,  4 May 2021 16:22:33 -0600
Message-Id: <20210504222235.1033685-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heres 2 maintenance patches;
 a minor short-circuit optimization
   v2: hoist buffer init to its alloc, #define just _ANY, not _ANYSITE
 remove useless pr_info

Jim Cromie (2):
  dyndbg: avoid calling dyndbg_emit_prefix when it has no work
  dyndbg: drop uninformative vpr_info

 include/linux/dynamic_debug.h |  9 +++++++++
 lib/dynamic_debug.c           | 10 ++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.30.2

