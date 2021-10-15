Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FE742F1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhJONFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbhJONFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:05:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFBEC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hl51WkBd6Z0GuZcXmOXw7H68jVbO8i+rjRoH58leiek=; b=EWDdmjOHLSAtIBfcZu0/ku7Wfq
        TTlSyPu3K5s7TEpdyBZNs0PfIPNW+tWR7JY7c7yll8ORo2NLZZpVBSxnoOjkA+9tazaJgTQrfveyQ
        +Jlqa/fPGBZFVm9coHqvhwQ7CkXHayLHteLXWdY9uItkOLmQF6FFsxtfppxTRRFX6ldWrDOuRpv8m
        6GbFQVY8EpbuZkm41A6LTik17J0Es0ONuExTB+mfbDj80UAn6UKDpV00volEezOcbuwwO9a4fw4s3
        0O2GYjbrXUTJl0SqG6vQ0kzFE0/Dus7i1ODdHWtIp5QgYVRABj8Af8Ckm5iEWRvphp2xzG86cNWFO
        VAUgrwQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbMr5-00A0Gu-Kf; Fri, 15 Oct 2021 13:02:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A5D8300577;
        Fri, 15 Oct 2021 15:02:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE135212B43C0; Fri, 15 Oct 2021 15:02:33 +0200 (CEST)
Date:   Fri, 15 Oct 2021 15:02:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Woody Lin <woodylin@google.com>, Ingo Molnar <mingo@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/scs: Reset the shadow stack when idle_task_exit
Message-ID: <YWl76d9EvJC9mB3g@hirez.programming.kicks-ass.net>
References: <20211012083521.973587-1-woodylin@google.com>
 <87zgrek1gl.mognet@arm.com>
 <CAHn4Dec0Jyc30vWMLAXwQ-ge4eS5S26hxfMky-e4f-TTtFrbEQ@mail.gmail.com>
 <87wnmijysj.mognet@arm.com>
 <CAHn4DedEV953QULZLAPOuXyHAw_mWRTdFj8bSm6zk3rNjFJj-A@mail.gmail.com>
 <87tuhljbi4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuhljbi4.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:32:51PM +0100, Valentin Schneider wrote:
> As for the SCS change, someone might argue for placing this elsewhere in
> the hotplug path, but that looks fine to me:
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks!
