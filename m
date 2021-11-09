Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1544ACF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhKIL4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbhKILz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:55:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F1C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:53:14 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id m14so19261845pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+P7Fs7OEF//AkCFwWHTn/bNUnCkRRYKmolIIpUkc3Hw=;
        b=MQYMqOPt8gRKNDkKXAxet4zXLNDLlUMs0Kjm8ACi6RfUkVpVLpR4hR/vmjRtt2PuDd
         avDje7y1NJsnj1lW/9m3ZImVVXkvcXdvgGAa374EuBB59PRuFUXyAOPCajC9f9MVDiyK
         dfTvwT73OvBE4ioQ6O/dMvKuiOKBr559617C3qxNIjVxOr7iqPBP8O5Jc2VimHQzyJT/
         eTlU3FAMhDUvJ1M5qfCafrAuxzsYIIlUWi0mvrt1PFQGzjLy+buXa1u4jGmJ6i8cQOAB
         UijjIkZoeItyAxRLHcEcsXsAvvLFFIgaLb2J29Ey5tI9jrg5yHsjNglfdbPDAY0y4kRM
         TF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+P7Fs7OEF//AkCFwWHTn/bNUnCkRRYKmolIIpUkc3Hw=;
        b=f9ozoGqez8cCKqk9N1j6C6PAx9Ukl+dRkEzBFQ0/blO2ipIlJeSEPuQ+d8MbYn2RgP
         xeFMzVXz2rjgDVgIu1nAalmPbDZWj6Q+AFdvirDjoBTsuRnhunDVH3P6nVjr30OG2LhA
         MjXBnEDZJDDDIrH8SIpgBx0MRDB3Lwy9YaJureTCbxswh3WZPbI3PputgGYegZMK8QKS
         W3gT+oXZQWmgo3urkdYrm2/VOddE/JA8a+Cy3eKAjamrEqkJVIYqCdT8xbPmlEs4xyPf
         2W+zbtqTYpEumyxC8kgo7KRU6gTfhyQVgmh3s2M41bcUhbO5ZKqmgdnaL8U+nv/DoZCY
         iUXQ==
X-Gm-Message-State: AOAM530kyBzWNlIxX9rUr9Ryt9zKy203WBtnN6QsXVvPl2hgQ8wUYct1
        I/xQfvD9yDn8X8xkd6eYXtk=
X-Google-Smtp-Source: ABdhPJxjsPQJeT+gty2oz6smIguBfdTWna00RmH2Ph4MbditbT6Y2UjbKd7HzhaXx8fP65GuP/oGJg==
X-Received: by 2002:a05:6a00:24cd:b0:49f:bf3f:c42c with SMTP id d13-20020a056a0024cd00b0049fbf3fc42cmr7465341pfv.54.1636458793900;
        Tue, 09 Nov 2021 03:53:13 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h3sm2420878pjz.43.2021.11.09.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 03:53:13 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] staging: r8188eu: remove unneeded variable
Date:   Tue,  9 Nov 2021 11:53:07 +0000
Message-Id: <20211109115307.133100-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./drivers/staging/r8188eu/core/rtw_cmd.c: 66: 5-8: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index e17332677daa..1b1c47f4a34e 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -62,8 +62,6 @@ static void c2h_wk_callback(struct work_struct *work);
 
 static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
 {
-	int res = _SUCCESS;
-
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
 	atomic_set(&pevtpriv->event_seq, 0);
 	pevtpriv->evt_done_cnt = 0;
@@ -72,7 +70,7 @@ static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
 	pevtpriv->c2h_wk_alive = false;
 	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
 
-	return res;
+	return _SUCCESS;
 }
 
 void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
-- 
2.25.1

