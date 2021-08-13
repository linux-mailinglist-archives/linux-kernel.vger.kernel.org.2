Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72063EAF58
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 06:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbhHMEcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 00:32:35 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:35271 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhHMEcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 00:32:33 -0400
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.100])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 62E42260EB;
        Fri, 13 Aug 2021 04:32:04 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 474553F202;
        Fri, 13 Aug 2021 04:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 78C0F2A521;
        Fri, 13 Aug 2021 06:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1628829120;
        bh=wco2uYT/C/REw9JO3fVns6TaOKfMHujekS5qiK7d4KQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LDcz+hUbfqSPgfueG+kV6yOcJY3apEG/8r/+wCEsb1NSuNtzDAEoNVny+kX9nf0j+
         lfDh0c5yvCAvjPf6EWpPBU9kwVA8BepZ3ZHSL+xYtpzItUWHEOxFyU+mV0rYKpnpHA
         ZNxzZFS/0cgq1kgzn/aNnB7LAtPHKdsO5wYVnvYY=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vp-wt9x0uCly; Fri, 13 Aug 2021 06:31:56 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 13 Aug 2021 06:31:56 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id D5A4740BFC;
        Fri, 13 Aug 2021 04:31:55 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="X/h9mPou";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.220])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 2076740BFC;
        Fri, 13 Aug 2021 04:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1628829107; bh=wco2uYT/C/REw9JO3fVns6TaOKfMHujekS5qiK7d4KQ=;
        h=From:To:Cc:Subject:Date:From;
        b=X/h9mPouIP6UtwvX8KJodIyT7vwhndKyQFDVXrApD/F2xTptTW7Mic7tMGmgmXlRZ
         HN/bcmHO/r/nMkqWP+KrKoO/XjBRAtswu9XcyaxSZxmuROJsjDpjnyNrh6VHyIX6CM
         7HeumCFOW/nCmstgyK9g+6H1WP0RHT7FsoHUbfgI=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] usb: typec: tcpm: always rediscover when swapping DR
Date:   Fri, 13 Aug 2021 12:31:31 +0800
Message-Id: <20210813043131.833006-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.90 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.220:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         RCPT_COUNT_FIVE(0.00)[6];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Queue-Id: D5A4740BFC
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, TCPM code omits discover when swapping to gadget, and assume
that no altmodes are available when swapping from gadget. However, we do
send discover when we get attached as gadget -- this leads to modes to be
discovered twice when attached as gadget and then swap to host.

Always re-send discover when swapping DR, regardless of what change is
being made; and because of this, the assumption that no altmodes are
registered with gadget role is broken, and altmodes de-registeration is
always needed now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/usb/typec/tcpm/tcpm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b9bb63d749ec..ab6d0d51ee1c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4495,15 +4495,14 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
 	case DR_SWAP_CHANGE_DR:
-		if (port->data_role == TYPEC_HOST) {
-			tcpm_unregister_altmodes(port);
+		tcpm_unregister_altmodes(port);
+		if (port->data_role == TYPEC_HOST)
 			tcpm_set_roles(port, true, port->pwr_role,
 				       TYPEC_DEVICE);
-		} else {
+		else
 			tcpm_set_roles(port, true, port->pwr_role,
 				       TYPEC_HOST);
-			port->send_discover = true;
-		}
+		port->send_discover = true;
 		tcpm_ams_finish(port);
 		tcpm_set_state(port, ready_state(port), 0);
 		break;
-- 
2.30.2
