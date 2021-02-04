Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2530EDB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhBDHtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbhBDHtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:49:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B91E764F41;
        Thu,  4 Feb 2021 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612424921;
        bh=jZ5VkMV+yvTTGTBLPJwWZjNdJ6FEI+yUk1SW6gkvJFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1cr0T0Bb8YdSuQS558nTlBpWsKr7YkV33KoyplTR3JJB3LUpUg5VVdirp2ZtZCen
         QfNIK9zqj1YPoR8dPqLhpdlxcNIeCKf0FwgGUdUFyx5vaCHVI2mxHiszs++o3ilJQo
         hnlyUiPcBK0Lu8V5ycceAOYS6iJ8aCnh7xJSUUiHpTu59fWfieXPPGGWpGwpJWLONR
         Yn9QSylE+IZTbJt2u6MfxFnd78PoqhTtZWgHp2CSotQvjf7aHv0I7JMemXuDYPRLLb
         Bb6HZeLSYUu6m8+JIkixO5EtcWCCvtFT5zCpiPA/BYJibxamgXUO+jPwQWtFpXCFY+
         wAPc3ou2MiguQ==
Date:   Thu, 4 Feb 2021 13:18:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] phy: phy-hi3670-usb3: move driver from staging
 into phy
Message-ID: <20210204074837.GE3079@vkoul-mobl.Dlink>
References: <cover.1611052729.git.mchehab+huawei@kernel.org>
 <82ce73ac9a383f0cae0faded5ec6fef2d3417d3c.1611052729.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ce73ac9a383f0cae0faded5ec6fef2d3417d3c.1611052729.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-21, 11:44, Mauro Carvalho Chehab wrote:
> The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> for mainstream. Mode it from staging into the main driver's
> phy/ directory.

Acked-By: Vinod Koul <vkoul@kernel.org>

I think it makes sense if Greg applies this as well

-- 
~Vinod
