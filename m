Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6479E33B024
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCOKlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCOKlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:41:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D581964E12;
        Mon, 15 Mar 2021 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615804873;
        bh=jemw6Q+9tGFKBMg01Wj15A1Cf1dSvnBxLZLbIMDh/cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UoKXRcRoKfKWLN+JjkIsnp2hEgi72G1v9sRFzRP5W9J8MctCTKE4a9WwTiNpw9RoL
         wsxxXyklXfn1KXqesUl5D0QH4dcAQD6I3pm6qastJ1hn6fwunjzaBl6EJ88vGLH0aZ
         rioFk7WnnW3Ayj/68ZdrqzbMUpnKVrKQF1mvlONAYORCJ58v1V+M9RlW+5u66NR4Zm
         Vzqfg32a3e1TCF1+dOE5Ja9Ju59AZftQANad/pIr/ko4uev83XTm/qgHw1D89Q/3oU
         DSoAvqRBIf4l68g6PBJkac2f7q2jDtSRaH99vurg4cnylgGkXICT7P5FQK7SlT3+OJ
         l7i/4nmoU3dPg==
Date:   Mon, 15 Mar 2021 16:11:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-phy@lists.infradead.org, Vivek Unune <npcomplete13@gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
Message-ID: <YE85xs+HX5UUXlXo@vkoul-mobl>
References: <20201116074650.16070-1-zajec5@gmail.com>
 <ed093ddb-da37-c3c4-cdd9-3b8e8db776bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed093ddb-da37-c3c4-cdd9-3b8e8db776bb@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-21, 21:31, Rafał Miłecki wrote:
> Hi,
> 
> On 16.11.2020 08:46, Rafał Miłecki wrote:
> > From: Rafał Miłecki <rafal@milecki.pl>
> > 
> > 1. Change syntax from txt to yaml
> > 2. Drop "Driver for" from the title
> > 3. Drop "reg = <0x0>;" from example (noticed by dt_binding_check)
> > 4. Specify license
> > 
> > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > ---
> > I think this should go through linux-phy tree. Kishon, Vinod, can you
> > take this patch?
> > 
> > This patch generates a false positive checkpatch.pl warning [0].
> > Please ignore:
> > WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
> > 
> > [0] https://lkml.org/lkml/2020/2/18/1084
> 
> Kishon, Vinod: I sent this patch back in December, it was Reviewed-by
> Rob, but never accepted.
> 
> Could you push this patch to the linux-phy.git?

Can you please rebase and resent me this patch. I am trying to
streamline patches now using phy ml and pw instance so that we dont miss
anything..

Thanks

-- 
~Vinod
