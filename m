Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9118B371886
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhECP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhECP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:56:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EEFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Vs0E/3wz3OQ4L5AnkU+ZgKdk9Ar5MBuRPGlKkIQNpE=; b=IOd8I0LIVnLrc0EybvWIy8xbaJ
        RazRbWdsTUUdwOd9euV7Rkw1fHjEcoTRqZEHV5zDApHuaruTUnk+2cWpEIskOp+9C7cWD3wiOUkeW
        GBNg9vxDAScezGoeWemV+gwz8lceYTDu6QBQxTpJ+MnnsIh8wJ5WZ4TAl4dlfBg55YMDL6XpM8y4M
        /MXx6bORsR6UDUJMLZp4lLgHhAZEobRT56enGT5d8R3/Rv6elyTTcmAl4lFbyCtvuIvjiYmRsOOO5
        It/YZInPf/mOloaXo8bzPmwtrzZHJj/qDNCGVWALFtBkT+Z2KAxL+uO9o3rBYsFXBvAG58HPobTB/
        XuUaAFVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldauj-00EJIl-DT; Mon, 03 May 2021 15:55:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69B2C300036;
        Mon,  3 May 2021 17:55:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AEED20D77EEE; Mon,  3 May 2021 17:55:16 +0200 (CEST)
Date:   Mon, 3 May 2021 17:55:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+f619f7c0a2a5f87694e6@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        syzkaller-bugs@googlegroups.com, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [syzbot] possible deadlock in vm_mmap_pgoff
Message-ID: <YJAc5EnwL59DNojt@hirez.programming.kicks-ass.net>
References: <000000000000217d7005c0f5c6b1@google.com>
 <20210428061522.1841-1-hdanton@sina.com>
 <20210428093018.70c3888b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428093018.70c3888b@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 09:30:18AM -0400, Steven Rostedt wrote:

> > Break the lock chain by asking kworker to destroy perf event.
> > Thoughts other than workqueue are appreciated.
> 
> I think this could cause a problem with the delay.
> 
> This is called from event->destroy()
> 
> 
> 	if (event->destroy)
> 		event->destroy(event);
> 	module_put(pmu->module);

The uprobe and tracepoint pmus will never be a module.
