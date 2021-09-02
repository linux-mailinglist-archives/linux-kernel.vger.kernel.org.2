Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E093FF179
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346361AbhIBQdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:33:31 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49870
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234607AbhIBQd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:33:27 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 03A534018F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 16:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630600348;
        bh=/hLx8OjGF7PEGI02/R3mR8wXhwB9eNDnHTpaX6K6wTc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=fhgro4QwCmCZMpJJGWXDKowQ0ucTiHqc/4qSpFo9i1rp5iYkO7PP0p0sMG49/GGGN
         nmzkIoScZ4/4UcVwKutQ2XrxpoE/3rS6SlO3fDk6eep0wlbjp0o+2CzP75ZawHEFzt
         5Lv8VNVMIGU0gSzWjoBVXeXynb2kvgPW9Jpv4VM+83LJtI/TOWtKgRWUC90L9rqMS3
         vwGWiunCwsyvsyhCf/P6vNdnUvjDbw4W0yNSXqhgevXp8Qtjapt6En3hVcaXCVgN+o
         d2SI5IIc1EvvXTVHlZyq3Mom65WPTq0vYs7NYq66mJSlq0tEKEGLJBo/MkCn84voGm
         w7A+nwydpu4vw==
Received: by mail-pf1-f198.google.com with SMTP id r1-20020a62e401000000b003f27c6ae031so1383210pfh.20
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hLx8OjGF7PEGI02/R3mR8wXhwB9eNDnHTpaX6K6wTc=;
        b=dt80JxFrGXp9kP3dcD4rRF6GSPNhvoN860njaGNnbSg/cDwZK5EHv5sxyKGG2AyLDt
         j8oOgW4IW39C6O853YJlgNXhncH7cFSX69us3W9VreTa4JDBG/i86Chx20lL2dgvjvNW
         vSGZdl1oQH8SQQUqbIRrzRFCtuTQXmUuADl4LLpcBvxHJgQy1hxTj9HOeYked5lIuqvf
         hpnq8Aihvt2j0SIvEreke1sdEaSYWEnQbS3N88r5I76txgpa8dpA7AUwbrSlviI9eXy9
         mVSiLoGfpyGIYnKMcjgFgdEd5CWJNpOXxZPw318WYytxpSQjfT/ExJsVS+UzDvKzawG6
         QJUg==
X-Gm-Message-State: AOAM530YC1dMVhQDtUvdPaN8jccGuxEqmLe/vq3H3PF60ZBdOb/4hB2f
        R+n51uU0ey8Pxe8Xj+YZHSux+JEqNfMHgjwgqiJ0bs7xtL3T6rxvzYajcD1OR9ygq9Q/WAXjewg
        4y2EgbeHWBzKCDRqz1WcQHPIHuKGS/5MvS3xYXpnkXQ==
X-Received: by 2002:a17:90a:f695:: with SMTP id cl21mr4752928pjb.220.1630600345759;
        Thu, 02 Sep 2021 09:32:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyN80o0NBi1VWRJJZUNrilZKuC03IOPbxn8+HvnOuK8x2e1T86Kw82Sq+tssmcBqXwYh3HBw==
X-Received: by 2002:a17:90a:f695:: with SMTP id cl21mr4752910pjb.220.1630600345553;
        Thu, 02 Sep 2021 09:32:25 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id l12sm2698919pji.36.2021.09.02.09.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:32:25 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     netdev@vger.kernel.org
Cc:     tim.gardner@canonical.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next] ipv4: Fix NULL deference in fnhe_remove_oldest()
Date:   Thu,  2 Sep 2021 10:32:05 -0600
Message-Id: <20210902163205.17164-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains that linux-next commit 67d6d681e15b5 ("ipv4: make
exception cache less predictible") neglected to check for NULL before
dereferencing 'oldest'. It appears to be possible to fall through the for
loop without ever setting 'oldest'.

Cc: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 net/ipv4/route.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d6899ab5fb39..e85026591a09 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -603,9 +603,11 @@ static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
 			oldest_p = fnhe_p;
 		}
 	}
-	fnhe_flush_routes(oldest);
-	*oldest_p = oldest->fnhe_next;
-	kfree_rcu(oldest, rcu);
+	if (oldest) {
+		fnhe_flush_routes(oldest);
+		*oldest_p = oldest->fnhe_next;
+		kfree_rcu(oldest, rcu);
+	}
 }
 
 static u32 fnhe_hashfun(__be32 daddr)
-- 
2.33.0

