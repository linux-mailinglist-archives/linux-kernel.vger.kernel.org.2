Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03A30526E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbhA0DT7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jan 2021 22:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392352AbhAZUnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:43:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F1322B3F;
        Tue, 26 Jan 2021 20:43:04 +0000 (UTC)
Date:   Tue, 26 Jan 2021 15:43:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
Message-ID: <20210126154302.302a3bb0@gandalf.local.home>
In-Reply-To: <20210126202058.GC12469@redhat.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
        <20210125181926.GA10248@redhat.com>
        <20210125133840.511b1496@gandalf.local.home>
        <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
        <20210126202058.GC12469@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 21:20:59 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> > No, not wrong. Even offset != 0, if the symbol exists in the kernel,
> > kprobe_on_func_entry() will check it.  
> 
> Yes, but unless I am totally confused... if kprobe_on_func_entry() returns false,
> then trace_kprobe_create() should fail with BAD_RETPROBE even if offset == 0 ?

From what I understand. kprobe_on_func_entry() can return false if you pass
in: "MOD:not_yet_loaded_module_func", but this is OK, because when the
module is loaded, and the "not_yet_loaded_module_func" exists, the
kretprobe will then be added.

The strchr(symbol,":") check is to see if "MOD:" (or some other ":" command)
is in the name, and we don't want it to fail if it is. Which is why we
should have that commented.

-- Steve
