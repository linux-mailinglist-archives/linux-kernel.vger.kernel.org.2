Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5D34011A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhCRIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhCRIkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:40:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AF6A64EF9;
        Thu, 18 Mar 2021 08:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616056834;
        bh=2WnPoIviAZ+IGxSDjZN09t9OnbPRCM6YsWbXkWl0BN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0jqft3tu04ROcqzVXETpQPfRSt5jOlqbfdNMF7oJLl+0/XTpPIROG1wie/1cU5Lf
         ABTOJFQ+faIOqEVD4P41JdVFGieozgznp+m6C+0u7u2tTC4LwsKE3R+ER5mMWXyS6k
         HS/HHWJloB3d4Qwoyue2THgQu+2yNHiUsCN/RPHXX98xheVlvFGjm+OBQtksGTsb1G
         tXBy2g3OAIZFNj3Snast2oDfMvp274v2YoZ9w/f6RCE4AHMHQ80xXNoxiQ6Pil83mf
         dzABejHfAvdYXNS/SlsgWlXCnC1AKFuh4jJiOJ8EmUNwhQMZ5JnJg/auABe12666th
         5BAx9DLtYfpoA==
Date:   Thu, 18 Mar 2021 16:40:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sahil Malhotra <sahil.malhotra@oss.nxp.com>
Cc:     Sahil Malhotra <sahil.malhotra@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: enable optee node
Message-ID: <20210318084029.GY11246@dragon>
References: <20210305083351.13598-1-sahil.malhotra@oss.nxp.com>
 <20210315042821.GC11246@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315042821.GC11246@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 12:28:29PM +0800, Shawn Guo wrote:
> On Fri, Mar 05, 2021 at 02:03:51PM +0530, Sahil Malhotra wrote:
> > From: Sahil Malhotra <sahil.malhotra@nxp.com>
> > 
> > optee node was disabled in ls1028a.dtsi, enabling it by default.
> > 
> > Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> 
> Applied, thanks.

Patch dropped, as it causes regression on kontron-kbox-a-230-ls [1].

Shawn

[1] https://lore.kernel.org/linux-arm-kernel/38c31f5c-4400-eed7-d561-8f45e261ab01@collabora.com/
