Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0A432D902
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhCDRwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhCDRwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:52:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9555C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5MGfSaAeVkWmIyQNDDu99rBCsaK43VLdAk/4CiW1WBk=; b=SvCBRD5JI11bvnhgXzbIqnayjm
        QIhTIzDfZB/Ms9IZ4S/O0pFa56g9SqQyk30YDUULjbXaDtduqcGwIevsoZg8YkFxex1UXO44h3OWe
        4S2dhqFIkesk824so/SlTPN9olP3+7bKJozAyFZcUforp9y5D9st7ilS7oj04aZLyfVJ+zKBHOV2U
        EjYfJQvybX902ofZEH/vDgZ5ynYw0XVnZW4zu4Dp0VlZrzqRbdfAm/igVFSSPqdR9DUa6lUTdaGXn
        SlLcwukhFbGfs9mbVOaGJuNI2+hk7I7Bw+rgKTOosy4NkrXJRq7qf7E2yXq8bSyhnxvzsqvdR6d98
        PjMkD7ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHs6r-0084Qv-9J; Thu, 04 Mar 2021 17:50:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4597307975;
        Thu,  4 Mar 2021 18:50:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89C0C2BA29BFA; Thu,  4 Mar 2021 18:50:00 +0100 (CET)
Date:   Thu, 4 Mar 2021 18:50:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: Re: [PATCH 00/49] Add Alder Lake support for perf
Message-ID: <YEEdyMdzKdDKIvmp@hirez.programming.kicks-ass.net>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <0b447023-7c74-bc4f-5485-e03897d213da@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b447023-7c74-bc4f-5485-e03897d213da@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 10:50:45AM -0500, Liang, Kan wrote:
> Hi Peter,
> 
> Could you please take a look at the perf kernel patches (3-25)?
> 
> By now, we have got some comments regarding the generic hybrid feature
> enumeration code and perf tool patches. I would appreciate it very much if
> you could comment on the perf kernel patches.
> 

Yeah, I started staring at it yesterday.. I'll try and respond tomorrow.
