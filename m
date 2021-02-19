Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8BC31F79F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBSKwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSKv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:51:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597B3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:51:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l18so3920503pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KpqDPrrwgSpJ0Jz+q1yA1PKOl7u983OV0CZZHBiD6uA=;
        b=CgaPuwcsXSa3rYSPFg4xNH+VojfgUAuQjRTWg61bCDiC8tt2m7Q55lE6n19K8Q2Ztv
         JExIG99WunwTL/AOkcDgFHty33pC59ZQcQiuEIuXWsntZH/uoLR39FGOFhMiXS8TdF8R
         R8V4rrtzmfMme0oKfNP9xvBQE5ObBRFzw2ngKIVNyj7q2rgP+nUOy/0cCFpqABjc+t36
         MluUoZTWGh4m3/HoeF5Tuw8+q3hHz5RuUwytOtFDglNi2XfMYluxyfu35UYEFmyOebtp
         mNmQWZlyvmcCW3Gmy64i93ClDPQ4v8vUmEk3s8mUsg4fjrI7TKTq6FPcxAvVl9Ldb5Z9
         dedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KpqDPrrwgSpJ0Jz+q1yA1PKOl7u983OV0CZZHBiD6uA=;
        b=PqWW3Bh0Vjb0HXQUMLim5P6mgPXu/Iit3tK1rcvsug0LXwl9M7gx28NgiGZDKK+ZHk
         XQfO05ARENZYRWrIubbDPymCIHb9ebEDwHVngk2zQyAznnIoH8tw1WYSg8y1k6Q1ZMg/
         fu7TR6pIqZF5taD3pgD940rox/LaF9Ly3VIo5ESsXUAo5mdR51gY+HV37Uvik5bbdG6x
         gBw7ybmUDGFr+zWCAOauKCHiEnMvfVhtJqNOti7+aFAhChQ245H0Od6479ZgPqrY226m
         dA6Imhav9WSBFLVWTJ+MQIyHD/cGvhwFh3Z2nAb+ydkUk/K0leGAXjZ8DWyBW0WKNzG2
         l79A==
X-Gm-Message-State: AOAM531upo3549ss88fq54hYfnTTI/jC53+k6UH7L7Ib0kx6AY77/iBy
        iNgOo7fuGRnnPTQWR1nh4nk=
X-Google-Smtp-Source: ABdhPJz0g9Cc0Ya0mhA5JNyXWod/f5fmyAfNmJgO5GgK+0zMBgx/qng58tTr0JUlNAYHhmJ0CKSI4g==
X-Received: by 2002:a17:90b:33c4:: with SMTP id lk4mr8997503pjb.157.1613731877797;
        Fri, 19 Feb 2021 02:51:17 -0800 (PST)
Received: from gmail.com ([2401:4900:3847:831e:690e:964b:81e9:e810])
        by smtp.gmail.com with ESMTPSA id i7sm8233633pjs.1.2021.02.19.02.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 02:51:17 -0800 (PST)
Date:   Fri, 19 Feb 2021 16:21:12 +0530
From:   Prakash Dubey <prakashdubey1999@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: fwserial: fix alignment of function parameters
Message-ID: <20210219105112.GA8315@gmail.com>
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
index a92741b8b6c6..137e97c9406c 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1318,8 +1318,8 @@ static int fwtty_break_ctl(struct tty_struct *tty, int state)
 	if (state == -1) {
 		set_bit(STOP_TX, &port->flags);
 		ret = wait_event_interruptible_timeout(port->wait_tx,
-							!test_bit(IN_TX, &port->flags),
-							10);
+						       !test_bit(IN_TX, &port->flags),
+						       10);
 		if (ret == 0 || ret == -ERESTARTSYS) {
 			clear_bit(STOP_TX, &port->flags);
 			fwtty_restart_tx(port);
-- 
2.25.1

