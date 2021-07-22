Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3A13D2BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGVRzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 13:55:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:44815 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhGVRzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 13:55:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="233538228"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="233538228"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:36:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="565185253"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 11:36:16 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m6dYG-00H8hf-Tq; Thu, 22 Jul 2021 21:36:08 +0300
Date:   Thu, 22 Jul 2021 21:36:08 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Guodong Xu <guodong.xu@linaro.org>, tangchengchang@huawei.com,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>, tim.c.chen@linux.intel.com,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v7 4/4] lib: test_bitmap: add bitmap_print_to_buf test
 cases
Message-ID: <YPm6mNa+cF1d5Am4@smile.fi.intel.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-5-song.bao.hua@hisilicon.com>
 <YPAlg5c8uDSZ2WvZ@smile.fi.intel.com>
 <YPCe+f3GPDUuvwnW@yury-ThinkPad>
 <CAHp75VcoNPiKDaZzTVr3unV3F5u+LQwAjy1hKSq0WUw_tB6uAw@mail.gmail.com>
 <YPDDdAwgYEptz2Uq@yury-ThinkPad>
 <YPgHtJqXi8cKad1Q@kroah.com>
 <YPmmR3JfgM/yIh1H@yury-ThinkPad>
 <YPmvMJHouZFDHVds@kroah.com>
 <YPm4eaqdx8mOIJ6p@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPm4eaqdx8mOIJ6p@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:27:05AM -0700, Yury Norov wrote:
> On Thu, Jul 22, 2021 at 07:47:28PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jul 22, 2021 at 10:09:27AM -0700, Yury Norov wrote:

...

> > And I have heard of systems much bigger than this as well.  Why do you
> > not think that large number of CPUs are not around?
> 
> I asked a question: is it urgent?, and I've got an answer: not urgent.

Sometimes that kind of answers may include grain of politeness.

-- 
With Best Regards,
Andy Shevchenko


