Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6016F3AE862
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFULwn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Jun 2021 07:52:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:43710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFULwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:52:39 -0400
IronPort-SDR: WvjEBBVnI6I1z6KmDkTX0DfujMCohgcCzwi8qz+SLNi+jbmf9IwuApN5N6o7BvS1EVEmDefRSs
 8mG+5phc9ofw==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="193962423"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193962423"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 04:50:25 -0700
IronPort-SDR: JXWRUJNWkg9ZSHMe6yEh6azfifIX8/9EowdPWhkut2anND4pr1+14KXROhhoF6MtHakW2KsmJk
 dIrlqA4C1j2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="453855133"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2021 04:50:24 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 04:50:23 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 19:50:21 +0800
Received: from shsmsx601.ccr.corp.intel.com ([10.109.6.141]) by
 SHSMSX601.ccr.corp.intel.com ([10.109.6.141]) with mapi id 15.01.2242.008;
 Mon, 21 Jun 2021 19:50:21 +0800
From:   "Xu, Pengfei" <pengfei.xu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Su, Heng" <heng.su@intel.com>, "Du, Julie" <julie.du@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Li, Philip" <philip.li@intel.com>
Subject: Recall: Tested x86 FPU fixes and found "Bad FPU state" issue
Thread-Topic: Tested x86 FPU fixes and found "Bad FPU state" issue
Thread-Index: AQHXZpOdT2Ohj/1gSo2GGOOxmvEmHQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Mon, 21 Jun 2021 11:50:21 +0000
Message-ID: <ace48269d8b540c394061773679b3584@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pengfei Xu would like to recall the message, "Tested x86 FPU fixes and found "Bad FPU state" issue".
