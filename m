Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4A34860E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbhCYAvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:51:05 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37614 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbhCYAu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:50:59 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lPEDC-0003K7-5V; Thu, 25 Mar 2021 01:50:58 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v5 1/8] dt-bindings: usb: convert rockchip,dwc3.txt to yaml
Date:   Thu, 25 Mar 2021 01:50:55 +0100
Message-Id: <161663335606.1190848.13995758068048147033.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210209192350.7130-1-jbx6244@gmail.com>
References: <20210209192350.7130-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 20:23:43 +0100, Johan Jonker wrote:
> In the past Rockchip dwc3 usb nodes were manually checked.
> With the conversion of snps,dwc3.yaml as common document
> we now can convert rockchip,dwc3.txt to yaml as well.
> Remove node wrapper.
> 
> Added properties for rk3399 are:
>   power-domains
>   resets
>   reset-names

Applied, thanks!

[7/8] arm64: dts: rockchip: add rk3328 dwc3 usb controller node
      commit: 44dd5e2106dc2fd01697b539085818d1d1c58df0
[8/8] dts64: rockchip: enable dwc3 usb for A95X Z2
      commit: f227197bdf91a58903753ff18f5d0ad8f170e4b5

Changed the title of the last patch to the more appropriate
      arm64: dts: rockchip: enable dwc3 usb for A95X Z2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
