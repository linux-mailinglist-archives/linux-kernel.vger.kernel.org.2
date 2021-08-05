Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953F63E15CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbhHENgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhHENgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:36:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9546AC061765;
        Thu,  5 Aug 2021 06:36:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c24so7839624lfi.11;
        Thu, 05 Aug 2021 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30uracpthIuXSs44lu6RRxWBv7NJjXzBaQjU8TB5510=;
        b=M/nP1CM7xn+CZ7274z8465Yq2jf1/nVPXJZvFxFte+iStx8VnQzGCydzYwV9YZ3qy/
         gi1PXGbBbs5VP7TKvXrabWmLYmPeGBazgZwyQAYFHrELvuVr+pFw1pCo6EgU4ftFslUE
         ftS58qvHPqAbZB6Li/DVMVhdK7saB3qktcqvII94alvZpJD4MBWqyi79yTlXv8G1WH4q
         uG3zZ20UNTUFzyoymNHt8ocDr/X3LRpbCg3U4zrYMxzp9LORkhCZe3phYxq1Wf377x7Q
         SppvoPu7U/pBFw4MbqqqEVMvhm8I9OJPOu4bzzX7YnMPZmsu/c9yilWQhdXpdznDfHhw
         /HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30uracpthIuXSs44lu6RRxWBv7NJjXzBaQjU8TB5510=;
        b=eEa3eeHOoqbhkSI3+1csJDTqb5fU6/dJahK9PgIlMBtbUP6Jw39QtePwfs51ZxoV5m
         XFOl4C8347upDDDBLfvJ51k4OD/v+73qUdQYCP4V9epcPdFX1e7aWVjrSdSw5lZ6flwM
         VFBPmEvZOdGMv0FUNHtmyHG/vxN/xVxzD1EMGmGE/LuJC8CL9GZ3OSyJZb/IrbQXT+xL
         W845KhbPyOF0+rUiWbRr5qRg9wiOPIiLnndZagkLg+4I9Tf+iMF4NI1lXw7LNwYIrId5
         4tUW9ds9yfnJPVlPL3OrMoQpuKnibN+REOqxwqpcupOUQ4SnQgbjAiKqzdqhOAIw0get
         E4dA==
X-Gm-Message-State: AOAM531BrMYOXjEOkCZveMD6kTt7mWRRdmDmRStfy5pTGCVGnrLokTFH
        XM8b4Vo5FnBlaAdFHfLr7MSwUcn8FGmX1YOA
X-Google-Smtp-Source: ABdhPJw2fPHEeV+vd6pzesnCmhAxkmBbMI0INtbdI/2mGN2zSGItLyeYPaCet25Itf6BhkoHATeH+A==
X-Received: by 2002:a19:5202:: with SMTP id m2mr247398lfb.581.1628170566923;
        Thu, 05 Aug 2021 06:36:06 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id t3sm516232lfe.241.2021.08.05.06.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:36:06 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add support for Samsung S6D27A1 display panel
Date:   Thu,  5 Aug 2021 16:33:40 +0300
Message-Id: <20210805133343.27032-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YQmG6EbBherV+8px@ravnborg.org>
References: <YQmG6EbBherV+8px@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Samsung Mobile Displays(SMD) Samsung S6D27A1 panel.
This display panel is used on Samsung mobile devices such as
Samsung Galaxy Ace 2 (GT-I8160) also known as Codina.

Markuss Broks (2):
  drm/panel: Add DT bindings for Samsung S6D27A1 display panel
  drm/panel: s6d27a1: Add driver for Samsung S6D27A1 display panel

 .../display/panel/samsung,s6d27a1.yaml        |  97 ++++++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6d27a1.c | 323 ++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6d27a1.c

-- 
2.32.0

