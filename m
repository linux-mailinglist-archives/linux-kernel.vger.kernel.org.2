Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45A0344BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhCVQmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:42:18 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59669 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231976AbhCVQmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:42:02 -0400
Received: (qmail 671620 invoked by uid 1000); 22 Mar 2021 12:42:00 -0400
Date:   Mon, 22 Mar 2021 12:42:00 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] USB: ehci: drop workaround for forced irq threading
Message-ID: <20210322164200.GB667925@rowland.harvard.edu>
References: <20210322111249.32141-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322111249.32141-1-johan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 12:12:49PM +0100, Johan Hovold wrote:
> Force-threaded interrupt handlers used to run with interrupts enabled,
> something which could lead to deadlocks in case a threaded handler
> shared a lock with code running in hard interrupt context (e.g. timer
> callbacks) and did not explicitly disable interrupts.
> 
> Since commit 81e2073c175b ("genirq: Disable interrupts for force
> threaded handlers") interrupt handlers always run with interrupts
> disabled on non-RT so that drivers no longer need to do handle forced
> threading ("threadirqs").

What happens on RT systems?  Are they smart enough to avoid the whole 
problem by enabling interrupts during _all_ callbacks?

Alan Stern
