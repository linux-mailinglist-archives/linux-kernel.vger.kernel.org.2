Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B945D7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354346AbhKYJ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351403AbhKYJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:55:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC20C061758;
        Thu, 25 Nov 2021 01:52:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso7812554wmr.4;
        Thu, 25 Nov 2021 01:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CtPmrpYr9FiDpTXd3LZYhMSJMkf3FHjKgX90xdY/MZw=;
        b=YBkfENrKTMYdi9hDB53l+uFIF16Y5kzRKjai/iYLc2I96/s1EbbQpiPsiPJWdr2JJr
         cShpznljdZ9kxttFrsMDjUuD713GsmrHwU9YSvhNMmCaYFM/wQnWy68UvE86rUTuoOVN
         Z8hLDEFyFBWbw6TVcW1VlRI7vyBq0Bq2qggYJhOUmVVqMbRGTdenTBYJUxY0OGVtMF2h
         5UIgtg5ghYHiyimrBgRXLubqDbNmlFyC8MRfW5UjVTHd+ybLH1OU5D7FrFa6SwVkZN9f
         eI/3Rr93o30kjnYZTBmSq9tAIRXaKdBCHeFDn6mAW9JzOr8IukAGy5rHY4Dc/q0F/Mgy
         1KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CtPmrpYr9FiDpTXd3LZYhMSJMkf3FHjKgX90xdY/MZw=;
        b=5lD6EuP9E+9ioUD3t09GkAnBnYj7yb2f1VZEN7GBAc53gI7f69ucl5CHwYsWfeyyiD
         x4D5NxKDdq7KR81ubopCha61FmYvpErtATXxS3p+g5jdQk/wUrOCci5+ZI2Jgf4FRmM1
         79EhCx5Q+wMxb/Yt89t1oiO7BIqgke3spHwZNXSCf1A4aUU5RY7vFgJuyp9lCtzMYCQ8
         lx2HYlaHNIecEdhQWouRJHbXuMdP9lYd6ejMrTVP4lM+8WGIvmn95hEfw//u/Xqd5E3+
         jW0nBcv32PAUhFuchHHOOuhaLbxRkBn/x2+Ntr7UIQ/i4T9MCS5n49Cy3Ll7DWyes9Gb
         oTog==
X-Gm-Message-State: AOAM533Ln4Tan/g+oG8/BQqTDVog0/lk+8+vyhPrV9/9pMo8D/8G3ygc
        RRzkE9R0NFoS3cc0hU1O9+0=
X-Google-Smtp-Source: ABdhPJzNEFk8SIxr8fH/3pyKqDj4fbQ2NQd6f198nSEoiAOLdUwr6rkVWXEhhfB4xZQ0YHzNSfucFQ==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr5608253wmi.46.1637833945112;
        Thu, 25 Nov 2021 01:52:25 -0800 (PST)
Received: from localhost.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id c1sm2310853wrt.14.2021.11.25.01.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 01:52:24 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] ASoC: codecs: wcd938x: add SND_SOC_WCD938_SDW to codec list instead
Date:   Thu, 25 Nov 2021 10:51:58 +0100
Message-Id: <20211125095158.8394-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125095158.8394-1-lukas.bulwahn@gmail.com>
References: <20211125095158.8394-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 045442228868 ("ASoC: codecs: wcd938x: add audio routing and
Kconfig") adds SND_SOC_WCD937X, which does not exist, and
SND_SOC_WCD938X, which seems not really to be the intended config to be
selected, but only a supporting config symbol to the actual config
SND_SOC_WCD938X_SDW for the codec.

Add SND_SOC_WCD938_SDW to the list instead of SND_SOC_WCD93{7,8}X.

The issue was identified with ./scripts/checkkconfigsymbols.py.

Fixes: 045442228868 ("ASoC: codecs: wcd938x: add audio routing and Kconfig")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 sound/soc/codecs/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3fe62df32238..b6d1827e7986 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -241,8 +241,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_UDA1380
 	imply SND_SOC_WCD9335
 	imply SND_SOC_WCD934X
-	imply SND_SOC_WCD937X
-	imply SND_SOC_WCD938X
+	imply SND_SOC_WCD938X_SDW
 	imply SND_SOC_LPASS_RX_MACRO
 	imply SND_SOC_LPASS_TX_MACRO
 	imply SND_SOC_WL1273
-- 
2.26.2

