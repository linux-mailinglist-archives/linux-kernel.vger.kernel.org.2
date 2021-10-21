Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602A6436CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhJUVhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhJUVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:37:15 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7261C061764;
        Thu, 21 Oct 2021 14:34:58 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id c29-20020a4ad21d000000b002b6cf3f9aceso521830oos.13;
        Thu, 21 Oct 2021 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pTwNmZooOeOdog1xCjDMl0qLSkOmdnMEB9kSUbzvyVs=;
        b=MRnKxjV2S5VmP3MI6tkI7zr9Azux0Rd/L85aFA6X0wUy+9ZtuHirQ72Ha8mPPLV6jF
         gX9Qnli2J+I2jtuv5EWT5fh8EB3OUSM4ZwE2NpnbXdI+L4PsDbkTMycEuJfnbQ2qmLdC
         Pc3cKHElfP+qJhmBBmtGRxWOK69LSNRzXfM3n0pCgoDpmlGSw/0l01/Krq3KgO3TqGMi
         IOgxIgts5EOSKRbRnacceTtAVKDEHkq9WhpZEommGBON352orr/HFQM2+lxRFLkZcDhL
         nsnWppvCWtIDV8CiwOEWpstzk0OVVrRLKTseuglUzwnGdoXL3OC5ogl2gzqmdbSyFQpa
         g2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pTwNmZooOeOdog1xCjDMl0qLSkOmdnMEB9kSUbzvyVs=;
        b=U+37mPbpH83FogcTcNbi5OtoxHML/TCHu8VCSjOOqEbB5eZxf3duHXw08XiZuMvjcN
         sEC4DUVGZtyxavLIC0xHvUuo6HxaRApsBwDvu6UQgRoiQtclIXp0HhZGk7OCCXXr/b0D
         6UKdoBRdZGcs1jsl5Uv6SBjkHx8Z26Rf0/LOylMDRJ4C2Vkk4bfiJfmeKTJbKqqsZKr4
         Ov0UjRjXSOf3EWgcxrWpYQVRa9bd4ypg39TcbgDDDq9Ovd9YkwZ1714dZICQblKklKv0
         shuuGVs9hxCyl0355w6oYLPes+ybMGGIL2FFhFmcMPren2cNwfdn2f5XXG+lPhGvrRzg
         GCag==
X-Gm-Message-State: AOAM533wXgQs8BANJAzTWXQ3OqWg7Xsg/ALoeq282X3CUTgF8isHbdkQ
        IXSwNVhvSWmu+111lK0jasU=
X-Google-Smtp-Source: ABdhPJwfTPpBcCCoB6iF70POe8qmJ1hWZFW1k43lF3cwrrSfvNcY6maKSjUXRG+WJEYFiMzL466hNA==
X-Received: by 2002:a4a:a34d:: with SMTP id u13mr6185244ool.53.1634852097915;
        Thu, 21 Oct 2021 14:34:57 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-172-188-255.mycingular.net. [166.172.188.255])
        by smtp.gmail.com with ESMTPSA id o42sm1152386ooi.9.2021.10.21.14.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 14:34:57 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     sam@ravnborg.org, thierry.reding@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH RESEND v2 1/2] dt-bindings: panel-simple-dsi: add Tianma TL057FVXP01
Date:   Thu, 21 Oct 2021 17:34:44 -0400
Message-Id: <20211021213445.17289-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the bindings for the Tianma TL057FVXP01 DSI panel,
found on the Motorola Moto G6.

v2:
Fixed accidental whitespace deletion.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index fbd71669248f..92a702d141e1 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -55,6 +55,8 @@ properties:
       - samsung,sofef00
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
+        # Tianma Micro-electronics TL057FVXP01 5.7" 2160x1080 LCD panel
+      - tianma,tl057fvxp01

   reg:
     maxItems: 1
--
2.30.2
