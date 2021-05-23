Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8197A38D912
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 07:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhEWFJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 01:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhEWFJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 01:09:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 712AC61152;
        Sun, 23 May 2021 05:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621746493;
        bh=mK9yzIz9e41aFiFE7aqOnNe3xw+SCXc3aojjA07+SNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLHV9FViMuX5A/QWzz5cTafYZDgTFVbbwCrDQRlNKC1ZB4OBZ3vmuBsE2Onoyy8Hh
         IyHCEvv7JIKmMg837uaOIEi9NuuDmlGitEn5BT+asZJS81/H6lKH0YxnsstmaDzeNh
         U7gN6XbK68v/AY6uUZhLIM589hmhTa0v0Sg4mH09PsifoMa3G+faltKn7DP8eX1UwD
         NU+t1D5jpxYWIigC/GapU5o35/SV8IrQzP+zRmdPTyZmGX/tqP+ORghb6rEqCi3Xll
         1JeNiqaOo43YVglypl2O9E5YeArWKBWv7sYWngOcIJXh5MYTv+BnNFKf8zn4K/Gs7w
         PMEnUY2R6W3cw==
Date:   Sun, 23 May 2021 13:08:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: freescale: sl28: fix RGMII
Message-ID: <20210523050807.GV8194@dragon>
References: <20210514185553.10095-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514185553.10095-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 08:55:51PM +0200, Michael Walle wrote:
> This fixes the RGMII on the sl28 boards. While the network port was
> actually working it is still out-of-spec.
> 
> Please note, that this is split into two patches because each one fixes
> a different commit.
> 
> Changes since v1:
>   - use different subjects for the two patches. I didn't use sl28-varN
> 	because I'd like to keep "sl28:" for all the sl28 related patches.
> 
> Michael Walle (2):
>   arm64: dts: freescale: sl28: var4: fix RGMII clock and voltage
>   arm64: dts: freescale: sl28: var1: fix RGMII clock and voltage

Applied both, thanks.
