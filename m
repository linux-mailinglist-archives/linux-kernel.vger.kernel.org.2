Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385DA3E24C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbhHFII7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:08:59 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:61688 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbhHFII4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:08:56 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210806080839epoutp03786959998a305ebc8510db9802879eb8~YqTcjGgxP1312713127epoutp03B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 08:08:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210806080839epoutp03786959998a305ebc8510db9802879eb8~YqTcjGgxP1312713127epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628237319;
        bh=vrMGpYMvYhy3dlysk5G86kR4UIbbT+vbo9YUzDmvKFw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=K/KBA4kSTv7VNuDAqlM8Uk4pPkFL1X8ESplY+GPn6oBRGcBtAxRBd8jIrErzom32j
         MVq41VmTxJMtM0wyfI7xr2r0mN18Ecw6zLfXIU9bwyc9qckocnnvg2Iu9vkOogj/Hk
         Dn/JIKZ9AUw/+zu9+pi79RN2wWcwC/QxKi82g2do=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210806080838epcas2p14a85f5834b014be62f3050f3dc05aabe~YqTb_3UDJ3019530195epcas2p1o;
        Fri,  6 Aug 2021 08:08:38 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Ggym44kRyz4x9QP; Fri,  6 Aug
        2021 08:08:36 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.2E.09541.30EEC016; Fri,  6 Aug 2021 17:08:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20210806080835epcas2p2134b8b635e27d129a9e2f2f400a814fc~YqTYcnuxS2470424704epcas2p25;
        Fri,  6 Aug 2021 08:08:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210806080835epsmtrp1f99415806879ef95d901b5d18054d8d0~YqTYbiXXZ1316913169epsmtrp1b;
        Fri,  6 Aug 2021 08:08:35 +0000 (GMT)
X-AuditID: b6c32a46-63f81a8000002545-d8-610cee036647
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.7A.08394.30EEC016; Fri,  6 Aug 2021 17:08:35 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210806080835epsmtip15e35a7c508d0f3007be7580bc42dbb38~YqTYTGfGO0972509725epsmtip1_;
        Fri,  6 Aug 2021 08:08:35 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB GADGET/PERIPHERAL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        taehyun cho <taehyun.cho@samsung.com>
Subject: usb: gadget: u_serial: check Null pointer in EP callback
Date:   Fri,  6 Aug 2021 16:53:26 +0900
Message-Id: <1628236406-185160-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLKsWRmVeSWpSXmKPExsWy7bCmmS7zO55Eg10rTSyOtT1ht2hevJ7N
        4vKuOWwWi5a1MltMOijqwOqxaVUnm8f+uWvYPfq2rGL0+LxJLoAlKscmIzUxJbVIITUvOT8l
        My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2itkkJZYk4pUCggsbhYSd/Opii/
        tCRVISO/uMRWKbUgJafA0LBArzgxt7g0L10vOT/XytDAwMgUqDIhJ2PuL/WCHRIV91/aNDC+
        Eeli5OSQEDCRWDSzmb2LkYtDSGAHo8Tl1+0sEM4nRoldP1ZBZb4xSkw5OocRpuXK0htQVXsZ
        JZ5/ms0K4fxglDiyv4W5i5GDg01AS+L7QrAGEYEwiYnL9rGA2MwC8xgl1jU7gdjCAo4SJzb3
        sYHYLAKqEv8/bWYGsXkF3CQ2vT/FCrFMTuLmuU5mkPkSAtPZJS7OOA6VcJG41bSQHcIWlnh1
        fAuULSXxsr+NHeQGCYFyiUXz7SB6Oxgl1nw6C/WBscSsZ+2MIDXMApoS63fpQ5QrSxy5BXUm
        n0TH4b9QU3glOtqEIBqVJaZfngB1gKTEwdfnmCFsD4lpG9rB4kICsRIT311jn8AoOwth/gJG
        xlWMYqkFxbnpqcVGBUbIMbSJEZyOtNx2ME55+0HvECMTB+MhRgkOZiUR3uTFXIlCvCmJlVWp
        RfnxRaU5qcWHGE2BwTWRWUo0OR+YEPNK4g1NjczMDCxNLUzNjCyUxHk14r4mCAmkJ5akZqem
        FqQWwfQxcXBKNTCZ3DDc7jBhzlONrh93998TqfwrcOphc8fT41fq3kjP2rImcMvl3vWrrI3m
        tj5oYb2sku53KMjgquBcuwqRinP8MZsV/16aWGvRr7XH3vv6bItf/Ar5ESFl1jrfJJY+KuwR
        jXF6fj4pcVrZRVO9P9v2HyqM1z1e/HGu1LNAru6S1d43rFjyDBpeVB/one9kuO1N0sP3j36L
        3nn8wFCZZ4Gv1TFGpU1LU9lyrX99Liy9/3Tl0eOLtW6fynfqW5BUt8Yi2K1ihVD79iKX2xkJ
        zqY1V1SPTzzR0pUdL9ShsesHTyrPpYNpl+sWB39dmnHq/Hy9X6XMt2ateuP3ddPd6YLnjZ9Z
        Nue+EKze9F76xFQ5JZbijERDLeai4kQAMH2qAdADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJMWRmVeSWpSXmKPExsWy7bCSnC7zO55Eg4OrWC2OtT1ht2hevJ7N
        4vKuOWwWi5a1MltMOijqwOqxaVUnm8f+uWvYPfq2rGL0+LxJLoAlissmJTUnsyy1SN8ugStj
        7i/1gh0SFfdf2jQwvhHpYuTkkBAwkbiy9AZLFyMXh5DAbkaJG1O72CESkhJL596AsoUl7rcc
        YYUo+sYoMaF5FWMXIwcHm4CWxPeFjCA1IgJhEv8eXQQbxCwwj1Fi/vMtbCAJYQFHiROb+8Bs
        FgFVif+fNjOD2LwCbhKb3p9ihVggJ3HzXCfzBEaeBYwMqxglUwuKc9Nziw0LDPNSy/WKE3OL
        S/PS9ZLzczcxgkNES3MH4/ZVH/QOMTJxMB5ilOBgVhLhTV7MlSjEm5JYWZValB9fVJqTWnyI
        UZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU8PEHUduG/+e16EoenzBzC1K5sp7mQ84
        NU79GhfZ/otXUGDXorWCjWFXxXddyN70ikM17/nlnTu+udblFrw7eIY789aRiHfXjn+ZENQp
        uHbH7zWf9rwNmfHyzO4Xn0/7/eKpv7XfZd2FZE9JGY3LC92OK9+Zm3xr7rMwvQjlWSc7enPO
        61VY6Gb1eyz96r6590FX+qk1H/edaVSze/j13TeFx69L5UtDmurZPpp+fm9yd2PCyvnRSdt3
        LWt4xST464Zt1y3GQ8uZNXu+pTyT75I1V2ObmBklbm+/df1hvk+nBP6+2/dKw/Y5q+Hjjd8v
        u4uf1t979WFRR8zPva/Cph6atmxd76YZAnJPWYSEZhu+UGIpzkg01GIuKk4EAJPySyqAAgAA
X-CMS-MailID: 20210806080835epcas2p2134b8b635e27d129a9e2f2f400a814fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210806080835epcas2p2134b8b635e27d129a9e2f2f400a814fc
References: <CGME20210806080835epcas2p2134b8b635e27d129a9e2f2f400a814fc@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: taehyun cho <taehyun.cho@samsung.com>

Endpoint complete function in u_serial can be executed
when 'gs_port' is Null. This situation happens when
'dwc3_gadget_pullup' returns ETIMEDOUT. The reason why
ETIMEDOUT is returned is that whole system is out of order
including interrupt regardless of USB.

pc : __lock_acquire+0x54/0x5ec
lr : lock_acquire+0xe8/0x198
sp : ffffffc03914b9d0
x29: ffffffc03914b9d0 x28: ffffff895f13b680
x27: 0000000000000000 x26: 0000000000000000
x25: 00000000000003c8 x24: 0000000000000080
x23: ffffffc010a8f650 x22: 0000000000000000
x21: 0000000000000000 x20: 0000000000000000
x19: ffffffc010a8f650 x18: ffffffc02d70a0b0
x17: 0000000000000000 x16: 00000000000229e0
x15: 0000000000000004 x14: 00000000000004f2
x13: ffffffc0120fe178 x12: 0000000000000003
x11: 00000000ffffffff x10: 0000000100000001
x9 : 0000000000000001 x8 : 00000000000003c8
x7 : 0000000000000000 x6 : ffffffc010a8f650
x5 : 0000000000000000 x4 : 0000000000000080
x3 : 0000000000000000 x2 : 0000000000000000
x1 : 0000000000000000 x0 : 00000000000003c8
Call trace:
 __lock_acquire+0x54/0x5ec
 lock_acquire+0xe8/0x198
 _raw_spin_lock+0x70/0x88
 gs_read_complete+0x48/0xac
 usb_gadget_giveback_request+0x48/0x80
 dwc3_gadget_giveback+0xcc/0xe8
 dwc3_remove_requests+0xa8/0x188
 __dwc3_gadget_ep_disable+0x98/0x110
 dwc3_gadget_ep_disable+0x50/0xbc
 usb_ep_disable+0x44/0x94
 gserial_disconnect+0xc0/0x250
 acm_free_func+0x30/0x48
 usb_put_function+0x34/0x68
 config_usb_cfg_unlink+0xdc/0xf8
 configfs_unlink+0x144/0x264
 vfs_unlink+0x134/0x218
 do_unlinkat+0x13c/0x2a0
 __arm64_sys_unlinkat+0x48/0x60
 el0_svc_common.llvm.10277270529376503802+0xb8/0x1b4
 do_el0_svc+0x24/0x8c
 el0_svc+0x10/0x1c
 el0_sync_handler+0x68/0xac
 el0_sync+0x18c/0x1c0

Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
---
 drivers/usb/gadget/function/u_serial.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 6f68cbe..af08a18 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -450,6 +450,15 @@ static void gs_read_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct gs_port	*port = ep->driver_data;
 
+	/*
+	 * Port became NULL when 'dwc3_gadget_pullup' returns ETIMEDOUT.
+	 * Return here to avoid panic.
+	 */
+	if (!port) {
+		pr_err("%s, failed to get port\n", __func__);
+		return;
+	}
+
 	/* Queue all received data until the tty layer is ready for it. */
 	spin_lock(&port->port_lock);
 	list_add_tail(&req->list, &port->read_queue);
@@ -461,6 +470,15 @@ static void gs_write_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct gs_port	*port = ep->driver_data;
 
+	/*
+	 * port became NULL when 'dwc3_gadget_pullup' returns ETIMEDOUT.
+	 * Return here to avoid panic.
+	 */
+	if (!port) {
+		pr_err("%s, failed to get port\n", __func__);
+		return;
+	}
+
 	spin_lock(&port->port_lock);
 	list_add(&req->list, &port->write_pool);
 	port->write_started--;
-- 
2.7.4

