Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4274232B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhJEVMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhJEVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:11:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1870C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 14:10:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j8so1885272wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=8cOH/aG07yStMJLzdyU38hYk2b3hNYwCSPojlLwanZQ=;
        b=R8MwJ0tIK2L+R3h4gQsUM0c6pGMMQLpPwSCy4xxruJ4g6r8Vse/KBgz1R3p0S2EOj/
         hXs2WPQEu9EcZpa79OrwqbHAcQYOhVA9rHZ1ZQRyRNFK1Y5pI/PlmfxYbMvHwywUepNB
         eWX2tqwFmr6sP9j88+YFc+IZk6nO7CwsdEC4JUAJz/xA6CHCe7Ws/jI+sURoXTu5vqAx
         PNwirMo0KGsGF9I+bcCXMivW4Dlsx5BquJlvU4PSZ3GGIgaDG/3V4LA3SO7jnuPFe9+0
         6y5+Oar2skbaPVxzjBhN0QNtynIOwu5ywPGe2a0c58JLRCh6B3ZxXJVRnr9ItLV2Pvm4
         wckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=8cOH/aG07yStMJLzdyU38hYk2b3hNYwCSPojlLwanZQ=;
        b=fgr28GdgXLNVXR2SNAhmbVLZNXWNnXVQoQF5cCLxQHvu9mMfjgNLVOmL5Xd4ng0ct/
         Bo2VBBwActbrBcJ6txeepsEiFDIwM8m4/DQy3T+fvrPHdE+ePulz9qhykSmhcEfbwIY/
         zTiiNBPP+fNYwaydp2v9fO/Z9W8p1AniASU3JmctjomZ8ubZBcwXi51Hddr+JWVvGOnQ
         tzieIud16osqT5mVMA33aV4g3dr42laRPoLsx82/tN/WlnZ6KN2t8fCcgum4Yq4Qlt+A
         umN9lF1W+ixmDGKw8Yd8GmEZeudTTqjY93mD2z0WCOhKJll3UlkvnsLRXZKZU3k9i+Oh
         Vj4w==
X-Gm-Message-State: AOAM532ulkbkPsl0sgA7xC2BPCoI9IwqkGA8GhpuD/tcMVUVf/Qjl7IJ
        V3H7aV9g8Z/sS9aHqlKsF8hcTkRgtybPpSbM
X-Google-Smtp-Source: ABdhPJx9+OuO1WcGHSnCt3qauKwt8c+gQ7auzMFFEE8j3SSHNik7sFMve3qubFL/ro1qfD7tUeTUlw==
X-Received: by 2002:adf:e0cc:: with SMTP id m12mr24585470wri.62.1633468206947;
        Tue, 05 Oct 2021 14:10:06 -0700 (PDT)
Received: from ?IPv6:2a02:8084:20c7:8d80:d71c:ed62:e10a:e7ca? ([2a02:8084:20c7:8d80:d71c:ed62:e10a:e7ca])
        by smtp.gmail.com with ESMTPSA id 189sm3575827wmz.27.2021.10.05.14.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 14:10:06 -0700 (PDT)
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
From:   "Siou-Jhih, Guo" <hallblazzar@gmail.com>
Subject: [PATCH v3] staging: r8188eu: Fix misspelling in comment
Message-ID: <681b368a-d326-ffc6-3a21-ef735ad1ee54@gmail.com>
Date:   Tue, 5 Oct 2021 22:10:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As format check raised by scripts/checkpatch.pl, comment in the rtw_ap.c
looks misspelled by accident. Help fix it.

The original error is as below shows:

CHECK: 'followign' may be misspelled - perhaps 'following'?
+Set to 0 (HT pure) under the followign conditions

Signed-off-by: Siou-Jhih, Guo <hallblazzar@gmail.com>
---
Changes in v3:
  - Fix wrong signed name in "From" field in email header(mismatch with
    sign-off).
  - Refer to the latest commit, ecd667f5f.
  - Add missing change log between each patch version.

Changes in v2:
  - Remove redundant "Subject:" from Subject
  - Fix missing public mail list in cc list
---
 drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 94e02aad96b7..205168f960f6 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -744,7 +744,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 
 /*
 op_mode
-Set to 0 (HT pure) under the followign conditions
+Set to 0 (HT pure) under the following conditions
     - all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
     - all STAs in the BSS are 20 MHz HT in 20 MHz BSS
 Set to 1 (HT non-member protection) if there may be non-HT STAs
-- 
2.25.1

