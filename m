Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD9C31E991
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhBRMJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhBRKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:38:42 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 02:28:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k22so1009900pll.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 02:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Y+cLMPGA1ovWbd6aZihF/dFMXZT41mz8HPHEusHOvRE=;
        b=nJcr/LSt0ixdNwqvQgze/hwDVq66IFQJomqsDqUvLovainOKHIdoapFNhkMpp38gmR
         st9HlD2OoGMhHlVSEuaRJ4BOoHm1pUThRRKW1aUpDUbySFhO+AAAdcjKv+sqKysMREI6
         Tycda8CKlbHeHsmhiCW1ARzMimX7d9ifUiozXYW0OJ3NLLGQP2uVwasMM88q8joF0+yz
         +HXB8V1ZDcDsuLxedxVTKaHVUW3eDpA/mJ5uuoeaCbBraZovrnnq+mbJgEP7ANmEzbBV
         QdpgDwJbbXBmLuwMeE2AumRqif86Bp3swM6XZmLL9vpqv3JtL7I0Xwl0bVW+wGuYz3xm
         A1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Y+cLMPGA1ovWbd6aZihF/dFMXZT41mz8HPHEusHOvRE=;
        b=PCqWKiB0NgyEML+jN8MRpqfYlB4l2EFgiWdOyA6kMPWF/VJtXpgoMXyBJ/tlrd1Ivx
         q6mN9Qv2TGU/9DaZrWp8TLiLoJLbHi87GVBfxvoyAhTKxzr9Qt4dfxRO8b7n2JI7bp1x
         ZTcncywvNj8IVi/JoCfEYKTEJevlfNM6vgkSPzMsYZ7ZE3vDlBohjUWxvGuk5MMFv0rL
         No5nSeLh0FfyB7h0p1f7n7FdW+I22/9sV173bFW3+rxS4xAZCxlxakN71N30PzThLRf0
         yVZxLSbMcP1WUh+Mng0SvaEOIowKax+dV+XGy/PZsIUY2ifmbWNeMRIihpco58P39ii4
         B06g==
X-Gm-Message-State: AOAM531b0JF3EzzB+bA3gZ5qBawqeF3Y22Ji7X+0CP/N582kF95hkN7T
        x0kHntjiDCZt2nap2SEQU1I=
X-Google-Smtp-Source: ABdhPJyXFfWod8W9CGiCjVEvPDlmUemJyL0QZwm6apZ+Rs2UVDm96wFBZFmM+oxIwbAC9Ytio/3DqA==
X-Received: by 2002:a17:902:7b89:b029:e1:1b46:bcec with SMTP id w9-20020a1709027b89b02900e11b46bcecmr3641890pll.5.1613644137152;
        Thu, 18 Feb 2021 02:28:57 -0800 (PST)
Received: from gmail.com ([2401:4900:3847:831e:5f3:b644:ce80:c8ab])
        by smtp.gmail.com with ESMTPSA id g68sm6271235pfb.29.2021.02.18.02.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:28:56 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:58:51 +0530
From:   Prakash Dubey <prakashdubey1999@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fwserial: Fix alignment of function parameters
Message-ID: <20210218102851.GA20810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl check:

CHECK: Alignment should match open parenthesis

Signed-off-by: Prakash Dubey <prakashdubey1999@gmail.com>
---
 drivers/staging/fwserial/fwserial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index c368082aae1a..a92741b8b6c6 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1318,8 +1318,8 @@ static int fwtty_break_ctl(struct tty_struct *tty, int state)
 	if (state == -1) {
 		set_bit(STOP_TX, &port->flags);
 		ret = wait_event_interruptible_timeout(port->wait_tx,
-					       !test_bit(IN_TX, &port->flags),
-					       10);
+							!test_bit(IN_TX, &port->flags),
+							10);
 		if (ret == 0 || ret == -ERESTARTSYS) {
 			clear_bit(STOP_TX, &port->flags);
 			fwtty_restart_tx(port);
-- 
2.25.1

