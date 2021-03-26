Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC09434A412
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhCZJR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhCZJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:16:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6E7C0613AA;
        Fri, 26 Mar 2021 02:16:56 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id i19so3755620qtv.7;
        Fri, 26 Mar 2021 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyIt38WFE9vg0s63Vp8tusIm5eIJviBYRHvIiSBOVAw=;
        b=mwoR+rQ7OTBklKUmL52HXE6v87oGhrFOYXni4lI8IJtN6jsqS6OXuVjATYd+7AgUGR
         CzXy8hVIzkDfbsxMQa9xzP/qRgQKPBpjfcpcoicH0syWA2FHYzOCMTUCdoDaIWO33+Aj
         gkXYgry6Lrlbu6KHZT5DfEeR92E5T8pXwpLLIBGxoRTOlaOnghmpn1buh6J0v3DxSR6Q
         rZRbQlFYck3lfB+NqSwakcvQ1jT8XQgR+BZueLt6Ze6O3rC6Lrp3dLC+kpVqe4jDqHRh
         3sF/akQ95jFiyGDVkt7wLxiw6VPOQyHgImtd2lll5eOK24pI0x/nG7eearhBqSbBPP03
         AJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyIt38WFE9vg0s63Vp8tusIm5eIJviBYRHvIiSBOVAw=;
        b=fcvolXKKC/IWOGix1X6IpSJMU8Ho/P2nxvTacMrsGk+p3kxk56S4xaH0q233iHyzJO
         onYRYJ6d0ZQW7rvN82G/dFYO0UHlOIPSCyZQMrZun7cEThnZiQBPFVbgxcInY0T4gmWv
         3aj9HetIBMbTzPq+4tlwMcD7Z/OEWnudNSMVlAN4LyEOhPv8obseA09nVw+0ZZn33dst
         4wfvPD4JYWg66bAXgdYQMwG1YbiqZH3knD5DKderMYiNV1jSL2PhLq1fFjhNL5AI3EcI
         RrQtI18p1iRhLgySjzSLJXCaq6jds89+EJjBCuytdtODQVhWQYmAY7LOoYsuB8/LGl2Z
         611Q==
X-Gm-Message-State: AOAM531N3OkRk85zFkMqj7W1AfBsMKkP7sVHYx+jdCvEcNeJFZw/8OqT
        goyTy4OOIrqTFZVcqSGxnEv69EjkrqOd6COm
X-Google-Smtp-Source: ABdhPJy6F3KDTZ7GmJ2NV72l7kd1PkSAgCoBE+KJBhMH4sK4nqBy1QqJaqK3Wi+eMw0N4DoQAuUaIw==
X-Received: by 2002:ac8:469a:: with SMTP id g26mr11499010qto.89.1616750215929;
        Fri, 26 Mar 2021 02:16:55 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.107])
        by smtp.gmail.com with ESMTPSA id e1sm5620114qti.10.2021.03.26.02.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:16:55 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tglx@linutronix.de, gregkh@linuxfoundation.org,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] scripts/spdxcheck.py: Fix a typo
Date:   Fri, 26 Mar 2021 14:44:43 +0530
Message-Id: <20210326091443.26525-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/Initilize/Initialize/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/spdxcheck.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index cbdb5c83c08f..3e784cf9f401 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -243,7 +243,7 @@ if __name__ == '__main__':
         # Initialize SPDX data
         spdx = read_spdxdata(repo)

-        # Initilize the parser
+        # Initialize the parser
         parser = id_parser(spdx)

     except SPDXException as se:
--
2.26.2

