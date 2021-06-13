Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E633A5995
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhFMQ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 12:29:31 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58838 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231915AbhFMQ3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 12:29:30 -0400
Received: from p508fc96c.dip0.t-ipconnect.de ([80.143.201.108] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lsSxJ-0005DC-KL; Sun, 13 Jun 2021 18:27:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, paweljarosz3691@gmail.com,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: add labels to the timer nodes on rk3066a
Date:   Sun, 13 Jun 2021 18:27:20 +0200
Message-Id: <162360159829.3586115.9536707519501339660.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210612184733.2331-1-jbx6244@gmail.com>
References: <20210612184733.2331-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 20:47:33 +0200, Johan Jonker wrote:
> While the kernel doesn't care so much right now, boot loaders like
> u-boot need to refine the node on their side, so to make life easier
> for everyone add the labels to the timer nodes on rk3066a.

Applied, thanks!

[1/1] ARM: dts: rockchip: add labels to the timer nodes on rk3066a
      commit: 3fedcc636e28f6188b6bb126199eda031bc707f3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
