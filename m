Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9DD3956D2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhEaIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhEaIXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:23:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F4296103E;
        Mon, 31 May 2021 08:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622449331;
        bh=0fzSp4PUDxkbwQ9WVqH4hcCf2zwEpJ8nEwsSxZ2qXMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5g4kmWxKRIiQlmEELmFcy6P1q0RX5632M4WRbMgqcNCbRP6y5hK+7+hhJl5D+jQk
         WwMtH3WilvLZLAj6RU4dHzJIKHpDrgy+pOSKxgWgEd7rA4+W/p5PdqPLi+EKTNayUb
         2pze2E3bht8vC6w8o6o9XLSiy1PzK2QqGpYLKhL9hB59aY0ciITrPZ9jhp4zgZPShj
         ZgGGh+nT8r4lCx7IEx385D7OfIcTXac3p05zeBCKaCi7lpDQNiQ5cxdVQb37MdpQVZ
         acRkKVkigDkmhLNMbpU71vcBjRa4k0Q6lDwHwT6oo1zGaMCuwtjW2JFI38wz/WK/O/
         N0G8jzqmrmS1A==
Date:   Mon, 31 May 2021 13:52:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RESEND PATCH v2 0/2] STM32 USBPHYC vbus-supply property support
Message-ID: <YLScr5BwfLkk80eF@vkoul-mobl.Dlink>
References: <20210517120821.26466-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517120821.26466-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-21, 14:08, Amelie Delaunay wrote:
> STM32 USBPHYC provides two USB High-Speed ports which are used by controllers
> with Host capabilities. That's why vbus-supply has to be supported on each
> phy node.

Applied, thanks

-- 
~Vinod
