Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9070036EF22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbhD2RvJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Apr 2021 13:51:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:57556 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233706AbhD2RvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:51:08 -0400
IronPort-SDR: YLgrXuhPP4sWKDqqlEY8/Nn8Z7JDx5gmRHdwCp5lQRgCurZE855wCNjmMrp/fpy5rLcdRtjKnn
 uHc7b/+pfhuA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="176555664"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="176555664"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 10:50:21 -0700
IronPort-SDR: bsJ7xWyidrkJGopANBwSbJO+yz7E0LhA2K2ENvAKxgJOrQH3hrN0jjMG1LmUimBlQWNXwMfiQs
 prEPB2UOK4mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="455644726"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2021 10:50:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 10:50:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 10:50:20 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 29 Apr 2021 10:50:20 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
Subject: RE: About add an A64FX cache control function into resctrl
Thread-Topic: About add an A64FX cache control function into resctrl
Thread-Index: AQHXPR8AhIvM7pb1S52qTlM+pjp6RKrLxTbg
Date:   Thu, 29 Apr 2021 17:50:20 +0000
Message-ID: <49cdd0b707194148915e2efe2ab5d707@intel.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
In-Reply-To: <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> [Sector cache function]
>>>> The sector cache function split cache into multiple sectors and
>>>> control them separately. It is implemented on the L1D cache and
>>>> L2 cache in the A64FX processor and can be controlled individually
>>>> for L1D cache and L2 cache. A64FX has no L3 cache. Each L1D cache and
>>>> L2 cache has 4 sectors. Which L1D sector is used is specified by the
>>>> value of [57:56] bits of address, how many ways of sector are
>>>> specified by the value of register (IMP_SCCR_L1_EL0).
>>>> Which L2 sector is used is specified by the value of [56] bits of
>>>> address, and how many ways of sector are specified by value of
>>>> register (IMP_SCCR_ASSIGN_EL1, IMP_SCCR_SET0_L2_EL1,
>>>> IMP_SCCR_SET1_L2_EL1).

Are A64FX binaries position independent?  I.e. could the OS reassign
a running task to a different sector by remapping it to different virtual
addresses during a context switch?

Or is this a static property at task launch?

-Tony
