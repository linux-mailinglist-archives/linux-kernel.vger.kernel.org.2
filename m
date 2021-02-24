Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A74324750
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 00:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhBXXDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 18:03:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:59508 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236169AbhBXXDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 18:03:39 -0500
IronPort-SDR: OO0a5f9u6tOGpflourjBbj8kOKFXwtuyeXjHs3vH+Lu7lNW0ABt7NSFe7DjzfLM1woEGsG80AN
 XtP/Uvh/pTyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="246751274"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="246751274"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 15:01:50 -0800
IronPort-SDR: h+2RPi2OzYuEaNndyIK6zqK4KdInzQr7GhcSJueF3UyfHRZbnVl1/4nPgIhm/kEOMZU3AtMTd1
 Q+tZzEfJSk3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="597555568"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2021 15:01:50 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.55])
        by linux.intel.com (Postfix) with ESMTP id 85B1558066A;
        Wed, 24 Feb 2021 15:01:50 -0800 (PST)
Message-ID: <dc97f44840890ccb0bc2cde1f1ef1e0ca47a64ab.camel@linux.intel.com>
Subject: Re: [PATCH V2 1/2] MFD: intel_pmt: Fix nuisance messages and
 handling of disabled capabilities
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, lee.jones@linaro.org,
        mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Wed, 24 Feb 2021 15:01:50 -0800
In-Reply-To: <6d45db24-7741-1956-9cf1-35a7dec517c5@redhat.com>
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
         <20210224201005.1034005-1-david.e.box@linux.intel.com>
         <6d45db24-7741-1956-9cf1-35a7dec517c5@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-24 at 21:22 +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/24/21 9:10 PM, David E. Box wrote:
> > Some products will be available that have PMT capabilities that are
> > not
> > supported. Remove the warnings in this instance to avoid nuisance
> > messages
> > and confusion.
> > 
> > Also return an error code for capabilities that are disabled by
> > quirk to
> > prevent them from keeping the driver loaded if only disabled
> > capabilities
> > are found.
> > 
> > Fixes: 4f8217d5b0ca ("mfd: Intel Platform Monitoring Technology
> > support")
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > For merge in platform-drivers-x86
> > 
> > Based on 5.11-rc1 review-hans branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Which, assuming you did a git remote update recently is AKA platform-
> drivers-x86-v5.12-1 .

That it is.

> 
> > Changes from V1:
> > 
> >         - None. Patch 2 added.
> 
> The series looks good to me, so for the series:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Lee, since both patches touch mfd files (and patch 2 also touches
> files under drivers/platform/x86)
> I think it would be best if you just merge the entire series.

Ack

David

> 
> As always I would appreciate a pull-req from you to also pull the
> changes
> into my tree, in case further drivers/platform/x86/intel_pmt* changes
> show up during this cycle.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> > 
> >  drivers/mfd/intel_pmt.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> > index 744b230cdcca..65da2b17a204 100644
> > --- a/drivers/mfd/intel_pmt.c
> > +++ b/drivers/mfd/intel_pmt.c
> > @@ -79,19 +79,18 @@ static int pmt_add_dev(struct pci_dev *pdev,
> > struct intel_dvsec_header *header,
> >         case DVSEC_INTEL_ID_WATCHER:
> >                 if (quirks & PMT_QUIRK_NO_WATCHER) {
> >                         dev_info(dev, "Watcher not supported\n");
> > -                       return 0;
> > +                       return -EINVAL;
> >                 }
> >                 name = "pmt_watcher";
> >                 break;
> >         case DVSEC_INTEL_ID_CRASHLOG:
> >                 if (quirks & PMT_QUIRK_NO_CRASHLOG) {
> >                         dev_info(dev, "Crashlog not supported\n");
> > -                       return 0;
> > +                       return -EINVAL;
> >                 }
> >                 name = "pmt_crashlog";
> >                 break;
> >         default:
> > -               dev_err(dev, "Unrecognized PMT capability: %d\n",
> > id);
> >                 return -EINVAL;
> >         }
> >  
> > @@ -174,12 +173,8 @@ static int pmt_pci_probe(struct pci_dev *pdev,
> > const struct pci_device_id *id)
> >                 header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
> >  
> >                 ret = pmt_add_dev(pdev, &header, quirks);
> > -               if (ret) {
> > -                       dev_warn(&pdev->dev,
> > -                                "Failed to add device for DVSEC id
> > %d\n",
> > -                                header.id);
> > +               if (ret)
> >                         continue;
> > -               }
> >  
> >                 found_devices = true;
> >         } while (true);
> > 
> > base-commit: a7d53dbbc70a81d5781da7fc905b656f41ad2381
> > 
> 


