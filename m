Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EB3C3FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 01:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhGKX3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 19:29:12 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54642 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhGKX26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 19:28:58 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m2ipr-0000zL-PF; Mon, 12 Jul 2021 01:26:07 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: rk3188: add space after &grf
Date:   Mon, 12 Jul 2021 01:26:04 +0200
Message-Id: <162604593565.371932.9846160742409185975.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210709103134.1750-1-jbx6244@gmail.com>
References: <20210709103134.1750-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 12:31:34 +0200, Johan Jonker wrote:
> Fix layout by adding a space after &grf.

Applied, thanks!

[1/1] ARM: dts: rockchip: rk3188: add space after &grf
      commit: 2120e486b41963dfdad355d91c2818ff670776ba

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
