Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB60D35FA85
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352807AbhDNSNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352024AbhDNSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247FAC061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g5so26115567ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQJ0kyMDz01R2sfKW6zJC27eCVFmF319bZji6t7JS5w=;
        b=HA3v0ycGQUgzrzWwaMK8UKT70x0MdmXAEY2CuIo+uVe33JjUAwcUAHyllELvSpyl18
         w6fRfyo5dja1c9ifkkxyhX0bE2C3TvxNFtYJ5MW61enHmpLvqfb5YpLLje5q3Ubjb3V9
         4uz4xDe0HncLHLi96renR3h6I+r/5cb+T9OO4RXb3gsKveENgmhPETQAV6Z65C+Rnopf
         9rD1otr93ev4clRGKes19LP3LXTmPKa+X3c9Lp0RaeLlA9bwNEUXZzE+KjLIExQqN4Ua
         7E/7EgT5hddm+LLq3IjLUkgk186He4Oa23vdaKCpN1InWUTegnKgpyD/8ouzsvX7e5s7
         D3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQJ0kyMDz01R2sfKW6zJC27eCVFmF319bZji6t7JS5w=;
        b=VRo5dx8no/GkjX/bEtx7NFYFEXAIZMtRazOjJj+DF+sTMxOq1Pvxt6D0wUhq81usM5
         w+s7wFjBp25OfAzOqarW2jFcuM0EHoyldXq0bavXcf46ShURV1iqesJ4GH4cX3B7ll4W
         wFHsZdH1cEwI/Di7FDFYZ1yhwQUYLkhWfIalWYV2kCDOlCtENG8wyFiYk3BOj/MPN/+7
         IfeJJuxNzQgP3+vX6BFwApWoXMwUX72VJcrvjxgrPcWvDe+4IdhWZ4fZSCB0jFOGGoVo
         oM5Uc+Kb55/cW6ZVpBhisvVgxYW6MTy5yCUi5dCisEi3PZVAG1frHFYo+ElQLHDGDl+D
         ewqw==
X-Gm-Message-State: AOAM532I9pMewaM5U11Ime3re49ddt4Ms/Oo/NhGke4Ej17b5Zs29P/8
        ammBnefmRLO7lDrNBTfv9qCzHg==
X-Google-Smtp-Source: ABdhPJxyYSb844/4pt3C/IWVl3GXJeAFitVD4YJ3VtOBo3lNTVi7y8Y93Y4M/Wqd/J6cXxbanmvw3g==
X-Received: by 2002:a17:907:367:: with SMTP id rs7mr156791ejb.468.1618423919783;
        Wed, 14 Apr 2021 11:11:59 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 24/57] staging: fwserial: Demote a whole host of kernel-doc abuses
Date:   Wed, 14 Apr 2021 19:10:56 +0100
Message-Id: <20210414181129.1628598-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/fwserial/fwserial.c:52: warning: Function parameter or member 'fwserial_list' not described in 'LIST_HEAD'
 drivers/staging/fwserial/fwserial.c:52: warning: expecting prototype for fwserial_list(). Prototype was for LIST_HEAD() instead
 drivers/staging/fwserial/fwserial.c:62: warning: cannot understand function prototype: 'struct fwtty_port *port_table[MAX_TOTAL_PORTS]; '
 drivers/staging/fwserial/fwserial.c:295: warning: Function parameter or member 'port' not described in 'fwtty_update_port_status'
 drivers/staging/fwserial/fwserial.c:295: warning: Function parameter or member 'status' not described in 'fwtty_update_port_status'
 drivers/staging/fwserial/fwserial.c:388: warning: Function parameter or member 'port' not described in '__fwtty_port_line_status'
 drivers/staging/fwserial/fwserial.c:412: warning: Function parameter or member 'port' not described in '__fwtty_write_port_status'
 drivers/staging/fwserial/fwserial.c:433: warning: Function parameter or member 'port' not described in 'fwtty_write_port_status'
 drivers/staging/fwserial/fwserial.c:486: warning: Function parameter or member 'work' not described in 'fwtty_do_hangup'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'card' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'request' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'tcode' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'destination' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'source' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'generation' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'addr' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'data' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'len' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Function parameter or member 'callback_data' not described in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:605: warning: Excess function parameter 'parameters' description in 'fwtty_port_handler'
 drivers/staging/fwserial/fwserial.c:670: warning: Function parameter or member 'card' not described in 'fwtty_tx_complete'
 drivers/staging/fwserial/fwserial.c:670: warning: Function parameter or member 'rcode' not described in 'fwtty_tx_complete'
 drivers/staging/fwserial/fwserial.c:670: warning: Function parameter or member 'txn' not described in 'fwtty_tx_complete'
 drivers/staging/fwserial/fwserial.c:914: warning: Function parameter or member 'tty_port' not described in 'fwtty_port_carrier_raised'
 drivers/staging/fwserial/fwserial.c:1021: warning: Function parameter or member 'tty_port' not described in 'fwtty_port_shutdown'
 drivers/staging/fwserial/fwserial.c:1312: warning: Function parameter or member 'tty' not described in 'fwtty_break_ctl'
 drivers/staging/fwserial/fwserial.c:1312: warning: Function parameter or member 'state' not described in 'fwtty_break_ctl'
 drivers/staging/fwserial/fwserial.c:1681: warning: Function parameter or member 'peer' not described in 'fwserial_claim_port'
 drivers/staging/fwserial/fwserial.c:1681: warning: Function parameter or member 'index' not described in 'fwserial_claim_port'
 drivers/staging/fwserial/fwserial.c:1708: warning: Function parameter or member 'peer' not described in 'fwserial_find_port'
 drivers/staging/fwserial/fwserial.c:1775: warning: Function parameter or member 'peer' not described in 'fwserial_connect_peer'
 drivers/staging/fwserial/fwserial.c:1844: warning: Function parameter or member 'driver' not described in 'fwserial_close_port'
 drivers/staging/fwserial/fwserial.c:1844: warning: Function parameter or member 'port' not described in 'fwserial_close_port'
 drivers/staging/fwserial/fwserial.c:1911: warning: Function parameter or member 'card' not described in '__fwserial_peer_by_node_id'
 drivers/staging/fwserial/fwserial.c:1911: warning: Function parameter or member 'generation' not described in '__fwserial_peer_by_node_id'
 drivers/staging/fwserial/fwserial.c:1911: warning: Function parameter or member 'id' not described in '__fwserial_peer_by_node_id'
 drivers/staging/fwserial/fwserial.c:2090: warning: Function parameter or member 'peer' not described in 'fwserial_remove_peer'
 drivers/staging/fwserial/fwserial.c:2321: warning: Function parameter or member 'unit' not described in 'fwserial_probe'
 drivers/staging/fwserial/fwserial.c:2321: warning: Function parameter or member 'id' not described in 'fwserial_probe'
 drivers/staging/fwserial/fwserial.c:2344: warning: Function parameter or member 'unit' not described in 'fwserial_remove'
 drivers/staging/fwserial/fwserial.c:2382: warning: Function parameter or member 'unit' not described in 'fwserial_update'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'card' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'request' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'tcode' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'destination' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'source' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'generation' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'addr' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'data' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'len' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Function parameter or member 'callback_data' not described in 'fwserial_mgmt_handler'
 drivers/staging/fwserial/fwserial.c:2717: warning: Excess function parameter 'parameters' description in 'fwserial_mgmt_handler'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/fwserial/fwserial.c | 46 ++++++++++++++---------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index 1ee6382cafc42..9ade8e7a68bae 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -45,14 +45,14 @@ module_param_named(loop, create_loop_dev, bool, 0644);
  */
 #define WAKEUP_CHARS             256
 
-/**
+/*
  * fwserial_list: list of every fw_serial created for each fw_card
  * See discussion in fwserial_probe.
  */
 static LIST_HEAD(fwserial_list);
 static DEFINE_MUTEX(fwserial_list_mutex);
 
-/**
+/*
  * port_table: array of tty ports allocated to each fw_card
  *
  * tty ports are allocated during probe when an fw_serial is first
@@ -284,7 +284,7 @@ static void fwtty_restart_tx(struct fwtty_port *port)
 	spin_unlock_bh(&port->lock);
 }
 
-/**
+/*
  * fwtty_update_port_status - decodes & dispatches line status changes
  *
  * Note: in loopback, the port->lock is being held. Only use functions that
@@ -375,7 +375,7 @@ static void fwtty_update_port_status(struct fwtty_port *port,
 		wake_up_interruptible(&port->port.delta_msr_wait);
 }
 
-/**
+/*
  * __fwtty_port_line_status - generate 'line status' for indicated port
  *
  * This function returns a remote 'MSR' state based on the local 'MCR' state,
@@ -403,7 +403,7 @@ static unsigned int __fwtty_port_line_status(struct fwtty_port *port)
 	return status;
 }
 
-/**
+/*
  * __fwtty_write_port_status - send the port line status to peer
  *
  * Note: caller must be holding the port lock.
@@ -426,7 +426,7 @@ static int __fwtty_write_port_status(struct fwtty_port *port)
 	return err;
 }
 
-/**
+/*
  * fwtty_write_port_status - same as above but locked by port lock
  */
 static int fwtty_write_port_status(struct fwtty_port *port)
@@ -462,7 +462,7 @@ static void fwtty_throttle_port(struct fwtty_port *port)
 	tty_kref_put(tty);
 }
 
-/**
+/*
  * fwtty_do_hangup - wait for ldisc to deliver all pending rx; only then hangup
  *
  * When the remote has finished tx, and all in-flight rx has been received and
@@ -589,9 +589,8 @@ static int fwtty_rx(struct fwtty_port *port, unsigned char *data, size_t len)
 	return err;
 }
 
-/**
+/*
  * fwtty_port_handler - bus address handler for port reads/writes
- * @parameters: fw_address_callback_t as specified by firewire core interface
  *
  * This handler is responsible for handling inbound read/write dma from remotes.
  */
@@ -656,7 +655,7 @@ static void fwtty_port_handler(struct fw_card *card,
 	fw_send_response(card, request, rcode);
 }
 
-/**
+/*
  * fwtty_tx_complete - callback for tx dma
  * @data: ignored, has no meaning for write txns
  * @length: ignored, has no meaning for write txns
@@ -904,7 +903,7 @@ static void fwtty_port_dtr_rts(struct tty_port *tty_port, int on)
 	spin_unlock_bh(&port->lock);
 }
 
-/**
+/*
  * fwtty_port_carrier_raised: required tty_port operation
  *
  * This port operation is polled after a tty has been opened and is waiting for
@@ -1011,7 +1010,7 @@ static int fwtty_port_activate(struct tty_port *tty_port,
 	return 0;
 }
 
-/**
+/*
  * fwtty_port_shutdown
  *
  * Note: the tty port core ensures this is not the console and
@@ -1297,7 +1296,7 @@ static void fwtty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	}
 }
 
-/**
+/*
  * fwtty_break_ctl - start/stop sending breaks
  *
  * Signals the remote to start or stop generating simulated breaks.
@@ -1669,7 +1668,7 @@ static inline int fwserial_send_mgmt_sync(struct fwtty_peer *peer,
 	return rcode;
 }
 
-/**
+/*
  * fwserial_claim_port - attempt to claim port @ index for peer
  *
  * Returns ptr to claimed port or error code (as ERR_PTR())
@@ -1697,7 +1696,7 @@ static struct fwtty_port *fwserial_claim_port(struct fwtty_peer *peer,
 	return port;
 }
 
-/**
+/*
  * fwserial_find_port - find avail port and claim for peer
  *
  * Returns ptr to claimed port or NULL if none avail
@@ -1764,7 +1763,7 @@ static void fwserial_plug_timeout(struct timer_list *t)
 		fwserial_release_port(port, false);
 }
 
-/**
+/*
  * fwserial_connect_peer - initiate virtual cable with peer
  *
  * Returns 0 if VIRT_CABLE_PLUG request was successfully sent,
@@ -1829,7 +1828,7 @@ static int fwserial_connect_peer(struct fwtty_peer *peer)
 	return err;
 }
 
-/**
+/*
  * fwserial_close_port -
  * HUP the tty (if the tty exists) and unregister the tty device.
  * Only used by the unit driver upon unit removal to disconnect and
@@ -1893,7 +1892,7 @@ static struct fw_serial *__fwserial_lookup_rcu(struct fw_card *card)
 	return NULL;
 }
 
-/**
+/*
  * __fwserial_peer_by_node_id - finds a peer matching the given generation + id
  *
  * If a matching peer could not be found for the specified generation/node id,
@@ -2076,7 +2075,7 @@ static int fwserial_add_peer(struct fw_serial *serial, struct fw_unit *unit)
 	return 0;
 }
 
-/**
+/*
  * fwserial_remove_peer - remove a 'serial' unit device as a 'peer'
  *
  * Remove a 'peer' from its list of peers. This function is only
@@ -2279,7 +2278,7 @@ static int fwserial_create(struct fw_unit *unit)
 	return err;
 }
 
-/**
+/*
  * fwserial_probe: bus probe function for firewire 'serial' unit devices
  *
  * A 'serial' unit device is created and probed as a result of:
@@ -2331,7 +2330,7 @@ static int fwserial_probe(struct fw_unit *unit,
 	return err;
 }
 
-/**
+/*
  * fwserial_remove: bus removal function for firewire 'serial' unit devices
  *
  * The corresponding 'peer' for this unit device is removed from the list of
@@ -2363,7 +2362,7 @@ static void fwserial_remove(struct fw_unit *unit)
 	mutex_unlock(&fwserial_list_mutex);
 }
 
-/**
+/*
  * fwserial_update: bus update function for 'firewire' serial unit devices
  *
  * Updates the new node_id and bus generation for this peer. Note that locking
@@ -2699,9 +2698,8 @@ static int fwserial_parse_mgmt_write(struct fwtty_peer *peer,
 	return rcode;
 }
 
-/**
+/*
  * fwserial_mgmt_handler: bus address handler for mgmt requests
- * @parameters: fw_address_callback_t as specified by firewire core interface
  *
  * This handler is responsible for handling virtual cable requests from remotes
  * for all cards.
-- 
2.27.0

