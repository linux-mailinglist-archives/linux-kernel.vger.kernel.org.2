Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C941188B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbhITPoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:44:15 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45540
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241976AbhITPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:44:11 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8D46140265
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632152563;
        bh=OcpxhdBlzejp2v0C2MQE07mgZm7uaKlgWhogNvtB6Bg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=jYU4h74b7zZgjrw963sCoErSuOmZSuTt+c4340SlhueniovejZ9dM3qYxl2QNeFtm
         GREH3Coih0Fg2Y0bOy0D/6MmQO4hqM9/edDiShqM60eYXraAk1OeV2l9ZbCB/5/8xB
         4EPjU8EPnX8BBCrIeEuXRX2fKiIT14B7BzZ0nlySjLc41Wg51swarqb8uGQm4MOApA
         9AiujQSrJFpUgOEekQcHCrE7jT6M5aDt0/RxCIcE0W5o6sQBcCGvGAPUqWJ+JO9N4D
         Pk25/vSV80laY3XItzNapYNRpucFh5xcxKu4kxCx76ufJikaUY0MshKBT32L4hIY8I
         cxQVScqLXxMvw==
Received: by mail-pg1-f197.google.com with SMTP id g15-20020a63564f000000b00261998c1b70so15179196pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OcpxhdBlzejp2v0C2MQE07mgZm7uaKlgWhogNvtB6Bg=;
        b=qF1HYCQzsHvKnkXChuKja3BO3Od1OxOAej9h9TcUlkzjVprUL1fTaQuWVyhHWi9Mxp
         tPggrPq47PtXAM/FeOnhP4PSX/a/lbeuyyropMKw9RoiCmxQ+HMAGEFjGdN1OQ90+k6v
         07SpILzZ4nfWM++xVrpfiLlbEbDFKHWg/1WA4qzt+Pgt2g99WcfwLsv9JAR40MhQeU9q
         ckRfcK8mkTU8IXVYxFFQfQYuxtGShhMDQF9Rx6dbHz9pzC2e4aGWANLzUo8bneEcP/os
         p1X5qEVnidJmAoBaP5zjPZIplBTHbi313glvZnIz7cuf7rYBcD+VRdQ5C4ayeEhd5UGN
         6Q4w==
X-Gm-Message-State: AOAM531IalpeUhs2h6epO4PIIQ2aDpxyhbpDWooTU+iaeKCG/vKPvjsn
        VNC+HI42QTFRx3MwG1on+dsXR69c0CaFaoFItLEJqKXLzQ6mUDM4ccFngJbEjO/Cncr+m9w/PRG
        tP6O2Et7g7aDXefSo8S2OB+/Kwrpb+fCixDcpaVD6Bw==
X-Received: by 2002:a17:90a:7a8b:: with SMTP id q11mr29895643pjf.35.1632152562060;
        Mon, 20 Sep 2021 08:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN+ikGFNNGkvQl7+s28E1V/m0S/lNnypEIpSFEkQjJp9P34/1b21IXIFSgIWBwJnHVvmXx7g==
X-Received: by 2002:a17:90a:7a8b:: with SMTP id q11mr29895618pjf.35.1632152561766;
        Mon, 20 Sep 2021 08:42:41 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id h18sm6260556pfr.89.2021.09.20.08.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:42:41 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     mptcp@lists.linux.dev
Cc:     tim.gardner@canonical.com,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][next] mptcp: Avoid NULL dereference in mptcp_getsockopt_subflow_addrs()
Date:   Mon, 20 Sep 2021 09:42:32 -0600
Message-Id: <20210920154232.15494-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains of a possible NULL dereference in
mptcp_getsockopt_subflow_addrs():

861        } else if (sk->sk_family == AF_INET6) {
    	3. returned_null: inet6_sk returns NULL. [show details]
    	4. var_assigned: Assigning: np = NULL return value from inet6_sk.
 862                const struct ipv6_pinfo *np = inet6_sk(sk);

Fix this by checking for NULL.

Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>

[ I'm not at all sure this is the right thing to do since the final result is to
return garbage to user space in mptcp_getsockopt_subflow_addrs(). Is this one
of those cases where inet6_sk() can't fail ?]
---
 net/mptcp/sockopt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8137cc3a4296..c89f2bedce79 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -861,6 +861,9 @@ static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subflow_addr
 	} else if (sk->sk_family == AF_INET6) {
 		const struct ipv6_pinfo *np = inet6_sk(sk);
 
+		if (!np)
+			return;
+
 		a->sin6_local.sin6_family = AF_INET6;
 		a->sin6_local.sin6_port = inet->inet_sport;
 
-- 
2.33.0

