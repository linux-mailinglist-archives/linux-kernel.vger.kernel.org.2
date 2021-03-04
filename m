Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA132CA53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 03:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhCDCDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 21:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232111AbhCDCDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 21:03:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3FF765036;
        Thu,  4 Mar 2021 02:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614823351;
        bh=O2GnyG4QH/iY6ZijLJqcuRB4+Yf0aV3BW9XeaC5jkMY=;
        h=Date:From:To:Cc:Subject:From;
        b=Fm/+7EHKM2w+ZsMWRXsW5W1VgPmG46KfC+76ILL/06OOnYpvlIO0AV34cD9I2KQfb
         l4k3CG4in02Y7ujz8DHSpXyuW1l3JQUp25RQN4JLDtss+lvqM2L/+Dq0w/hqJylfSx
         GdlLz1XpOoRH1bphLjhwVZsTP9j7RLCZydzyxAzc/5eAU3iNRgi9rfp3papE0fqZyF
         xGlewg/n9O2BbajnDNy0Q9TxNneeZwkDc1lqRR5RPVs6BToHgmYcNCznw5IJeR+SIN
         FkWoZCSQcOQM1irwo0YymqeXs2E2X+wcxxzG/j9IrDJ4wSTXap+86EdekKDECDPMG+
         Gz2sFIKEmVCaA==
Date:   Wed, 3 Mar 2021 20:02:28 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: rtl8188eu: Replace one-element array with
 flexible-array in struct ndis_802_11_var_ie
Message-ID: <20210304020228.GA45139@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Use flexible-array member in struct ndis_802_11_var_ie, instead of
one-element array.

Also, this helps with the ongoing efforts to enable -Warray-bounds by
fixing the following warning:

drivers/staging/rtl8188eu/core/rtw_wlan_util.c: In function ‘HT_caps_handler’:
drivers/staging/rtl8188eu/core/rtw_wlan_util.c:665:65: warning: array subscript 2 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
  665 |    if ((pmlmeinfo->HT_caps.ampdu_params_info & 0x3) > (pIE->data[i] & 0x3))
      |                                                        ~~~~~~~~~^~~

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/109
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/rtl8188eu/include/wlan_bssdef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/wlan_bssdef.h b/drivers/staging/rtl8188eu/include/wlan_bssdef.h
index 2c184ce8746b..350bbf9057b8 100644
--- a/drivers/staging/rtl8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8188eu/include/wlan_bssdef.h
@@ -64,7 +64,7 @@ struct ndis_802_11_fixed_ie {
 struct ndis_802_11_var_ie {
 	u8  ElementID;
 	u8  Length;
-	u8  data[1];
+	u8  data[];
 };
 
 /*
-- 
2.27.0

