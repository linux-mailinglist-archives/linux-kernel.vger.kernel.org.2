Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885F53A4988
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFKTmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFKTmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:42:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF561613CA;
        Fri, 11 Jun 2021 19:40:22 +0000 (UTC)
Date:   Fri, 11 Jun 2021 15:40:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
Message-ID: <20210611154021.008537b0@gandalf.local.home>
In-Reply-To: <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
        <1623419180.o4u5xf72jm.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 19:25:38 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> We also have perf_event_open() as an interface to add probes, and I 
> don't think it would be helpful to require all tools to utilize the 
> error log from tracefs for this purpose.

The there should be a perf interface to read the errors. I agree with
Masami. Let's not have console logs for probe errors.

-- Steve
