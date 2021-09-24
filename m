Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04B3416A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244024AbhIXD3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235369AbhIXD24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:28:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B983F60EE0;
        Fri, 24 Sep 2021 03:27:23 +0000 (UTC)
Date:   Thu, 23 Sep 2021 23:27:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: prevent preemption in
 perf_ftrace_function_call()
Message-ID: <20210923232722.4fc6f3fe@oasis.local.home>
In-Reply-To: <20210923232619.50103473@oasis.local.home>
References: <2470f39b-aed1-4e19-9982-206007eb0c6a@linux.alibaba.com>
        <20210923093359.30da8ba6@gandalf.local.home>
        <7f4dfb4a-d271-b3c5-f603-06cc789ba9e9@linux.alibaba.com>
        <20210923232619.50103473@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 23:26:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> If it can be scheduled, then RCU is definitely watching ;-)

In other words. Nothing ever gets scheduled into a location that RCU is
not watching.

-- Steve
