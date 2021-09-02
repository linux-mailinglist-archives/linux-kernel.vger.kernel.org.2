Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9E3FEECF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbhIBNjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234646AbhIBNjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:39:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E007960FC4;
        Thu,  2 Sep 2021 13:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630589904;
        bh=l6uGBy344Ik/n8UBlJrjcnIquIgfHVdam3N42gR+sUI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SjYuVkEAVYAjQp+u9hSTMc3fC7P9udJYCb7RaLZvFIvUL5h5EW63rHf2Mtk/kjQp5
         Kft841UbbviIMIIurDAJnWL2rVRiMQGSa/wPYmVk5icJeicJXicDqWDLUqOPLFLrN1
         /FajbLW5FQbfUtKbfHI3psfOaL/61R7tYAGDWdfgh56Yzi1sEaD+2XYND4fiBpV2Nx
         KX0kx7xQq8VJAzMBiSD7KHFfQsIN23m7mg5SgxDvgtH8Fg5TOZJgUlzSJ/Da727ZPK
         HBFB6c6B0R7oxUwYUIW2CZYIzS7bLRbRvkecE9i9T5ieFmTeNjfw9N1U8EWMESeGVy
         FEmOUWlKjTCHA==
Date:   Thu, 2 Sep 2021 15:38:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
Message-ID: <20210902153820.5624b57f@coco.lan>
In-Reply-To: <20210902151053.7ddfbe3a@coco.lan>
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
        <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
        <YTC4LPDem9uKXyMd@kroah.com>
        <20210902151053.7ddfbe3a@coco.lan>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 2 Sep 2021 15:10:53 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 2 Sep 2021 13:40:28 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Thu, Sep 02, 2021 at 01:28:35PM +0200, Mauro Carvalho Chehab wrote:  
> > > As there's no upstream DT bindings for this driver, let's
> > > update its DT schema, while it is not too late.    
> > 
> > So this is for 5.15-final?  
> 
> It can either be for 5.15 or 5.16, as there aren't any compatible
> under arch/ which uses the DT schema there. All patches adding
> such compatible are on this series. So, whatever version this
> is applied should be OK.

On a separate note, despite having "hisi_" on this driver's name, there's
nothing there that is really HiSilicon specific. What this driver does is
to control an USB HUB integrated inside a DT-based board, doing those 
functions:

	- Power on/off the chip;
	- reset the HUB;
	- control its OTG switch;
	- control power on/off for an USB type-C connector;
	- set USB role as host or device.

This is used on both HiKey 960 and HiKey 970 with the following
topology:

  +-----+      +--------+       +---------+
  | SoC | ---> | USB PHY|  ---> | USB HUB | ---> USB 3.0
  +-----+      +--------+       +---------+      and type-C ports 

Both Kirin 960 and 970 SoCs have a Synapsys IP (DWC 3). 

Both HiKey 960 and 970 cards use Richtek RT1711H Type-C Chip Driver
as part of the USB PHY logic, but they use different USB HUBs:

	- HiKey 960 use a Microchip USB5734 HUB
	- HiKey 970 use a TI TUSB8041 HUB

While I'm not sure how generic this driver can be, I'm thinking that
maybe a future patch could rename it to 'generic-usb-hub' or 
something similar - finding a good name is always the hardest 
part :-)

Thanks,
Mauro
