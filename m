Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C979D452F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhKPKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234368AbhKPKnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:43:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87C0363213;
        Tue, 16 Nov 2021 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637059216;
        bh=vq5+K85pB1PFui0mQEetA92k/TvPf421WEIxiyypjvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4uysUtvFckb2XzbGlPw6TUu6LG5TjRIx43g94jZcWHmg74ZJ8DhiQ+N8Osgj2fOQ
         09nyX6mpHJsrXssA3V6hoVaSEO14Jej1sDoMJMARl6A+NF/cSJxwQVWEWC47zsxBSo
         7oADKfj6ttckFz8hQ01D9EhVVTU15F+o0V44iXsukNC5Q8Lw5lAtiSBeC/YQHRquda
         f2Hp9OXl3rKquMRYwZXgLcMWztxyODxsqTotjV9S8AeJ6NuL2+P4IPrLsW/qIE+8Wt
         Vk3JEKHI6TdFDoIyk4/Vuob79mX/QHQ0ToqD9KzUc8MChn1BBzIaMRm+zdl+M/+G1r
         nx3qh3rip7HXQ==
Date:   Tue, 16 Nov 2021 16:10:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH] phy: ti: report 2 non-kernel-doc comments
Message-ID: <YZOKjDoOR0s/fKV4@matsya>
References: <20211115030559.13994-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115030559.13994-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-11-21, 19:05, Randy Dunlap wrote:
> Do not use "/**" to begin a non-kernel-doc comment.
> Fixes these build warnings:
> 
> drivers/phy/ti/phy-am654-serdes.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * PCIe SERDES driver for AM654x SoC
> 
> drivers/phy/ti/phy-j721e-wiz.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>     * Wrapper driver for SERDES used in J721E

Applied, thanks

-- 
~Vinod
