Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCB33C5488
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352708AbhGLH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242446AbhGLHWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:22:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 183B660C40;
        Mon, 12 Jul 2021 07:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626074369;
        bh=+YGAxHpyvw/k/kJdOcc4VCHCnFA4RS2PxkSKHExu8cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AP97KsHZSd1IwdGqLdV8T30k81BC5XOErrJJHF1ely25QhEIng5DW6qGC9rHUCemO
         +abPISbNLyBe6iFK+2wveL6nhMfeYtYMcPkiN1xLPp0KZHfOXmNKBvwTgumC+dh72O
         tPFHIQnxRQR0VmG17mIItBwoI0qRSvVIQ9Tjjs18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 557/700] usb: typec: tcpm: Fix up PR_SWAP when vsafe0v is signalled
Date:   Mon, 12 Jul 2021 08:10:40 +0200
Message-Id: <20210712061035.477249093@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060924.797321836@linuxfoundation.org>
References: <20210712060924.797321836@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Badhri Jagan Sridharan <badhri@google.com>

[ Upstream commit d112efbe6dbf7d4c482e2a3f381fa315aabfe63b ]

During PR_SWAP, When TCPM is in PR_SWAP_SNK_SRC_SINK_OFF, vbus is
expected to reach VSAFE0V when source turns off vbus. Do not move
to SNK_UNATTACHED state when this happens.

Fixes: 28b43d3d746b ("usb: typec: tcpm: Introduce vsafe0v for vbus")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Link: https://lore.kernel.org/r/20210517192112.40934-1-badhri@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index a57047d7fac8..07dee0118c27 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5187,6 +5187,9 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
 				tcpm_set_state(port, SNK_UNATTACHED, 0);
 		}
 		break;
+	case PR_SWAP_SNK_SRC_SINK_OFF:
+		/* Do nothing, vsafe0v is expected during transition */
+		break;
 	default:
 		if (port->pwr_role == TYPEC_SINK && port->auto_vbus_discharge_enabled)
 			tcpm_set_state(port, SNK_UNATTACHED, 0);
-- 
2.30.2



