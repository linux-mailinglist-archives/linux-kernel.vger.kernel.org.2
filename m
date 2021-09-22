Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68430414116
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhIVFLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhIVFLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:11:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57354611C6;
        Wed, 22 Sep 2021 05:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632287412;
        bh=JQnSd+cAl/5+FLE07eY8U96T+jHtRzYG7q1o4fBOIJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMCwmEPoJPOG4ufOwf/BJcbKXCiZInwpgES0ZC1Pi9y5xzRRSmExagGv2mKdEuBh2
         oHxliWpSvrfYLfUlnuZlkXUMDVwU/f+wymo2V/Bv0AC2C4g+sFRqLnDbut3vv3O0Au
         SZSONNC2r2ihTIdJjVH8Ejo9yfIXtV8NqTuCFUwoMQlx0Bj3vaUudHZqxwb0tDUqxN
         Hby+eTUMZB3dyHJ8vB8JaaHjBl4tKAdtHuA/f8zLxKv2pD2DVe/rTIMrBx0nk2JLZb
         U3c+5PfudDJHJTcxSFNm+bNvEFILBBk5j+Amw1T9ipZfB2CtKWQMy4N8iNgC79LJmx
         A/vI2ns3MXfwQ==
Date:   Wed, 22 Sep 2021 13:10:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH 1/2] arm64: dts: freescale: fix arm,sp805 compatible
 string
Message-ID: <20210922051006.GC13480@dragon>
References: <20210826123529.737398-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826123529.737398-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 02:35:28PM +0200, Michael Walle wrote:
> According to Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
> the compatible is:
>   compatible = "arm,sp805", "arm,primecell";
> 
> The current compatible string doesn't exist at all. Fix it.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
