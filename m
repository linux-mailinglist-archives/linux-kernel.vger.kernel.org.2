Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB88435637
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 00:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhJTW7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 18:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTW7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 18:59:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D790C06161C;
        Wed, 20 Oct 2021 15:56:52 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h193so8443773pgc.1;
        Wed, 20 Oct 2021 15:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbgMvfMFq+A+FFRO8X7opBMuf5LG95uPYdcTf+JJmCI=;
        b=KawtoqSmnh4Pm9IT5us9MfFLOondHv8xnIF6HKGfedJTjGeSIR/8DHb7cVdZECMLAd
         44gNuXBrHruuwifjd1PBleArPgrltw+I+Gx+FT8uM3d2MqGTxsS/lGHTxpxV5PgTFS5v
         M1RlTCcUeYRIUZjbkqoNYhd0ZyTQCq3mGN2jLsKZ21toGh6ptI3d7r12aAz5+PqM7CWJ
         lw1q88A4r6wY9AdWRpO5WYf4LjqRRrKN8GS+4+0OjL4yKHB7lP28eWJkTe+UKLF2DlKI
         gWLZ/9E71/D+1CT1NItVG0TjyZnyT0Kx8tzQpXBYthGDVKk/EFY+3zNWXdvkJ4/dywDl
         fTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbgMvfMFq+A+FFRO8X7opBMuf5LG95uPYdcTf+JJmCI=;
        b=taxAUHIr8ArJO/PQGbjIVWnmaSA5AuOj2LPZ+fsXIRw9QdPfhBGK7IfyXqzS5Io67J
         oFfc/vB5H1k377mvVbJwyvJH7Pm8DVesag3ZjH1w1C6bA3heNxI3OI7fsWI7tT2YgGPM
         Sv9D0M69LscptlC/S6fCpBtAQORTBr61DCmlXEvGRmZaTCPJlzkgZxHmw0ZIFPZlRA/r
         rvNlfnoRcg5WmN/Vca4Moo7Ma624nq07gYK9nIWEaEDJV62rllBuKgi4hhoW/Lder4lP
         XrClKYNRCnzVVDyshE/sca/3UmTZhYov1UyAp+YzM2Fxi9FHF5SfrJ9ep1w17YZvvDEE
         3Abw==
X-Gm-Message-State: AOAM531QjCCh/owuQ7UtygrwngM98Ka/NtZnJK890h3dMNOoRC54EjmV
        ixHWTzlq+SwPhRV3VcdOQ+Y=
X-Google-Smtp-Source: ABdhPJz4NtSlLlIZHVG8uYbobX52wcOpdNy55Nsb9WeOzLYWHsJWHBbqRm2KD1YFNJFY936pwn8arg==
X-Received: by 2002:a05:6a00:13a5:b0:44c:ae90:8603 with SMTP id t37-20020a056a0013a500b0044cae908603mr2095038pfg.17.1634770611619;
        Wed, 20 Oct 2021 15:56:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x30sm3755071pfj.219.2021.10.20.15.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:56:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Matthew Hagan <mnhagan88@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: NSP: MX65: add qca8k falling-edge, PLL properties
Date:   Wed, 20 Oct 2021 15:56:49 -0700
Message-Id: <20211020225649.3144490-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015225022.3828860-1-mnhagan88@gmail.com>
References: <20211015225022.3828860-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 23:50:22 +0100, Matthew Hagan <mnhagan88@gmail.com> wrote:
> This patch enables two properties for the QCA8337 switches on the MX65.
> 
> Set the SGMII transmit clock to falling edge
> "qca,sgmii-txclk-falling-edge" to conform to the OEM configuration [1].
> 
> The new explicit PLL enable option "qca,sgmii-enable-pll" is required
> [2].
> 
> [1] https://git.kernel.org/netdev/net-next/c/6c43809bf1be
> [2] https://git.kernel.org/netdev/net-next/c/bbc4799e8bb6
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
