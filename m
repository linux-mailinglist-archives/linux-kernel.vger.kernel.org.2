Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5583F01DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhHRKip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhHRKig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:38:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D337060EB5;
        Wed, 18 Aug 2021 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629283081;
        bh=c82u97ew4Crm1pKl6m89vOH9xM0DBu4AvuwoDSaTMtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6nOA7Sal3sT3pfQiX+r63/k9sY5wKVY8rL2fejingbEPdAhn0kVdtJqn9qDBmyrU
         JLLKYdF23tycwwAcOhDxFvsoMZGfF6Y6zvIGhJgK45axQB2bdtnG8s4Wvd+Bi+b5Rw
         TrmoKiCJB3kgKfHNmpY1WzUNVjK4dznUsXIAk+MpeyNuQ1/8r2go3r9NBfoFojIClp
         tE+VFpVb9n6bjaMsq8nAwLzUN9VAJuwBA1Yc4Y81opAnnd0wzcsNK5rsGr9PzkMRST
         YuGwaxJMo6DVj0UZS2tj8fMtHI4w9otrkOe00402wkr0q2Icq4yfNOIhdLyBw8hkMo
         +pHuGvmP5fTJg==
Date:   Wed, 18 Aug 2021 16:07:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v11 01/11] phy: HiSilicon: Add driver for Kirin 970 PCIe
 PHY
Message-ID: <YRzjBOGsehbHAGJv@matsya>
References: <cover.1628755058.git.mchehab+huawei@kernel.org>
 <7788c5ead6d6f5a6f9e5faaee4460eb2149967c4.1628755058.git.mchehab+huawei@kernel.org>
 <YRuSnXHSZHhBC40r@matsya>
 <20210818110123.33eba838@coco.lan>
 <YRzck9WqerFtu846@matsya>
 <20210818123037.2adef2de@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818123037.2adef2de@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-21, 12:30, Mauro Carvalho Chehab wrote:
> Em Wed, 18 Aug 2021 15:40:27 +0530
> Vinod Koul <vkoul@kernel.org> escreveu:

> > Okay sounds fair to me, I think fixme should be left but the c99 style
> > code commented out can be removed
> 
> Agreed. I'll replace it with:
> 
> +       /*
> +        * FIXME: The enabled clocks should be disabled here by calling
> +        * kirin_pcie_clk_ctrl(phy, false);
> +        * However, some clocks used at Kirin 970 should be marked as
> +        * CLK_IS_CRITICAL at clk-hi3670 driver, as powering such clocks off
> +        * cause an Asynchronous SError interrupt, which produces panic().
> +        * While clk-hi3670 is not fixed, we cannot risk disabling clocks here.
> +        */

sounds good!

-- 
~Vinod
