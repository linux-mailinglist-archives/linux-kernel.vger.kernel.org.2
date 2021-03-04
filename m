Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F066C32D1C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhCDL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:28:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhCDL2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:28:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C72BA64E84;
        Thu,  4 Mar 2021 11:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614857255;
        bh=ZLlwqe4CZHdUFtx/pyzY9t1/fCqc2OK8iyKFQdrNv7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpYjOIgLtSF1Rjn67TEIRmnu6szWUePal+2rX51/5KQ/kchjDVoSj6laD0J5km7zg
         R8v0OsfQPGNO4TIJLVgdESaD2qSwn78ZUzuLjFXeFpy1fM5ESj9RVZB7iqd3HxmXsB
         o84zUIDRjXI/6UgKK3oxHr3nCp0akmXjXFSonVCr2QpmVS+Kna5Z5o1DRDFMDxM6Vq
         8QXYgwxPLrlDNqOs6BBJJwf41NnZ15f2Sx0M1vxTcXaakY9xJAniUhWCNPDdUPGknX
         sxuq02dTUh1yoj9wJyH1ijOoUeowJyQCABPypEolgpDyW9hIg5sIeXam3EJHt8aI09
         52jqYQLycDypA==
Date:   Thu, 4 Mar 2021 19:27:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Yang <leoyang.li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] arm: dts: ls1021a: Harmonize DWC USB3 DT nodes
 name
Message-ID: <20210304112720.GO15865@dragon>
References: <20210208135154.6645-1-Sergey.Semin@baikalelectronics.ru>
 <20210208135154.6645-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208135154.6645-2-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 04:51:45PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>

Applied, thanks.
