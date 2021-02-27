Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4031326F18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 22:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhB0V40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 16:56:26 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:34152 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhB0V4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 16:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Message-Id:Date:Subject:Cc:To:From; bh=iSTG0geJy4jh7GW2AvwR7jsaRm906Tp0l7rHRny74TY=;
        b=YwCBminN/mNtii/3jmJASEuyRy/FKls6gBobTHgkVEDiUBCFmI78mShqitiCxizdD9/WtRjcWHFTfNsQbGE9YezYj9KPgVg5+kuNN7P/7Q21v2dGMUTSok1LeiFEJTsrxyRQxaAsKOlSNIFMDSIDEGYMW7YfwXe+QMCX+4/qWrw=;
Received: from [82.99.129.6] (helo=localhost.localdomain)
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1lG7Yn-0007Tv-4R; Sat, 27 Feb 2021 22:55:39 +0100
From:   Martin Devera <devik@eaxlabs.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Devera <devik@eaxlabs.cz>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc2: Add STM32 related debugfs entries
Date:   Sat, 27 Feb 2021 22:55:28 +0100
Message-Id: <20210227215528.12752-1-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are entries related to STM32MP1 PHY control.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
---
 drivers/usb/dwc2/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc2/debugfs.c b/drivers/usb/dwc2/debugfs.c
index aaafd463d72a..f13eed4231e1 100644
--- a/drivers/usb/dwc2/debugfs.c
+++ b/drivers/usb/dwc2/debugfs.c
@@ -691,6 +691,8 @@ static int params_show(struct seq_file *seq, void *v)
 	print_param(seq, p, ulpi_fs_ls);
 	print_param(seq, p, host_support_fs_ls_low_power);
 	print_param(seq, p, host_ls_low_power_phy_clk);
+	print_param(seq, p, activate_stm_fs_transceiver);
+	print_param(seq, p, activate_stm_id_vb_detection);
 	print_param(seq, p, ts_dline);
 	print_param(seq, p, reload_ctl);
 	print_param_hex(seq, p, ahbcfg);
-- 
2.11.0

