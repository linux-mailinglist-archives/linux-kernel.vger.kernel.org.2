Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29DE438EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 07:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhJYFMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 01:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhJYFMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 01:12:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5DCC061764;
        Sun, 24 Oct 2021 22:09:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e4so10470585wrc.7;
        Sun, 24 Oct 2021 22:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e33cFBOzoJJnu+QuhW9z/Ktfqeqk4oyAu7uMrGtMqZY=;
        b=TgUa0vL9aNRUteLxgIr0I4C/MZLmDNW58yWC/lNuvNTQEI0xsYsFCC4aNh/UjdH7Y2
         uLp7HSvmuZPjXxHBV7WNCitmIEun4xLEMECob/7zuv7720aDGT9sPNwhdyxP26p/YtFk
         g/a05A10M0a0psfwBygHGP2NcPjivzH6/S9eehB66fyLnJlTD0IM2zCYH/rZs5mQUvl9
         cmSuiC1wccMYwDAXJ9hrivuipVlNbChSGIfh8FabII+b+SQvixDRoigc7zbMyF+p4lea
         lVxTVtAdvCy69QPj0/HDz7PRLkoiGfqRMrPaLLci6eeXYPjHCvg2gexAAvzBoFQjv0Yt
         wq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e33cFBOzoJJnu+QuhW9z/Ktfqeqk4oyAu7uMrGtMqZY=;
        b=keR+d37aqWcxXDpz9HZ8zycRQVaE8wnAnJwIMghwnx2YsCckEQUtrsYv5a0eW1meRB
         YrfpPC6AJ/Qt7cx1/Dqs4KyJmpE4c8sboSnSrRu7j2rz6PdAiVkDwoUZADh1/rJvHxtF
         J71EoXqbl+1s8292qKH7MF1ImtigzI9me/nUCzMeoSPtQYjmus+qFCQr7KHHfGROiTB6
         Enlzd97QKxvXQEMx/TTXyL5MC1iclYAy3SyvoRXxGZkbKW4/8qFRvSTvM3cyLZRVQes5
         8Uk83Ntner4f8K3SdlKiDYP1SMBVx8YOVxN5zg8tXOrSV+mm0wB1mT+ZK2pixvYVkpTp
         GziA==
X-Gm-Message-State: AOAM530jRNB1q3BNrvuX1RsX8ILmmgH/jJMwg5SKoLzo/eX0eydh/6/S
        KipdTUhW67c55khfKn5k9SrUEXiMgtU=
X-Google-Smtp-Source: ABdhPJy2XwvxxbsM/WsD+PFFAlvFMpLU1VSoZ2+r1KcO8Rw5FKWBoRKTw4SSojyFj7r8cesJcg817Q==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr7190814wri.41.1635138597222;
        Sun, 24 Oct 2021 22:09:57 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06658ca10b404d232775.dip0.t-ipconnect.de. [2003:c7:8f4e:665:8ca1:b40:4d23:2775])
        by smtp.gmail.com with ESMTPSA id j7sm19076095wmq.32.2021.10.24.22.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 22:09:56 -0700 (PDT)
Date:   Mon, 25 Oct 2021 07:09:55 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 2/2] Docs: usb: remove :c:func: for usb_register and
 usb_deregister
Message-ID: <0ace789dfbe2d4562c27d374afa5ff078efe2261.1635138058.git.philipp.g.hortmann@gmail.com>
References: <cover.1635138058.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635138058.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove :c:func: for usb_register and usb_deregister

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index a511c6fecf96..e09dac9e2cb6 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -84,7 +84,7 @@ this user-space interaction. The skeleton driver needs this kind of
 interface, so it provides a minor starting number and a pointer to its
 :c:type:`file_operations` functions.
 
-The USB driver is then registered with a call to :c:func:`usb_register`,
+The USB driver is then registered with a call to usb_register(),
 usually in the driver's init function, as shown here::
 
     static int __init usb_skel_init(void)
@@ -105,7 +105,7 @@ usually in the driver's init function, as shown here::
 
 
 When the driver is unloaded from the system, it needs to deregister
-itself with the USB subsystem. This is done with the :c:func:`usb_deregister`
+itself with the USB subsystem. This is done with usb_deregister()
 function::
 
     static void __exit usb_skel_exit(void)
-- 
2.25.1

