Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B688A3B3944
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhFXWhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhFXWhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:37:18 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D55BC061574;
        Thu, 24 Jun 2021 15:34:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g192so6437150pfb.6;
        Thu, 24 Jun 2021 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LFewT4LozUu+nAt7Nt96N2mp7ShoiQT1cip00MBFIJI=;
        b=W6U4VLAmyLt9R+6GEGR3XA7VkpenPBYl6kR4awOCcgpfCos/VfuDQBdO+bPD8biMpY
         I04euDckNDeko3tv6SjSCKXvMJOvNp0COzt5amJku6AhBS4Rz+6gLC+ls50aEE43BnFk
         DdJ1FK9r5dQYJ/d+u4Dx5aX1ZYw9JnlQzUq1RnMKKHdQWZxDFCVH0rDI8ccKq1ZpxDBk
         htb/Brd6eXVWlojrfcrH/tlufZ9zmq/lPXSsCdEtxSHa5nPDSSJngyTNTS7IxgY2TLSy
         LDKsIzuJCQVDRCqDVgXbGHmII/QXwr63XKLNrCDhIHRejS5k+QfglsS59lm43f9sSGFa
         d7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LFewT4LozUu+nAt7Nt96N2mp7ShoiQT1cip00MBFIJI=;
        b=WjVDTBfFcojlTsazEBevGNVQME9VN3EDFVp+IXkw1cx9blA/BaKzRxtAJ778/Hg/jl
         yPvuv95Kt0ArdZbexVp6PRjSOo+ILsQ6Oiq6r8BVZFrQZkUXzF/7MEKcvHgl47UH/3zs
         +S6w5TSB+VUap3ChmzHdBP/DrQRgxe7ViTJMPeBjvqKAXNUGSlDB1I3bpp8pYWUCImh3
         zo7Zd8vZXLNmne+xUWLyarweZj4IlHXmWQNd0OG+dL6fyVwEql6EGXIX8SGeYT6i9m0P
         in0pkpwWOFjN99oq6vgXPaH1OVnE/yYKve7AjZpUaatRB79klWtoo+/n2BFHklpz+5CB
         xNMg==
X-Gm-Message-State: AOAM53220vOOvCYsJC7rukyx2hzDumdaMMLfSxRq4zazb/GHIij8GMQG
        9zhZr3oN1GqRRDonEshMpgk=
X-Google-Smtp-Source: ABdhPJwOZrmHEAeS4vPS8g74kqBvm5m6lYTTatd4n6uLEIohOV4u1m1nLFhhQYa2MwJSsODVULzDrg==
X-Received: by 2002:a65:460f:: with SMTP id v15mr6826963pgq.298.1624574098559;
        Thu, 24 Jun 2021 15:34:58 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v9sm3533945pgq.54.2021.06.24.15.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 15:34:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: NSP: Move USB3 PHY to internal MDIO bus
Date:   Thu, 24 Jun 2021 15:34:56 -0700
Message-Id: <20210624223456.1315572-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210613094639.3242151-4-mnhagan88@gmail.com>
References: <20210613094639.3242151-1-mnhagan88@gmail.com> <20210613094639.3242151-4-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jun 2021 10:46:37 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> This patch largely replicates Vivek Unune's patch "ARM: dts:
> BCM5301X:Make usb3 phy use mdio phy driver"[1] for the NSP platform,
> whereby we need to create an mdio-mux to facilitate switches
> configured via external MDIO, in this case on the Meraki MX65.
> 
> However in doing so, we are creating an overlap with usb3_phy's
> ccb-mii range. To resolve this, usb3_phy should be moved to a child
> node of the internal MDIO bus. The result is heavily based upon Vivek's
> patch. This has also been cross-referenced with Yendapally Reddy's
> earlier work which utilised the subsequently dropped brcm,nsp-usb3-phy
> driver: "[PATCH v2 4/4] arm: dts: nsp: Add USB nodes to device tree"
> [2]. Finally, this change provides conformance to the bcm-ns-usb3-phy
> documentation, utilising the required usb3-dmp-syscon property. Note
> that support for the deprecated ccb-mii bindings has been dropped as of
> "phy: phy-bcm-ns-usb3: drop support for deprecated DT binding"[3].
> 
> [1] https://lore.kernel.org/patchwork/patch/933971/
> [2] https://www.spinics.net/lists/arm-kernel/msg555132.html
> [3] https://lore.kernel.org/linux-devicetree/20201113113423.9466-1-zajec5@gmail.com/
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
