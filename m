Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC83C3E2A39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245725AbhHFMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 08:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230373AbhHFMAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 08:00:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 568EF61102;
        Fri,  6 Aug 2021 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628251201;
        bh=8CWEa5pug1TqjU/0+6MgZWQeHoGlugaUWEqNFqlUCL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDSN6L+kPd4HfYFQhwnsZqxDGut6rHSipG3b2BU+aVZiPXU/OSzSP0jMtsp8oTe/V
         oA5ypb5sWtsk9GbVmMWG9AaUDsULpVWGmIrV+U8QCEn1fgTzzr9aH47vKrluUtsTg+
         W0zPEtZTT0TQL27yD/QOcV4ft7ivU85W5og+M2Mm0IQmSBGbGgtYIPYGtZhfWuSIl6
         d0ohNqLAJe6uNGlPoxlCFnqeAXUYqm7hHtHTp/XGBdOBmNBuFAH22Zq7BeKAN13u+1
         mhRM9Dba44N0Ih+zx/bwD4M3epNZP3FFvmAu3Mjpviuf5k1TVZmZ+bg+qXJjSIUnHo
         nKZOBZdLZemDw==
Date:   Fri, 6 Aug 2021 17:29:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: mediatek: tphy: add support
 hardware version 3
Message-ID: <YQ0kO7ZWO3y0Xmne@matsya>
References: <1627028562-23584-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627028562-23584-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-21, 16:22, Chunfeng Yun wrote:
> The PHYA architecture is updated, and doesn't support slew rate
> calibration anymore on 7nm or advanced process, add a new version
> number to support it.
> Due to the FreqMeter bank is not used but reserved, it's backward
> with v2 until now.
> For mt8195, no function changes when use generic v2 or v3 compatible,
> but prefer to use v3's compatible, it will not waste the time to
> calibrate the slew rate, and also correspond with hardware version.

Applied all, thanks

-- 
~Vinod
