Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28173746BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhEERYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:24:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:25660 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240814AbhEERVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:21:55 -0400
IronPort-SDR: Gy5WfCCn8aFWi/mK5icurepG65pTP4/nbE5fdG3WmiDuQiKHKxHoJHeYx1mX6tyownRGoe2QTR
 DFu2uKJRLyPg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="177816675"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="177816675"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 10:20:55 -0700
IronPort-SDR: o0yYawx1/oCR50PF9y3RQo/kL4Ul4IoEzby+KDd4eOIHGD4boO5vcuxfAg3lZsk6M6TWjvEHWX
 nxfZZdfaeNjA==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="433926393"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.54.13]) ([10.209.54.13])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 10:20:54 -0700
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class
 checking
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
References: <20210505033945.1282851-1-ak@linux.intel.com>
 <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
 <875yzxh8j8.fsf@oldenburg.str.redhat.com>
 <20210505143916.GS4032392@tassilo.jf.intel.com>
 <CAKwvOdneTkwm1xmte2SxwR=pcp3vi320kQuQHtVNVbnqLbcP3Q@mail.gmail.com>
 <a4d64648-6726-2046-0883-ac7f20c70445@linux.intel.com>
 <CAKwvOd=jrmFxNMJzbMYbSYs7C6S1d7faOj-R60ZhpV50PNTdbw@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <37defc3e-4050-d8c5-c056-fdf64f516098@linux.intel.com>
Date:   Wed, 5 May 2021 10:20:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=jrmFxNMJzbMYbSYs7C6S1d7faOj-R60ZhpV50PNTdbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> But not sure why you want a test case?
> In general,
> when making a feature request to a compiler vendor, having a
> digestible snippet of code that demonstrates the problem goes a long
> way, much further than "clone this branch of my fork of this project
> and do a build and something goes wrong somewhere."  We're too busy to
> do that, please take the time to isolate it before making such
> requests.

Ah you misunderstood. I'm not making any feature requests.

-Andi

