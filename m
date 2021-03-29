Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5132934C098
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 02:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhC2Ait (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 20:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhC2AiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 20:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0915161922;
        Mon, 29 Mar 2021 00:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616978300;
        bh=Xn0UndLnRHTcnV9w5V4XY+G1MloCRyKASA1FTEQj8G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2/kj0xb3cFoaVuximJ2D22pa1TqyWlIFAqQQtA7bFQhA4UowrOlJmSAn5fLRw5Bp
         WKvSutZAIw1kVdmSo7hirDAeLth5z0VCr9l91VsMMxy1IMUowLddMm5IUNSHPPtOcY
         olo9/AcjjLnUoeYeCOHrqjhauqXFQ1IZA5bc/rrOJpLEitGmdnFnZEROqX6AvBvmIp
         LglxPQAQth9hljlf4FjR+3RS1faE215HYSbkyjgNNmxfFZGVgu+6lNas2ydZcuEj1L
         vFP2ip5UmsPzNkrXW2DaptApYmvFJ4n4QrwoOhsfwdvFXouWaKCLZqGin2fKSGolxy
         zkhJBHVnrESzQ==
Date:   Mon, 29 Mar 2021 08:38:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Michael Walle <michael@walle.cc>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix optee node
Message-ID: <20210329003814.GC22955@dragon>
References: <20210318083438.26536-1-michael@walle.cc>
 <CADRPPNR=xy_oBZFS+hmO1k+uu2ckFyrK9EUP77N3buU5XpuHrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNR=xy_oBZFS+hmO1k+uu2ckFyrK9EUP77N3buU5XpuHrw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 06:12:06PM -0500, Li Yang wrote:
> On Thu, Mar 18, 2021 at 3:36 AM Michael Walle <michael@walle.cc> wrote:
> >
> > Don't enable the optee node in the SoC include. It is an optional
> > component and actually, if enabled, breaks boards which doesn't have it.
> 
> Hi Shawn,
> 
> Shall we make this a general rule?  I see quite a few SoC dtsi files
> are having the optee node enabled by default.


Yeah, we should probably make it a general rule considering the issue
reported here.  I thought that optee driver is smart enough to stop
probing if there is no optee os/firmware support found on given platform.

Shawn
