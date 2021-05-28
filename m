Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D89394681
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhE1ReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:34:21 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44422 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhE1ReQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:34:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lmgLf-0006NM-1Z; Fri, 28 May 2021 19:32:39 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1] ARM: dts: rockchip: move mmc aliases to board dts on rk3066/rk3188
Date:   Fri, 28 May 2021 19:32:36 +0200
Message-Id: <162222314614.2865009.9000799386327047041.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210520091822.28491-1-jbx6244@gmail.com>
References: <20210520091822.28491-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 11:18:22 +0200, Johan Jonker wrote:
> As suggested by Arnd Bergmann, the newly added mmc aliases
> should be board specific, so move them from the general dtsi
> to the individual boards.

Applied, thanks!

[1/1] ARM: dts: rockchip: move mmc aliases to board dts on rk3066/rk3188
      commit: d67113c261c196232c96dbed1ff2fbd071c8c457

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
