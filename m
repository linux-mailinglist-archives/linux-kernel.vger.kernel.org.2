Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124ED3A02B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhFHTHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236069AbhFHS6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:58:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 114646143F;
        Tue,  8 Jun 2021 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623177775;
        bh=1NFF60RrzAFQWswXjOOAcJE7ziMW7DOkgkMshNJk4jY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqNmlwu9f0AHUvPq53GooKyDIIw/0oN5DnYrFfxPq37cEX+USXzNw9AHSdEUCzhtk
         V9Dmgaiyyq5SfJ4+ri+ACfk39fvqtq6C5qeZi7LCIgg2L0wZNBYcFJxdggp3DsVuAv
         2cZaLJLH0Wcmyu9eiUDH+BkuAPXCJasD0E69IiUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.10 095/137] HID: multitouch: require Finger field to mark Win8 reports as MT
Date:   Tue,  8 Jun 2021 20:27:15 +0200
Message-Id: <20210608175945.592622767@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608175942.377073879@linuxfoundation.org>
References: <20210608175942.377073879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

commit a2353e3b26012ff43bcdf81d37a3eaddd7ecdbf3 upstream.

This effectively changes collection_is_mt from
  contact ID in report->field
to
  (device is Win8 => collection is finger) && contact ID in report->field

Some devices erroneously report Pen for fingers, and Win8 stylus-on-touchscreen
devices report contact ID, but mark the accompanying touchscreen device's
collection correctly

Cc: stable@vger.kernel.org
Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-multitouch.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -604,9 +604,13 @@ static struct mt_report_data *mt_allocat
 		if (!(HID_MAIN_ITEM_VARIABLE & field->flags))
 			continue;
 
-		for (n = 0; n < field->report_count; n++) {
-			if (field->usage[n].hid == HID_DG_CONTACTID)
-				rdata->is_mt_collection = true;
+		if (field->logical == HID_DG_FINGER || td->hdev->group != HID_GROUP_MULTITOUCH_WIN_8) {
+			for (n = 0; n < field->report_count; n++) {
+				if (field->usage[n].hid == HID_DG_CONTACTID) {
+					rdata->is_mt_collection = true;
+					break;
+				}
+			}
 		}
 	}
 


