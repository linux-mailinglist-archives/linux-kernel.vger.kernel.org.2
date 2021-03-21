Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28C5343495
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCUUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:15:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43646 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhCUUOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:14:41 -0400
Received: from p508fc3a3.dip0.t-ipconnect.de ([80.143.195.163] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lO4T8-0007Oi-Ht; Sun, 21 Mar 2021 21:14:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Thomas Schneider <qsx@chaotikum.eu>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add infrared receiver node to rockpro64
Date:   Sun, 21 Mar 2021 21:14:34 +0100
Message-Id: <161635763247.767241.7420445041544765170.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210310122821.126408-1-qsx@chaotikum.eu>
References: <20210310122821.126408-1-qsx@chaotikum.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 13:28:21 +0100, Thomas Schneider wrote:
> This adds the RockPro64’s infrared receiver to its dtsi.  The configuration is
> almost the same as on rk3328-rock64, except for the GPIO pins, and thus adapted
> from there.

Applied, thanks!

[1/1] arm64: dts: rockchip: add infrared receiver node to rockpro64
      commit: 7c7f041309f73b05d21980f88f29305255e126ee

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
