Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743EB367A00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhDVGfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:35:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:7070 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhDVGfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:35:33 -0400
IronPort-SDR: +wiVnhqi3qWiQpkMQRa6OnEdSRjlXeMCw/bs+ArZELeQvzxf2bi4+p4ICZ54RVGDW0Qh/g4Oux
 nZB1SBaM85iA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="281164951"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="281164951"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 23:34:58 -0700
IronPort-SDR: N/VdHPgKMmnCktx4S1kk0xv2cVIku/kjvc542q4RO5SjiE13e4jhIuMmjIFzPAycFgCO8IQ/Tx
 lru/cqQLORNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="453172193"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2021 23:34:56 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Yu Kuai <yukuai3@huawei.com>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, zhangxiaoxu5@huawei.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] stm class: initialize static variable in declaration
In-Reply-To: <20210407125358.4135345-1-yukuai3@huawei.com>
References: <20210407125358.4135345-1-yukuai3@huawei.com>
Date:   Thu, 22 Apr 2021 09:34:55 +0300
Message-ID: <87o8e6esj4.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Kuai <yukuai3@huawei.com> writes:

> mutex lock can be initialized automatically with DEFINE_MUTEX()
> rather than explicitly calling mutex_init().
>
> list head can be initialized automatically with LIST_HEAD() rather
> than explicitly calling INIT_LIST_HEAD().
>
> srcu_struct can be initialized automatically with DEFINE_STATIC_SRCU()
> rather than explicitly calling init_srcu_struct().

What's missing is the "why". We can do these or we can keep them as they
are. Each choice has impact on .text/.data, for instance. Why is one
preferred over the other?

Each patch should contain some form of analysis that shows that the
author thought about why they made the patch in the first
place.

And please learn not to spam the STMicro people with patches for System
Trace Module. Sometimes the same acronym can mean multiple different
things. This is another sign that the patch author spent zero time
getting to know the code that they are patching.

Regards,
--
Alex
