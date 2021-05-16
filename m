Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B05382039
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhEPRc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 13:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEPRcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 13:32:55 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607FBC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 10:31:40 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f18so3705102qko.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 10:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jZ8LOmff06oPPMAKh+a2jwE6y0ctqZ6V1VXFOR4SU0w=;
        b=UVVyfsvBXooBVNH5JuyXsbzu1D7n933coq3oC53JqIxd6tmmdmqRyFWxqyOXM6XR6w
         12KpGePCNG4lx2ZhnoACF4gHLgEOxeiiC4UaTBvC3CvkEH2QF/x8x/0MjNDI8e09HBtr
         3u3vm+CpRTYH7tQimi7hPEYZNzX+36rZo2cUDHuUqGmjif10filwv0wAGeBhjxN1WWhP
         dXDThqeDxngrKRoi040j4Bys18LFIYzD8/AB9e7FnVK1f/7Sh6YY+OR1HaMdT2QWp+wY
         xUoLigiysLE74nh12lL4E3XabsdZ3aOYjLFWaxIWUO5KfOT1rbq1Pr8vZBUJFQFEE5/8
         umkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jZ8LOmff06oPPMAKh+a2jwE6y0ctqZ6V1VXFOR4SU0w=;
        b=epVH5HfGYiRdYHc+d2+AKrsYsswQHO0xnmeMF4H0q+G0X5KFUWXtogJ5VK+ErxDhVu
         R5esEIbHXLvl0aTMQ7AQUZM1pHCBTnS1VZ8a5btVVujWf8Wgj7ZJRzEcwlpDCHwbSXny
         AxLBO3GrzfHiNMxuma9BhRN1d0XzY0dD3MHb/GWvPlXzqtMfIJH7RtCmNW/r+M4QUCiZ
         QA+04GBDN1AC33tljp5C+8eg2rei/b3MQDJcfIaEpJigssuDUAkoneor8uVmRd8Jne9S
         qsNBFS9Wp9zo0qvpdCIezfOFISlNuE+XfNO+GspG3WW7dXnS3Txn0O2URIDQgBWXJy/C
         2Y+w==
X-Gm-Message-State: AOAM530PuqedAdRKJk/17cSvYVZRYCNNaIDQ+x3gr6eh9INsJrnKFkqm
        vzmqxCWi5zGGcYDIsfGrd8lgW/4OA6F1OetRfTo=
X-Google-Smtp-Source: ABdhPJzkYHi0xkBNpfuJGhU5qaWfyPJAcIei0SZhQV69eer7522bZZIhPdUn7fY6aRBYl+UJYNRUCQ==
X-Received: by 2002:a37:a995:: with SMTP id s143mr51224554qke.414.1621186299470;
        Sun, 16 May 2021 10:31:39 -0700 (PDT)
Received: from yusupbadiev-17Z90N-R-AAC8U1 (ool-45788941.dyn.optonline.net. [69.120.137.65])
        by smtp.gmail.com with ESMTPSA id c185sm8849615qkg.96.2021.05.16.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 10:31:39 -0700 (PDT)
Date:   Sun, 16 May 2021 13:31:38 -0400
From:   Yusup Badiev <ybadiev@gmail.com>
To:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in commented code. Issue found by checkpatch
Message-ID: <20210516173138.GA586734@yusupbadiev-17Z90N-R-AAC8U1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the typo "Atleast" -> "At least" as checkpatch.pl warned

Signed-off-by: Yusup Badiev <ybadiev@gmail.com>
---
 drivers/staging/greybus/arche-apb-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index bbf3ba744fc4..45afa208d004 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -445,7 +445,7 @@ static int __maybe_unused arche_apb_ctrl_suspend(struct device *dev)
 static int __maybe_unused arche_apb_ctrl_resume(struct device *dev)
 {
 	/*
-	 * Atleast for ES2 we have to meet the delay requirement between
+	 * At least for ES2 we have to meet the delay requirement between
 	 * unipro switch and AP bridge init, depending on whether bridge is in
 	 * OFF state or standby state.
 	 *
-- 
2.25.1

