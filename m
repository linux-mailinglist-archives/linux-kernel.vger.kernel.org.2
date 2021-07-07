Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484263BE8F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhGGNrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231758AbhGGNq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:46:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD1C861C98;
        Wed,  7 Jul 2021 13:44:18 +0000 (UTC)
Date:   Wed, 7 Jul 2021 09:44:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Daniel Bristot de Oliveira Subject: [PATCH] tracing:" 
        <bristot@redhat.com>
Subject: Re: [PATCH v2] tracing: Add linear buckets to histogram logic
Message-ID: <20210707094412.14080ac6@oasis.local.home>
In-Reply-To: <20210707195851.ae0aa69f0d37ed6d91c68e06@kernel.org>
References: <20210706154315.3567166e@gandalf.local.home>
        <20210707195851.ae0aa69f0d37ed6d91c68e06@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 19:58:51 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> BTW, would you plan to add this field options to tracefs/README ?
> (at least Documentation should be updated)

Yep, both should be updated. I wanted to make sure this looked good
before I spent time documented it ;-)

I'll add that as a second patch.

Thanks!

-- Steve
