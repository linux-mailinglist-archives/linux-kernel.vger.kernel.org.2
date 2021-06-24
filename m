Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80193B3137
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhFXO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:26:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:63560 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhFXO0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:26:53 -0400
IronPort-SDR: sx3gDlPaGyxQVXu5wl5Wg9ljHfvZ4YjhouzZQsw3/n+QR2OjBAiiPYHDyWYxyxyDzrXcl6sbWv
 ZCjPIPXZOr8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="268610469"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="268610469"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 07:24:32 -0700
IronPort-SDR: BOnw6q+YprfzkrA2H+5wpuIJTQg4qNnIwCFqowTlQr/HHbE5TZVmu34xNxggsbicRGF9FCF+mj
 hNgl81uOb/hg==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="406658358"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.74.185]) ([10.209.74.185])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 07:24:32 -0700
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
To:     Greg KH <greg@kroah.com>, kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
Date:   Thu, 24 Jun 2021 07:24:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNQckpOuw80uCUa1@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> But first off, why is this symlink suddenly needed?  What is so special
> about this new hardware that it breaks the existing model?

The driver can be in two modes:

- Driver fully knows the hardware and puts in the correct Linux names

- Driver doesn't know the hardware but is in a fallback mode where it 
only looks at a discovery table. There we don't have the correct names, 
just an numeric identifier for the different hardware sub components.

In the later mode the numeric identifier is used in sysfs, in the former 
case the full Linux name. But we want to keep some degree of Linux user 
space compatibility between the two, that is why the full mode creates a 
symlink from the "numeric" name. This way the (ugly) identifiers needed 
for the fallback mode work everywhere.

-Andi

