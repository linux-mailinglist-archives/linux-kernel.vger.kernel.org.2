Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DA43B9D11
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 09:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGBHkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 03:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhGBHkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 03:40:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E387661425;
        Fri,  2 Jul 2021 07:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625211450;
        bh=uBTI/CCNPuHkzGumin/E2AqnTSr5suczbA9cPn5m2N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMqfmuuePkZ4OfrZS/DTu872MSYrr8Ud3TINuNif16N9+9bzBWsxJTGSMojg4pi7r
         OPuDGFWnFVzcL11iTzbZQ4XZYcFL4ZURxk0XGP/2my59J80se1gyjhY0TEDEvmkrzo
         1Mzk/npHHPXnoTnZlvRIuIi4INQyrclzFZei2DAxYdGaVYG2Qpf2vfrnpWd7lUivSm
         VFWTEXIvoSbUws6OUK3v7mplpeEiE49sdUkJpfGJrvl5XdS9NMqRw4mEpBH59GmEwP
         xQInL42d/dBoLOObqg50PdXt2eHb2MIHJmflDFSUxGysC4rxCPhtkFhCQ8pb6l/tFm
         94m4y9E9EHTMQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lzDjo-000gZm-OY; Fri, 02 Jul 2021 09:37:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Axel Lin" <axel.lin@ingics.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/8] regulator: hi6421v600-regulator: add a missing dot at copyright
Date:   Fri,  2 Jul 2021 09:37:17 +0200
Message-Id: <e9c0f27688d7be75652800e67c913878fd772cbe.1625211021.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625211021.git.mchehab+huawei@kernel.org>
References: <cover.1625211021.git.mchehab+huawei@kernel.org>
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

