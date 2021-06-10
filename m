Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA63A3225
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFJRfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhFJRfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:35:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB18A613D0;
        Thu, 10 Jun 2021 17:33:47 +0000 (UTC)
Date:   Thu, 10 Jun 2021 13:33:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] kprobes: Print an error if probe is rejected
Message-ID: <20210610133346.4a55c60a@oasis.local.home>
In-Reply-To: <20210610191643.d24e7d56d102567070fe8386@kernel.org>
References: <20210610085617.1590138-1-naveen.n.rao@linux.vnet.ibm.com>
        <20210610191643.d24e7d56d102567070fe8386@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 19:16:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hmm, Nack for this way, but I understand that is a problem.
> If you got the error in perf probe, which uses ftrace dynamic-event interface.
> In that case, the errors should not be output in the dmesg, but are reported
> via error_log in tracefs.
> And kprobes itself should return different error code to the caller, instead
> of printing error in dmesg. See below.

We should update perf to use libtracefs that also has an interface to
read the error_log file.

-- Steve
