Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730113DC728
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 19:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhGaRSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhGaRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 13:18:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F24C06175F;
        Sat, 31 Jul 2021 10:18:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k4so4875950wrc.0;
        Sat, 31 Jul 2021 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TYAR2TN+HLCEo0IKM3gk6gNN7p0qbP1mcajdWTzCkkY=;
        b=M52/iticaY8knwq6V+LuB99CyidPAlzmvQfhb8aOvzqHW7LGjltktcTpGSBpcgpAtv
         aRqCuVZxgRY+DIOV5aVcTrn8ojoXt3/3+ERV2QTd4y62aCoyellhOEJzSlYphSs8fX9m
         +Fho4SANqRyMU1uUZ09305tU1Fnl5CG37lPS15Mxz2vv8F1gDGq9OU00IHQCq6V7aoJd
         KLSGbWvIBiRcYI6ORBNh4iZvi19zKieMZ/RQC4q3hLNyOFCtrC+nxAiePGCYWdWG4tHO
         pRKg1KEhxb2s4EJzXTolT/0wN46eCmqfsNGN94FgOpHRyf2KblSIX/Lsoxz1ZNFhCnW9
         1GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TYAR2TN+HLCEo0IKM3gk6gNN7p0qbP1mcajdWTzCkkY=;
        b=AgUzJaqgvi156J0FxDMZo1xezvvSsyyPPAIhKRaNasDgQPRRDYHCtZa2kJuBOyd+Cv
         hJVhAzihBiMCFwMTLmTo/Ep1EmDATadoQ3xuYIns09sOBKsRvMjw06UD31vCGESMg+71
         bk9GVQohfUHRJetZ98Jjo/iXE9gaamyIPrhcXWymyaq4ksS0zH+xM6cQ00+N6AogMYq0
         f3v12cUI9NXnM5S/EXqhs1pL0BmnsSfnn1CUxZQ93tnGgH1ijOv9mVB+GxYPlTBAwBPO
         zEVJfbClumJKq7hsrvO5dCEG/hDGVVgNpV+J0L2Z0YkEwfaDJZbRG9KhPlUfzkIw+on4
         QCwg==
X-Gm-Message-State: AOAM5333GDevt+Ygcep0UcbsKO6NzHTnalgRHCdFVF1jyXNIZojnv4/P
        vJKV196aR6w/s6JsRXvO448=
X-Google-Smtp-Source: ABdhPJyR1F4x3H45pg0po8H4tQtOMk0FvgFyxWTrukbMTvdYsD1NEAAJH8WrPAQ2C4QTCzuUSfIdXQ==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr8868165wrt.227.1627751922345;
        Sat, 31 Jul 2021 10:18:42 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id m39sm4971255wms.28.2021.07.31.10.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:18:41 -0700 (PDT)
Date:   Sat, 31 Jul 2021 18:18:38 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>,
        Jack Pham <jackp@codeaurora.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dean Anderson <dean@sensoray.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Vamsi Krishna Samavedam <vskrishn@codeaurora.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: remove useless cast
Message-ID: <20210731171838.GA912463@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the cast done by ERR_PTR() and PTR_ERR() since data is of type char
* and fss_prepare_buffer() should returns a value of this type.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 9c0c393abb39..e411555e4c34 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3831,7 +3831,7 @@ static char *ffs_prepare_buffer(const char __user *buf, size_t len)
 
 	data = memdup_user(buf, len);
 	if (IS_ERR(data))
-		return ERR_PTR(PTR_ERR(data));
+		return data;
 
 	pr_vdebug("Buffer from user space:\n");
 	ffs_dump_mem("", data, len);
-- 
2.25.1

