Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC53C452CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhKPIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:35:15 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:21030 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231863AbhKPIfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637051535; x=1668587535;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=znU9LehZrn6drxfXvozvV494USWdBTfhm6EK8AQwbYE=;
  b=jLbx5TdW5r8MIzOmmMhwkpgTmtOQ+ObnfnkRPAdHexH5xR59VK/yDFpP
   9tm/fOa3it7ej1Sty/nAYGGeUecI/J/4TT063abCr+e0dgvzF6XD4Kx2m
   2pUzKY0YInccQrzRW3dxxugAy6BlhaR0BnyShgjxBGjaXayDAqyM/l6mv
   1NRDKskKJui8u7mboTRbSrZalE1OMFuncWsiD8yk8wa0JKMj9PKsVlKEY
   PW5LxlhLR3G2UJ9vyhHC6uUHbvwu+dAx1POqXO3d+HZTp15TVsESywyNc
   r+aRZlBeeGtUPYIDYpctSD/dxjORGwHjevj5Mip/4RzCDt+IFmTuUnYlp
   g==;
X-IronPort-AV: E=Sophos;i="5.87,238,1631570400"; 
   d="scan'208";a="20481749"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Nov 2021 09:32:13 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 16 Nov 2021 09:32:13 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 16 Nov 2021 09:32:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1637051533; x=1668587533;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=znU9LehZrn6drxfXvozvV494USWdBTfhm6EK8AQwbYE=;
  b=pviToSL1mfKaDP0k/Mc7Dj/AFqxlaC/XSCCml36nNO6a7X+s53p8EZf5
   TNnU7HLzaKZIZzsm8DfvqCpVebz7EhaHq7NCXQe5UNXPzhB//nNMM2zAb
   Tgmkk0l5AhfAjeKQ4p4eLtxcBggtfifwa9BKsSiROBHDZx//4rjxTwfhQ
   V6wYC6rO4jtmFiWzNFq2PjqDlXv6y25MNB+goVOgxfNmtybr4xxrzk53Y
   hh5MRY09t8EBbzy1xUNBHQxYouDbZetoLkGo1vMjiHdjemzD7dnExtx/2
   7QH/WGNN7584r+qVDqmDdploF2K4zAQS1fCNvkVqWEPQJPFao1VzZ1JMV
   A==;
X-IronPort-AV: E=Sophos;i="5.87,238,1631570400"; 
   d="scan'208";a="20481748"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Nov 2021 09:32:13 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 4FC86280065;
        Tue, 16 Nov 2021 09:32:13 +0100 (CET)
Message-ID: <e1a8d864a87553fb99bae8ac0c437dad8c37cd79.camel@ew.tq-group.com>
Subject: Re: [PATCH] of: base: Skip CPU nodes with non-"okay"/"disabled"
 status
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 16 Nov 2021 09:32:11 +0100
In-Reply-To: <0b4b4c4c-7b8d-7139-54b1-29c79f7ec081@gmail.com>
References: <20211108084804.13474-1-matthias.schiffer@ew.tq-group.com>
         <7b4afaa7-13df-513a-5986-e1a9f5f5d7ed@gmail.com>
         <19130461cbdd39e92b06ec425db5db2984b41a41.camel@ew.tq-group.com>
         <0b4b4c4c-7b8d-7139-54b1-29c79f7ec081@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-15 at 12:23 -0500, Frank Rowand wrote:
> Hi Matthias,
> 
> On 11/15/21 3:13 AM, Matthias Schiffer wrote:
> > On Sun, 2021-11-14 at 14:41 -0500, Frank Rowand wrote:
> > > On 11/8/21 3:48 AM, Matthias Schiffer wrote:
> > > > Allow fully disabling CPU nodes using status = "fail". Having no status
> > > > property at all is still interpreted as "okay" as usual.
> > > > 
> > > > This allows a bootloader to change the number of available CPUs (for
> > > > example when a common DTS is used for SoC variants with different numbers
> > > > of cores) without deleting the nodes altogether, which could require
> > > > additional fixups to avoid dangling phandle references.
> > > > 
> > > > References:
> > > > - https://www.lkml.org/lkml/2020/8/26/1237
> > > > - https://www.spinics.net/lists/devicetree-spec/msg01007.html
> > > > - https://github.com/devicetree-org/dt-schema/pull/61
> > > > 
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > > ---
> > > >  drivers/of/base.c | 29 +++++++++++++++++++++++++++++
> > > >  1 file changed, 29 insertions(+)
> > > > 
> > > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > > index 61de453b885c..4e9973627c8d 100644
> > > > --- a/drivers/of/base.c
> > > > +++ b/drivers/of/base.c
> > > > @@ -650,6 +650,32 @@ bool of_device_is_available(const struct device_node *device)
> > > >  }
> > > >  EXPORT_SYMBOL(of_device_is_available);
> > > >  
> > > > +/**
> > > > + *  __of_device_is_disabled - check if a device has status "disabled"
> > > > + *
> > > > + *  @device: Node to check status for, with locks already held
> > > > + *
> > > > + *  Return: True if the status property is set to "disabled",
> > > > + *  false otherwise
> > > > + *
> > > > + *  Most callers should use __of_device_is_available() instead, this function
> > > > + *  only exists due to the special interpretation of the "disabled" status for
> > > > + *  CPU nodes.
> > > > + */
> > > > +static bool __of_device_is_disabled(const struct device_node *device)
> > > > +{
> > > > +	const char *status;
> > > > +
> > > > +	if (!device)
> > > > +		return false;
> > > > +
> > > > +	status = __of_get_property(device, "status", NULL);
> > > > +	if (status == NULL)
> > > > +		return false;
> > > > +
> > > > +	return !strcmp(status, "disabled");
> > > > +}
> > > > +
> > > >  /**
> > > >   *  of_device_is_big_endian - check if a device has BE registers
> > > >   *
> > > > @@ -817,6 +843,9 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
> > > >  		of_node_put(node);
> > > >  	}
> > > >  	for (; next; next = next->sibling) {
> > > > +		if (!__of_device_is_available(next) &&
> > > > +		    !__of_device_is_disabled(next))
> > > 
> > > Shouldn't that just be a check to continue if the device is disabled?
> > > 
> > > If adding a check for available, then all of the callers of for_each_of_cpu_node()
> > > need to be checked.  There is at least one that is suspicious - arch/arm/mach-imx/platsmp.c
> > > has a comment:
> > > 
> > >  * Initialise the CPU possible map early - this describes the CPUs
> > >  * which may be present or become present in the system.
> 
> Thanks for the links to previous discussion you provided below.  I had
> forgotten the previous discussion.
> 
> In [2] Rob ended up saying that there were two options he was fine with.
> Either (or both), in of_get_next_cpu_node(),
> 
>   (1) use status of "fail" as the check or
> 
>   (2) use status of "disabled" as the check, conditional on !IS_ENABLED(CONFIG_PPC)
>       "this would need some spec update"
>       "Need to double check MIPS and Sparc though."
> 
> Neither of these two options are what this patch does.  It seems to me that
> option 1 is probably the easiest and least intrusive method.

My intuition is that a device with an unknown status value should not
be used. For most devices this is already handled by treating any value
that is not unset, "okay" or "ok" the same. For CPU nodes, this would
be the case by treating such values like "fail".

I did a quick grep through the in-tree Device Trees, and I did find a
few unusual status properties (none of them in CPU nodes though):

- Typo "failed" (4 cases)
- Typo "disable" (17 cases)
- "reserved" (19 cases)

"fail" appears 2 times, the rest is "okay", "ok" or "disabled".

I do not have a strong opinion on this though - for our concrete
usecase, checking for "fail" is fine, and we can treat unknown values
like "disabled" if you prefer that solution. Should "fail-*" status
values also be treated like "fail" then?




> 
> -Frank
> 
> > Previously, there were two option for the (effective) value of the
> > status of a device_node:
> > 
> > - "okay", "ok" or unset
> > - anything else (which includes "disabled" and "fail")
> > 
> > __of_device_is_available() checks which of these two is the case.
> > 
> > With the new code, we have 3 cases for the status of CPU nodes:
> > 
> > - "okay", "ok" or unset
> > - "disabled"
> > - anything else ("fail", ...)
> > 
> > My patch will only change the behaviour in one case: When a CPU node
> > has a status that is not "okay", "ok", "disabled" or unset - which is
> > exactly the point of my patch.
> > 
> > See also the change [1], which removed the !available check a while
> > ago, and the discussion in [2], which led us to the conclusion that 
> > of_get_next_cpu_node() must not distinguish "okay" and "disabled" CPU
> > nodes and we instead need a third status to disable a CPU for real.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/of/base.c?id=c961cb3be9064d1097ccc019390f8b5739daafc6
> > [2] https://www.lkml.org/lkml/2020/8/26/1237
> > 
> > 
> > > 
> > > -Frank
> > > 
> > > > +			continue;
> > > >  		if (!(of_node_name_eq(next, "cpu") ||
> > > >  		      __of_node_is_type(next, "cpu")))
> > > >  			continue;
> > > > 
> > > 
> > > 
> 
> 

