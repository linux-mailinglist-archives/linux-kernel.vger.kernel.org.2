Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE73956E0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhEaIZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhEaIZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:25:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EABF061249;
        Mon, 31 May 2021 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622449439;
        bh=CN/16kVh4u23VzsRHDG1/+J9ntor0VIp5iDOhcnKVEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0LbcQyAybJOvrx2DtHtcMbZgtyRiol6GOABGiB5G8dj8sJZo2dS8pRlkL51HB4U7
         8zItwetVIB20M8RD9jd29qNPN3ZzoywfKZy+13Vhj2nBi0x5GSyT8VRgKCrHxrDsmX
         YPbzrm1+u7eYrIXzanBkWA27n2TP9E8cFKwiUl1OV3Z3OUHCPuAkIxQUO+GQN0Chm7
         SS8E6s/SNdaTA4TSb7ShDliyJ4Iw+beoa26TTWbA/4113ltlv5J2kWkJMoJKfo441W
         cStzoyHwRSofDnHwooyGBM7f9ZRT0TFAogqHSc5vRJebxdyDf3s2qQszerj8VQEMoj
         e0d38rxqGxZzA==
Date:   Mon, 31 May 2021 13:53:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: rockchip-inno-usb2: add
 compatible for rk3308 USB phy
Message-ID: <YLSdG3Ity+iAnddG@vkoul-mobl.Dlink>
References: <20210514150044.2099298-1-t.schramm@manjaro.org>
 <20210514150044.2099298-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514150044.2099298-2-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-05-21, 17:00, Tobias Schramm wrote:
> The RK3308 features a slightly different USB phy than other Rockchip SoCs.
> This patch adds a compatible string for it.

Applied, thanks

-- 
~Vinod
