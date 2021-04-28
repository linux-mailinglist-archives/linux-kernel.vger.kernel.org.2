Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD236E10C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 23:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhD1Vjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 17:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229593AbhD1Vjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 17:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619645938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+ySnh0a0AMi/WenqtYhk3zr8l1sB+1deE0YxwC1z4yQ=;
        b=jPY6SUFVu326djVdLE71xZVXrmCAgTb22OvilhtDS/t120Tnr8Y+gJyxnZ4reJhvvgA4VX
        wVgWNEAgyT5mAJJdxiMIlGklwZBfdNsHMmjAAYJE6XtAipq4IPbBi6lxTuZOigSmBo6OT7
        wDCjujJpd87tpnjryhYnPuBzjK5S/Ps=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-K0cPD7oMO5GfZMqGvjOeMQ-1; Wed, 28 Apr 2021 17:38:56 -0400
X-MC-Unique: K0cPD7oMO5GfZMqGvjOeMQ-1
Received: by mail-qt1-f199.google.com with SMTP id j3-20020ac874c30000b02901bab5879d6aso6928143qtr.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 14:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ySnh0a0AMi/WenqtYhk3zr8l1sB+1deE0YxwC1z4yQ=;
        b=EqnWs1SkpbCzKn5qIn4lLvZL3L/dDt3OJj1DiPdEOx+6jkiUbgjxbDbYG+o10vsINO
         kHqlmaseiAkVWJYms9Oc7hIztrl+yxqhXvg0Hwg2aK/oSwE70/I1aMRC9fO2Ro1nBVmQ
         faqbbAURNFWyp99+7banvO8/XuQIK2W0oa1ka7YE4z5FVa1waRdKqakb8EisdIMzVeN6
         O9ny5XMQ9J+liynYhRomQ7RKoxcYKyAIkzX8xRMx5TRKnt0yPixkxVs0TgkIwAHWS1vB
         doEfRwVx6f1ue6FDxpmJUBMlQmu5sZgiATDcPTTWrKBU9pKou+NsgWYTNPTqWv10SOZw
         d0TQ==
X-Gm-Message-State: AOAM5329Tj6q1JU1ilc25JBArtfWqOR9elXWMQJfJbhGMBWBU7dzlUWF
        TgWgo29kDaSNEUREMTBGKtii9W54/bjIJ+Fp1MUIFJlLDXWT/aVC1/vvi7QpJmE/v9c20KOJ4na
        a1k6niPpHAdMydNXEf18h4gcr
X-Received: by 2002:a05:6214:246a:: with SMTP id im10mr31110811qvb.7.1619645936484;
        Wed, 28 Apr 2021 14:38:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9+jqad9GKeMFzz/PInGfcPx0yhu0vao99XZF2CIU6KE5Ec+7v7AnOjT/Zkc1SVcVUaBQdcA==
X-Received: by 2002:a05:6214:246a:: with SMTP id im10mr31110794qvb.7.1619645936274;
        Wed, 28 Apr 2021 14:38:56 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r9sm897899qtf.62.2021.04.28.14.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 14:38:55 -0700 (PDT)
From:   trix@redhat.com
To:     mic@digikod.net, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] samples/landlock: fix path_list memory leak
Date:   Wed, 28 Apr 2021 14:38:52 -0700
Message-Id: <20210428213852.2874324-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

sandboxer.c:134:8: warning: Potential leak of memory
  pointed to by 'path_list'
        ret = 0;
              ^
path_list is allocated in parse_path() but never freed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2:
  - Remove NULL ptr check
---
 samples/landlock/sandboxer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 7a15910d2171..8859fc193542 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -134,6 +134,7 @@ static int populate_ruleset(
 	ret = 0;
 
 out_free_name:
+	free(path_list);
 	free(env_path_name);
 	return ret;
 }
-- 
2.26.3

