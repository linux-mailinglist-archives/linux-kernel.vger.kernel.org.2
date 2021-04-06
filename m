Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94268354A2E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbhDFBhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243154AbhDFBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:37:01 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3D6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 18:36:51 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id b127so11603388qkf.19
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 18:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dbfWdEk71d05wtMOYO5VWpygVVGycsBdaqIVkRurjJc=;
        b=BAR7OUZd+mvxcCgi62qFqE3hsFcuoajIGcUCbtLVdtm0ia9XwnG2iSJ4mqSzP2imNB
         KxS2ecs1JFxg4JpD7enCGtfQcIkuLy11rPzZdtqUB78s/m8qTWZKN0KbZJZJduGzu8f3
         YMxspCQKPFtKuzyKAlplz8nUzlhPCQnmc9/Ca5+MKFJiYniKqT4FpMNqD5bEawHw6tgd
         DE/R3snltXNS+pLo0v4ckbpSnSToyYrTT6jIl23Zplo8mt/ko6LG8PPsqFkcr6X0trP9
         ZVJV/oHLlzp76934NbnUcns9UQBlRn31cvUk7Kg6ly8vJbBrSpu7iZjT8dKuD/EP27Pu
         kMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dbfWdEk71d05wtMOYO5VWpygVVGycsBdaqIVkRurjJc=;
        b=nKMl+T+Q6YyI5HTJE3NmJ8fJyKWFZnflz/MO/l/48E72LQ4ziW0sPDGbxqbBlP5zzG
         JQf+589tsYzUCKpLobvtqyBtYxiMp7E0gy0qd0WJq+6enn/edrd/beyXmAGMUJ2QICw9
         JRGl3of/eE5dS1zYo+nM1bJuTlBvjrNurR1F/QUi60LANOpAhRstOOzgtbrMtkoIwUyp
         SiqNqs0e1WVLPwnTDevuolSlbvKxhjxHeQe9Lhc5pfuSu62GLAc83Vkg4BXzhXgvDeTR
         b/vLMlu1v/LC05hXHsNsOAW+Uzj6IsGKgFAgC8yZXhWi4la7jTnYJrWCpuUWGSHQs693
         aOIA==
X-Gm-Message-State: AOAM530TD+TK0bOC6cTgW7qs0SyWXbpwgW/GUjDXzDwzzNIDRc1SNTeA
        Lr+DXsG4RuyliFHbXDnpL7XbT/bPfWA=
X-Google-Smtp-Source: ABdhPJwidgs6gNWKYh3z73bewgYbt8o1NELjeHncKpV3YbEPHhJiHtXI8JM7mjC3RNplE0UQ9gK0zGFbRgA=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:7080:32f9:cd15:6178])
 (user=badhri job=sendgmr) by 2002:a05:6214:2b0d:: with SMTP id
 jx13mr15014039qvb.25.1617673010339; Mon, 05 Apr 2021 18:36:50 -0700 (PDT)
Date:   Mon,  5 Apr 2021 18:36:38 -0700
In-Reply-To: <20210406013643.3280369-1-badhri@google.com>
Message-Id: <20210406013643.3280369-2-badhri@google.com>
Mime-Version: 1.0
References: <20210406013643.3280369-1-badhri@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v1 1/6] usb: typec: tcpm: Address incorrect values of tcpm psy
 for fixed supply
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcpm_pd_build_request overwrites current_limit and supply_voltage
even before port partner accepts the requests. This leaves stale
values in current_limit and supply_voltage that get exported by
"tcpm-source-psy-". Solving this problem by caching the request
values of current limit/supply voltage in req_current_limit
and req_supply_voltage. current_limit/supply_voltage gets updated
once the port partner accepts the request.

Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through power_supply")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index ca1fc77697fc..03eca5061132 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -389,7 +389,10 @@ struct tcpm_port {
 	unsigned int operating_snk_mw;
 	bool update_sink_caps;
 
-	/* Requested current / voltage */
+	/* Requested current / voltage to the port partner */
+	u32 req_current_limit;
+	u32 req_supply_voltage;
+	/* Acutal current / voltage limit of the local port */
 	u32 current_limit;
 	u32 supply_voltage;
 
@@ -2435,8 +2438,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		case SNK_TRANSITION_SINK:
 			if (port->vbus_present) {
 				tcpm_set_current_limit(port,
-						       port->current_limit,
-						       port->supply_voltage);
+						       port->req_current_limit,
+						       port->req_supply_voltage);
 				port->explicit_contract = true;
 				tcpm_set_auto_vbus_discharge_threshold(port,
 								       TYPEC_PWR_MODE_PD,
@@ -2545,8 +2548,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
 			port->pps_data.active = true;
-			port->supply_voltage = port->pps_data.out_volt;
-			port->current_limit = port->pps_data.op_curr;
+			port->req_supply_voltage = port->pps_data.out_volt;
+			port->req_current_limit = port->pps_data.op_curr;
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SOFT_RESET_SEND:
@@ -3195,8 +3198,8 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
 			 flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
 	}
 
-	port->current_limit = ma;
-	port->supply_voltage = mv;
+	port->req_current_limit = ma;
+	port->req_supply_voltage = mv;
 
 	return 0;
 }
-- 
2.31.0.208.g409f899ff0-goog

