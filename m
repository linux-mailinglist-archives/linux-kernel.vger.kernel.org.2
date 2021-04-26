Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01A836AAA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 04:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhDZCic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 22:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231530AbhDZCib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 22:38:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C80D461153;
        Mon, 26 Apr 2021 02:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619404670;
        bh=7dpW4eQeq+ZG8h1PDSRmKfVnaz1vyaoHBPm2vPnkKS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rf1ReuJMlyuLgevcWEHbNemRHlYzXyyVW97LJE5ShPiohZ1Sw2mG6YRGXmeH/Aiia
         jOZdK/DafVgYPrhnNz5roJ8UCSwrwgSUPeF/LaAl88RS2Cx3DdU5KM32p6B6k27J5L
         iR0FHh8hgDD/o+ppndRCV6Aybufme9vJ6KAuSJUBWRVQgBGFxCiX8FvwObkYJvzuBO
         4Hqg211QiK74sKcQXuck3Nq0CDuelOu6OR6dDFID93plQKvJypOMM2L0YB4Dognd/J
         oHO1+FhFrzrE46L0ul9Ik4jCzDhWHyJ5yqIF/hWNQ87gI/SOLVJ9NBuiTuvyJ2ykIW
         zfYRJ4HsjFr9g==
Date:   Mon, 26 Apr 2021 10:37:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sahil Malhotra <sahil.malhotra@oss.nxp.com>
Cc:     Sahil Malhotra <sahil.malhotra@nxp.com>,
        Michael Walle <michael@walle.cc>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1028a-rdb: enable optee node
Message-ID: <20210426023744.GF27585@dragon>
References: <20210330145027.16897-1-sahil.malhotra@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330145027.16897-1-sahil.malhotra@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 08:20:27PM +0530, Sahil Malhotra wrote:
> From: Sahil Malhotra <sahil.malhotra@nxp.com>
> 
> optee node was disabled by default, enabling it for ls1028a-rdb.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>

Applied, thanks.
