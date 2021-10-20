Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA0434661
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhJTIEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:04:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46780 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhJTIEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:04:06 -0400
Received: from [213.208.157.36] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1md6XX-0002Hv-PZ; Wed, 20 Oct 2021 10:01:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add idle cooling devices
Date:   Wed, 20 Oct 2021 10:01:32 +0200
Message-Id: <163471688410.692684.11557412132014625068.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001161728.1729664-1-daniel.lezcano@linaro.org>
References: <20211001161728.1729664-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 18:17:28 +0200, Daniel Lezcano wrote:
> The thermal framework accepts now the cpu idle cooling device as an
> alternative when the cpufreq cooling device fails.
> 
> Add the node in the DT so the cooling devices will be present and the
> platforms can extend the thermal zone definition to add them.

Applied, thanks!

[1/1] arm64: dts: rockchip: Add idle cooling devices
      commit: 43f9699b0c12d4e50b66723213cef456c52254f3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
