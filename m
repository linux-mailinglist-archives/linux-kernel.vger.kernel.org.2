Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE03C3EE5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 21:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhGKTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 15:49:04 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:37884 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229544AbhGKTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 15:49:02 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1FECF1834334A;
        Sun, 11 Jul 2021 19:46:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 1461720A295;
        Sun, 11 Jul 2021 19:46:13 +0000 (UTC)
Message-ID: <d3a180c3dc8db68a25440edf466cfeddcaae5a64.camel@perches.com>
Subject: drm/amd/display: Simplify hdcp validate_bksv
From:   Joe Perches <joe@perches.com>
To:     Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 11 Jul 2021 12:46:12 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: 539sh6xq8seofo8ke64ezq5hhueemyjt
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1461720A295
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX199Uq/CjUUQdOfJPyou+ohMOJSTDeqoedM=
X-HE-Tag: 1626032773-460936
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 06888d571b51 ("drm/amd/display: Avoid HDCP over-read and corruption")
fixed an overread with an invalid buffer length but added an unnecessary
buffer and copy.

Simplify the code by using a single uint64_t and __builtin_popcountll to
count the number of bits set in the original bksv buffer instead of a loop.

This also avoid a possible unaligned access of the temporary bksv.

Signed-off-by: Joe Perches <joe@perches.com>
---

It seems quite odd 20 bits set is a magic number here.
Should it be a specific be/le value instead?

 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index de872e7958b06..78a4c6dd95d99 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -28,17 +28,10 @@
 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
 {
 	uint64_t n = 0;
-	uint8_t count = 0;
-	u8 bksv[sizeof(n)] = { };
 
-	memcpy(bksv, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
-	n = *(uint64_t *)bksv;
+	memcpy(&n, hdcp->auth.msg.hdcp1.bksv, sizeof(hdcp->auth.msg.hdcp1.bksv));
 
-	while (n) {
-		count++;
-		n &= (n - 1);
-	}
-	return (count == 20) ? MOD_HDCP_STATUS_SUCCESS :
+	return (__builtin_popcountll(n) == 20) ? MOD_HDCP_STATUS_SUCCESS :
 			MOD_HDCP_STATUS_HDCP1_INVALID_BKSV;
 }
 


