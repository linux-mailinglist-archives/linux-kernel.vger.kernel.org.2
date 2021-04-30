Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA0E3702F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhD3VaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 17:30:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:13530 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhD3VaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 17:30:16 -0400
IronPort-SDR: EvZ7CBfW2bs0FA84I6ZG8RnwI2TdUESxfGu6XwHttDcGIcGED9ydQ1ETHKflJ2L7nGGeZjhQ0+
 6dE4sa9B02DA==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="261320604"
X-IronPort-AV: E=Sophos;i="5.82,263,1613462400"; 
   d="scan'208";a="261320604"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 14:29:25 -0700
IronPort-SDR: QyZPI2TWT3liiCZURjZ6O9/cDnSRzTHfeNXvAqo4disO4VmBXvzif3veaNPyYUzdMImnr1CFuh
 LACTE41OYCTw==
X-IronPort-AV: E=Sophos;i="5.82,263,1613462400"; 
   d="scan'208";a="449101391"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.139.198]) ([10.252.139.198])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 14:29:24 -0700
Subject: Re: [PATCH V2 00/12] perf intel-pt: Add more support for VMs
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210430070309.17624-1-adrian.hunter@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <3bf1d71c-25d9-c5f8-40d3-60f79d7f72cc@linux.intel.com>
Date:   Fri, 30 Apr 2021 14:29:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210430070309.17624-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/30/2021 12:02 AM, Adrian Hunter wrote:
> Hi
>
> Here is V2, see changes list below.


This will be very useful. I'll definitely be an user for future 
debugging. Thanks for working on this.

For the series

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi


