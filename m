Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A31452983
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhKPFY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhKPFYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:24:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516D0C0D8D96
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 18:33:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gt5so14474722pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 18:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKfhufo9ZhJ+OMD70ns2wBLpWz4YQqMTSmCPY9vPWTg=;
        b=EJksFojPs22v4/mclATmno3le8etqI5Dl2Uapd+hW/jzWMiR7VTEnic4jPK/R663qW
         LPeq82ifkyV5XfYPYF1ZfLfPs0h7AEgnAP19ms5q9OpRzCepR8zRd5bkcr4pZug1EWdf
         OVenRGCUqEwV7+QZJFHYysGdNL7REEowzoeD6P5bOu2KORJDXcKwskArAnH8slqjiKyt
         dJbeX8aHgCC+abtLfYV3A3pE8V17fpKfmsqzrAwQuy10ZRIbkcnnpUKrg38eLfSQr8XU
         DdoFooKVr7yEwvjCYrmHVD+hohIWutyw9C4q5aP6lO69UObXD8aOgiDCf9OKk9MdukhI
         BtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eKfhufo9ZhJ+OMD70ns2wBLpWz4YQqMTSmCPY9vPWTg=;
        b=ROZyKSbjRFr4IwOc2g8hQtT9aysSfHJCEIKRBbVYdvsePNVJHsyTAok/hlXtlcuHk2
         UMgwVWwAwcnDQ9vmZ+jMHPeIXlgm+KH4eVR1Qkr2d7HmXWHFShsbH5jGwdPnzQZJpmTt
         OJC4SMGFGoY/zu/9dwxxQiQ4zFGz3ave9TbQP/1G5gkG6OTwPsjQTowG448jgSTuTBlr
         L/wJLFDZAkSw6vjAC5Oa3us9D8rOeJ4IbWo0mjGnpPJ3bk6RwRw6ZnMUPoYE61zmSJlW
         CkTAcN2hwZk+yYvVedU2NQ3dJwYUi/fumv0zEInSUfy7EiWzAmhYkB7/ccVEjmgE2nZj
         UuGQ==
X-Gm-Message-State: AOAM5313WUex71gcfDdXmWxRhmxlxZKds34xS/Eu+Za9leWPSqvszSFi
        SUROc1pGqnlTW+JhBkommUQ=
X-Google-Smtp-Source: ABdhPJzrGjYbjsvmaRPnikJ9row5hGgYtA6XFnHF/Q+o13o1njeMJZ+jewyv57hiQ9JugzAJH3ny7g==
X-Received: by 2002:a17:902:e2c3:b0:143:9b60:d16d with SMTP id l3-20020a170902e2c300b001439b60d16dmr41025607plc.42.1637029995888;
        Mon, 15 Nov 2021 18:33:15 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s30sm16898734pfg.17.2021.11.15.18.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 18:33:15 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     linux@dominikbrodowski.net
Cc:     ran.jianping@zte.com.cn, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] pcmcia: remvoe unneeded variable
Date:   Tue, 16 Nov 2021 02:33:10 +0000
Message-Id: <20211116023310.154283-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

Fix the following coccicheck review:
drivers/pcmcia/pcmcia_resource.c:396:5-8: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/pcmcia/pcmcia_resource.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index c1c197292111..d7e0f659d0a7 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -393,7 +393,6 @@ int pcmcia_release_configuration(struct pcmcia_device *p_dev)
 static int pcmcia_release_io(struct pcmcia_device *p_dev)
 {
 	struct pcmcia_socket *s = p_dev->socket;
-	int ret = -EINVAL;
 	config_t *c;
 
 	mutex_lock(&s->ops_mutex);
@@ -413,7 +412,7 @@ static int pcmcia_release_io(struct pcmcia_device *p_dev)
 out:
 	mutex_unlock(&s->ops_mutex);
 
-	return ret;
+	return -EINVAL;
 } /* pcmcia_release_io */
 
 
-- 
2.25.1

