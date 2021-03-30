Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC4934E11C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhC3GUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:20:44 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:8872 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhC3GUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:20:23 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 3F8AF9803E1;
        Tue, 30 Mar 2021 14:20:19 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] usb: dwc2: Remove duplicate struct declaration
Date:   Tue, 30 Mar 2021 14:19:08 +0800
Message-Id: <20210330061908.2268499-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHx0YQ0NDHUxOSU0YVkpNSkxLQ05JSkJPTUNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Mzo6GT8WFjc9KBhPNkwU
        NC5PC0JVSlVKTUpMS0NOSUpCTE9CVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT0xJNwY+
X-HM-Tid: 0a7881ca4234d992kuws3f8af9803e1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct dwc2_hsotg is declared twice. One has been declared
at forward declaration. Remove the duplicate one.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/usb/dwc2/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 7161344c6522..8407bba523ce 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -210,7 +210,6 @@ do { \
 #define call_gadget(_hs, _entry)	do {} while (0)
 #endif
 
-struct dwc2_hsotg;
 struct dwc2_host_chan;
 
 /* Device States */
-- 
2.25.1

