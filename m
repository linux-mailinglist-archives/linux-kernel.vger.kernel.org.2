Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546B634F03B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhC3RzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232524AbhC3Ry7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:54:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B36FD619AB;
        Tue, 30 Mar 2021 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617126898;
        bh=yesn2P2b6cKTqwc/ApNdhDGqh1nvwMnUBdprspUhg6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdULg5uX5G3w6ecEKzMY/ysuqoaRe8fWn8QawRj1DPYOItxOmHtFo/KK4ZuFrKjHo
         UQn5F17Wu8hJbiUSfha1kJk3nt4EtmYtMyph2EtY1QNBES/lkjho1Y76flh00JdVsP
         VjM9ExyXbFhgERg37eY3WxbrIMUGRYk2aBNltPA04gEJp8WtW3Dfn7xukN1JRCV4ET
         Kibkg0RUD05hPp/UjY+jfGLZKFNW3h/xQpEfwOTC4rIYgLdgsL7E0OHbREWtM2jy2k
         6Cf70RzD8CTndDvEOgUTG16FVKyLw0EUUgSM08ow0QAsA9ObNv1z1Ss6iu1uIfGI1X
         X01KDMGmK8B4A==
Date:   Tue, 30 Mar 2021 23:24:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     kostap@marvell.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        linux@armlinux.org.uk, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, robh+dt@kernel.org,
        kishon@ti.com, miquel.raynal@bootlin.com, mw@semihalf.com,
        jaz@semihalf.com, nadavh@marvell.com, stefanc@marvell.com,
        bpeled@marvell.com
Subject: Re: [PATCH v3 0/5] Add support for CP110 UTMI PHY
Message-ID: <YGNl7n8A4KNY2lq0@vkoul-mobl.Dlink>
References: <20210307163343.25684-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307163343.25684-1-kostap@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-21, 18:33, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> This series of patches adds a new PHY driver for supporting CP110 UTMI
> PHY in Linux. Currently the functionality of USB ports connected to
> this PHY depends on boot loader setup.
> The new driver eliminates kernel configuration dependency from the boot
> loader. 

Applied 1-3, thanks

-- 
~Vinod
