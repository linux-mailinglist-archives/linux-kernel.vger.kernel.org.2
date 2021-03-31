Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8183508E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhCaVJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhCaVJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:09:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5981C61056;
        Wed, 31 Mar 2021 21:09:02 +0000 (UTC)
Date:   Wed, 31 Mar 2021 17:09:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org
Subject: Re: User stacktrace garbage when USER_STACKTRACE_SUPPORT is not
 enabled
Message-ID: <20210331170900.5f41bcd7@gandalf.local.home>
In-Reply-To: <your-ad-here.call-01617223875-ext-7005@work.hours>
References: <your-ad-here.call-01617191565-ext-9692@work.hours>
        <20210331103749.01a7c283@gandalf.local.home>
        <your-ad-here.call-01617223875-ext-7005@work.hours>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 22:51:15 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> It does! Thanks for the explanation and for the fix. I wonder why nobody
> noticed and complained about that since v5.6.

Because it didn't lose data, just added extra junk.

> 
> Acked-by: Vasily Gorbik <gor@linux.ibm.com>

Want to give a "tested-by" too?

-- Steve
