Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7AC33AF64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCOJ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhCOJ51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8BB864E90;
        Mon, 15 Mar 2021 09:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615802246;
        bh=FIJka7xF+QteK9T+Iqp7GBjyzzP3ufqgREOJRod/2IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMJnUVEhBjC4sRlDPMG+Bqm5/d9gUMRp+IG8WbAzntGjOvWvlvcsWnuXRTzTXcJGz
         xihSeMK9iUNOuX15THnVLoCehi1Sbj98my4vTm+qqXl9rnt347/e28vWZlR2TDaPSh
         SmE7J1zAlagCWpHnDYVpiACRvKPLoeCKL9tio6QAZlRCI2Dfe7sHWk6IaoAFJe+I0Q
         GfTQOOvkY/Q970c09h9x3ekZyId3WDDHOyHK7GvJ2smjH0rjEwysaXsWvGOvFvGA7I
         wJNZX8KNOdzKZvmXmHctMncaNbDaiZa08lOP/v+pFQUVvPfysMxsw14Fg2zMUOxDOl
         4lJz1+FhFwq0Q==
Date:   Mon, 15 Mar 2021 15:27:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RESEND PATCH v3 0/2] STM32 USBPHYC ck_usbo_48m clock provider
Message-ID: <YE8vgizAd97I3EeC@vkoul-mobl>
References: <20210304160440.27612-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304160440.27612-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-03-21, 17:04, Amelie Delaunay wrote:
> STM32 USBPHYC provides clocks to STM32 RCC pour STM32 USB controllers.
> Specifically, ck_usbo_48m is a possible clock parent for USB OTG clock,
> during OTG Full-Speed operation.
> 
> This series registers the usbphyc as clock provider of this ck_usbo_48m clock.

Applied, thanks

-- 
~Vinod
