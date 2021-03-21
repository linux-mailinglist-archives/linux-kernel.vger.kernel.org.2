Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42872343494
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhCUUPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:15:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43578 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhCUUOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:14:39 -0400
Received: from p508fc3a3.dip0.t-ipconnect.de ([80.143.195.163] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lO4T8-0007Oi-54; Sun, 21 Mar 2021 21:14:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, cmuellner@linux.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: add phandle to timer0 on rk3368
Date:   Sun, 21 Mar 2021 21:14:32 +0100
Message-Id: <161635763248.767241.16202827958833185296.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210209103408.2302218-1-heiko@sntech.de>
References: <20210209103408.2302218-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 11:34:08 +0100, Heiko Stuebner wrote:
> While the kernel doesn't care su much right now, bootloaders like
> u-boot need to refine the node on their side, so to make life easier
> for everyone add the timer0 phandle for timer0.

Applied, thanks!

[1/1] arm64: dts: rockchip: add phandle to timer0 on rk3368
      commit: 46f86be0fc6900a13bc27138a72cb7188ef6b4be

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
