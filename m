Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED927441354
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 06:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKAF65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 01:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhKAF6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 01:58:54 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44268C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 22:56:21 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id k29so10596265qve.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3evMtfDXSXxIXmW4d5cTDKamJr22uxUjcmHCUKPQucg=;
        b=CnccC9zv+NP6im/hC9vqpYUuR/vOMlEu46yx+V87+3Ae4EtYU5ZAt0dSCBN3nR5i06
         m1iuF3wvvEeZ+pg7jyU2puczGofsMz0G1VAQ/UdACw1nwqn7cPyWiK0nA2jwApPpcJxL
         oH9IdCdYggfDeNy9pTGSBadJMF8UvhqOhLffUoB6zpDxH7BDnOs5/cb7rvgJBA3GntcL
         +wYD+Ty36yr9j9gAa/CwjokiHFNyhb1ga9UCwVvvblB2zuEB43JxLbV2/hgmWMpWloS1
         MJ1UWSSPMtIy3hgBVyNGNOjcAx0WefzVP8sq7cjzDhD0NOXQZRuYHhwPu88tO+BHY2Fv
         zTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3evMtfDXSXxIXmW4d5cTDKamJr22uxUjcmHCUKPQucg=;
        b=P1qBDiKGIYjl7dxaBH2SOJQxrYWBgKYyJbrt/D1p1jgk8t4VYuK37wRyXnyOeXvYHU
         fhOM2ugxmwmAG8EGOdPL+dWJWSiwxzq83r39Z8dBAQz5Ma3IxbqTWPGbh/2h3p5mYJd4
         8B7jChwWDGqrpQc6TU0migkzZ92xJcHl86hghOCC4TZJT69+UfWR9UxvYD94tveLygR+
         XQmap6hGO6c99BIhiMVXr/JPXeWfZjU4BmnWKHWhokpRFYHUwVk2rxRocgyC7ztSxhKz
         tCa3j4/ddGhpeFffqNQbaJRBWiYFQLecDzRGl/8zc0DQAE6eFAfAKOso1t0RUnjcmEnN
         QC2A==
X-Gm-Message-State: AOAM532ax4jPfZ58hviU7dwSvpy7DWv6xeDEaK87inzDE6/jDYgl+92X
        x9cmLuo1CFayYEg6Nb2OPKA=
X-Google-Smtp-Source: ABdhPJxwxW4SZBGuaytQRtr+ghDf8eAj0vZxs4F/TeT4dtDy7oy/Tlrh6NfL3lB5m6tEVjwiAnnpgA==
X-Received: by 2002:a05:6214:5289:: with SMTP id kj9mr1071914qvb.56.1635746180400;
        Sun, 31 Oct 2021 22:56:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u19sm2554072qtw.14.2021.10.31.22.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 22:56:20 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tracing:Remove unneeded semicolon
Date:   Mon,  1 Nov 2021 05:56:02 +0000
Message-Id: <20211101055602.35167-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Eliminate the following coccinelle check warning:
kernel/trace/trace_events_hist.c:6087:2-3

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index cddf6bf165a0..61586f16a853 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6084,7 +6084,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	while (start) {
 		*(start + 4) = 'X';
 		start = strstr(start + 11, ".sym-offset");
-	};
+	}
 
 	attrs = parse_hist_trigger_attrs(file->tr, trigger);
 	if (IS_ERR(attrs))
-- 
2.25.1

