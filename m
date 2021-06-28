Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243253B674D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhF1RLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:11:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:65358 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232010AbhF1RLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:11:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="195147999"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="195147999"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 10:08:37 -0700
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="488960331"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 10:08:34 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lxukI-0065KS-9v; Mon, 28 Jun 2021 20:08:30 +0300
Date:   Mon, 28 Jun 2021 20:08:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, mihai.carabas@oracle.com,
        arnd@arndb.de, pizhenwei@bytedance.com, pbonzini@redhat.com,
        joe@perches.com
Subject: Re: [PATCH] misc/pvpanic-pci: Allow automatic loading
Message-ID: <YNoCDmHglfmN15lf@smile.fi.intel.com>
References: <20210628144422.895526-1-eric.auger@redhat.com>
 <YNnilZ/Kg4SpU+bw@kroah.com>
 <5e3f7609-4820-6a8b-306e-553f10ce0f8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e3f7609-4820-6a8b-306e-553f10ce0f8a@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 05:44:13PM +0200, Eric Auger wrote:
> On 6/28/21 4:54 PM, Greg KH wrote:
> > On Mon, Jun 28, 2021 at 04:44:22PM +0200, Eric Auger wrote:
> >> The pvpanic-pci driver does not auto-load and requires manual
> >> modprobe. Let's include a device database using the
> >> MODULE_DEVICE_TABLE macro.

...

> > Is this something that you need?  Or is it created by a tool?
> 
> the virtual machine monitor (QEMU) exposes the pvpanic-pci device to the
> guest. On guest side the module exists but currently isn't loaded
> automatically. So the driver fails to be probed and does not its job of
> handling guest panic events. We need a SW actor that loads the module
> and I thought this should be handled that way. If not, please could you
> advise?

At least something like about should have been in the commit message.
Otherwise the selling point is unclear.

-- 
With Best Regards,
Andy Shevchenko


