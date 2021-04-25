Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C613A36A96A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhDYVOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:14:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:40015 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231241AbhDYVOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:14:40 -0400
IronPort-SDR: gHc4FmaGNdYQrd7Iox5PZImLHQkHfyKZG00O0PczzxenH33oacdGoMOwbrQHjGzjFJrMgmA/PY
 ZmmojwpL0vXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="260209223"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="260209223"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:14:00 -0700
IronPort-SDR: ueF7ujSkZblDYJuIDbqiNBKEjj17IgPKlhbDTESwrZu0+NzHiVBpqv1NPjCFHwiFLVAgU6nt+f
 54eBUDmjIBdg==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="422374513"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:14:00 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH] dvb-usb: Make prototypes match
Date:   Sun, 25 Apr 2021 14:13:43 -0700
Message-Id: <20210425211343.3157860-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

gcc 11 complains when arrays in prototypes do not match the function.
Fix this here.

Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Andi Kleen <andi@firstfloor.org>
---
 drivers/media/usb/dvb-usb/dvb-usb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb.h b/drivers/media/usb/dvb-usb/dvb-usb.h
index 741be0e69447..2b8ad2bde8a4 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb.h
+++ b/drivers/media/usb/dvb-usb/dvb-usb.h
@@ -487,7 +487,7 @@ extern int __must_check
 dvb_usb_generic_write(struct dvb_usb_device *, u8 *, u16);
 
 /* commonly used remote control parsing */
-extern int dvb_usb_nec_rc_key_to_event(struct dvb_usb_device *, u8[], u32 *, int *);
+extern int dvb_usb_nec_rc_key_to_event(struct dvb_usb_device *, u8[5], u32 *, int *);
 
 /* commonly used firmware download types and function */
 struct hexline {
-- 
2.25.4

