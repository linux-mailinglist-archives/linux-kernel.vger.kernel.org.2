Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025F4338AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhCLK4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhCLKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73276C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:40 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e9so1517579wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2upXzLPWVLGRwG0458fGKMH0wzW7zeYu4SHHuwM9k4=;
        b=qnmSZDmaTXegmiqZpDi4s1t/1ZjZBLNoJ77NVtDc4tz6lLgtq9aNxhP9OLRGfQX25/
         fyPMHBbhR0aQZUhTpjDNfJSyVUG5YPVieXrYdfJt5saetIwsP0jpZWqrox9h7Qx6jdLM
         KseuLgzmUH4x2OBMgclQp/KtxrKONLfnF/qp6almy6emiwfJr9OXegUGI9IpmDclA9A9
         i587SxFjTcq8/b/xj9WoscWR7ZwClHToKBHOGaoCLIrfTyKud3KSVwfGuZDSUh/sK0yg
         OE84eXyy90QcvFKGErYTD1jZ1sba1wcdxvqOVgCMB+H+SzN8RJgmGbbqFT/Q5Itl6Fxe
         XKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2upXzLPWVLGRwG0458fGKMH0wzW7zeYu4SHHuwM9k4=;
        b=ZgQuRVXu8XDo7IIlvMmjtAPJMPpo8bFO4Ts5kqGrxgVFGFiCgih2HYM9XJLWQmiegS
         n0DMx4S+1/qm5bYW94aqWNn59D8llsYHgjCxcCFjI3klyAzeRFOjGdsi2BBBvOb/B/h4
         5UZrwKywYvXf5N3I/aloNpG9jPwUlvLqRGoEE3xuKpoHPQHXUZnF72OcYx/bS3o/j5vt
         22zAaa77luG1U41yrtRgk7KdwuS5+9bkb1g/yP0tfYOyoPzADbeIixtb7w+zJ2Mt3gXG
         pB1udCVrcwlmjmHuppW2ViCF9hg5NUWILEc3NwsK8qIHiTUMLFD8VDCC7w+pI2nwNpPe
         4pOg==
X-Gm-Message-State: AOAM532Wq/mfq69GYxaHa2KKHF6im8E6jlalL/nLxnA8SksROBKJp4qa
        WHU2b5h6KTjIHzarLXbajtvCwg==
X-Google-Smtp-Source: ABdhPJyskrfqJ/c4QwfqtJ+2rayWd9noi5nBNi8HA7AQIB7lsqXTyBYCnN4toqJQFQUuztuv46l2Zw==
X-Received: by 2002:adf:c54a:: with SMTP id s10mr13707663wrf.58.1615546539220;
        Fri, 12 Mar 2021 02:55:39 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH 04/11] block: drbd: drbd_state: Fix some function documentation issues
Date:   Fri, 12 Mar 2021 10:55:23 +0000
Message-Id: <20210312105530.2219008-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/block/drbd/drbd_state.c:913: warning: Function parameter or member 'connection' not described in 'is_valid_soft_transition'
 drivers/block/drbd/drbd_state.c:913: warning: Excess function parameter 'device' description in 'is_valid_soft_transition'
 drivers/block/drbd/drbd_state.c:1054: warning: Function parameter or member 'warn' not described in 'sanitize_state'
 drivers/block/drbd/drbd_state.c:1054: warning: Excess function parameter 'warn_sync_abort' description in 'sanitize_state'
 drivers/block/drbd/drbd_state.c:1703: warning: Function parameter or member 'state_change' not described in 'after_state_ch'

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_state.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index 0067d328f0b56..b8a27818ab3f8 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -904,9 +904,9 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
  * is_valid_soft_transition() - Returns an SS_ error code if the state transition is not possible
  * This function limits state transitions that may be declined by DRBD. I.e.
  * user requests (aka soft transitions).
- * @device:	DRBD device.
- * @ns:		new state.
  * @os:		old state.
+ * @ns:		new state.
+ * @connection:  DRBD connection.
  */
 static enum drbd_state_rv
 is_valid_soft_transition(union drbd_state os, union drbd_state ns, struct drbd_connection *connection)
@@ -1044,7 +1044,7 @@ static void print_sanitize_warnings(struct drbd_device *device, enum sanitize_st
  * @device:	DRBD device.
  * @os:		old state.
  * @ns:		new state.
- * @warn_sync_abort:
+ * @warn:	placeholder for returned state warning.
  *
  * When we loose connection, we have to set the state of the peers disk (pdsk)
  * to D_UNKNOWN. This rule and many more along those lines are in this function.
@@ -1696,6 +1696,7 @@ static bool lost_contact_to_peer_data(enum drbd_disk_state os, enum drbd_disk_st
  * @os:		old state.
  * @ns:		new state.
  * @flags:	Flags
+ * @state_change: state change to broadcast
  */
 static void after_state_ch(struct drbd_device *device, union drbd_state os,
 			   union drbd_state ns, enum chg_state_flags flags,
-- 
2.27.0

