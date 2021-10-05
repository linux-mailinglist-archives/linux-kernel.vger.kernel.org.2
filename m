Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453D2421DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 07:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhJEF02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 01:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhJEF01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 01:26:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF9E461381;
        Tue,  5 Oct 2021 05:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633411477;
        bh=vYAlzfEKox5rYhvzwKXOP8m2/mJ52FvXE7XU/QVmPQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Upr2EwIpRCPYGaE2mWxWcQUv9J7KR7ivOTn03NQWsFuX9aYbvdndZobuxuDjFldQb
         Nrac3rCl7GLSJsvJrOZr8g5lj6AP+rQFn6JYp+fbyiYlQMHemES2T/aeo5FtodgZHk
         rMSiEOyt9543IYUADFJDYNnrmTMZ1KDmnv5w5iQlhY/Z8psBEjve3Jf+qPYodfKuUn
         +ODuFd+wgrCyaFY0f8hfrvXJGlpdLFvhQh/dDV3bIiYQXTVkBN++JQEmEejnmJaZ2K
         ZhDGuTQGG8zxGCGpMRVfBtL3wMyKbVyPdJYC+Jwo2thS9XtagI1acTafuUR6tQBCVZ
         W1lIVI8KelTaA==
Date:   Tue, 5 Oct 2021 13:24:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ARM: dts: imx7-tqma7/mba7: correct spelling of
 "TQ-Systems"
Message-ID: <20211005052431.GJ20743@dragon>
References: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <941f977a8f98a26a4f14fd2c8caf5374a67e9345.1632314390.git.matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 03:00:52PM +0200, Matthias Schiffer wrote:
> "TQ-Systems" is written with a dash.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied all, thanks!
