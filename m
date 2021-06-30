Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD123B7F00
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhF3IbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhF3IbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:31:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C58C61D05;
        Wed, 30 Jun 2021 08:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625041721;
        bh=l0wHCFLyYbPFPL22qPyyESrGKo/qF7An+trFHeA935w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Srg3CaWAzV75696uAtf4yD0OjoO3SwimDBmuVpmyrS+jv89IAoJrNo4sF9G4QCV6I
         fQRvaVWy9XLx6d1S/xVtRumIg02GT+4DMyr80ajVnhd4wUsKhX/aRIX1qAQrcQe060
         l4SCWxWZadn8Ry1maZdAHeIFT3b9421do7DVLfkuoR7hdCL6FVK7n2y/Qj++gP04z9
         aL7+gFOmKSdbI3Y1Hiqjdsq1ziQdOznPzEl5Z5pyjEy1+upDBrVRBbCq8o6YUKnC2H
         lWF1uKienS0VpMdJgRGmkUTUU2wBJZ+721L6aoG8SDx8l/h7nhfM4fLfbJdV4z0CVz
         bC/SWOoc9LqrA==
Date:   Wed, 30 Jun 2021 10:28:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>,
        Axel Lin <axel.lin@ingics.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 0/5] Move Hisilicon 6421v600 SPMI and USB drivers
 out of staging
Message-ID: <20210630102835.35a4f334@coco.lan>
In-Reply-To: <YNr5Y5mDjX5pHfFO@kroah.com>
References: <cover.1624962269.git.mchehab+huawei@kernel.org>
        <YNr5Y5mDjX5pHfFO@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 29 Jun 2021 12:43:47 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Tue, Jun 29, 2021 at 12:31:26PM +0200, Mauro Carvalho Chehab wrote:
> > Hi Greg,
> > 
> > This series contain the final bits needed for the USB3 bus to work
> > without staging drivers on Hikey 970.  
> 
> Thanks for these, I'll look at them after 5.14-rc1 is out.

Thanks!

I'll submit a v11 soon enough.

We're opting to solve a regression at the regulator driver using a 
different approach than on v10. 

We need to sync with Mark if the fixup patch from Axel [1] will be 
merged via the regulator's tree or together with this series, as there 
will be one (trivial) conflict, as one of the patches in this series
drop a priv struct, defined on a header that will also be dropped,
replacing it by struct regmap.

[1] https://lore.kernel.org/lkml/20210630100911.5e866629@coco.lan/T/#m598ee2e31ecdf560c3b752fd8b0518131f4bf123

Thanks,
Mauro
