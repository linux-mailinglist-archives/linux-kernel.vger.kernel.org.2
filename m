Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADE9368D69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbhDWG4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:56:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:18564 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhDWG43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:56:29 -0400
IronPort-SDR: gmOIab7+LyFG5YOuvNp1s6D1IzL7UGw5dErtTkdiCjGTFHscijqONGqU7Qoe9iCW6hYar2CJbF
 DoEeSQPcl1Mw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="175511556"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="175511556"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 23:55:52 -0700
IronPort-SDR: GCdFF6GP8kc2I/8Dxaz0fqjxv8x5uyyexAcSKSBZVk2aLiVYPPqaPy7zifFC/Gn8dvXYDQRfiC
 +EP4Cj09ndgQ==
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="428272895"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.46]) ([10.238.4.46])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 23:55:48 -0700
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
To:     Hillf Danton <hdanton@sina.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        tim.c.chen@linux.intel.com, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, yuzhao@google.com,
        wfg@mail.ustc.edu.cn
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <20210422102325.1332-1-hdanton@sina.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <2d254758-4e5c-5dbc-b939-0d1ca4be03a5@linux.intel.com>
Date:   Fri, 23 Apr 2021 14:55:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210422102325.1332-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2021 6:23 PM, Hillf Danton wrote:
> Another option seems like we take a nap at the second time of lru tmi
> with some allocators in your case served without the 100ms delay.

Thanks, I will try it with my test cases.

-- 
Zhengjun Xing
