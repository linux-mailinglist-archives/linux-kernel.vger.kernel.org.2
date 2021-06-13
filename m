Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02E83A5947
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhFMPQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 11:16:21 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42929 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhFMPQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 11:16:19 -0400
Received: by mail-qk1-f202.google.com with SMTP id o14-20020a05620a0d4eb02903a5eee61155so3844347qkl.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TGzdE/APFAf/QMVTCv6KrvuvVJCn0wQ+q/HXZINXzWw=;
        b=TdETGPLOrdfX/voxN6D0z0R9BOc6lPsqTWQAO7iZBwfPPhUs++8SVMeICrH0N81BoR
         N2d2Z0+zvPp8zj8W2YWtnXA96JQu66axaQyVw1SJ32NoVwEMZ+x35u3tEVDThCeHv0wH
         ktu3TVENspFulSMLxqa+7TmdoOJJskLRWw9WwhspC8x5uvSfdYsnvO15Fnl05JXLPPnd
         h9uz9gYJOS8lTL1jDCmjiEc6qRjViLh9w/oXn7hu64XM01Vu3H1KODOnDzLUIVG0bL3i
         6ynNOMpB5fQyCyDvDAa+36GzMBX78tuoCjAzZIDuhhfhOKOl2qCY/S2uibYTwlZFabFd
         lm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TGzdE/APFAf/QMVTCv6KrvuvVJCn0wQ+q/HXZINXzWw=;
        b=WmAicnbpgxiyjpoGZo9tmQG3BN5peHcaTB4NzHny9a3q+MZkgRqz6W/29hHwYaY698
         7Sm7pyPp5+Um1q7Z8iGtxBXemnJcvAL7c1eyOVGA07zriBDm6ZHfa5G2S2C1UgvkSu5P
         XNZFH+V8M0/yDL3G7YkvMOvOwcLxjXyog4GAJEt+MaCuqUGMmPXvvDeKvtJQPFUEmKfj
         x4nvMVOvRp26wRDCs3qpYX8bvBqZTtLe/YuAo5+KIxuF6QVI05Xe/cyb8wEuZTYqyBPl
         KD1hNPq+KeUGxq5R5bkXaSbtt0kqxkh7jus7gioXYaARACsTTLZomZJ94ijCZQNroP5+
         4LOQ==
X-Gm-Message-State: AOAM5324nK2ZtyERnPFDjfuX/zC/nq+5X/kYTN3uOOf/k68gLohAxjlJ
        PL2P6+aj1+zm2zbfkymyq6W6g8gsVN+v
X-Google-Smtp-Source: ABdhPJxgQO9w7lIDehKWme31EnNi3PlaODRiweM4ZxMNnnlWK6NgFovfbb0R+FF1iTdEhNaqBIpU/Q4NpYLh
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:e9e4:90ce:a18b:7097])
 (user=kyletso job=sendgmr) by 2002:a05:6214:1cb:: with SMTP id
 c11mr2062240qvt.47.1623597188802; Sun, 13 Jun 2021 08:13:08 -0700 (PDT)
Date:   Sun, 13 Jun 2021 23:12:23 +0800
Message-Id: <20210613151223.563736-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] usb: typec: tcpm: Relax disconnect threshold during power negotiation
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the voltage is being decreased in power negotiation, the Source will
set the power supply to operate at the new voltage level before sending
PS_RDY. Relax the disconnect threshold for Sink after receiving Accept
Message to ensure the relaxed setting is enabled before the voltage
collapse. And the real threshold will be set after Sink receives PS_RDY
Message.

Fixes: f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
Cc: Badhri Jagan Sridharan <badhri@google.com>
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0db685d5d9c0..9f3f37da71b6 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2646,6 +2646,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
 			port->pps_data.active = false;
+			/* Voltage is going to be at new level. Relax the threshold here. */
+			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
@@ -2656,6 +2658,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			port->req_supply_voltage = port->pps_data.req_out_volt;
 			port->req_current_limit = port->pps_data.req_op_curr;
 			power_supply_changed(port->psy);
+			/* Voltage is going to be at new level. Relax the threshold here. */
+			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SOFT_RESET_SEND:
-- 
2.32.0.272.g935e593368-goog

