Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418B2399243
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhFBSNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhFBSNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:13:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CC1C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 11:11:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso3947259pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GuUNe4sUbo8SYTJ3ZCyTMOYGwjKXZAJXEGqFop91ew=;
        b=Ry6vjTsznuzxu8W5O1DZkGVTjrLlo1KrgmIMAdFmU6cz2udwGF1gR0wD+bMu2MmYu/
         6lC4HrMDPCdXi59jSpLB5dIH1BnTgVij4NK1Ud34VraK+cbueZexA6NKJQgPZH+aexWG
         ZbvEyjb1m9Fu8EjzudGIz7vBkhccDZb6caNRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GuUNe4sUbo8SYTJ3ZCyTMOYGwjKXZAJXEGqFop91ew=;
        b=rVTKoQxyMTrsKl8UZWFkiqv0TF5CUD4NI2q9UjiaXyY/z1+1Qs22/LeGkiQxVQOhOr
         vOGJbclDkO1r5IWV0EFZmaE7tPSnGlUEIdPkiaeKuexycJqkZwFCE1U6peKvRfC73KVY
         iPlT6VYTk/s9r35isIKjhGq58wnt6fXyPbOdurxeF7vHzxenNbQx+6oFtPd8QvFGu0U/
         twI68ZyIU+5E99iVzp1MjfrfLL7ve2jUUl6HONGmMSONAWQ2/BhumWxPj8VH3+gn4JsF
         //QTRdJaLE5l2M1bQMpViJCdJZpifZX8JSDwiVMMYevLR4HycYwg2r24n1SkMBbGsP3d
         BFKA==
X-Gm-Message-State: AOAM533INu8d24yT4bTxEQV+hSJqPrASBLZPbb/eiX4zCcLGmyGdgMq1
        gzAY2vFnYlECFlRJvLDciYtwuQ==
X-Google-Smtp-Source: ABdhPJzzszQ4456Ap1WdtkdbN8tapHCqtT/yvYuGCx7dNarmq+s0H0g6yROU36W8D05oQxchGMWumA==
X-Received: by 2002:a17:90a:9bc4:: with SMTP id b4mr6703832pjw.42.1622657496853;
        Wed, 02 Jun 2021 11:11:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n69sm270015pfd.132.2021.06.02.11.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:11:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jay Vosburgh <j.vosburgh@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] net: bonding: Use strscpy() instead of manually-truncated strncpy()
Date:   Wed,  2 Jun 2021 11:11:33 -0700
Message-Id: <20210602181133.3326856-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=3f61903c76c789f32d65acb60d6b57550ace0464; i=+jq1hjyNarBiZF1iCP+ld51I3zySb92TJIxasbU5Dvg=; m=Ah79ZzdISBOESKLrfqwFLaaLO/pavYkh4XaFeC1dpRE=; p=wiF5U0J2tCL474X+qPHfVl2ssY7ZE/qDY5eF8gxKAwA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC3ydUACgkQiXL039xtwCYZZxAAhUb 2z0F2AYS4Vmc+SCkudP4bOpCOnqSNfTHvMi+9y5JsQaxeNUUnuKquDnNxbX1FuLqHIJtyB0yya9o2 5b7Ayx9JHiZD3bDCUcAt3LZBFP1Cp26q8aXgupLZjzqN80OLMfHcfBDnTWC7tVnedVPbyVfl+xmpJ ej1rzkAWzVcG9g4Ez/gIzJg8+5Ca1L0beLZnsVXy7+VUXGGcyEWSxLCfnVMKxgzIgjZdL6UDLW78k qv7n0CCdQhX2wlS0epA3Uc0xlYwkMC5h8ym/rWLQ5l8tARqQvLhJDrgiRmWrhirhHdDnrF8XO8fLo XGFVWSFWTLy52KSLHLzuQqrUxYUla0g+EigLOtCRxxZ/t4ITiFEfyiyWaUVKzquoqfMCYVN7SMwdX v8cNzeIe4U80KB0eaJGpAuDM+fcVIMmOQ7aF/o8NE+R0IOsFNLnXTPN9dy759xolMFrpD9nq2dY2v Xqa6KRV505i85MXcN3eP38BfLDme/0IhwJJLyOWwQeLgCuS5ZrWSKZDQSgJ4sBqM/+ib+ieeoIm+h DXMmwuvFNqc5R4zLk58nsEqTxwWVq6cn6RGnvCUUcBxKiaPbKrhsEMoeJ+dz3wUF71sE9wZJXNDdh He/3J6jqPyJDJ4Eh8Z/OKItVGZg+9xzrrRT8WOBB3Qm3c7zgvLUoOsGYCzFqIWso=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence this warning by just using strscpy() directly:

drivers/net/bonding/bond_main.c:4877:3: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
    4877 |   strncpy(params->primary, primary, IFNAMSIZ);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202102150705.fdR6obB0-lkp@intel.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/bonding/bond_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c5a646d06102..ecfc48f2d0d0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5329,10 +5329,8 @@ static int bond_check_params(struct bond_params *params)
 			(struct reciprocal_value) { 0 };
 	}
 
-	if (primary) {
-		strncpy(params->primary, primary, IFNAMSIZ);
-		params->primary[IFNAMSIZ - 1] = 0;
-	}
+	if (primary)
+		strscpy(params->primary, primary, sizeof(params->primary));
 
 	memcpy(params->arp_targets, arp_target, sizeof(arp_target));
 
-- 
2.25.1

