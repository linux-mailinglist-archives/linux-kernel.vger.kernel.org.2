Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C54004C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbhICSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348321AbhICSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:19:14 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11586C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 11:18:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j12so151301ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=883xElBFencY5c0OGGg52rdLZq6bLCaxWzcjeMOL5Ig=;
        b=QRMaoMuu+mn7nYV8gnSsQzl0222xnKTRPE0tqT2Z4lYny5RixvHQLav7A2IOYhPiVu
         z9zjyFgpBH4MmrQTyXiJeg0DLDGTdOM0keZRvnUs+u406UAkyykG2QRezV0P5EjZwxkX
         VLtrbFHE4BfhWrZllXz7ledx/m8IP8YnPBVbjPn9UlsSOyAeLoNGGN/K3Ardm/XPYOxd
         QnfyLBaLH+QyCMKsYZuAmO9W7nTZ+MOm3g9j9boYblDt6B+M7CD27roOInJL6o+n5xoc
         3/d8j/x4U/AczX7WaUjOS09O97F3OojOUoAIylXzDQ6OYwseEUDkYPjwFG0V/7HLxbVt
         lrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=883xElBFencY5c0OGGg52rdLZq6bLCaxWzcjeMOL5Ig=;
        b=Cla7IbpYGk2jVgXbBCY7Ui7DZEMER/cmHj5Fv5SRWbU+s/bFrwsLrCTKTmcoBP7T5o
         JgAtA3kJyak9jzL66g91P172XUUTQOAdo7jkyLq1eXWDF8A7p0H2kHxJVdJqqyNhygqd
         asXbrP85aY4d/MSoor7tdVIM0UW4J7OIycBN4LWwNi4sipqjl+3dnBOtJqG12XSl2/Ah
         h2lbVo26m2YDNLfPEm0ldun8L0yAKzsbbRSQmreAi+b9amMcFeDT/C1KZExE/zUw9q0p
         paLeZN2bvs0c2MS8FSBMDT/RDDuzPqgAPvEMUuqKdbxn6C2JQqTmcI+c4y1ry+k1W4h+
         HVmQ==
X-Gm-Message-State: AOAM530z/g1syWC1nWsPtvTrQ1tECXub3sa2v4YBQPwziHkA4mAPey2Z
        hOu6FCRtaLonY5uTjJFwMSw=
X-Google-Smtp-Source: ABdhPJy9FMS8REW2mtVJBLxK/Eusely6MYf8zBy4dPK+0LWD28RMb76WayE95gFYfislhIl8ZAmVIw==
X-Received: by 2002:a2e:5345:: with SMTP id t5mr247471ljd.20.1630693092357;
        Fri, 03 Sep 2021 11:18:12 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.70])
        by smtp.gmail.com with ESMTPSA id d5sm15719lfv.14.2021.09.03.11.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 11:18:12 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove useless memset
Date:   Fri,  3 Sep 2021 21:18:07 +0300
Message-Id: <97a283ed5b97632033b0fc7c6aa0fbfc82f06da3.1630692375.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ee783fbb71abb549505b84542223be7a7c905eea.1630692375.git.paskripkin@gmail.com>
References: <ee783fbb71abb549505b84542223be7a7c905eea.1630692375.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

psetkeyparm is kzalloced buffer, there is no need in zeroing it one more
time, since kzalloc had already set memory to 0.

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index bd991d7ed809..37578638bb76 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1690,8 +1690,6 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 		goto exit;
 	}
 
-	memset(psetkeyparm, 0, sizeof(struct setkey_parm));
-
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)
 		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
 	else
-- 
2.33.0

