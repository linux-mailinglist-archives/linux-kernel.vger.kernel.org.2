Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EEE3E8E28
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhHKKKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:10:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:33981 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236580AbhHKKKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:10:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="213242778"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="213242778"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 03:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="506890714"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2021 03:09:52 -0700
Subject: Re: [PATCH 5/5] perf tools: Add dlfilter test
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210810114813.12951-1-adrian.hunter@intel.com>
 <20210810114813.12951-6-adrian.hunter@intel.com>
 <YRLGTfQdg7pBcf29@kernel.org>
 <e0eba7e7-d9ae-eff4-254c-6fe16809a675@intel.com>
 <YRLf0+ij2rNLvdRj@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a02ebcc2-798a-6c0c-60b2-7a90fd12163b@intel.com>
Date:   Wed, 11 Aug 2021 13:10:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRLf0+ij2rNLvdRj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/21 11:21 pm, Arnaldo Carvalho de Melo wrote:
> Em Tue, Aug 10, 2021 at 10:06:13PM +0300, Adrian Hunter escreveu:
>> On 10/08/21 9:32 pm, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Aug 10, 2021 at 02:48:13PM +0300, Adrian Hunter escreveu:
>>>> Add a perf test to test the dlfilter C API.
>>>>
>>>> A perf.data file is synthesized and then processed by perf script with a
>>>> dlfilter named dlfilter-test-api-v0.so. Also a C file is compiled to
>>>> provide a dso to match the synthesized perf.data file.
>>>
>>> [root@five ~]# perf test dlfilter
>>> 72: dlfilter C API                                                  : FAILED!

Should be fixed in V2
