Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D583C73C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGMQJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:09:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39514 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhGMQJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:09:58 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1411BCC;
        Tue, 13 Jul 2021 18:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1626192427;
        bh=7u3NFORVoHd5fpCFXJVJnRfV1NHuvZn9ebeFQRmpx90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODnIbVVNZT6B7eFai6iv16GMp4fSv3pzdRagXY2JhEcH1aX+YyFJF3zy5cAFYX5DV
         154OaZk/PpfCxGhNWO4Emfw1HBtPV4E29+g3CsDQMT6+4d+TQ1Ndozf5ILGI9rHsQN
         NmFM18WoRBQIzkBpFA7h8s2Byrd3cgHVbplkCq4s=
Date:   Tue, 13 Jul 2021 19:06:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <YO25/IAD0J40R7bH@pendragon.ideasonboard.com>
References: <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
 <20210712133428.GD4435@sirena.org.uk>
 <CAHp75VcQUUDdLYbpvTXSMPvjBzbHtBxywVBPS_xfY5JXyo9XxA@mail.gmail.com>
 <20210712170120.GG4435@sirena.org.uk>
 <e17af9dc-78c0-adb8-1dfb-0698e7a4e394@gmail.com>
 <20210713152454.GC4098@sirena.org.uk>
 <YO20aXWkqLgwHkku@pendragon.ideasonboard.com>
 <20210713160259.GD4098@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210713160259.GD4098@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:02:59PM +0100, Mark Brown wrote:
> On Tue, Jul 13, 2021 at 06:42:33PM +0300, Laurent Pinchart wrote:
> > On Tue, Jul 13, 2021 at 04:24:54PM +0100, Mark Brown wrote:
> > > On Tue, Jul 13, 2021 at 12:32:26AM +0100, Daniel Scally wrote:
> > > > It also creates some problems to suppress the enumeration of the i2c
> > > > device via ACPI (which we'll have to do in a machine specific fashion,
> > > > because some laptops have this chip with properly configured ACPI and
> > >
> > > To be clear I think that's a terrible idea.
> >
> > If you're talking about the ACPI implementation on those machines,
> > nobody disagrees :-)
> >
> > To make sure I understand you correctly, do you advocate for suppressing
> > registration of the I2C devices from ACPI and instantiate them from
> > board code instead, or to somehow supplement the I2C device with
> > board-specific data ?
> 
> No, to repeat yet again that is what I think is a terrible idea.

Which of those two ? :-)

-- 
Regards,

Laurent Pinchart
