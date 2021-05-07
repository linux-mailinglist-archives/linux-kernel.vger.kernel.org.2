Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BAE375EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 04:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhEGCLp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 May 2021 22:11:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:22521 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhEGCLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 22:11:44 -0400
IronPort-SDR: VKaAD9iBv5NxnlWX4NBjH1JOjZkLDTp0IVwqmvJKiLVTkWfjqr+sxzNVOk9qZaMNzFOizynZfX
 FwHWtz0RK/Sw==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="186086661"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="186086661"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 19:10:44 -0700
IronPort-SDR: 8gWaSfEocJhW/51YD4zvzwFNyCtvIk1q1FNl95gCK+3xJ6PylCiEnzgoqPF6yZr+X6lv3kTEdb
 CDT6n6yQQqGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="389850749"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2021 19:10:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 6 May 2021 19:10:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 6 May 2021 19:10:43 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Thu, 6 May 2021 19:10:43 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aili Yao <yaoaili@kingsoft.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Topic: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Index: AQHXNklUtDziI1+1ZUqZsXGvSliLyarXX3UA
Date:   Fri, 7 May 2021 02:10:43 +0000
Message-ID: <d09f178272df4c82b8c090ba79d222b5@intel.com>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
In-Reply-To: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I updated the series based on previous feedbacks/discussions.

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
