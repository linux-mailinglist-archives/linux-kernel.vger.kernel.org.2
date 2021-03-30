Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B3034F073
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhC3SEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232502AbhC3SEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:04:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2E67619B9;
        Tue, 30 Mar 2021 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617127472;
        bh=PQ5S/TrXO84kqcGj5dGJdHVqnmimxvxf9DtcGJchqBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRB2J9y+/ZivoGmsa2n/wlr5fZ6PveJtyY0CTrAtzXlMpc2rsS9XP8nXYkS1GNXcx
         lildalmwicnPpauB0KdQfELyvw5hsmx0qU+gm0Kf8voACOYxSXXsJfPEuwQFzm4d7s
         UOGhRcm4yRvIMpXrQ4YtZIAp9y+YG5MRRmpxGY+HPG5BwZdkV+fgGsZNiktatTUmkK
         B9fF1r0vejlg+dtO2T/D5TlSxtJ2t4bguu78Fv6fyoaod1cSn8JSElmSWXQddV8ppE
         T+vb2d//4CcInE163bclzgsosS+cXeePZinQCcVDZBb6khlV6cx9RQmVOawvDGSmQo
         JvDkdgKyq30LA==
Date:   Tue, 30 Mar 2021 23:34:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Swapnil Jakhade <sjakhade@cadence.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v3 0/6] AM64: Add SERDES driver support
Message-ID: <YGNoLHjKC0y/VIHl@vkoul-mobl.Dlink>
References: <20210310120840.16447-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310120840.16447-1-kishon@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-03-21, 17:38, Kishon Vijay Abraham I wrote:
> AM64 uses the same SERDES as in J7200, however AM642 EVM doesn't
> have a clock generator (unlike J7200 base board). Here the clock from
> the SERDES has to be routed to the PCIE connector. This series adds
> support to drive reference clock output from SERDES and also adds
> SERDES (torrent) and SERDES wrapper (WIZ) bindings.
> 
> v1 of the patch series can be found @ [1]
> v2 of the patch series can be found @ [3]
> 
> Changes from v2:
> *) Sent the DT bindings as a separate series [4]
> *) Remove enabling PHY output clock in isolation mode
> 
> Changes from v1:
> *) Model the internal clocks without device tree input (Add #clock-cells
>    to SERDES DT nodes for getting a reference to the clock using index
>    to phandle). This is in accordance with comment given by Rob [2].
>    However the existing method to model clocks from device tree is not
>    removed to support upstreamed device tree.
> *) Included a patch to fix modifying static data by instance specific
>    initializations.
> *) Added a fix to delete "clk_div_sel" clk provider during cleanup

Applied, thanks

-- 
~Vinod
