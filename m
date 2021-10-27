Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E3C43D16B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbhJ0TLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:11:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231572AbhJ0TLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:11:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97EF860296;
        Wed, 27 Oct 2021 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635361735;
        bh=S4l6QXgwpR+ap6FEjSf8z0UBhaHkW1+FoXkUNyVM84U=;
        h=From:To:Cc:Subject:Date:From;
        b=p3KrmKNJLJ1JDfZap2w4kC18EoZv83npg5JRuzMGKZnbm7vQaBY69LhJ/tCdJb9jK
         Ytv5qMdR0ZwqvSVtEVD2aP+/yA5AXC3jlzTv3SWYuQ4oprtm6GMSZiCCuEQpOpr3TS
         cXTMVJgA8ptOtjoirhemKqCzPUf8PGzcISelnnAv+z8wHWWqOp8RpvhXeupK8esC2I
         62uSqkxQyg1tBajZiCpXtj3f0jKVVzt5GyHrz1ITb8AmxOZlxl0cFvZ4s0G2FXr7ii
         01iWCnOP+wbIsHf+iBWfmS+BzjX4iH1dB5uwxIzaPjQ7Py3AWf924SI3h0ngQworoB
         b9zkdu5wLS4Sw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] ASoC: qdsp6: audioreach: Fix clang -Wimplicit-fallthrough
Date:   Wed, 27 Oct 2021 12:08:23 -0700
Message-Id: <20211027190823.4057382-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.1.637.gf443b226ca
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

sound/soc/qcom/qdsp6/topology.c:465:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                default:
                ^
sound/soc/qcom/qdsp6/topology.c:465:3: note: insert 'break;' to avoid fall-through
                default:
                ^
                break;
1 warning generated.

Clang is a little more pedantic than GCC, which permits implicit
fallthroughs to cases that contain just break or return. Clang's version
is more in line with the kernel's own stance in deprecated.rst, which
states that all switch/case blocks must end in either break,
fallthrough, continue, goto, or return. Add the missing break to fix
the warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/1495
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 sound/soc/qcom/qdsp6/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index f31895379925..bd649c232a06 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -461,7 +461,7 @@ static struct audioreach_module *audioreach_parse_common_tokens(struct q6apm *ap
 			break;
 		case AR_TKN_U32_MODULE_DST_IN_PORT_ID:
 			dst_mod_ip_port_id = le32_to_cpu(mod_elem->value);
-
+			break;
 		default:
 			break;
 

base-commit: 1dcc81d95b910dc404c40ff6101bfa2520a3528e
-- 
2.33.1.637.gf443b226ca

