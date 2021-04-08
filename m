Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733ED358746
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhDHOja convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Apr 2021 10:39:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:54887 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhDHOj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:39:29 -0400
IronPort-SDR: NH1/JSunqwBSMdgdwtmMDF2Y2ZLVxzt7FYQpaupl0Ky/KxXpCgw/droPlaK74/tnhb54HEAoUv
 iEF5MzxsiULw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="193595515"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="193595515"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 07:39:10 -0700
IronPort-SDR: X/kVjaTo9Okcc1DAfz/wFhJ8An0Rv4xFM/Puw+ACxQ4c7BCphuDDsJZtyZ4gUzu0UlRuHiSw1c
 i5JL2hJOS22g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="380276511"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 08 Apr 2021 07:39:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 07:39:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 07:39:09 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 8 Apr 2021 07:39:09 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>, Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKCAbJEJLWTh9ISFEPkxpGyhCKQ==?= 
        <naoya.horiguchi@nec.com>
Subject: RE: [RFC 0/4] Fix machine check recovery for copy_from_user
Thread-Topic: [RFC 0/4] Fix machine check recovery for copy_from_user
Thread-Index: AQHXIdNYiHm6dP/RhkeqE8lsAeByWKqqa0GAgABaGyA=
Date:   Thu, 8 Apr 2021 14:39:09 +0000
Message-ID: <595ed0ac4fbb470ca9cfd256aaf1810e@intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210408101335.28fd3692@alex-virtual-machine>
In-Reply-To: <20210408101335.28fd3692@alex-virtual-machine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have one scenario, may you take into account:
>
> If one copyin case occurs, write() returned by your patch, the user process may
> check the return values, for errors, it may exit the process, then the error page
> will be freed, and then the page maybe alloced to other process or to kernel itself,
> then code will initialize it and this will trigger one SRAO, if it's used by kernel,
> we may do nothing for this, and kernel may still touch it, and lead to one panic.

In this case kill_me_never() calls memory_failure() with flags == 0. I think (hope!)
that means that it will unmap the page from the task, but will not send a signal.

When the task exits the PTE for this page has the swap/poison signature, so the
page is not freed for re-use.

-Tony
