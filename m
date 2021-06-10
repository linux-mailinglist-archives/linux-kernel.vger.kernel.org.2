Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F13A25DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhFJHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:55:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40656 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFJHzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:55:14 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lrFV5-0002uS-J6; Thu, 10 Jun 2021 09:53:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: fix supply properties in io-domains nodes
Date:   Thu, 10 Jun 2021 09:53:14 +0200
Message-Id: <162331157357.3382826.15742943707319190282.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210606181632.13371-1-jbx6244@gmail.com>
References: <20210606181632.13371-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2021 20:16:32 +0200, Johan Jonker wrote:
> A test with rockchip-io-domain.yaml gives notifications
> for supply properties in io-domains nodes.
> Fix them all into ".*-supply$" format.

Applied, thanks!

[1/1] ARM: dts: rockchip: fix supply properties in io-domains nodes
      commit: f07edc41220b14ce057a4e6d7161b30688ddb8a2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
