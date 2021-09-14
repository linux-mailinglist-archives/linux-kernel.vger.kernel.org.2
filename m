Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0118440AC6F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhINLdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhINLdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:33:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 04:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FsfKK5Kf9vKOxvR+9nsUJsi/c2UPNx/XksUYhPIZxzQ=; b=tbYyq0WkHL9L6+6fcr/8s9zv7m
        FtDypcaSf0fRrxiR7uf3Snls2idNGwX9ErS/e0NlJeGHeC7a+gwkac2Z3ZimK4BSVm7NDdB8BanUT
        CfGlGObVwO29buR3dsqrqVjLupweO/ib4f9EMeZI5Zc9fsqyFj9ZDo0kbGUWa2fhMdXi0XrH40Vdl
        H9RvwtD2CNeDpTtlQih8oMEeeJ8nG/XhwxeGUP9NThATLhIewHghYw/58edZk9ciY74Asl+ixPkA4
        wtHB25S38nccETWBDtl75G/OhnOP8OggfCzYWqDXjkYnjAItzLIYqDf3szJYH+aaPbcyW3gFyjYlk
        kJgJVNHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ6df-00EbX3-Nz; Tue, 14 Sep 2021 11:30:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFED3300255;
        Tue, 14 Sep 2021 13:30:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4DBE20CB3026; Tue, 14 Sep 2021 13:30:09 +0200 (CEST)
Date:   Tue, 14 Sep 2021 13:30:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, 21cnbao@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        prime.zeng@huawei.com,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>
Subject: Re: [RFC] Perfomance varies according to sysctl_sched_migration_cost
Message-ID: <YUCHwYo525+/98wq@hirez.programming.kicks-ass.net>
References: <ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3b3e55-8be9-595f-6d54-886d13a7e2fd@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 03:27:09PM +0800, Yicong Yang wrote:
> 2. The ABI now has been removed from sysctl and moved to debugfs. As tuning this can improve the performance
>    of some workloads on some platforms, maybe it's better to make it a formal sysctl again with docs?

It never was an ABI, there is nothing to restore. It has always been
CONFIG_SCHED_DEBUG.

I'm open to topology based improvements to the code, but I don't think
user tunables are a good way.
