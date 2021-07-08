Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B23C1B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 23:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhGHVg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 17:36:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:49848 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhGHVg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 17:36:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209643870"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="209643870"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 14:34:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="482685301"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 14:34:10 -0700
Date:   Thu, 8 Jul 2021 14:33:44 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Dey, Megha" <megha.dey@intel.com>, linux-kernel@vger.kernel.org,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: Programming PASID in IMS entries
Message-ID: <20210708213344.GA347913@otc-nc-03>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
 <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
 <20210707221216.GA56594@otc-nc-03>
 <20210707235822.GB4459@nvidia.com>
 <20210708003335.GC56594@otc-nc-03>
 <20210708120846.GD4459@nvidia.com>
 <20210708143657.GA70042@otc-nc-03>
 <87v95kod9f.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v95kod9f.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Jul 08, 2021 at 08:45:48PM +0200, Thomas Gleixner wrote:
> Ashok,
> 
> >> > IMS core owns the format of the entries right now vs device specific driver. 
> >> > I suppose your use case requiring a vm_id might have a different format. 
> >> > So this is yet another one the core needs to learn and adapt?
> >> 
> >> All entry format stuff is device specific, it shouldn't be in "core"
> >> code.
> >
> > Well, this is how it started way back last year. 
> >
> > https://lore.kernel.org/lkml/158751209583.36773.15917761221672315662.stgit@djiang5-desk3.ch.intel.com/
> 
> Which is wrong on so many levels as we all know.

Sorry, I was just trying to point to Jason, that its how things started.
Since he was suggesting to have them as device specific. 


> 
> > Where the driver functions for mask/unmask/write_msg etc. So the core
> > needs
> 
> Needs what?

Fat fingered that reply.. I completed it partially but moved to a different
sentence formation :-(
> 
> > So the format or layout is device specific, but core can dictate the exact
> > message that needs to be written.
> 
> Sorry, I don't grok what you want to say here.

Sorry it was unclear.. I meant things like compose_msg() 

Cheers,
Ashok
