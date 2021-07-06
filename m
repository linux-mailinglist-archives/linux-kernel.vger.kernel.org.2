Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A494F3BDA28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbhGFP3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhGFP3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:29:45 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF29619AE;
        Tue,  6 Jul 2021 15:27:06 +0000 (UTC)
Date:   Tue, 6 Jul 2021 11:26:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] tracing: Add "grouping" to histogram logic
Message-ID: <20210706112659.74bc2b2a@oasis.local.home>
In-Reply-To: <CAM9d7chNNYdg5OPir=1QuyQ0OqdZJ=jbW5iy+6o9kSNuqZ1i_A@mail.gmail.com>
References: <20210702175648.1172476c@gandalf.local.home>
        <20210703190725.8082fc92c244e26abec0bf8b@kernel.org>
        <20210703082713.3643b4d6@rorschach.local.home>
        <CAM9d7chNNYdg5OPir=1QuyQ0OqdZJ=jbW5iy+6o9kSNuqZ1i_A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2021 13:32:53 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> > Yeah, I just picked '-' but then realized it would conflict with other
> > key words.  
> 
> Also we already have ".log2" flag for a logarithmic histrogram.
> Then we might have something like "keys=FIELD.bucket=SIZE"
> for linear histograms.

I like the above idea.

Tom, do you have any issue with this?

-- Steve
