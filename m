Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD330C64D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhBBQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:44:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:48231 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236614AbhBBQlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:41:52 -0500
IronPort-SDR: 0wocoNJt5zZkb7tf6TGY0rphL87CEjSyGj0jAhLUVXK2VOwf6OeMYqAxGPIVRdpDxNBLYnZSAl
 9756zWkuh/0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="178325272"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="178325272"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 08:41:04 -0800
IronPort-SDR: Eg+PeupmJB38Swuetqqo43nQrCypvHKzH7vo8Lzx7eWKLBcq1cAlygGlegUyVr2t2BYtaiY6w2
 EXjdQ83jzDfA==
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="413654954"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 08:41:04 -0800
Date:   Tue, 2 Feb 2021 08:41:02 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Yian Chen <yian.chen@intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Parse SATC reporting structure
Message-ID: <20210202164102.GD39643@otc-nc-03>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202044057.615277-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:40:56PM +0800, Lu Baolu wrote:
> From: Yian Chen <yian.chen@intel.com>
> 
> Software should parse every SATC table and all devices in the tables
> reported by the BIOS and keep the information in kernel list for further
> SATC policy deployment.
> 
The last part seems bit vague? Are you trying to imply, 

if kernel is booted with noats for instance, a device listed in SATC table
as "requires ATS" will fail to load?

Otherwise its not clear what the policy enforcement means.
