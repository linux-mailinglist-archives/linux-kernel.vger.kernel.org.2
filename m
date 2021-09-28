Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B83041AE14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbhI1Ltz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240343AbhI1Ltx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:49:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B773D61157;
        Tue, 28 Sep 2021 11:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632829694;
        bh=vggUV5w9gPWUj0ZepYVJiJ+ZdNJmronGsXprqLnRN7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qMX0VSamLXVs6tHBQy5sBxpNV6KA2fj5dcROnJKrVfz2UN02u5gvPlfL1z6LyluF4
         F75Ra+DEYrfN/LjiOncFTHaGZf3ZjSs/uomCpqFeVNDSV1G/APmcTZsisPvT81nzFy
         z9iChvTDT2bn7vTBFZLGuQnanm2XrFjA9pwgJQE8+DWWD5z5kQUGMKR0ynlXIKC/zJ
         MqIKYz0ca+OI0nDReAOFrQSuurVm2qgEhJjeVIfijU661rRl2mnxLdTGB4Xiz0Db72
         uJwspzuOF3iQH3XlS8MDmH8bCrsTpvV6SiDdMcILW0M+nwV9QMTRDo1jHrrwt0kKzp
         WirVQKW57rEvQ==
Date:   Tue, 28 Sep 2021 13:48:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] ABI: sysfs-bus-pci: add documentation for
 modalias
Message-ID: <20210928134803.0d28feb6@coco.lan>
In-Reply-To: <YVLy6ouDppRSp2Pk@kroah.com>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
        <9ceb1fcdbef3c0d2d0368dcc2f19084a3e529ad1.1632750608.git.mchehab+huawei@kernel.org>
        <YVLy6ouDppRSp2Pk@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 28 Sep 2021 12:48:10 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Sep 27, 2021 at 03:59:39PM +0200, Mauro Carvalho Chehab wrote:
> > Even being available since 2005, there's no documentation for
> > modalias.
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> > 
> > See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/
> > 
> >  Documentation/ABI/testing/sysfs-bus-pci | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index 191cbe9ae5ed..1eeac7f59672 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -187,6 +187,24 @@ Description:
> >  		The symbolic link points to the PCI device sysfs entry of the
> >  		Physical Function this device associates with.
> >  
> > +What:		/sys/bus/pci/devices/.../modalias
> > +Date:		May 2005  
> 
> Wow, I was not good at documenting this stuff back then, sorry about
> that :(

Yeah, I guess most of the undocumented stuff comes from old times.
 
> I'll queue this series up now, thanks so much for working on this!

Anytime! I'm also glad with the results. 

-

I guess that there's still one missing feature at the script,
that should probably be easy to implement.

Right now, "./get_abi.pl search <foo>" doesn't evaluate regexes,
but searches for a substring match. This is very fast, but
we could do better, by changing the logic in order to use the
preparation part of the "undefined" logic, if the exact match
doesn't happen.

This way, a sys admin could use the script in order to find
documentation for a certain sysfs file on his system.

If I have some spare time left, I guess I'll try to implement
it.

Thanks,
Mauro
