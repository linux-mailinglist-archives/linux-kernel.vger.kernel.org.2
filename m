Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7C939F7C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhFHN0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232854AbhFHN01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:26:27 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE146124B;
        Tue,  8 Jun 2021 13:24:33 +0000 (UTC)
Date:   Tue, 8 Jun 2021 09:24:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Export tracing_start() and tracing_stop()
Message-ID: <20210608092431.2cad44e0@oasis.local.home>
In-Reply-To: <20210608125927.GA4095@axis.com>
References: <20210602080118.21627-1-vincent.whitchurch@axis.com>
        <YL3X7yRr1+yW/PHU@infradead.org>
        <20210607091432.667ff0ba@oasis.local.home>
        <20210608125927.GA4095@axis.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 14:59:27 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> Right, thanks, that's certainly much simpler.  I'd only used
> tracing_stop() before and never noticed that tracing_on can't be used to
> restart tracing, probably because the kind of problems I used it for
> usually resulted in the system needing a restart anyway to be usable.

You must have been using this from the beginning, because
tracing_stop() was first, but people complained that it was slow and
you couldn't turn it back on. Thus "tracing_off()" was added, and
documented as the "thing to use" (if you looked at the comments around
them). But that was years (decade?) ago.

-- Steve
