Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C51445D71
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhKEBqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhKEBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:46:07 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF38C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:43:28 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i13so6520107qvm.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxmXyn8ShSjxQDOiXzzY6+U7bBPX7WyywFrWVYsZkWg=;
        b=Day+dNVbswGrLVeC5a0reDjIbvCvPwztiayrv67iHseOJ2xFBcBxNvOqMuxuOgUHyh
         /gWqXKBqf6QRP+7cwgRdII5hrtMMnr46Y9JSFq8ShLemhuxp17lU2R18w/hizCeiMXXU
         fdlAqbU+3oUh3lVc81inNP1N06DAURuEfrJ7WtkrLDY4ql6w3VYcgABJBBVQCoagMpov
         t/963QHZ09vx9rDQPlJqvD6MoYF5Kp3SZeTFxLF6zZx4ZJfYCGyUHOKQFVqfb9//3uo/
         Vu7e5amsSwMTKBsvWQnqBSbhmofe/fQVcC4ipaJb+f5Q1L8qOH+qg/emu67yZ6EYEUXH
         PK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxmXyn8ShSjxQDOiXzzY6+U7bBPX7WyywFrWVYsZkWg=;
        b=m7fKW8ktErq4UYEniXJS4KSypQ8gIe6yH5B32q23pl2c3zSwpJdIbM6PFz41MyYiyv
         C6djxNLYSZzOcXkwzEKx2Tk6iaZWSzHxvgQ75ZuZepGU4gGLEFicDJPATxW7hE2v223b
         hGiwKnQnhRr4oc/OvJmPgSgK8URpDvgE4FtMzB8hBSBVHirNYYSXlo6gW/mM3heR5SXI
         aG+8AqequvzzFUH0Rx7/rl+REtACSkkOEdRDvDidpfLmhdvoXn+gXzjXnCnWrrw5qIso
         1mIkDvl6apgWVA8vFJCPq6RJm0U03jkK+zjPpn2Q+viQ4gaTxcnAgKvnZ8N0Gb+3nESn
         +/uQ==
X-Gm-Message-State: AOAM532ICCP4aQONkbqwE5ukxKrtWIfMuNWPul0ftQruBrBMcJzfjXvx
        2VOp6c4FM3npzSNBfETHzRc=
X-Google-Smtp-Source: ABdhPJwL0kRNhKYAnnUt3cBzUpylAnh1d+EPtRjvz4BrDdOleJGSUi7WtOjrezpNUa3pjWxrl0G77Q==
X-Received: by 2002:a05:6214:508f:: with SMTP id kk15mr4491156qvb.3.1636076607634;
        Thu, 04 Nov 2021 18:43:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d11sm5540489qtx.81.2021.11.04.18.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:43:27 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     ccaulfie@redhat.com
Cc:     teigland@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs: dlm:Remove unneeded semicolon
Date:   Fri,  5 Nov 2021 01:43:20 +0000
Message-Id: <20211105014320.75292-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Eliminate the following coccinelle check warning:
fs/dlm/midcomms.c:972:2-3

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 fs/dlm/midcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 7ae39ec8d9b0..aa4215388b62 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -969,7 +969,7 @@ void dlm_midcomms_receive_done(int nodeid)
 		spin_unlock(&node->state_lock);
 		/* do nothing FIN has it's own ack send */
 		break;
-	};
+	}
 	srcu_read_unlock(&nodes_srcu, idx);
 }
 
-- 
2.25.1

