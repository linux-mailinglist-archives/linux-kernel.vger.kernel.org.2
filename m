Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F6F377A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhEJD3O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 9 May 2021 23:29:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:24215 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhEJD3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:29:13 -0400
IronPort-SDR: m/B67G93Bk3fupKUvEg1iWlU8j/y3QUnlxwl62q+NfTJqptC5iGDBhw2+/4vX55voeGet2ya9t
 hXI4O81s94Bg==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="199173575"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="199173575"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2021 20:28:08 -0700
IronPort-SDR: 3CDholy5BJ7Vmf/JABB6RxzlkV8ggywUriuMcaB/y7SyzqRMVjkN1ynKFnTrCSsiruMRTHwOG8
 YCuSZX0e10mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="390804963"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 09 May 2021 20:28:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 9 May 2021 20:28:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 9 May 2021 20:28:07 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Sun, 9 May 2021 20:28:07 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>,
        =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Oscar Salvador" <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, Jue Wang <juew@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaoaili126@gmail.com" <yaoaili126@gmail.com>
Subject: RE: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Topic: [PATCH v3 0/3] mm,hwpoison: fix sending SIGBUS for Action
 Required MCE
Thread-Index: AQHXNklUtDziI1+1ZUqZsXGvSliLyarXX3UAgAAW4VCAAJTpAIAAYa8A///72gCAAQaCAIACu56g
Date:   Mon, 10 May 2021 03:28:07 +0000
Message-ID: <ad43e2df993e477cbe5d2db44ebbcad5@intel.com>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
        <d09f178272df4c82b8c090ba79d222b5@intel.com>
        <87ba79daaba1416589b203118be096cb@intel.com>
        <20210507052422.GB2158342@hori.linux.bs1.fc.nec.co.jp>
        <20210507191400.6258dee6@alex-virtual-machine>
        <e6577ace06ca4ce9bbfb8195d7a2bfb7@intel.com>
 <20210508103842.7dc6e8b1@alex-virtual-machine>
In-Reply-To: <20210508103842.7dc6e8b1@alex-virtual-machine>
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

> Sorry, I am not sure if the stress test in my server is same with yours.

It's better if you test different things ... that's how we get better coverage.

> Usually, I will do one RAS stress test from mce-test/cases/stress before post something.
> Maybe this test is not general useful or you have tested it and passed or you may think
> the test is not proper though or you tested and you don't think it's one real issue,
> then just ignore it please.

I haven't re-run the mce-test cases for a while. The test that was run on these patches
involves a multi-threaded application running on all logical CPUs. When poison is injected
many of the CPUs can hit the poison close together. So it's a good stress test for the new
series.

-Tony

