Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F13398846
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhFBL16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhFBL1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:27:11 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD05C061352
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 04:24:59 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r1so1965152pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=li91TkB8vt4LZTs/ZRDPEkBtTqhmB+m8Wqp+53J3jpY=;
        b=aonkHIp6X5zJfn9dkevz/e7hkCumER3RcmOsiw9du/9D9yv94CjQLo/uYyuC/XvNPf
         SohKN8bPTJ8DIEn3p+38+e/UxffGTjgmc2yVx0mpVd9jw1xOAnvgrFB5P/4IoInc+373
         Yb3dj/a26fUyuxUZC5tisApOpD1X0pSwB1ljE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=li91TkB8vt4LZTs/ZRDPEkBtTqhmB+m8Wqp+53J3jpY=;
        b=mR9ecGXLp3oeVfXIh973nXReVkxd/ov4iGfKjGorH/xLMgDbP/EvugVOKDlEXHujaH
         iiXOLJ6NGK4a4jdasP//SDAsr+pfh/p/K+e5tH45XUk3YtdXM9pbFBJ7P9v9PgTzG+0w
         eb7Jv1sfwwMBr/1aK+2oJcI6r6x28/yqC9QMuEuhnpUAs806DPwLb8ZpjtFI0T+dywAH
         jmV7XNUiGtvRVGduLn8VJZjtyiygNw1HC7rqN3ZJMaVPU/7yX+emKOc6GguYwjPDPdzu
         gP3v+nX6lC8JHrknzv5pENHHDW4gxzxHQHU1eK4t9YqlIjGXkocjl53VIPR+P3S4OVm3
         AFAQ==
X-Gm-Message-State: AOAM532cSYEozPZk3HemMGtTLnh1IAUAtN1JVejMCUOpmfbYfladnT2s
        GzlmjKAYFWxYEZLObQ8eZ2uIlA==
X-Google-Smtp-Source: ABdhPJxpfZpr0xBPXyYNB5hyvH20vouT4QUVROCCeFjRrQPFQFstm2zrwf9q7Ou5UnmCblp40cXiWA==
X-Received: by 2002:a63:b507:: with SMTP id y7mr33357175pge.74.1622633099202;
        Wed, 02 Jun 2021 04:24:59 -0700 (PDT)
Received: from 5f9be87369f8 ([124.170.34.40])
        by smtp.gmail.com with ESMTPSA id t1sm10568249pfe.61.2021.06.02.04.24.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jun 2021 04:24:58 -0700 (PDT)
Date:   Wed, 2 Jun 2021 11:24:53 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     broonie@kernel.org, ezequiel@collabora.com, chenjh@rock-chips.com,
        pgwipeout@gmail.com
Subject: [PATCH 1/2] dt-bindings: regulator: Add support for TCS4526
Message-ID: <20210602112452.GA98@5f9be87369f8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string to support the TCS4526 device,
which is compatible with Fairchild FAN53555 regulators.

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 Documentation/devicetree/bindings/regulator/fan53555.txt | 2 +-
 1 file changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fan53555.txt b/Documentation/devicetree/bindings/regulator/fan53555.txt
index e7fc045281d1..013f096ac0aa 100644
--- a/Documentation/devicetree/bindings/regulator/fan53555.txt
+++ b/Documentation/devicetree/bindings/regulator/fan53555.txt
@@ -2,7 +2,7 @@
 
 Required properties:
   - compatible: one of "fcs,fan53555", "fcs,fan53526", "silergy,syr827",
-		"silergy,syr828" or "tcs,tcs4525".
+		"silergy,syr828", "tcs,tcs4525" or "tcs,tcs4526".
   - reg: I2C address
 
 Optional properties:
-- 
2.29.2


