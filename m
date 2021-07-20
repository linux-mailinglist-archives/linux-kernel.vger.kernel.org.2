Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3546D3CF83B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhGTKFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236776AbhGTKBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:01:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5287B61186;
        Tue, 20 Jul 2021 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626777738;
        bh=M4jlSJ3UNzpr+mylozsLVwswTXGvtSsFEMeKSMl3c5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZNiZZtNLAPyZJfy/2ntlt8NyM/cVcy0jo0IcptDzXh5fEALfIqk3zXq4p/DClF4Hu
         v+wwlqDtEeHQyPhMJMm7TDjaqBzbRpuyCRXZ2AKDS7g6DMqlhe1SMFCAF7ChTk1c96
         FZ/ESN2JifAFCiZbenYF9lq9XtYiBDn/ElZWjTWylSPE+KouN80yMEpsPKFxDDEb4T
         G+5rQ2io9tiMYBKEwATG/e1QOuYE1hKQ6hc1hD5vk/FO02FGp2rfcCby3uz1TKbga8
         nUW5mFLpqldVrL9MNFjuY3QJo8ZnfPXJXljPquaDkwl/X6LlqLtEAgHEwYLjmbQQTz
         oD6xZOoiJAebA==
Date:   Tue, 20 Jul 2021 16:12:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: phy: Rename Intel Keem Bay USB PHY
 bindings
Message-ID: <YPaohpd+QorBLmTu@matsya>
References: <91235a64185f7446fc58e638d77691078d3114d1.1626255556.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91235a64185f7446fc58e638d77691078d3114d1.1626255556.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-21, 11:42, Geert Uytterhoeven wrote:
> This is the only file not using the "intel,keembay-*" pattern.
> Fortunately the actual compatible value is already following the
> standard scheme.

Applied, thanks

-- 
~Vinod
