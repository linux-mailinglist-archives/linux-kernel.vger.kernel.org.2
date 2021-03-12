Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD14338693
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhCLHbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhCLHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:31:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93011C061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:31:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z1so6549907edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85FTr8CtWZi7ZTbKGT7x0/typLYu/sxAfnMblivg5KA=;
        b=his6owhZa67rd6+8ImNixx8KFUBCqUHledGahWGFtejo2HliAv4AwHeShz619wuPSa
         PPXwLSeBYsnD7NNHganXwlqztk8SIKPl+UU0sw7YFh1ehUy6p6y+T+IXxCBvtFHxhYfN
         px6B93b/Lk2lVNAI1kIlEhXxRVgrdPwWfiWZBvIXNF0FBwoPWD/YY3UhtBwXAdzErc3P
         MK93j0pL6zaChQRp19UQ8n4CTFM9SjduSsQ/lmvDU0erVUsfCC9jCC9jqL4VNW/9r4Gs
         QAQ7ltWBzWeOFQSR0vrcpTHHnWtcSUtxTKGFzN+0+YiZwsPadphR0emWYbmQOEVEDAUO
         jcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=85FTr8CtWZi7ZTbKGT7x0/typLYu/sxAfnMblivg5KA=;
        b=JF5oRvv2SV0QHTaAHRBdDmmQGomclBmUiO+nbI8cu1I9sWVu+xDxSUPGVNMjE2LfOZ
         /wXltS+0r874GwWD5/wdx162nMIPefWy0t/7SilF8lEzxhB+jj/HXRrORihWIYar05sX
         y2T7HTRj+KZhnZqtlO3KbtN1JbG1piXXddrkm3LmHrLFCm4DdGKNhyrsldtMpBIRQzuG
         FbjkolErE7wfmXt8wDrsE13nUTC1Wgch1fcwLF2LBFbH1iOMP8C7Z7uRnWJp5R9D8Kuu
         ChOeV5xlKO+EEdUWW3z9WPtMTv+rhpvlQ6b9KyQokw/qrhrqGKDnsrVRVO4tF6qWhowP
         vR9A==
X-Gm-Message-State: AOAM530pwWCPDBNhwPIuKcAFwG5OnAXuIzj1LQPu08f3dJLGKA3XXwZ/
        XFqzU4JK6V5cObIF+g1EIeH3XulvVdgVcp+M
X-Google-Smtp-Source: ABdhPJw98Ym+p9UPqE9aBe2e/cvMX9+FBoTewDHD+AIzg1CYVml7UPcdtDFkJYG/Rv2lAhWI9i/uhA==
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr12862709edw.354.1615534298928;
        Thu, 11 Mar 2021 23:31:38 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id l18sm2326832ejk.86.2021.03.11.23.31.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 23:31:38 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     colin.king@canonical.com, dan.carpenter@oracle.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH] pinctrl: core: Set ret to 0 when group is skipped
Date:   Fri, 12 Mar 2021 08:31:34 +0100
Message-Id: <e5203bae68eb94b4b8b4e67e5e7b4d86bb989724.1615534291.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analyzer tool found that the ret variable is not initialized but
code expects ret value >=0 when pinconf is skipped in the first pinmux
loop. The same expectation is for pinmux in a pinconf loop.
That's why initialize ret to 0 to avoid uninitialized ret value in first
loop or reusing ret value from first loop in second.

Addresses-Coverity: ("Uninitialized variables")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
CC: Colin Ian King <colin.king@canonical.com>
CC: Dan Carpenter <dan.carpenter@oracle.com>
---

 drivers/pinctrl/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index f5c32d2a3c91..136c323d855e 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1266,6 +1266,7 @@ static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 			break;
 		case PIN_MAP_TYPE_CONFIGS_PIN:
 		case PIN_MAP_TYPE_CONFIGS_GROUP:
+			ret = 0;
 			break;
 		default:
 			ret = -EINVAL;
@@ -1284,6 +1285,7 @@ static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 	list_for_each_entry(setting, &state->settings, node) {
 		switch (setting->type) {
 		case PIN_MAP_TYPE_MUX_GROUP:
+			ret = 0;
 			break;
 		case PIN_MAP_TYPE_CONFIGS_PIN:
 		case PIN_MAP_TYPE_CONFIGS_GROUP:
-- 
2.30.1

