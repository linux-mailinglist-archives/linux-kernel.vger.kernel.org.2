Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8165134E99B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhC3NtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhC3Nsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:48:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88EC061574;
        Tue, 30 Mar 2021 06:48:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u21so24887542ejo.13;
        Tue, 30 Mar 2021 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgEY6qp1JZV1rOF/Ou3wnAprtwFXFp4sHJwSjl7P+Bw=;
        b=nLR0P9zvwsms9T2TnqVlER13YSLJmOZKbmOs6U8CjxTdTseF/8wy8c24SKTy18ZdWM
         9l92mAL07rlM/VLKrmS7mUlBTkRyitF7K4enoafrerK8D8rfJANUhz/Fa6R9FSv6NV0S
         ZeEnRcbD2IyfAbzZeqCkmU0HbZioASU0g2q5NAR86X9ZdB+k+kuctArWN/6pQUOOBpSk
         gDbkYzKk3+jbjrIwtzKEQBLzHH/v+iuJPFy0hQpBlPw8mXLA1HIC0EUeXVGdeD8UNipi
         1GWK2TdEhVu3GhzQcEySC5gYs31SBI9GLgcxZ2FDETbAawkvhX1EJ2+3BChqv8DsmdOk
         QTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgEY6qp1JZV1rOF/Ou3wnAprtwFXFp4sHJwSjl7P+Bw=;
        b=fwM85bkpeI7Kde/mQFzc8QB4RBJrUcfNTNiIQZe++wiq3/7RVp/mx6KvMzZo6GagiI
         kmpTV0KAX8QowLa2mH+PXtVpcYriDp5TkgqfSj/oobUN0GjbuxI4R5BMQgEgCIQsysyH
         Au9tgHlz5SGp2dyh3vbCA04jXOnyCeKvzVF9LmBqQTvNx5lZkWwZrVR+vVNOKSYqgdok
         Uo6YQyiCmKZxfrFYPDXuFUKrbLZD+p72DIzbDhIkyKhbrdyX/czpJsC5O4ZuHYqilv42
         qcZBjwdUMgErvtwCw0k5WPLSftMETnckkjQAEw5X+StDbVIEUKyN5BBrDYaYEDP5C4Bn
         WKMw==
X-Gm-Message-State: AOAM531vA2EM3sXWMe/aBdQSG+Wi2S/wTj7v/KGD3cmCMnJQAdnVjTxu
        w7V4kV7T/4eIxje+GfWRQ54=
X-Google-Smtp-Source: ABdhPJyJE5hydZVLvd0FCgP9b/8wuaVZI6ZKfns35hMp8ep9yB94ngwgClzdpbFhad2RWAEToYzfMw==
X-Received: by 2002:a17:906:add7:: with SMTP id lb23mr33114685ejb.273.1617112111213;
        Tue, 30 Mar 2021 06:48:31 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id l12sm11114681edb.39.2021.03.30.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:48:30 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] MAINTAINERS: Add entries for Owl reserved-memory and socinfo bindings
Date:   Tue, 30 Mar 2021 16:48:21 +0300
Message-Id: <883dd458759146eddee0d2a157f2a90fbb09d477.1617110420.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for the Actions Semi Owl reserved-memory and socinfo
bindings.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bea5ac8a5e47..48b7f7d097ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1533,6 +1533,8 @@ F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
+F:	Documentation/devicetree/bindings/reserved-memory/actions,owl-soc-serial.yaml
+F:	Documentation/devicetree/bindings/soc/actions/owl-socinfo.yaml
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 F:	arch/arm/boot/dts/owl-*
 F:	arch/arm/mach-actions/
-- 
2.31.1

