Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC4A32D595
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhCDOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhCDOlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:41:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7737864F5B;
        Thu,  4 Mar 2021 14:40:50 +0000 (UTC)
Date:   Thu, 4 Mar 2021 09:40:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix memory leaks in __create_synth_event()
Message-ID: <20210304094049.19554140@gandalf.local.home>
In-Reply-To: <20210304094521.GA1826@cosmos>
References: <20210304094521.GA1826@cosmos>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 15:15:24 +0530
Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com> wrote:

> To fix call argv_free() even when argc=0.

I want to cry :'-(

Not anything to do with you. I have a set of fixes that I have queued that
requires a ~13 hour test to run before I push off to Linus. When it was
almost done, I discovered another bug. Fixed it. Killed the almost completed
running test, and restarted it for another 13 hour run. I woke up this
morning happy to see that it passed, but then found your patch.

Wash, rinse, repeat! :-p

Thanks, looks good and I'll apply it. (and start up my 13 hour test again!)

-- Steve
