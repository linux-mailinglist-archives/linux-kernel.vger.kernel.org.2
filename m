Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC534C2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhC2FRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhC2FQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:16:52 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AE6C061574;
        Sun, 28 Mar 2021 22:16:52 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id q9so5905012qvm.6;
        Sun, 28 Mar 2021 22:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6g+lgLBSDX6TD/T6Z84lMITA6ycCwCQ9sjXvqkoHkaU=;
        b=qeJfZUD3Qvxi9jy39JQmbXif4CGrf35Dy53578/XM7ztPIxdiz/GMrpFP0O1mapHlL
         ZsQNtWYetBkvPn0WxjdVsUghLTQjmuenvBU9GtJXuu4JD9Zyb23rcuXqJegCu3j7R6h7
         9Qtg2gT5fORIsWInNktgNw4iTX/Zp/jgoj9NT1zWlndYFqzHc6U0VwyNgehGT4EiNQNE
         Y3+y9/V7RYnUrjeQIH9IZlksJZyQQnuhTJ+BTrDO3ruzP4c5tu/CLf34ysg5qZ+0/gwy
         RoXlr7NcrXslvbTH9aMaxCMYD53cTuXv5UMFFUht6jnx169BTZbzqvmSw4jYyHuldezR
         HejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6g+lgLBSDX6TD/T6Z84lMITA6ycCwCQ9sjXvqkoHkaU=;
        b=COYOUujllKwqDBivSuQ/Gjw/qGAHrAzRRnudlKOvZahLU88j6RTICH0Y+tcfSWLxf7
         tSuZ56jss428HzfiE/hWdWVFiUCORNM4NrOgbaICEJctRbqh5q1M/Kbp1h7t3gLf9xI0
         A4qn1hh0IcDEqbEEgHPIXcKJdCi7dJpkmXmdpflanQ4/aEruK4Ovk1VcD3iZPWyq/gaC
         5BpGTBTfGGSbxcc4qgpBWkeiaihZTLr+nVn1jSvaq6GBlndSbxtqkjoN7tV1y65/zEmh
         OJidwIwsLqsqpXqo9DtG7U78jSzRLPeghe9VEfC44Ap8awCQW++jvnfu++ZQp0qhhX3u
         Ma7w==
X-Gm-Message-State: AOAM531fG6Pi9OUoycEcPg8NlCQ5u3OuIMxANMZN7lzEgrmcHxOTlGud
        IIv+eV9dfJf5im9zRoXIF4g=
X-Google-Smtp-Source: ABdhPJzv3X6nHOkOXiP7iEOiKZsVdwqvEWOvk9wVBoqP+sEV++J4MV2dCZPSp5s7ziq9zSi1Ge4Wug==
X-Received: by 2002:a0c:a954:: with SMTP id z20mr23840330qva.29.1616995011623;
        Sun, 28 Mar 2021 22:16:51 -0700 (PDT)
Received: from localhost.localdomain ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id z124sm12993181qke.36.2021.03.28.22.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:16:51 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/23] openrisc: openrisc_port.rst: Fix a typo
Date:   Mon, 29 Mar 2021 10:42:59 +0530
Message-Id: <3f294d0860973889e0e7826b86a8779d4834fb6e.1616992679.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616992679.git.unixbhaskar@gmail.com>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/enhancments/enhancements/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/openrisc/openrisc_port.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
index 657ac4af7be6..b3c6c5e258b0 100644
--- a/Documentation/openrisc/openrisc_port.rst
+++ b/Documentation/openrisc/openrisc_port.rst
@@ -114,7 +114,7 @@ History
 	port to 2.6.x

 30-11-2004	Matjaz Breskvar (phoenix@bsemi.com)
-	lots of bugfixes and enhancments.
+	lots of bugfixes and enhancements.
 	added opencores framebuffer driver.

 09-10-2010    Jonas Bonn (jonas@southpole.se)
--
2.26.3

