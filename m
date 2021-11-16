Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE84538A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbhKPRkK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Nov 2021 12:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238918AbhKPRkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:40:06 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51F2A61A09;
        Tue, 16 Nov 2021 17:37:08 +0000 (UTC)
Date:   Tue, 16 Nov 2021 12:37:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        kernel@pengutronix.de, Colin Cross <ccross@android.com>
Subject: Re: [PATCH] pstore/ftrace: add a kernel parameter to start pstore
 recording
Message-ID: <20211116123705.7f99e35e@gandalf.local.home>
In-Reply-To: <20211116172835.r3puikipzryxnsoj@pengutronix.de>
References: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
        <20211116120603.4e0c04c2@gandalf.local.home>
        <20211116172835.r3puikipzryxnsoj@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 18:28:35 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> > Is this still needed? It's still in my internal patchwork, and I haven't
> > seen any responses.  
> 
> I didn't see any responses either, and unless someone else implemented
> something similar somewhere else, it's still needed.
> 
> The change was actually useful to debug a clk problem, where the machine
> freezed when a certain driver was loaded.

Perhaps I should ask this. Would anyone object if I just take this change
through my tree for the next merge window?

-- Steve


> 
> Thanks for keeping track of this change. I would only have noticed it
> missing next time when I have to debug a similar problem.

