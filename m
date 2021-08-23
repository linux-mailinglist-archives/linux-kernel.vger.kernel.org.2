Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6D43F4EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhHWRB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHWRB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:01:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9009C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mf2so19888844ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yj1Ue2jMXvR7X0uHJnNJMhKnuo4YtIqgemMSiUhxv3Q=;
        b=Vkn4HafvOIp/HWLPzqTFHfRKzeWas98kiWPTw58yRFaP+XCOAN3p4UOYXkjWVAFLQ9
         dBH5zySk1ulGI+/CuKPt3rl7PUU8JQ4iJ8o+gWz5GBheqPxWxwSCBaHQUrbQkkPM7J0a
         m1lssgE+31ZEpGptu+Nh1nbn8axUTstJCl6pIUz5+75o2YYU5EXEt6dgj3qBb50KENAp
         WBLXua+HFgSG46ObDooRjaeeh4Uu1Kdu2HFVPmZTF6BXqmKUy7UE/RBal5bC9oE9Ghsb
         RbEyVvB0LiBMk/Kj1AVdqitwBAAuNzgfrfES0+ODGPNviemBKp9rqkNHgkbyTDTsk1N8
         8m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yj1Ue2jMXvR7X0uHJnNJMhKnuo4YtIqgemMSiUhxv3Q=;
        b=bmryB864Fm0gkwyYzBqn4c10k9JBSukX+HH4RkCcRdvVn6LR1DxqPXDxZqSqI77yDC
         +PR1ySdXCQRqA8NZfVaC2AEgEJFCsOGklYM2By3x5Ep7oXSot7sxnHZSuGMwU7c7omRF
         EBjyWOEyw3nM2O9cBAo0czGiSzUi1PPtOtJyTZNhE+/YH4WCNuq4i6h2HhH1eDmdDFIr
         URP8fiOV4IHIY6NrB0kw1ZXg6yfXUjhMZDeziJzmec3l86m+BNfAceNmbys2Mfnd3y70
         4l1BiyMUy3bj8qMLCKlPh0W+ecoAGrYFmuz/fLNNd7OlzQUa3+b8+ny+CE7OTa5g7FRr
         t2Ug==
X-Gm-Message-State: AOAM530Wwk2XXgR5KG8udZcUpUQ5ZlZdML2gP4SKL2LFpXsbbQVm1Wmy
        7UpkmTPUuREz1xbCKqdXIEw=
X-Google-Smtp-Source: ABdhPJzINKvfz4RZjtwI+d/ez/Pc0GdF8yHiLStweP09PqhEOcdDjmP6xbmW2MZWSh+qgC6RG2mt3Q==
X-Received: by 2002:a17:906:edc3:: with SMTP id sb3mr37395976ejb.114.1629738043326;
        Mon, 23 Aug 2021 10:00:43 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id b18sm1633188ejl.90.2021.08.23.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 10:00:42 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] staging: r8188eu: restricted __be16 degrades to int
Date:   Mon, 23 Aug 2021 22:30:26 +0530
Message-Id: <7572c80d90b499df7e9feb4781c07967fa31bf88.1629563318.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629563318.git.aakashhemadri123@gmail.com>
References: <cover.1629563318.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:73:23: warning: restricted __be16 degrades to integer

Here tag->tag_len is be16, use be16_to_cpu()

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---

Prefer using be16_to_cpu() over ntohs()

 drivers/staging/r8188eu/core/rtw_br_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index ee52f28a1e56..f6d1f6029ec3 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -70,7 +70,7 @@ static int __nat25_add_pppoe_tag(struct sk_buff *skb, struct pppoe_tag *tag)
 	struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
 	int data_len;
 
-	data_len = tag->tag_len + TAG_HDR_LEN;
+	data_len = be16_to_cpu(tag->tag_len) + TAG_HDR_LEN;
 	if (skb_tailroom(skb) < data_len) {
 		_DEBUG_ERR("skb_tailroom() failed in add SID tag!\n");
 		return -1;
-- 
2.32.0

