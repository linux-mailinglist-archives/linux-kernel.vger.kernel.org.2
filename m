Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9D40A68D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbhINGPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:15:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:39272 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237875AbhINGPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:15:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="244222301"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="244222301"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 23:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="699345992"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Sep 2021 23:13:52 -0700
Date:   Tue, 14 Sep 2021 14:14:19 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com, fei1.li@intel.com
Subject: Re: [RFC PATCH v3 0/2] Introduce some interfaces for ACRN hypervisor
 HSM driver
Message-ID: <20210914061419.GA16275@louislifei-OptiPlex-7050>
References: <20210914060141.16187-1-fei1.li@intel.com>
 <YUA8Bb7OGg59eEzE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUA8Bb7OGg59eEzE@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:07:01AM +0200, Greg KH wrote:
> On Tue, Sep 14, 2021 at 02:01:39PM +0800, Fei Li wrote:
> > Add some new interfaces for ACRN hypervisor HSM driver:
> >   - MMIO device passthrough
> >   - virtual device creating/destroying
> >   - platform information fetching from the hypervisor
> 
> "RFC" means that you do not feel good about having these merged.  What
> needs to be finished before you send a "real" set of patches that you
> want to have reviewed properly?

Hi Greg

Sorry, please ignore the "RFC".
I feel good about these patches. Would you help to review these patches ?

thanks.

> 
> thanks,
> 
> greg k-h
