Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6323D33AA6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhCOE2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhCOE2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:28:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47D6564E13;
        Mon, 15 Mar 2021 04:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615782514;
        bh=LRNomH0gWorND74xJbojp//YEG2tVqAv0it20YOlcQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jjzomq+N987Uzm2cukzQ17V05+ifjpnnU9ehgjDhwID16tfWFeDRKct+L9NEcda+C
         kL0Dpgaw9XFKJUAuN3saJ6v+gHCRpGtOmRsJjgrWyDjOuWBeBlwqRG8aabqiUSfGj2
         eFn812U/lTwxwsg/7x0AQw+tYgRzSy8+8yGs/1OUsAAgJX4S0KaaGToJy1KMxnWvsI
         puKJQOjDxBYBfxfUx//gyI4fv3hOQCJ3jKRza7Lm+xe/x2yX/Z/d1n6KMN0yKROWLM
         uWtynFQa03rpz6fS0LK7WCMwFH7i8NyoOSnCjO08NIuXi8FTT3zEMLq2uNlPf2mTbj
         hwPMMnNzXvWXQ==
Date:   Mon, 15 Mar 2021 12:28:29 +0800
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
Message-ID: <20210315042821.GC11246@dragon>
References: <20210305083351.13598-1-sahil.malhotra@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305083351.13598-1-sahil.malhotra@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 02:03:51PM +0530, Sahil Malhotra wrote:
> From: Sahil Malhotra <sahil.malhotra@nxp.com>
> 
> optee node was disabled in ls1028a.dtsi, enabling it by default.
> 
> Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>

Applied, thanks.
