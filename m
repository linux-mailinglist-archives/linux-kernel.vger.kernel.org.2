Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A48379C53
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhEKB5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:57:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:35576 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhEKB5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:57:50 -0400
IronPort-SDR: BavRm09k8GY8b8cFjrzN7FflLn3ceHCUnjI/asrcpQMhRUnAgsMKe8qU70i3nbyA3lKTmbxBEs
 xp6e+z1gqOpA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="284819771"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="284819771"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 18:56:41 -0700
IronPort-SDR: SQphaNSnTY+2ExKDYQSdheFzJeELZxKuiRd2Zuof1+nV40+Ch5d0Fe3AqcdEJnUJYq8CqqOMZe
 XvlU9aCf0KFQ==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="470975445"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 18:56:11 -0700
Date:   Tue, 11 May 2021 10:13:06 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <20210511021306.GA8539@xsang-OptiPlex-9020>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
 <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
 <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
 <20210507030606.GA27263@xsang-OptiPlex-9020>
 <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Fri, May 07, 2021 at 10:52:22AM -0700, Roman Gushchin wrote:
> On Fri, May 07, 2021 at 11:06:06AM +0800, Oliver Sang wrote:
> > hi Roman,
> >  
> > On Thu, May 06, 2021 at 12:54:59AM +0000, Roman Gushchin wrote:
> > > Ping
> > 
> > sorry for late.
> > 
> > the new patch makes the performance a little better but still has
> > 1.9% regression comparing to
> > f183324133 ("percpu: implement partial chunk depopulation")
> 
> Hi Oliver!
> 
> Thank you for testing it!
> 
> Btw, can you, please, confirm that the regression is coming specifically
> from ace7e70901 ("percpu: use reclaim threshold instead of running for every page")?
> I do see *some* regression in my setup, but the data is very noisy, so I'm not sure
> I can confirm it.
> 
> Thanks!

sorry for late. according to our tests, the answer seems be yes.
let me explain our test a little, we found the KPI (here is aim9)
droped, then an automatic bisection was triggered. the ace7e70901
was finally recognized as the commit introduced the change.

since it's a bisection result, we have test data for both parent
and this commit. (BTW, we make sure the config for both kernels are
same)

for this bisect, we tested 6 times for both parent and ace7e70901,
and the data is stable, as below:

parent:
f183324133ea535db4127f9fad3e19725ca88bf3/avg.json:  "aim9.sync_disk_rw.ops_per_sec": 103531.76166666666,

f183324133ea535db4127f9fad3e19725ca88bf3/matrix.json:  "aim9.sync_disk_rw.ops_per_sec": [
f183324133ea535db4127f9fad3e19725ca88bf3/matrix.json-    103673.09,
f183324133ea535db4127f9fad3e19725ca88bf3/matrix.json-    102188.39,
f183324133ea535db4127f9fad3e19725ca88bf3/matrix.json-    104325.06,
f183324133ea535db4127f9fad3e19725ca88bf3/matrix.json-    104038.4,
f183324133ea535db4127f9fad3e19725ca88bf3/matrix.json-    102908.57,
f183324133ea535db4127f9fad3e19725ca88bf3/matrix.json-    104057.06
f183324133ea535db4127f9fad3e19725ca88bf3/matrix.json-  ],

ace7e70901:
ace7e7090137ee996757eb5eebc94439b0e2803a/avg.json:  "aim9.sync_disk_rw.ops_per_sec": 101102.73857142858,

ace7e7090137ee996757eb5eebc94439b0e2803a/matrix.json:  "aim9.sync_disk_rw.ops_per_sec": [
ace7e7090137ee996757eb5eebc94439b0e2803a/matrix.json-    101193.43,
ace7e7090137ee996757eb5eebc94439b0e2803a/matrix.json-    100689.98,
ace7e7090137ee996757eb5eebc94439b0e2803a/matrix.json-    100988.63,
ace7e7090137ee996757eb5eebc94439b0e2803a/matrix.json-    100732.64,
ace7e7090137ee996757eb5eebc94439b0e2803a/matrix.json-    101389.69,
ace7e7090137ee996757eb5eebc94439b0e2803a/matrix.json-    101662.74,
ace7e7090137ee996757eb5eebc94439b0e2803a/matrix.json-    101062.06
ace7e7090137ee996757eb5eebc94439b0e2803a/matrix.json-  ],

