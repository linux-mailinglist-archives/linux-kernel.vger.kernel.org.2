Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C845AB32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 19:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhKWSYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:24:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232326AbhKWSYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:24:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A901D60F9D;
        Tue, 23 Nov 2021 18:20:56 +0000 (UTC)
Date:   Tue, 23 Nov 2021 13:20:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: Patch "tracing: Add length protection to histogram string
 copies" has been added to the 5.4-stable tree
Message-ID: <20211123132055.56997d60@gandalf.local.home>
In-Reply-To: <YZ0t7neMJJVrVBE/@kroah.com>
References: <20211121231943.88009-1-sashal@kernel.org>
        <YZzaazoMzw8eANyR@kroah.com>
        <20211123113304.19da789b@gandalf.local.home>
        <YZ0t7neMJJVrVBE/@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 19:07:42 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> This doesn't apply for me, probably because other patches have been
> added to this queue already in this area.  Specifically 63f84ae6b82b
> ("tracing/histogram: Do not copy the fixed-size char array field over
> the field size") has been backported, so maybe wait another 5.4 release
> cycle to submit this if you don't want to try to mess with the current
> queue?

OK, I'll wait for the next release.

Thanks!

-- Steve
