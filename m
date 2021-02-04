Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A10030EDD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhBDHyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234527AbhBDHys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:54:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3B4664F41;
        Thu,  4 Feb 2021 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612425247;
        bh=qvleDJN7mq45Ln2tGXfhFUsthuAjXYBNdm2TsW6JbAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKP35KI1iJmTZX6k2z7k/uaPZTRIcYXj1VV+lNItravJpuuiYBee+95xWm9yKJwxO
         tlhwCe2rHsya6abdlGaVYfuJOa74JefGMXtJnCDFob0Dtd1L2iLvCs3wHpQBjXpweT
         uPHORNF+S/vwJ/mCezI5CmR7NhDciweWfkmu9S/f6+PRn+8IAxTvKXCOSpSD9mBGtN
         HOooF9sUVQWlSgiB8KDZo0PrWYkQs5rSckoJ+R6lLBi18RfP5qCqZg0uJRMjZggfHk
         txVyz4kRjjbnI8drRtL2utNNob8H2hljPpCrwNDiSp20UCXumSILQEkA9tLJlOJfcn
         j3j7zp+p59rtw==
Date:   Thu, 4 Feb 2021 13:24:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        David Gow <davidgow@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] phy: phy-hi3670-usb3: move driver from staging
 into phy
Message-ID: <20210204075402.GH3079@vkoul-mobl.Dlink>
References: <cover.1611773727.git.mchehab+huawei@kernel.org>
 <b74d127e45b586119dce5009b5630ddbd4a7f28d.1611773727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74d127e45b586119dce5009b5630ddbd4a7f28d.1611773727.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-21, 20:08, Mauro Carvalho Chehab wrote:
> The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> for mainstream. Mode it from staging into the main driver's
> phy/ directory.

I guess Greg will pick this, so:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
