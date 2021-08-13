Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55D3EAFF3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhHMGTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhHMGTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:19:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5869CC061756;
        Thu, 12 Aug 2021 23:19:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j1so13842152pjv.3;
        Thu, 12 Aug 2021 23:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4kXF8rjOaeUla0M3rXpxWrQcPuqS5qE0SGdfEVWI3rM=;
        b=uZvcZZqIFNj0oDqsoh2+Z3ZzkR7lRij4WGZUrHX0lYsxzbb4EBVP8bKG0BiC8ygjq1
         Adp+InWlnHZS6RdBUnehs469ZSr5pudW7hxw7lamtm0TUcs3OrFTVy3fsAzYNd9FXKQ/
         M56bfvRMRULEu9HhXdtfaY4E/ajsWLcwRlBRcclajQB3iOkCo2aMT+p08YeSwpUkBSYx
         VYA6on8qRoL+ovuErmO+p0+jBxp0Sh4Gqsqec7DOhp9XOMB/dIDOx543fib9cjADRvmm
         33re47tEnRLsqYEqaWbD8iWsqzAR+b+IBRbZwJSss3u5VFzSC/3l9WXWFhm47OWE8vmE
         7veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4kXF8rjOaeUla0M3rXpxWrQcPuqS5qE0SGdfEVWI3rM=;
        b=HMZiLf76I6fxQYJuhaOYmKzHCY9mvESqFRmU8zdLuJX/WHc6rzOr3JK/Cgfu91rtKM
         044feuukentnhggwM5KjfIJWBbdF2/AgLdBEKNa4Y96IqAhXjpwaAVPngYOqELN6rA0A
         SsHoVOhX2tr93IilaQby1c0B9DRq77HKp7JJ5mE1KmQ8eOV2gsGpyntzjc1cOJXFe107
         tmrEcsROL83+prfErAi6wvOCe9OwwVIfa0fiv/7x0R/Q8Q1QLjTaukUnX8BdP4kQGf/7
         PQ5ledwmejeEF5CGEFU8Mv/W/uIg7PqAruY7yaVEhovj6U2w0eUxQHLN7Vw4JpC6b7Xr
         tVaQ==
X-Gm-Message-State: AOAM532EEI4mW2nSP3XKW6yaA+x+LxMGZo9L8x66lgXJ5+q2On22gX2R
        iS6RaivSeXv6GTft43f7nhs=
X-Google-Smtp-Source: ABdhPJxH82ZJV9xD4x1exd/C7JijJWwsA0z4BAdmdDdiEerjGXqcQmOLUV7Y6pZUmASz/wyXv71Q9g==
X-Received: by 2002:aa7:870e:0:b029:3c2:f326:468b with SMTP id b14-20020aa7870e0000b02903c2f326468bmr999709pfo.53.1628835549694;
        Thu, 12 Aug 2021 23:19:09 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-92-48-112.hsd1.ca.comcast.net. [73.92.48.112])
        by smtp.gmail.com with ESMTPSA id f9sm733196pjq.36.2021.08.12.23.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 23:19:09 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: cloudripper: Add comments for "mdio1"
Date:   Thu, 12 Aug 2021 23:19:00 -0700
Message-Id: <20210813061900.24539-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add some comments to explain the purpose of "mdio1" controller: it's
connected to the MDC/MDIO interface of the on-board management switch.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
index 01ec3ce0a29d..9c6271a17ae8 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
@@ -96,6 +96,11 @@
 	status = "okay";
 };
 
+/*
+ * "mdio1" is connected to the MDC/MDIO interface of the on-board
+ * management switch (whose ports are connected to BMC, Host and front
+ * panel ethernet port).
+ */
 &mdio1 {
 	status = "okay";
 };
-- 
2.17.1

