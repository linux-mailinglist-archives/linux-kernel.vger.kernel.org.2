Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE11348A32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhCYH3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:29:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYH3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:29:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B80A861554;
        Thu, 25 Mar 2021 07:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616657341;
        bh=Mr+BDr76BpJXyUusio9MRTC9Cg69ld5vy7wOR2RmRsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7atfcBnwjv20i25mhZKHFRB7JQGurVZ2sjsGo6k4fQUQFbzNzhnNsaj9Z1lbDVtl
         KBNgs1u48j0yPUjp0yTIYN5GUaZ4LnzLQ7rYSW4kN7b1/3lTMtM9ZCa0gZhvMJUJ2g
         y4NSX1F1mGZDbp+PGqwHP0uNQOCkL6WMgCfltuf8HSPqdg3UMK+vI746ZGSJ/XD3mn
         wdBc02PZFjSlH2zPRLroJeyOOCgIuFTGJtB0P7u6JlMYi8L6rCZ8qvL2SmLJUOmCpL
         hdVPO6vvMq6CZsbAsLTd+aAOvCI4KXcEhql7m+Pf9/AY9w8golgBD2YY0cuZRY0Uok
         lFYF/6rLBY4dA==
Date:   Thu, 25 Mar 2021 12:58:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm,
        robert.foss@linaro.org
Subject: Re: [PATCH v4 2/5] phy: Add LVDS configuration options
Message-ID: <YFw7udw4G9WrWlAd@vkoul-mobl.Dlink>
References: <1615175541-29009-1-git-send-email-victor.liu@nxp.com>
 <1615175541-29009-3-git-send-email-victor.liu@nxp.com>
 <YFHYeZ/ZVqNiG/yo@vkoul-mobl.Dlink>
 <6c52ebc6a027cbe309ed2c8848f2ae8cfa6e15f4.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c52ebc6a027cbe309ed2c8848f2ae8cfa6e15f4.camel@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-03-21, 10:22, Liu Ying wrote:

> > Can we have these in kernel-doc style please, similar to style in linux/phy/phy.h
> 
> I take this way of in-line member documentation comment for the below 3
> reasons:
> 
> 1) Members of struct phy_configure_opts_mipi_dphy and
> struct phy_configure_opts_dp use the same way of comment.
> The structures are defined in linux/phy/phy-mipi-dphy.h and
> linux/phy/phy-dp.h respectively.
> Aligning to them makes a bit sense, IMHO.
> 
> 2) In-line member documentation comments[1] are mentioned in kernel-doc 
> guide. It says 'The structure members may also be documented in-line
> within the definition.'.
> 
> 3) Even the 'configure' and 'validate' members of struct phy_ops use
> the same way of comment.  struct phy_ops is defined in linux/phy/phy.h.
> 
> [1] 
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#in-line-member-documentation-comments

It 'may be' but I would like all headers of a subsystem to display one
style. As I said linux/phy/phy.h use a style which we should use
everywhere.

Thanks

-- 
~Vinod
