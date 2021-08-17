Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD143EEAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbhHQKbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236220AbhHQKbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:31:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBC0F600CC;
        Tue, 17 Aug 2021 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629196268;
        bh=gwHWOw/ASy61DLhExAAJff6S57004jn6JCY7yTCDpLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICnrOAIY3x8BStucty1s+XddE23iaDU6CpMMaQCdyyjQyhqEXlk8MeQHj5gjktf6u
         B5+dsi06P+oXwRZ7NPCoXNCWPgxyny24V0QHyfLuDLy9BBl/Ajo+jDnuhsTI5/Cm/O
         J61MyqioLWtl3yevXMwuIqNYoBnVEJgeyk8JT8FZQnE/19aazFBpEiBixUAWKQTYOo
         gBbTogqfhVSRQAuPJ8Vx15aVHDCITtazvPkrfDaiP3aMTgbRlZ+ONa9EnrDwxEfmCg
         wxkRGAg9dYAlpBQoQPKbMv3Xo6hPzrzSM0NXhfW52cXHXjDCFY0m8Iz1p50tl6aGwL
         I9Fml9+Wd1E8w==
Date:   Tue, 17 Aug 2021 16:01:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Subject: Re: [PATCHv3 6/6] phy: amlogic: meson8b-usb2: don't log an error on
 -EPROBE_DEFER
Message-ID: <YRuP6JfdEZNL8tXt@matsya>
References: <20210817041548.1276-1-linux.amoon@gmail.com>
 <20210817041548.1276-7-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817041548.1276-7-linux.amoon@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-21, 09:45, Anand Moon wrote:
> devm_phy_create can return -EPROBE_DEFER if the vbus-supply is not ready
> yet. Silence this warning as the driver framework will re-attempt
> registering the PHY. Use dev_err_probe() for phy resources to indicate
> the deferral reason when waiting for the resource to come up.

Applied, thanks

-- 
~Vinod
