Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A432133AF75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCOJ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhCOJ73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:59:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B3F360202;
        Mon, 15 Mar 2021 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615802369;
        bh=oCxOmOQ+5pDp18uQ/6qn5hC2mTYGOBc5c1gK3RWfSgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kA2g65Ep8rer34Pbm9P4aAjhKV3G+HDo2ueBN/QO6NHqLVlXTixzFAGmBRMPZnRiq
         VO6PK5A/zHIZafZL25d20TvbdXXg3c6zlbB2HJOXllZnDmgknvqa/Fw/I7GRliqSUW
         N3JlqOz+wbe8xFkZlBFuiuWOfortb1Xzt71EkCdoG8Fyk2KHb18mo22RFfKlwPjB1K
         Gpcs3CXussEwoblEARkP70RtJZ3I5H8zN5xsEP/DAE6aygE2n61WJPmCPogcI5ryWj
         YSL0vEGk3o+GQtVYoS1sMhpJ0uAUflwaXKk6HSGdpPfheguEpgYN6HfIF5COaUP2OD
         KyUURBLJ4kydg==
Date:   Mon, 15 Mar 2021 15:29:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: marvell: ARMADA375_USBCLUSTER_PHY should not
 default to y, unconditionally
Message-ID: <YE8v/XQyshBwmG6O@vkoul-mobl>
References: <20210208150252.424706-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208150252.424706-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-21, 16:02, Geert Uytterhoeven wrote:
> Merely enabling CONFIG_COMPILE_TEST should not enable additional code.
> To fix this, restrict the automatic enabling of ARMADA375_USBCLUSTER_PHY
> to MACH_ARMADA_375, and ask the user in case of compile-testing.

Applied, thanks

-- 
~Vinod
