Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E0C40BD40
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhIOBgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:36:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:43117 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhIOBgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:36:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="220304979"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="220304979"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 18:35:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="544375514"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Sep 2021 18:35:27 -0700
Date:   Wed, 15 Sep 2021 09:35:54 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com, fei1.li@intel.com
Subject: Re: [PATCH v4 2/2] virt: acrn: Introduce interfaces for virtual
 device creating/destroying
Message-ID: <20210915013554.GA28232@louislifei-OptiPlex-7050>
References: <20210914062627.16431-1-fei1.li@intel.com>
 <20210914062627.16431-3-fei1.li@intel.com>
 <YUBIoEYPP7e5+CR0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUBIoEYPP7e5+CR0@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 09:00:48AM +0200, Greg KH wrote:
> On Tue, Sep 14, 2021 at 02:26:27PM +0800, Fei Li wrote:
> > +struct acrn_vdev {
> > +	/*
> > +	 * the identifier of the device, the low 32 bits represent the vendor
> > +	 * id and device id of PCI device and the high 32 bits represent the
> > +	 * device number of the legacy device
> > +	 */
> > +	union {
> > +		__u64 value;
> > +		struct {
> > +			__u16 vendor;
> > +			__u16 device;
> > +			__u32 legacy_id;
> 
> What is the endian of these fields?
"Big-endian" or "Little-endian" ? If yes, they're Little-endian.

> 
> Please always specify them.
Sure.
> 
> thanks,
> 
> greg k-h
