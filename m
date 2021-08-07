Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0B3E3241
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhHGAGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhHGAGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:06:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10269C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 17:06:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x90so15385275ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 17:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RzozSNQTz1Bpza4jp/rOPaJfg+JvR6EqQ0E1yzsox8A=;
        b=T2Lf2SOPRd8WVy6tOKA1+5ahRA27A4734PUTOhAWiMNvW9ZjqSTMS4rB+b5+JnQplY
         vm7zZuNjVHqAiwuF4z2FPr9cyQmpHAKq+EnP01wBy9Kuk4UpPDroOG31/0AZ+As/U4Dm
         3XZc3AJI/aDTU8kyBworzrVuJTtPP8dEkFMKQGU+AbNKA6RyA9GlfnZjOEti0F+XH1y1
         biXR/7Ttu2TdX/JcO5Qit8uP5v4WX2R8TgalekYtbZZWq/z2z6bw1NktkjE6N8PXNNe2
         1T0KdXfmvOB6jUn9Ns0e+XBDTBb2c6mJ8LJBkNJHz+ahmUE7/Eg1WbNRffTAW6tjYQ/I
         ZAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RzozSNQTz1Bpza4jp/rOPaJfg+JvR6EqQ0E1yzsox8A=;
        b=aL6EA6xeP09GgoBWo/8BufEXvgCHRo3aOG82PUROEHyyxAL/not4lDlO6saG9cnzi1
         e/IsRZDq4rCCr0ClOFQf55zHIAHPrINMb0/JBrHLJKa6P+pgAzNCfDlQg5Sq5IKL2dp8
         jmoTGdVqM2hZF1kwauOQ/YO8Z03nx3J4/hvajER6TbdeYdRvL5NEv2ELnsnJOhODHELu
         iX4zc4wzT9nV2Zf609MLxfDHD8yyluixvhjliJUUOPbUUrdpX7GMdN+8dQaTweVbeksf
         AIEAVKvGbHBltWfoxykmLPj72MW+vKnvXv2FupadQhMkiDYZevMepYhJty6Sxz9KG91v
         jupQ==
X-Gm-Message-State: AOAM5317tEJsjbcm4Qgxy9nVuVPib6k6dWJp1nh/vWumluLLYY7ty5ou
        BpRZODlULXMvMrHLDvhvZRIoNg==
X-Google-Smtp-Source: ABdhPJzijoUVX8vE9DIoBCMrXonPi4y3ILNA2/rCE4NzWtj2Mqnh56DmLUrbDFvf95XBrFBxhqfQEw==
X-Received: by 2002:a05:6402:1cb6:: with SMTP id cz22mr16086918edb.148.1628294780302;
        Fri, 06 Aug 2021 17:06:20 -0700 (PDT)
Received: from cephalopod (168.7-181-91.adsl-dyn.isp.belgacom.be. [91.181.7.168])
        by smtp.gmail.com with ESMTPSA id w23sm4419437edx.34.2021.08.06.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 17:06:20 -0700 (PDT)
Date:   Sat, 7 Aug 2021 02:06:18 +0200
From:   Ben Hutchings <ben.hutchings@mind.be>
To:     Steve Bennett <steveb@workware.net.au>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: micrel: Fix link detection on ksz87xx switch"
Message-ID: <20210807000618.GB4898@cephalopod>
References: <20210730105120.93743-1-steveb@workware.net.au>
 <20210730095936.1420b930@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <74BE3A85-61E2-45C9-BA77-242B1014A820@workware.net.au>
 <20210807000123.GA4898@cephalopod>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807000123.GA4898@cephalopod>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a5e63c7d38d5 "net: phy: micrel: Fix detection of ksz87xx
switch" broke link detection on the external ports of the KSZ8795.

The previously unused phy_driver structure for these devices specifies
config_aneg and read_status functions that appear to be designed for a
fixed link and do not work with the embedded PHYs in the KSZ8795.

Delete the use of these functions in favour of the generic PHY
implementations which were used previously.

Fixes: a5e63c7d38d5 ("net: phy: micrel: Fix detection of ksz87xx switch")
Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
---
 drivers/net/phy/micrel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 53bdd673ae56..5c928f827173 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1760,8 +1760,6 @@ static struct phy_driver ksphy_driver[] = {
 	.name		= "Micrel KSZ87XX Switch",
 	/* PHY_BASIC_FEATURES */
 	.config_init	= kszphy_config_init,
-	.config_aneg	= ksz8873mll_config_aneg,
-	.read_status	= ksz8873mll_read_status,
 	.match_phy_device = ksz8795_match_phy_device,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-- 
2.20.1

