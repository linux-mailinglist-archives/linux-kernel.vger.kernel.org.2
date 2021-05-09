Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552DA377964
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 01:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhEIX4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 19:56:21 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55636 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhEIX4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 19:56:19 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lftGU-0007y6-Cu; Mon, 10 May 2021 01:55:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: fix pinctrl sleep nodename for rk3036-kylin and rk3288
Date:   Mon, 10 May 2021 01:55:07 +0200
Message-Id: <162060449718.1266480.9605079619831759008.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126110221.10815-1-jbx6244@gmail.com>
References: <20210126110221.10815-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 12:02:20 +0100, Johan Jonker wrote:
> A test with the command below aimed at powerpc generates
> notifications in the Rockchip ARM tree.
> 
> Fix pinctrl "sleep" nodename by renaming it to "suspend"
> for rk3036-kylin and rk3288
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml

Applied, thanks!

[1/2] ARM: dts: rockchip: fix pinctrl sleep nodename for rk3036-kylin and rk3288
      commit: dfbfb86a43f9a5bbd166d88bca9e07ee4e1bff31
[2/2] arm64: dts: rockchip: fix pinctrl sleep nodename for rk3399.dtsi
      commit: a7ecfad495f8af63a5cb332c91f60ab2018897f5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
