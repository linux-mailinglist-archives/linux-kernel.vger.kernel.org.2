Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276C6332CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCIRFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:05:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhCIRFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:05:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCC064FB8;
        Tue,  9 Mar 2021 17:05:21 +0000 (UTC)
Date:   Tue, 9 Mar 2021 12:05:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The killing of ideal_nops[]
Message-ID: <20210309120519.7c6bbb97@gandalf.local.home>
In-Reply-To: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 17:58:17 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Hi,
> 
> AFAICT everything made in the past 10 years ends up using p6_nops. Is it
> time to kill off ideal_nops[] and simplify life?
> 

Well, the one bug that was reported recently was due to a box that uses a
different "ideal_nops" than p6_nops. Perhaps we should ask him if there's
any noticeable difference between using p6_nops for every function than the
ideal_nops that as found for that box.

-- Steve
