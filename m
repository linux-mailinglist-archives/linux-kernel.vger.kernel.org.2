Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF03F8E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbhHZS6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:58:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:14395 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243427AbhHZS6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:58:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="205021944"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="205021944"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 11:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="444679450"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 26 Aug 2021 11:57:24 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id A374F5808BC;
        Thu, 26 Aug 2021 11:57:24 -0700 (PDT)
Message-ID: <6e7f25a8a4c46ebf19238d9ad6708b490a157784.camel@linux.intel.com>
Subject: Re: [PATCH] mfd: intel_pmt: Only compile on x86
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Date:   Thu, 26 Aug 2021 11:57:24 -0700
In-Reply-To: <b075d481-f1a3-22d5-24b7-0b170d2908a1@redhat.com>
References: <20210825125735.621799-1-prarit@redhat.com>
         <b075d481-f1a3-22d5-24b7-0b170d2908a1@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-26 at 15:19 +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/25/21 2:57 PM, Prarit Bhargava wrote:
> > The intel_pmt driver shows up as a compile option for all arches
> > but is
> > 32-bit and 64-bit x86 specific.
> > 
> > Add a CONFIG dependency on X86 for intel_pmt.
> > 
> > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: David E. Box <david.e.box@linux.intel.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans

Okay by me.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

> 
> 
> 
> > ---
> >  drivers/mfd/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 6a3fd2d75f96..0f12b00955b4 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -676,7 +676,7 @@ config MFD_INTEL_PMC_BXT
> >  
> >  config MFD_INTEL_PMT
> >         tristate "Intel Platform Monitoring Technology (PMT)
> > support"
> > -       depends on PCI
> > +       depends on X86 && PCI
> >         select MFD_CORE
> >         help
> >           The Intel Platform Monitoring Technology (PMT) is an
> > interface that
> > 
> 


