Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6779035143D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 13:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhDALJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 07:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234035AbhDALI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 07:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41366610CA;
        Thu,  1 Apr 2021 11:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617275279;
        bh=ogd+y0+ZXpj/igXJ7ptSRR8VZf3rn4GEdDLItqgA/SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OftIwAXvBBXjILGp6g/LnTvAHq00DxXPLg5xCuM5HEUpREg0qwheg/vNZUxXNN8I0
         S01QMncG4IuZ4vWglC3QzCXJM/ZW3oEXCty58naVv6tzdHJw8EbzSRDeWdLAOccoy1
         2UyPohCy/CjeukzhhRSbVuaDgmIo1XpPd1HIXStWxz3XAobydHGu+GbEBNfEGAQ2+3
         hDydlKNk/wPHDiPYtX+izzLTI2gdZotZPlpKwcv4s456ixkIKd3niVhHlv25GbXKYa
         ged+8ITp8ti4G4x8JRc/08wQqZYQjb+TlcNHplD2SzhkIaUk/iF3ru/sQJ2XBrT/Hq
         pqvpwoCqsdyDA==
Date:   Thu, 1 Apr 2021 16:37:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        matheus@castello.eng.br
Subject: Re: [PATCH v2 0/6] Add support for Actions Semi Owl socinfo
Message-ID: <20210401110752.GG14052@work>
References: <cover.1617110420.git.cristian.ciocaltea@gmail.com>
 <20210401052438.GB14052@work>
 <20210401094041.GA1993499@BV030612LT>
 <20210401102717.GF14052@work>
 <252dd954-c8f1-fa2a-c37a-ede386fc9d43@suse.de>
 <20210401105805.GA1998829@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210401105805.GA1998829@BV030612LT>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Matheus

On Thu, Apr 01, 2021 at 01:58:05PM +0300, Cristian Ciocaltea wrote:
> Hi Mani, Andreas,
> 
> On Thu, Apr 01, 2021 at 12:49:37PM +0200, Andreas Färber wrote:
> > Hi,
> > 
> > On 01.04.21 12:27, Manivannan Sadhasivam wrote:
> > > On Thu, Apr 01, 2021 at 12:40:41PM +0300, Cristian Ciocaltea wrote:
> > >> On Thu, Apr 01, 2021 at 10:54:38AM +0530, Manivannan Sadhasivam wrote:
> > >>> On Tue, Mar 30, 2021 at 04:48:15PM +0300, Cristian Ciocaltea wrote:
> > >>>> This patchset adds a socinfo driver which provides information about
> > >>>> Actions Semi Owl SoCs to user space via sysfs: machine, family, soc_id,
> > >>>> serial_number.
> > >>>>
> > >>>> Please note the serial number is currently available only for the S500
> > >>>> SoC variant.
> > >>>>
> > >>>> This has been tested on the S500 SoC based RoseapplePi SBC.
> > >>>>
> > >>>
> > >>> Is this the soc_id provided by the vendor bootloader (uboot)? If so, under
> > >>> what basis it provides? I don't think the SoC has the provision for
> > >>> soc_id based on HW parameters.
> > >>
> > >> No, the soc_id is not provided by the bootloader, or at least I couldn't
> > >> identify any related implementation. Instead, I provided this via the
> > >> driver itself, since I've encountered this approach in some other soc
> > >> drivers as well (e.g. imx/soc-imx.c, versatile/soc-integrator.c). 
> > >>
> > > 
> > > Sorry, I was referring to serial_number. Since your comment says so, can
> > > you point to the corresponding code?
> > 
> > Seconded that this needs to be better understood. If this is just a
> > convention of some downstream U-Boot that's not implemented in mainline
> > (and maybe not even for Guitar or Labrador? tested on RoseapplePi only),
> > it might not be worth its own reserved-memory based kernel driver?
> 
> The serial number is actually provided by the s500-bootloader for which
> Actions did not provide the source code, at least it is not available
> in the xapp github repo. I did not find anything related to this in
> downstream U-Boot.
> 

Hmm, then we can consider this as the firmware dependent property. But
can we get consensus that this is common for all S500 SoCs? Maybe,
Matheus can verify it on Labrador?

I don't think adding a SOCINFO driver for a single board is a good idea.

Thanks,
Mani

> Kind regards,
> Cristi
> 
> > Implementing a standard interface such as DMI tables or a DT property in
> > mainline U-Boot may be more useful then. Is it still Mani's S900 only?
> > 
> > Regards,
> > Andreas
> > 
> > -- 
> > SUSE Software Solutions Germany GmbH
> > Maxfeldstr. 5, 90409 Nürnberg, Germany
> > GF: Felix Imendörffer
> > HRB 36809 (AG Nürnberg)
