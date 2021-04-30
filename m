Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3764836FC3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbhD3OWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233014AbhD3OWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619792484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w/gN216hU1Rn3Btpd2kd7hL2tCgT/dn3Xe/SlBBd5lo=;
        b=eoOA7g5rveBq7BUcV8o+nlVHkhCZssgwJltvK4CXhx1XsYHRR3bknELuTIpZgGpBs+13iw
        hBTWFctenKz8ncTpLC6WbK5qYYcBvZjvEabAJWxvGz3LvOtjHqDWGYziGrgw9WbhdBjPF6
        CErAWaMBiLtxWTqLQLNHMkWWnZYw6pM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-6BwuBKSQOZyyb2CVL0S5aA-1; Fri, 30 Apr 2021 10:21:22 -0400
X-MC-Unique: 6BwuBKSQOZyyb2CVL0S5aA-1
Received: by mail-qk1-f198.google.com with SMTP id h15-20020a37de0f0000b029029a8ada2e18so30374847qkj.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/gN216hU1Rn3Btpd2kd7hL2tCgT/dn3Xe/SlBBd5lo=;
        b=gg4U9pf5Z8RhuzsBDqY9vEEtsErPhMBLnwn/zksTlMzHrqfAUVnAsPRDQ5EeWiWhNm
         YB3Q7QIKPPEatYRr+Kj9U3m3G6FXRgSaYK2EyTaLUftwSXFuRLv/5U+UN7fydb9Tu2u7
         upgyLQ/5pg7owb+JH4FEnELzUtV9uKdR7605btyn3eSXIQZGfTTcdqyfZoxRdhNb+0HX
         e+OvFV0L3MVIIpGOznDUROEgTGODDLrjtZA6sfaxM4E4kH1P5+HHW+9RutV9hc6kNDVz
         iL0ndJPcrDiKWc8iO30NVtoLlNeweO392zyZwjciw5/QqhYN0jrKW4NvD6F+0V2JfGBx
         Pxxg==
X-Gm-Message-State: AOAM532wLY+Ua+JTbyMwNuPfZrgjw2X18AN24GbcY9J7WMXNG+t2zJSW
        SRuGbyQtbQV5LbjfBDcljshdsdBIfhfr4wIPiaoZM580SK1CFG20FtWfqOzFq8vkfNOyruelm/z
        nnc0XulSu9IndU762d2Kw7uTC
X-Received: by 2002:ac8:5ac6:: with SMTP id d6mr4946505qtd.18.1619792482420;
        Fri, 30 Apr 2021 07:21:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdZI/RkrGjDivkFxS4UsfSFFktmqzzu95SsUqZ3E9oGQ70pLr6U5HZ8qsqrD35IpwXr+REig==
X-Received: by 2002:ac8:5ac6:: with SMTP id d6mr4946481qtd.18.1619792482162;
        Fri, 30 Apr 2021 07:21:22 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 1sm1477180qka.52.2021.04.30.07.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:21:21 -0700 (PDT)
From:   trix@redhat.com
To:     srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] ASoC: codecs: lpass-wsa-macro: handle unexpected input
Date:   Fri, 30 Apr 2021 07:21:17 -0700
Message-Id: <20210430142117.3272772-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem

lpass-wsa-macro.c:1732:6: warning: Array subscript is undefined
        if (wsa->ec_hq[ec_tx]) {
            ^~~~~~~~~~~~~~~~~

The happens because 'ec_tx' is never initialized and there is
no default in switch statement that sets ec_tx.  Add a default
case that returns an error before the array is accessed.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2:
  - handle the input error, keep switch
---
 sound/soc/codecs/lpass-wsa-macro.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 1a7fa5492f28..d3ac318fd6b6 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1727,6 +1727,10 @@ static int wsa_macro_enable_echo(struct snd_soc_dapm_widget *w,
 		val = val & CDC_WSA_RX_MIX_TX1_SEL_MASK;
 		ec_tx = (val >> CDC_WSA_RX_MIX_TX1_SEL_SHFT) - 1;
 		break;
+	default:
+		dev_err(component->dev,	"%s: Invalid shift %u\n",
+			__func__, w->shift);
+		return -EINVAL;
 	}
 
 	if (wsa->ec_hq[ec_tx]) {
-- 
2.26.3

