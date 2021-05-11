Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F88D37AF02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhEKTEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhEKTEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:04:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45A9F61554;
        Tue, 11 May 2021 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620759804;
        bh=c9M2Y2+yyr+0FJ4tZihcOTGkMl3MfiCdm0Drg1ijW68=;
        h=From:To:Cc:Subject:Date:From;
        b=L91wfspyKgSvXRaYSfuEEXMIpjgMyLa+aCDlqlPGQrSO4vGZDq5zgtd1alFCYxlPO
         kcuTLyM8JRcjN/kS4aq7AMIgPaGaS4XoSGeI/AWaZ51JPjJCSz2xYGPhsSAk/0zuvK
         c1rxojsuO3U4fI+sFH6k060/d9UDB0yZgE7BjUj/HhdKBB2+LCDOgvWJApBXXDIldt
         jyCSlvw/zCDarUpm7A+Nsyy2X+ZjhBKYuaKqHFhl6I/3pG3foh9ogfKH5YAX7PWxiy
         eibuJrZcasmcgZAhNtmqdsQaq2tUc8Hs/7p8HjQU8GUg41zFkiBzRg4CDXISEGaBYh
         75IbiqgYXX3gg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] Revert "ASoC: q6dsp: q6afe: remove unneeded dead-store initialization"
Date:   Tue, 11 May 2021 12:03:06 -0700
Message-Id: <20210511190306.2418917-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5f1b95d08de712327e452d082a50fded435ec884.

The warnings that commit 5f1b95d08de7 ("ASoC: q6dsp: q6afe: remove
unneeded dead-store initialization") was trying to fix were already
fixed in commit 12900bacb4f3 ("ASoC: qcom: q6afe: remove useless
assignments"). With both commits in the tree, port_id is uninitialized,
as pointed out by clang:

sound/soc/qcom/qdsp6/q6afe.c:1213:18: warning: variable 'port_id' is
uninitialized when used here [-Wuninitialized]
        stop->port_id = port_id;
                        ^~~~~~~
sound/soc/qcom/qdsp6/q6afe.c:1186:13: note: initialize the variable
'port_id' to silence this warning
        int port_id;
                   ^
                    = 0
1 warning generated.

Bring back the initialization so that everything works as intended.

Fixes: 5f1b95d08de7 ("ASoC: q6dsp: q6afe: remove unneeded dead-store initialization")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index c5c1818a6f75..729d27da0447 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1183,7 +1183,7 @@ int q6afe_port_stop(struct q6afe_port *port)
 	struct afe_port_cmd_device_stop *stop;
 	struct q6afe *afe = port->afe;
 	struct apr_pkt *pkt;
-	int port_id;
+	int port_id = port->id;
 	int ret = 0;
 	int index, pkt_size;
 	void *p;

base-commit: 4ac9b48adf4d561d0e33419d548278f205dd70b5
-- 
2.31.1.527.g2d677e5b15

