Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BAF3B11DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 04:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFWCp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 22:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhFWCpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 22:45:53 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7438BC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 19:43:36 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 297D480719;
        Wed, 23 Jun 2021 14:43:31 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1624416211;
        bh=6m75k33uLkoEGCsnXHFsQuSUeJtVMSaMAYRp55SjWOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=yGP9CCV5YXeNFYbpHK5sR6rxAR+cT1tIgmtu4NpafVLIOimvL7loJykgaWYolEMsW
         5xN+j2k1/WSr16zMnRPevimX+JRHvTsjX+ir5d/Xk8Xi/zJ65i6f+tU/Krl3gRmCeK
         Oq6ezvGoEXKhQMXdGj002WeJXvn/JSVdtG3wl0atg8STV/6OfXDVmKPP8+h+GEOzB1
         4iq8lgG4apYlJWZwVsVBd2BCAKQbwjWs5rjI698WO3WA5jPkLCgv98XdEk7A4CCL/I
         4tnir93Abb0mumrSjdXScdxpsYcC+9g+IDR2l54RVNVzEbnP/pqnN0+wgy5OE5Gxn6
         R5xcYVNNp3VLg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60d29fd20002>; Wed, 23 Jun 2021 14:43:30 +1200
Received: from pauld-dl.ws.atlnz.lc (pauld-dl.ws.atlnz.lc [10.33.23.37])
        by pat.atlnz.lc (Postfix) with ESMTP id D9EEF13EEB4;
        Wed, 23 Jun 2021 14:43:30 +1200 (NZST)
Received: by pauld-dl.ws.atlnz.lc (Postfix, from userid 1684)
        id D631D1E0560; Wed, 23 Jun 2021 14:43:30 +1200 (NZST)
From:   Paul Davey <paul.davey@alliedtelesis.co.nz>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Paul Davey <paul.davey@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] bus: mhi: Fix pm_state conversion to string
Date:   Wed, 23 Jun 2021 14:43:26 +1200
Message-Id: <20210623024327.15029-2-paul.davey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623024327.15029-1-paul.davey@alliedtelesis.co.nz>
References: <20210623024327.15029-1-paul.davey@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=IOh89TnG c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=r6YtysWOX24A:10 a=xDYxNL215i3Ysd8OqoQA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On big endian architectures the mhi debugfs files which report pm state
give "Invalid State" for all states.  This is caused by using
find_last_bit which takes an unsigned long* while the state is passed in
as an enum mhi_pm_state which will be of int size.

Fix by using __fls to pass the value of state instead of find_last_bit.

Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
---
Not adding Tested-by or Reviewed-by tags as this patch has changed
substantially from v1.

 drivers/bus/mhi/core/init.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index c81b377fca8f..0706eb046f2a 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -79,9 +79,12 @@ static const char * const mhi_pm_state_str[] =3D {
=20
 const char *to_mhi_pm_state_str(enum mhi_pm_state state)
 {
-	int index =3D find_last_bit((unsigned long *)&state, 32);
+	int index;
=20
-	if (index >=3D ARRAY_SIZE(mhi_pm_state_str))
+	if (state)
+		index =3D __fls(state);
+
+	if (!state || index >=3D ARRAY_SIZE(mhi_pm_state_str))
 		return "Invalid State";
=20
 	return mhi_pm_state_str[index];
--=20
2.32.0

