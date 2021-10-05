Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DBE421E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 08:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhJEGCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 02:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhJEGCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 02:02:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 918AD61528;
        Tue,  5 Oct 2021 06:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633413626;
        bh=Bk6/mMhROwyPtlCFI1g+JgM6tv/dp/NyH0OOXI/lBho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJSX4zYjDBbp8/10bx8IAfbnPMwtUGgvURtmJxjZG+NwAe74zh6Vc0lAjIUN6wVhB
         QUAJgLhCVjtwWY1lllwDf9WAUgrMr53FpuN2K8q3+aSL95HRS0iB8zfI103Sr2GABC
         MZFmaDlKY0/HKdQuuGBRwdP1pKHdK0y7NgsYnY/eOpKDb+czJP7sAxKrTpjeH7LtuO
         7869+AruZ3jtaf0EVVonx9nQCkBtYfkzJC6smBSpxrNbB7Piyepg9NkWyAvWoNeKHZ
         Tz5HZlSGpm18KdHA5hhnWjf56coN0PqlMQVVvccjrzbrwp/YcAdUO3afO9ayJrWf3A
         xf1rOuHVmOHhw==
Date:   Tue, 5 Oct 2021 14:00:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: Fix 'interrupt-map' parent
 address cells
Message-ID: <20211005060021.GQ20743@dragon>
References: <20210928192154.1841889-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928192154.1841889-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:21:54PM -0500, Rob Herring wrote:
> The 'interrupt-map' in several Layerscape SoCs is malformed. The
> '#address-cells' size of the parent interrupt controller (the GIC) is not
> accounted for.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
