Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1988D38F1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhEXQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:47:22 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:53462 "EHLO
        1.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEXQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:47:21 -0400
X-Greylist: delayed 5045 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 May 2021 12:47:20 EDT
Received: from player797.ha.ovh.net (unknown [10.110.208.124])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id EB6EA207E39
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:21:45 +0200 (CEST)
Received: from mrtz.fr (lfbn-lyo-1-490-81.w2-7.abo.wanadoo.fr [2.7.79.81])
        (Authenticated sender: harold@mrtz.fr)
        by player797.ha.ovh.net (Postfix) with ESMTPSA id ECC801A5C91A4;
        Mon, 24 May 2021 15:21:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G005c8330ba4-4892-4bbc-9840-5d478b1168bf,
                    C140F9C3D5E2866CE6A0DF242C55A977A0D9EDE7) smtp.auth=harold@mrtz.fr
X-OVh-ClientIp: 2.7.79.81
From:   Harold Mertzweiller <harold@mrtz.fr>
Cc:     Harold Mertzweiller <harold@mrtz.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Sean Behan <codebam@riseup.net>,
        Colin Ian King <colin.king@canonical.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: fix alignment issues
Date:   Mon, 24 May 2021 17:21:26 +0200
Message-Id: <20210524152128.20519-1-harold@mrtz.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14161850503387417869
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -55
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnehmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegoteeftdduqddtudculdduhedmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefjrghrohhlugcuofgvrhhtiiifvghilhhlvghruceohhgrrhholhgusehmrhhtiidrfhhrqeenucggtffrrghtthgvrhhnpefhudekgefhheevleeugeehvedufeelieeggefgvdegheevheekvdfhgeduveevheenucfkpheptddrtddrtddrtddpvddrjedrjeelrdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhephhgrrhholhgusehmrhhtiidrfhhrpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three function calls can now be properly formatted inside the 100
characters limit.

Signed-off-by: Harold Mertzweiller <harold@mrtz.fr>
---
 drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index ecc5c9da9027..b6abd3770e81 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -1073,9 +1073,8 @@ static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep,
 		i_word_length = length / sizeof(u32);
 		if (i_word_length > 0) {
 			for (i = 0; i < i_word_length; i++) {
-				_nbu2ss_writel(
-					&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
-					p_buf_32->dw);
+				_nbu2ss_writel(&preg->EP_REGS[ep->epnum - 1].EP_WRITE,
+					       p_buf_32->dw);
 
 				p_buf_32++;
 			}
@@ -1225,8 +1224,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
 		return;
 
 	if (ep->epnum > 0) {
-		length = _nbu2ss_readl(
-			&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
+		length = _nbu2ss_readl(&ep->udc->p_regs->EP_REGS[ep->epnum - 1].EP_LEN_DCNT);
 
 		length &= EPN_LDATA;
 		if (length < ep->ep.maxpacket)
@@ -1462,8 +1460,7 @@ static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc,
 		for (limit_cnt = 0
 			; limit_cnt < IN_DATA_EMPTY_COUNT
 			; limit_cnt++) {
-			regdata = _nbu2ss_readl(
-				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
+			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
 
 			if ((regdata & EPN_IN_DATA) == 0)
 				break;
-- 
2.20.1

