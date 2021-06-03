Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23B7399A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 07:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFCFvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 01:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhFCFvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 01:51:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCB1361369;
        Thu,  3 Jun 2021 05:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622699370;
        bh=CA5CSdjZBRa4Qv1WOjAo6swDQqJBKNZLwtBz5M0dgFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tt7d1qGGJogMUnc/5PfH4Lrt+r0I2N8YrFtIP/37cijqWfVxeh3K32vDsqH8Mn4wQ
         pD/INgfKqg+ZTG2Ni2R/tVmpZlthg8DcwhVE13EIV3N1VPARHtL0wv6iK7OUxqkypI
         bJ+jD+amRs02mV0hbx/C+rY2C6Pf8/fGvzNayI1LNMuEx0Tf8z6VBy2yMB/ptHl4Gv
         iJGeE4eSOm6rPvjR8Y2BmbBXI8CdKJxWvVjhJbVV8UD4MC1r3uu/o+WzzFqTy09erg
         F5EFh465+dmYqMF0Vg+189tlDr3OjLuBQ7Z6pbNvch/Sx/B9pHPn+DoVJ2XU0p3ucY
         uajZ/AQu4VDTA==
Date:   Thu, 3 Jun 2021 11:19:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        steen.hegelund@microchip.com
Subject: Re: [PATCH -next] phy: Sparx5 Eth SerDes: check return value after
 calling platform_get_resource()
Message-ID: <YLhtZ+WEVgIrqIUb@vkoul-mobl>
References: <20210603051014.2674744-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603051014.2674744-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-06-21, 13:10, Yang Yingliang wrote:
> It will cause null-ptr-deref if platform_get_resource() returns NULL,
> we need check the return value.

Applied, thanks

-- 
~Vinod
