Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE93BBA57
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhGEJlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhGEJlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:41:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56A2761357;
        Mon,  5 Jul 2021 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625477942;
        bh=uBTI/CCNPuHkzGumin/E2AqnTSr5suczbA9cPn5m2N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvyLIvhhS4LIjk4A91iwFsPUD1NHHF5WAX23C+utgZbloPMCViUUrGEXKyIg7VmMb
         Z2AgKzVcyvAkVNkk2g/B+IOpFS8ZFMfJodGMolfsqFd7Wot9xm+cTuIgpgVxpLE+ND
         YBLQa5pogStXggIGEYSou6o4I34WNMHGEtgSOSjPK/Ims28BbRCcgFvPBfFAhTHRDN
         ddKpGZSDUx64ID23CcDGTMOP1Tbe0hGOvv4KbPk7WUiC0n8mS0kebhX736dc8HvKnN
         RBq1KQslLBkdjOnXsxKz5ncio2bDPQb/plXipzV/buAXxHqH2zJXRhzFoSVzmlomb6
         lKBdawjBPUV+w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m0L43-002toq-8M; Mon, 05 Jul 2021 11:38:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v12 3/9] regulator: hi6421v600-regulator: add a missing dot at copyright
Date:   Mon,  5 Jul 2021 11:38:44 +0200
Message-Id: <f03c2d3a1491beb6188abf3e4b375deba1d12dc7.1625477735.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625477735.git.mchehab+huawei@kernel.org>
References: <cover.1625477735.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Huawei's copyright is missing a dot at the end. Add it,
in order to make it similar to the other two copyrights.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 845bc3b4026d..916d4e1f9061 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -4,7 +4,7 @@
 //
 // Copyright (c) 2013 Linaro Ltd.
 // Copyright (c) 2011 HiSilicon Ltd.
-// Copyright (c) 2020-2021 Huawei Technologies Co., Ltd
+// Copyright (c) 2020-2021 Huawei Technologies Co., Ltd.
 //
 // Guodong Xu <guodong.xu@linaro.org>
 
-- 
2.31.1

