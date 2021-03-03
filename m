Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A332BDA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349321AbhCCQSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:18:14 -0500
Received: from comms.puri.sm ([159.203.221.185]:56318 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234981AbhCCLpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:45:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 06028E0415;
        Wed,  3 Mar 2021 01:17:02 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JZHkuqRt8frZ; Wed,  3 Mar 2021 01:17:01 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] Documentation: dynamic-debug-howto: fix example
Date:   Wed,  3 Mar 2021 10:16:46 +0100
Message-Id: <20210303091646.773111-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dynamic debug is "expecting pairs of match-spec <value>" so the example
for all files of which the paths include "usb" there is "file" missing.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 6c04aea8f4cd..b119b8277b3e 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -347,7 +347,7 @@ Examples
 				<debugfs>/dynamic_debug/control
 
   // enable messages in files of which the paths include string "usb"
-  nullarbor:~ # echo -n '*usb* +p' > <debugfs>/dynamic_debug/control
+  nullarbor:~ # echo -n 'file *usb* +p' > <debugfs>/dynamic_debug/control
 
   // enable all messages
   nullarbor:~ # echo -n '+p' > <debugfs>/dynamic_debug/control
-- 
2.30.1

