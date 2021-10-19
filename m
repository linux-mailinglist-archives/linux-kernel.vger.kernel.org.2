Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2580433E12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhJSSJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234770AbhJSSJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:09:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 674B8604AC;
        Tue, 19 Oct 2021 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634666809;
        bh=QRHoFOiTZy8VK0r2DCaWi9nxm3sfvfTDB4HypYQ8wpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FIX0YVuaUlmTBhAiYoxYlY5KoMGZnwmQNfKdQl5h0rsGmj4Yh1fdGptzM4zbnhAal
         ulL2npUToEepyrzbf0aNGdrHacL1v/fkl8WlseiQ3gibXbFs70WAtSkN15lepHNPX2
         UV2civm+cGfDyGDAyVW1Gm8wqbbEoOfwEgFsvOhidqOWiytrsdvjpM1151QJdZZ6Cp
         Ut2DS6WjmQSmtYBcKOnHPLknscz0QaMkTppXz3rS9RrNCmHRFwF5B9rLJQrNgoKoy7
         b2m95hkXjwW++ibTmKrOTtLoBTZ41FOFqwkfuJ/p/x8wItNlIYpoy9dkGeZsU17fCN
         yBy2Dg8Kt9kvA==
Date:   Tue, 19 Oct 2021 23:36:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 0/3] phy: stm32: add phy tuning support
Message-ID: <YW8JNd82rZyjLoH9@matsya>
References: <20211015161427.220784-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015161427.220784-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-21, 18:14, Amelie Delaunay wrote:
> This series brings phy tuning to stm32-usbphyc with new optional
> device tree properties.
> A prior patch add resume routine, which is used to restore UTMI
> switch and phy tuning configuration, as they can be reset if
> deep low power state is achieved.

Applied, thanks

-- 
~Vinod
