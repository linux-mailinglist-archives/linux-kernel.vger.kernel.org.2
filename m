Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03223380984
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhENMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:31:00 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44348 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233190AbhENMa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:30:57 -0400
Received: from p5b127fa9.dip0.t-ipconnect.de ([91.18.127.169] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lhWwp-0002eq-0X; Fri, 14 May 2021 14:29:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: Remove more clock-names from PWM nodes A test with the command below gives this error:
Date:   Fri, 14 May 2021 14:29:40 +0200
Message-Id: <162099533685.1969114.6556603856663835579.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510172911.6763-1-jbx6244@gmail.com>
References: <20210510172911.6763-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 19:29:11 +0200, Johan Jonker wrote:
> /arch/arm/boot/dts/rk3228-evb.dt.yaml:
> pwm@110b0020: clock-names: ['pwm'] is too short
> 
> Devices with only one PWM clock use it to both to derive the functional
> clock for the device and as the bus clock. The driver does not need
> "clock-names" to get a handle, so remove them all.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: Remove more clock-names from PWM nodes A test with the command below gives this error:
      commit: dc71c5ca34f408030b979d894c0459ef059445a1

Fixed the patch subject that somehow got mangled together with
the first line of the patch message.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
