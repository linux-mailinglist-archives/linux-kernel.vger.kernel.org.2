Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE73337EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 09:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhCJIyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 03:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhCJIyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 03:54:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A1AF64FE2;
        Wed, 10 Mar 2021 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615366478;
        bh=/Pb3Pqj6xPlhaw9BQdMhiUyimBZOyzlbK5I639vLzAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvggVSiT/dNDyvL3kRyqa64L7i2oAjrj9x1bkCQf1cRXrLUp2DbT2SFgntQYjtTyk
         imB9pRQgKuPPOBPGguh4c0WEMkKwVe5s/bexNtBdEMU1klw/LVjsbjhCu8wNQuXZMX
         fGnp8WAImU6LcaF52WkpGo5r2HYLk93EQBcF8SAY=
Date:   Wed, 10 Mar 2021 09:54:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 01/12] dt-bindings: usb: fix yamllint check warning
Message-ID: <YEiJS0fPCOPOdlIq@kroah.com>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
 <20210310022811.GA1612587@robh.at.kernel.org>
 <1615346469.26498.1.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615346469.26498.1.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:21:09AM +0800, Chunfeng Yun wrote:
> On Tue, 2021-03-09 at 19:28 -0700, Rob Herring wrote:
> > On Mon, Mar 08, 2021 at 01:37:34PM +0800, Chunfeng Yun wrote:
> > > Fix warning: "missing starting space in comment"
> > 
> > What tree is this in because I don't see it.
> The patch is based kernel 5.12-rc1, also happens on
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-next

My branches are now rebased to not be on 5.12-rc1 because of the
problems with it, so please refresh and provide a "Fixes: " tag in your
updated patch.

thanks,

greg k-h
