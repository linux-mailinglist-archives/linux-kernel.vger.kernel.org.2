Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AC444FFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhKOIRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:17:03 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:26958 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236727AbhKOIQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636964028; x=1668500028;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9w1hHGeqrAi9vzCE5kTs/S+OT21nKM0nTVCiPQ2ofg=;
  b=BoT4wgDx04x2929zqDb4xY01rQ8eAEebGpyFO874crEgZ72s0j5wT1WT
   z9qha9XjZR5r/RpqGbT2wXS7KaQ6LnBhu9rNOjJNiLdy9KVjAm3uQttXL
   k+JPm5zWRfMGts3WJdvZipQdrCbRkFEDWxUBs3uYAjVUPgqMFgORqS4Dh
   LgLDSES78FCPYkiFreRH7aTX8vzWORRd4k9aIYDmiIRGT8g/jEohh/PN0
   VPNjnlMJlCmBu5bJU5FKAAZthRFmMGeE6W/smLs6BPupfNCjiFNiRgRIs
   F0aliOr9jEhJFv2aQ9cqUHeepaiMZhQtXs7Jif/jmXd6Qp63cXfavYIUh
   g==;
X-IronPort-AV: E=Sophos;i="5.87,235,1631570400"; 
   d="scan'208";a="20457720"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Nov 2021 09:13:44 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 15 Nov 2021 09:13:44 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 15 Nov 2021 09:13:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636964024; x=1668500024;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9w1hHGeqrAi9vzCE5kTs/S+OT21nKM0nTVCiPQ2ofg=;
  b=bmSRn6UTTIMaT5PbL2lK8FjPjq1RnLoO+kgEl0TC8lrPg+r6r8P7xMEt
   vK8BVJhnx44eJoaLPXx2MPW89tdRdaZVZXQESaisBem8UJ64cWeQctPKB
   /2Ztv4of6eqGb1l03W+BFLQJUH8QXvjdIAf1BFD5GYSOAyU/uKfdTZb5Q
   DuwHVI0ZUi0tBbYmCN711yhiXqSAy6oTb7nAns/cPvpYqSfrIxLd8fH1B
   pINzo3ycA9KyKeHARVsRvevuqpzs9qpWafROfkVuuVHw77LySGVtc0qq+
   Wk1l6sgeQcPZ1FgYfgVqsY5QORn9XH+SFyqL2as2/dXEnXM2XT/Y+7DKT
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,235,1631570400"; 
   d="scan'208";a="20457719"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Nov 2021 09:13:44 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 4F1C8280065;
        Mon, 15 Nov 2021 09:13:44 +0100 (CET)
Message-ID: <19130461cbdd39e92b06ec425db5db2984b41a41.camel@ew.tq-group.com>
Subject: Re: [PATCH] of: base: Skip CPU nodes with non-"okay"/"disabled"
 status
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Nov 2021 09:13:42 +0100
In-Reply-To: <7b4afaa7-13df-513a-5986-e1a9f5f5d7ed@gmail.com>
References: <20211108084804.13474-1-matthias.schiffer@ew.tq-group.com>
         <7b4afaa7-13df-513a-5986-e1a9f5f5d7ed@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-11-14 at 14:41 -0500, Frank Rowand wrote:
> On 11/8/21 3:48 AM, Matthias Schiffer wrote:
> > Allow fully disabling CPU nodes using status = "fail". Having no status
> > property at all is still interpreted as "okay" as usual.
> > 
> > This allows a bootloader to change the number of available CPUs (for
> > example when a common DTS is used for SoC variants with different numbers
> > of cores) without deleting the nodes altogether, which could require
> > additional fixups to avoid dangling phandle references.
> > 
> > References:
> > - https://www.lkml.org/lkml/2020/8/26/1237
> > - https://www.spinics.net/lists/devicetree-spec/msg01007.html
> > - https://github.com/devicetree-org/dt-schema/pull/61
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/of/base.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 61de453b885c..4e9973627c8d 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -650,6 +650,32 @@ bool of_device_is_available(const struct device_node *device)
> >  }
> >  EXPORT_SYMBOL(of_device_is_available);
> >  
> > +/**
> > + *  __of_device_is_disabled - check if a device has status "disabled"
> > + *
> > + *  @device: Node to check status for, with locks already held
> > + *
> > + *  Return: True if the status property is set to "disabled",
> > + *  false otherwise
> > + *
> > + *  Most callers should use __of_device_is_available() instead, this function
> > + *  only exists due to the special interpretation of the "disabled" status for
> > + *  CPU nodes.
> > + */
> > +static bool __of_device_is_disabled(const struct device_node *device)
> > +{
> > +	const char *status;
> > +
> > +	if (!device)
> > +		return false;
> > +
> > +	status = __of_get_property(device, "status", NULL);
> > +	if (status == NULL)
> > +		return false;
> > +
> > +	return !strcmp(status, "disabled");
> > +}
> > +
> >  /**
> >   *  of_device_is_big_endian - check if a device has BE registers
> >   *
> > @@ -817,6 +843,9 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
> >  		of_node_put(node);
> >  	}
> >  	for (; next; next = next->sibling) {
> > +		if (!__of_device_is_available(next) &&
> > +		    !__of_device_is_disabled(next))
> 
> Shouldn't that just be a check to continue if the device is disabled?
> 
> If adding a check for available, then all of the callers of for_each_of_cpu_node()
> need to be checked.  There is at least one that is suspicious - arch/arm/mach-imx/platsmp.c
> has a comment:
> 
>  * Initialise the CPU possible map early - this describes the CPUs
>  * which may be present or become present in the system.

Previously, there were two option for the (effective) value of the
status of a device_node:

- "okay", "ok" or unset
- anything else (which includes "disabled" and "fail")

__of_device_is_available() checks which of these two is the case.

With the new code, we have 3 cases for the status of CPU nodes:

- "okay", "ok" or unset
- "disabled"
- anything else ("fail", ...)

My patch will only change the behaviour in one case: When a CPU node
has a status that is not "okay", "ok", "disabled" or unset - which is
exactly the point of my patch.

See also the change [1], which removed the !available check a while
ago, and the discussion in [2], which led us to the conclusion that 
of_get_next_cpu_node() must not distinguish "okay" and "disabled" CPU
nodes and we instead need a third status to disable a CPU for real.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/of/base.c?id=c961cb3be9064d1097ccc019390f8b5739daafc6
[2] https://www.lkml.org/lkml/2020/8/26/1237


> 
> -Frank
> 
> > +			continue;
> >  		if (!(of_node_name_eq(next, "cpu") ||
> >  		      __of_node_is_type(next, "cpu")))
> >  			continue;
> > 
> 
> 

