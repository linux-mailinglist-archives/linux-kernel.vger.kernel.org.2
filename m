Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28074116EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbhITOaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:30:22 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55048 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhITOaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:30:20 -0400
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mSKHq-0005O5-9R; Mon, 20 Sep 2021 16:28:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        jacopo@jmondi.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: add isp node for px30
Date:   Mon, 20 Sep 2021 16:28:39 +0200
Message-Id: <163214478704.1547258.2589966466040582287.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210830141318.66744-1-heiko@sntech.de>
References: <20210830141318.66744-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 16:13:17 +0200, Heiko Stuebner wrote:
> Add the rkisp1 node and iommu for the px30 soc.

Applied, thanks!

[1/2] arm64: dts: rockchip: add isp node for px30
      commit: 8df7b4537dfb4c0a2a42de603927f5818cee0274
[2/2] arm64: dts: rockchip: hook up camera on px30-evb
      commit: 474a77395be201c80925efb7a0425fb28b0ba60b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
