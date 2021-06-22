Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC83B02EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFVLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:41:38 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55428 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFVLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:41:36 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210622113917epoutp02448a472bc7117da11deb700e1186a4ce~K5JgHkKGp0362303623epoutp02w
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:39:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210622113917epoutp02448a472bc7117da11deb700e1186a4ce~K5JgHkKGp0362303623epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1624361957;
        bh=s1Avvz1h66BixbIt3cMuqFT42a4Y6eRXBpAQuPpp6qw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FHN3bvqEZ5XNAyPokSjfYGbwy+y4cnkHdLZmDqxYjrVpbnvMbKM9IwZi3NKxlClzA
         TTjVOH5Z6gTESh24JfFf3GAhSf9hXvJ4yEA2i6Di0JHzXcQTQjxWl9tOEa/LuZ54Mu
         lc5u4lyvJNoEq0WWPZIZ/QQzXm1+XdsMjd99371U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210622113916epcas2p32f6acc194b1a6793eb53850b6ae5ef49~K5Jfgv8ZU1372513725epcas2p3F;
        Tue, 22 Jun 2021 11:39:16 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.187]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4G8PYv3tWsz4x9Q1; Tue, 22 Jun
        2021 11:39:15 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.0B.09571.3EBC1D06; Tue, 22 Jun 2021 20:39:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b~K5JeJ7Uuk0831208312epcas2p2J;
        Tue, 22 Jun 2021 11:39:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210622113915epsmtrp12b2960d91be90a33f08cf2cbff0bc16b~K5JeJPXHz0725207252epsmtrp1W;
        Tue, 22 Jun 2021 11:39:15 +0000 (GMT)
X-AuditID: b6c32a48-1dfff70000002563-59-60d1cbe39e04
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.53.08394.2EBC1D06; Tue, 22 Jun 2021 20:39:15 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210622113914epsmtip263687963dec77073818dc30645a0b2cf~K5Jd_A5g40096900969epsmtip2f;
        Tue, 22 Jun 2021 11:39:14 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: usb: host: Reduce xhci_handshake timeout in xhci_reset
Date:   Tue, 22 Jun 2021 20:24:56 +0900
Message-Id: <1624361096-41282-1-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7bCmme7j0xcTDFZskLW4s2Aak0Xz4vVs
        Fpd3zWGzWLSsldmiedMUVgdWj8V7XjJ57J+7ht2jb8sqRo/Pm+QCWKJybDJSE1NSixRS85Lz
        UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCgwNC/SKE3OLS/PS9ZLzc60MDQyMTIEqE3IytnZOZyv4yFGxYFUL
        YwNjP3sXIyeHhICJxI9ll1lBbCGBHYwSc5YEdjFyAdmfGCWunLrKAuF8Y5S48/oTK0zHwstz
        2CESexkl7vZ8YYJo/8EosW2dTRcjBwebgJbE94WMIGERAWOJ/rOzwOqZBfoYJeZ3fwUbJCxg
        L3Fn/RKwIhYBVYnDs46C2bwCrhLL585igVgmJ3HzXCczhN3PLrHjbh2E7SIxc8ZVNghbWOLV
        8S1Q70hJvOxvYwe5QUKgXGLRfDuQvRICHYwSaz6dZYSoMZaY9aydEaSGWUBTYv0ufYhyZYkj
        t8C2MgvwSXQc/gs1hVeio00IolFZYvrlCdBQkJQ4+Poc1GEeEhdfLGOEBEKsxLmDt5kmMMrO
        Qpi/gJFxFaNYakFxbnpqsVGBCXIMbWIEJyQtjx2Ms99+0DvEyMTBeIhRgoNZSYT3RfbFBCHe
        lMTKqtSi/Pii0pzU4kOMpsDQmsgsJZqcD0yJeSXxhqZGZmYGlqYWpmZGFkrivBzshxKEBNIT
        S1KzU1MLUotg+pg4OKUamKRzQs7m7Nk+y9lfauFaPb6lz6fZOS//ceWo9yOTV/3RuwpuJzf7
        x19Nl36823lno4P7pPrdDxUcPm21YeOszHnz43JHrafu+p1Lw1O8b9QduSuxz79ofb78l/by
        06rrP/EpGU+IOy8f5Ja63fqZYnfv1w8c/Vu/B5v4aR+vaqorf7Ls9Bt9r033j5x8YWEYvULt
        95kGlrTt7w1OOIS4bNR4Mu+n/6yJGeLul+8fT7v37+6Nm9N3B9dFzKybkqkpzFffdNsyNUvx
        eTH7rQcOKuGlma73gmb4LTF/udtaa79Mx9t5uZJKZ9c93SL0/rZxK78fjwjX3h1mxmaM7DVB
        NTtWLP6hGnaji+/+tfVRSkosxRmJhlrMRcWJAFLZ1EfRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWy7bCSvO7j0xcTDN42M1vcWTCNyaJ58Xo2
        i8u75rBZLFrWymzRvGkKqwOrx+I9L5k89s9dw+7Rt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GVs7p7MVfOSoWLCqhbGBsZ+9i5GTQ0LARGLh5TlANheHkMBuRomWr++ZIBKSEkvn3oAqEpa4
        33KEFaLoG6PEmVl7gRwODjYBLYnvCxlBakQEjCX6z84CG8QsMIFRomNTM1hCWMBe4s76JWA2
        i4CqxOFZR8FsXgFXieVzZ7FALJCTuHmuk3kCI88CRoZVjJKpBcW56bnFhgWGeanlesWJucWl
        eel6yfm5mxjBgaKluYNx+6oPeocYmTgYDzFKcDArifC+yL6YIMSbklhZlVqUH19UmpNafIhR
        moNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANTpOXEqIXvIz2uCP1bmvH0w0R//jX/N/ql
        VLVP+pr8QOZUxtOw5oeyliz/+kTVPFpnvL388PK3niK3ELnLspqim9YZtPmXTQnYbrY7x4G3
        Z/X8/xdKH0zmiuhZkWpgVqoebq7s+ii1+lKfsCHrtIAXaoEBntm7P31m/rh9Xf1HAcWs7r1u
        VewXQlh02nh5O/xnvVm8wokzbsH+tNrGCxzl7QVRScKOrgeaPllUFn+aumh1kDP7QRWb1bZh
        DExdB2OFXpuzsiiXNB6TFXU2MC589fXNnsd+f9Z1epxT/j3B5t+qsLS+g/6cO6aon2Vgn77j
        cMhzTX071op/vyP+fw9O157FMjPZXWdP3uop7UosxRmJhlrMRcWJAH874HmDAgAA
X-CMS-MailID: 20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b
References: <CGME20210622113915epcas2p284c61291fc9d83487f6dfebb65fd4e9b@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems 10 secs timeout is too long in general case. A core would wait for
10 secs without doing other task and it can be happended on every device.
It's better to reduce timeout for general case and use new quirk if needed.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/host/xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 9248ce8..0a1b6be 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -196,7 +196,7 @@ int xhci_reset(struct xhci_hcd *xhci)
 		udelay(1000);
 
 	ret = xhci_handshake(&xhci->op_regs->command,
-			CMD_RESET, 0, 10 * 1000 * 1000);
+			CMD_RESET, 0, 1 * 1000 * 1000);
 	if (ret)
 		return ret;
 
@@ -210,7 +210,7 @@ int xhci_reset(struct xhci_hcd *xhci)
 	 * than status until the "Controller Not Ready" flag is cleared.
 	 */
 	ret = xhci_handshake(&xhci->op_regs->status,
-			STS_CNR, 0, 10 * 1000 * 1000);
+			STS_CNR, 0, 1 * 1000 * 1000);
 
 	xhci->usb2_rhub.bus_state.port_c_suspend = 0;
 	xhci->usb2_rhub.bus_state.suspended_ports = 0;
-- 
2.7.4

