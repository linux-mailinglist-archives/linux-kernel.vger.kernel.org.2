Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804553EAE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbhHMChQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237040AbhHMChP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:37:15 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B48260F35;
        Fri, 13 Aug 2021 02:36:48 +0000 (UTC)
Date:   Thu, 12 Aug 2021 22:36:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     bristot@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 0/1] tracing: Provide more parseable hist trigger output
Message-ID: <20210812223641.2bb429c9@oasis.local.home>
In-Reply-To: <cover.1628807056.git.zanussi@kernel.org>
References: <cover.1628807056.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 17:43:23 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> I designed it so that more files/formats could be easily added as
> desired, so if you still want the csv output, let me know.  If so,
> though, please give me some more detailed idea as to what you think
> that should look like.

Thanks Tom!

BTW, I have off tomorrow, so I wont be looking at this until next week.

Although, tomorrow I'll probably spend my "free" time finishing up
slides that were due two weeks ago :-/

-- Steve
