Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2B1441D31
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhKAPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhKAPOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:14:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD1F60F02;
        Mon,  1 Nov 2021 15:12:16 +0000 (UTC)
Date:   Mon, 1 Nov 2021 11:12:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v4 1/2] trace: Add trace any kernel object
Message-ID: <20211101111214.1710bfb3@gandalf.local.home>
In-Reply-To: <20211101150759.617943-1-xiehuan09@gmail.com>
References: <20211101150759.617943-1-xiehuan09@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Nov 2021 23:07:59 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Introduce a method based on function tracer to trace any object and get
> the value of the object dynamically. the object can from the dynamic event
> (kprobe_event/uprobe_event) or the static event(tracepoint).
> 
> Usage:
> When using the kprobe event, only need to set the objtrace(a new trigger),
> we can get the value of the object. The object is from the setting of the 
> kprobe event.

Hi Jeff,

I just wanted to let you know that because the merge window just opened
(Linus released 5.15 and is now accepting changes for 5.16), I most likely
wont have any time to review your changes while the merge window is open
(for the next two weeks).

Please do not take my lack of responses during this time as ignoring you.
I'm just going to be overwhelmed with getting things right, and this merge
window is going to be a bit tougher for me than other merge windows.

Thanks,

-- Steve
