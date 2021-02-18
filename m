Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4677D31F0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhBRUAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhBRTqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:46:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA15C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 11:45:25 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id y7so5596835lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WGzzHr1P0hoTz1sp9mRxfkrtsYLhqg7/e84iIOqYBhY=;
        b=COBNIMVcZRwLGfCuQE2beb/fdAs5Rp3wkO8/uY3cYKKJp1alKlWAJK8kIA6IP7cl5C
         umfGIsXMwzXMzZZFuJX2EjCWb4sGW+UCvmjDoCZ9onG7xBcvasTlJ1V9puUFS6ye5liA
         /chzvQ+DuoN8eaGME1JIhHlXAc7OpCdOQ9ip8qOKByNaNvZqS1x52FBRaNwzfXXmw3PH
         76rN0aQWDLItrChzu85x9W9uSkXzAo2HoTMQ5LlOX3wf2b7Vl+445ygrSN8Ea6XcSu7u
         yDneO7V9zSAppt2hUSeEf7jpBaak/NsIEbuyNMFXvXKEIAlATf/jCtovxYVb5QPwP9gU
         a7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WGzzHr1P0hoTz1sp9mRxfkrtsYLhqg7/e84iIOqYBhY=;
        b=uDFMFIM4IFR6/WElOE4T+AeTUfITvptSPIlYXQCL+4z1LU3yY7ABt+LeCtf9FGOcVM
         bwmDagVSC7uwo68iSf58I4ZIiUmkxU5eFhUwYXO8apjk4ctp5Enllt5RJTgog/i2P8al
         4D2R53R5EFapDEicRv4jYe2KszfFjwF6ZMq6d/koYX3NDhmFSBPHEbCzwRFSDa0wkCbp
         DoSCf5Pv4RgGe50iQrAqEUvNasdKS91Ntdft0H4H6jpX0Q4yMMhTvqQMDHw6dJ7R8FMS
         yc6NTmhCXFAhufP3yDxGcsnIoXkinNaQDdke+2jSv7hqshE2dEdwGOmBv41g1J1jj/Sq
         ucfQ==
X-Gm-Message-State: AOAM5338gjFT9VrVf2Wk/fYEjKC59KfoEat2O0SkTuXJCbxbjquix4NS
        tuDcqiO9Xd6k3trxXqh642F62oZPfaQUbA==
X-Google-Smtp-Source: ABdhPJydq5KMHFlkOjsoYUx6lv86iE1lsyuNoTnJ+RK3WJvjijVOdEtXtNZx+c8Aeu82JmwBpVL6sQ==
X-Received: by 2002:a05:6512:3194:: with SMTP id i20mr3292776lfe.283.1613677524163;
        Thu, 18 Feb 2021 11:45:24 -0800 (PST)
Received: from msi.localdomain (vmpool.ut.mephi.ru. [85.143.112.90])
        by smtp.gmail.com with ESMTPSA id e16sm683448ljn.105.2021.02.18.11.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 11:45:23 -0800 (PST)
From:   Nikolay Kyx <knv418@gmail.com>
To:     gregkh@linuxfoundation.org, adawesomeguy222@gmail.com,
        dinghao.liu@zju.edu.cn
Cc:     Nikolay Kyx <knv418@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fwserial: match alignment with open parenthesis
Date:   Thu, 18 Feb 2021 22:43:33 +0300
Message-Id: <20210218194333.7115-1-knv418@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwserial.c:

fix CHECK: Alignment should match open parenthesis

Signed-off-by: Nikolay Kyx <knv418@gmail.com>
---
 drivers/staging/fwserial/fwserial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index c368082aae1a..137e97c9406c 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1318,8 +1318,8 @@ static int fwtty_break_ctl(struct tty_struct *tty, int state)
 	if (state == -1) {
 		set_bit(STOP_TX, &port->flags);
 		ret = wait_event_interruptible_timeout(port->wait_tx,
-					       !test_bit(IN_TX, &port->flags),
-					       10);
+						       !test_bit(IN_TX, &port->flags),
+						       10);
 		if (ret == 0 || ret == -ERESTARTSYS) {
 			clear_bit(STOP_TX, &port->flags);
 			fwtty_restart_tx(port);
-- 
2.30.1

