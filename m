Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8500C39B509
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFDIl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDIl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:41:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991BDC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qXJkxcEwIBu9Q5l9I0LHtYs/king+MVE7zIB/sgk2X0=; b=FpXeWg6E0jQdMhYGhJDCCbDvMf
        Qk9decS4JOfv/k1rEKDS7VRsIWYcTho4jnZPjKvB4zxmuHpl5sIDjF6jbSV99BOGFdwhoe1lR9e8x
        iKb5+ZXAqTkos/LZViN3XNoUnKc3UaBU5soZrVJOYtRVE89GjTLobE6nPrHuqviZ/xh5d5Sbwz0xx
        lPNFzQsBaIbzef1h+AGkoO8qBhjFdb8vWFflqXe9RrEH9gNLOlqUTqvub3qizadM/81IFlyx5wpYS
        JSWkr1xeH3r+22aE9+9i62hSa3S+2AuC/E1NDaQMsRi7YeAhpeqxqiY6ANYBjaGcnyBv5zjnOrJ5X
        TNgpy1ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lp5Mn-00CzXo-DL; Fri, 04 Jun 2021 08:39:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EE0E300091;
        Fri,  4 Jun 2021 10:39:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 870DA2BE400DC; Fri,  4 Jun 2021 10:39:43 +0200 (CEST)
Date:   Fri, 4 Jun 2021 10:39:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Fix debugfs_read_file_str()
Message-ID: <YLnmz7dOek/aTJAn@hirez.programming.kicks-ass.net>
References: <20210527091105.258457-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527091105.258457-1-dietmar.eggemann@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 11:11:05AM +0200, Dietmar Eggemann wrote:
> Read the entire size of the buffer, including the trailing new line
> character.
> Discovered while reading the sched domain names of CPU0:
> 
> before:
> 
> cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
> SMTMCDIE
> 
> after:
> 
> cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
> SMT
> MC
> DIE
> 
> Fixes: 9af0440ec86eb ("debugfs: Implement debugfs_create_str()")
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Urgh.. so much for last minute changes :/

Greg, AFAICT that commit has since landed in Linus, will you take care
of this?

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
