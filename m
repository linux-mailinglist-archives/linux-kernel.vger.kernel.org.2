Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8DA4384B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhJWSf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 14:35:58 -0400
Received: from out1.migadu.com ([91.121.223.63]:59687 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhJWSf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 14:35:56 -0400
Date:   Sat, 23 Oct 2021 14:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svmhdvn.name;
        s=key1; t=1635014015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXI5zMzn4ZCVC7NxCdK+DQvmhL2s3QnW1bF9OqxDGAw=;
        b=Omi6a7AQfgZmu9BDEEbRmDEF5SrhszAA4NmExL8zUw52f9vuIrnX1p1Czi/HhvnDLbo9E+
        ofPP/JO/VchGwBgJGbfv98vDV5ZFuj3uymy8hYuFOXtUCw1nAimxx67T/uK/sSd9nGZXVu
        pOPu6OIaVSZhCQoNCnUkVcCUcXxoOx8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Siva Mahadevan <me@svmhdvn.name>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>
Cc:     devicetree@vger.kernel.org, Simon South <simon@simonsouth.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guillaume Gardet <guillaume.gardet@arm.com>,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Disable CDN DP on Pinebook Pro
Message-ID: <YXRVrY9LYU9aD3Vp@think.localdomain>
References: <20210715164101.11486-1-matthias.bgg@kernel.org>
 <162655869103.853863.17662789602843984386.b4-ty@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162655869103.853863.17662789602843984386.b4-ty@sntech.de>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: mbsync-msmtp@svmhdvn.name
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Stuebner wrote:
> On Thu, 15 Jul 2021 18:41:01 +0200, matthias.bgg@kernel.org wrote:
> > The CDN DP needs a PHY and a extcon to work correctly. But no extcon is
> > provided by the device-tree, which leads to an error:
> > cdn-dp fec00000.dp: [drm:cdn_dp_probe [rockchipdrm]] *ERROR* missing extcon or phy
> > cdn-dp: probe of fec00000.dp failed with error -22
> > 
> > Disable the CDN DP to make graphic work on the Pinebook Pro.
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: rockchip: Disable CDN DP on Pinebook Pro
>       commit: 714b35da2b6eace13bfe23ae02330e3b6a2ea4e7
> 
> Best regards,
> -- 
> Heiko Stuebner <heiko@sntech.de>

Will this patch be submitted to mainline? I can confirm on my pinebook
pro that this solves the issue.
