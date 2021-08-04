Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CD73DF944
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhHDBbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 21:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbhHDBbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 21:31:41 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810E960E09;
        Wed,  4 Aug 2021 01:31:27 +0000 (UTC)
Date:   Tue, 3 Aug 2021 21:31:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <20210803213126.37a6da31@rorschach.local.home>
In-Reply-To: <f834d8e7-1027-9573-63ff-eedc49884b78@redhat.com>
References: <cover.1621414942.git.bristot@redhat.com>
        <ad69b06e9e3a5ec9ad2a49d290b719a96dcc471e.1621414942.git.bristot@redhat.com>
        <90c917eb-f0a8-3ef5-b63d-d88c1f6919a1@infradead.org>
        <f834d8e7-1027-9573-63ff-eedc49884b78@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 08:54:39 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> > No need for default y. There are other reasons to use DEBUG_KERNEL
> > without wanting RV turned on.  
> 
> yes, you are right, I will remove it.

Can you send a new updated version. I'd like to review whatever you
have as the latest.

Thanks!

-- Steve
