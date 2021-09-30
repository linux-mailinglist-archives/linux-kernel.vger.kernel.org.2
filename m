Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3926B41D591
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348696AbhI3IjA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Sep 2021 04:39:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:41463 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348048AbhI3Ii7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:38:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212215353"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="212215353"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 01:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="487241757"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 30 Sep 2021 01:37:15 -0700
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 30 Sep 2021 01:37:14 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 30 Sep 2021 11:37:12 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2242.012;
 Thu, 30 Sep 2021 11:37:12 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH 7/7] ABI: sysfs-platform-intel-pmc: add blank lines to
 make it valid for ReST
Thread-Topic: [PATCH 7/7] ABI: sysfs-platform-intel-pmc: add blank lines to
 make it valid for ReST
Thread-Index: AQHXs5BhWDSB44ICBEuOmGxnwUE14Ku8RYTw
Date:   Thu, 30 Sep 2021 08:37:12 +0000
Message-ID: <b21707f01a3646bf929db9c9df3653d7@intel.com>
References: <cover.1632740376.git.mchehab+huawei@kernel.org>
 <3673e1a255ad4100c933af215b60d68ba126f820.1632740376.git.mchehab+huawei@kernel.org>
In-Reply-To: <3673e1a255ad4100c933af215b60d68ba126f820.1632740376.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The ReST format requires blank lines before/after identation changes, for it
> to properly detect lists.
> 
> Fixes: ee7abc105e2b ("platform/x86: intel_pmc_core: export platform global
> reset bits via etr3 sysfs file")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Ack.
> ---
> 
> See [PATCH 0/7] at:
> https://lore.kernel.org/all/cover.1632740376.git.mchehab+huawei@kernel.o
> rg/T/#t
> 
>  Documentation/ABI/testing/sysfs-platform-intel-pmc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-intel-pmc
> b/Documentation/ABI/testing/sysfs-platform-intel-pmc
> index ef199af75ab0..f31d59b21f9b 100644
> --- a/Documentation/ABI/testing/sysfs-platform-intel-pmc
> +++ b/Documentation/ABI/testing/sysfs-platform-intel-pmc
> @@ -11,8 +11,10 @@ Description:
>  		to take effect.
> 
>  		Display global reset setting bits for PMC.
> +
>  			* bit 31 - global reset is locked
>  			* bit 20 - global reset is set
> +
>  		Writing bit 20 value to the etr3 will induce
>  		a platform "global reset" upon consequent platform reset,
>  		in case the register is not locked.
> --
> 2.31.1

