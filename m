Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8526134FF54
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhCaLOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234377AbhCaLOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:14:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3F4F6195D;
        Wed, 31 Mar 2021 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617189248;
        bh=/qrwf4ibBO5YM+ChG3SK10ENvkb+3yKaA1jC0utRdGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUJX/y5dyMN6YghXIrAeqF3rPpo0OPM5RDiZL7X3xzr4P4CkxrLCmkFeBrfKAZOxa
         HroHWzbiW6aftNCRi9Jd23Ckc4zllQn3duzyhI3w8pXul3FdEi7cJWFbh591drMpAW
         mHZtIHfoNkBHlEdEJeWUmdMO3l3LVBUkDzcmefABXaEkNFVKdf4W2VXckfbxgdJbAd
         u0XM5+lJ8q7IIUc5f2Vyscw+dUiremnkeANmEt3Xnf9F842ubs4bGUN1YdAEhqvoVX
         5TILfVzFcE/2C1q9KzSsYc31xPKjTuWqmDQHuaYbEk7xDfRVy0Fiy8aEndK+kn6JT+
         HUiCi61KkuHxg==
Date:   Wed, 31 Mar 2021 16:44:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v7 00/13] PHY: Add support in Sierra to use external clock
Message-ID: <YGRZfDnFpmhN89hk@vkoul-mobl.Dlink>
References: <20210319124128.13308-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319124128.13308-1-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-03-21, 18:11, Kishon Vijay Abraham I wrote:
> Patch series adds support in Sierra driver to use external clock.
> 
> v1 of the patch series can be found @ [1]
> v2 of the patch series can be found @ [2]
> v3 of the patch series can be found @ [3]
> v4 of the patch series can be found @ [5]
> v5 of the patch series can be found @ [6]
> v6 of the patch series can be found @ [7]

Applied, thanks. I was able to resolve the conflict on patch 4, please
check it was fine

-- 
~Vinod
