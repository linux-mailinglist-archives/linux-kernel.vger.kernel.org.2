Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB43452E92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhKPKCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:02:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233671AbhKPKCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:02:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D65B6120F;
        Tue, 16 Nov 2021 09:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637056744;
        bh=72HtoTGOJnv1qQ+d/4YD/KC5HfK4DkAfw+y+7wktYf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vsj2gGJxGtDVL78WRh9z3uErysp0TtVMznFmvYqHqr0vcB/bPq9Quiu7cjektfttc
         SImNPjIIhqHmzFmhbXoMftbdi9tfCNIPnYS7wMzNCM5OrGseShZnIhR9EpLqzo3/FS
         XJEoF6jfkUjUg1KTyzGC2pIXX/5Wj8dqkUyIh+IboIgxNnTmPSWRw7MAP5ZFwQac5Q
         hilkJed3q0lBMVyI5horwXcOkiAG4Lx+iVP29IajxQYjP5kBWriAge/JdhOkyInOiZ
         peqI5XrjQV4e07hHoDcJxaX+HZKtFlaQykdHFE6G3Tjc6BSk/uRADhMd2Fhiboj7pw
         5pSWch50ectFg==
Date:   Tue, 16 Nov 2021 15:28:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/1] phy: stm32: fix st,slow-hs-slew-rate with
 st,decrease-hs-slew-rate
Message-ID: <YZOA4wQH4Q4fNVTY@matsya>
References: <20211026154817.198937-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026154817.198937-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-21, 17:48, Amelie Delaunay wrote:
> st,decrease-hs-slew-rate is described in phy-stm32-usbphyc.yaml. Then
> fix the property name in driver.

Applied, thanks

-- 
~Vinod
