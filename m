Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF23E8371
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhHJTN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhHJTN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:13:27 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C18861008;
        Tue, 10 Aug 2021 19:13:04 +0000 (UTC)
Date:   Tue, 10 Aug 2021 15:12:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 36/38] tracing: Replace deprecated CPU-hotplug
 functions.
Message-ID: <20210810151257.71a8ba01@oasis.local.home>
In-Reply-To: <20210810133401.6xhxtr2uwd36uase@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
        <20210803141621.780504-37-bigeasy@linutronix.de>
        <20210803222637.0612b6aa@rorschach.local.home>
        <20210810133401.6xhxtr2uwd36uase@linutronix.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 15:34:01 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2021-08-03 22:26:37 [-0400], Steven Rostedt wrote:
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Steven, could you please route this via your tracing tree?
> 

Sure, will do.

-- Steve
