Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E243CCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbhJ0O4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237296AbhJ0O4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:56:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CB0B60EFF;
        Wed, 27 Oct 2021 14:53:51 +0000 (UTC)
Date:   Wed, 27 Oct 2021 10:53:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] bootconfig: Initialize ret in xbc_parse_tree()
Message-ID: <20211027105349.56b84ee2@gandalf.local.home>
In-Reply-To: <20211027234908.ea6b045947c0bd99f64d56af@kernel.org>
References: <20211027095512.3da02311@gandalf.local.home>
        <20211027234908.ea6b045947c0bd99f64d56af@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 23:49:08 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Thanks for fixing!
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Thanks!

> 
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 76db5a27a827c ("bootconfig: Add Extra Boot Config support")  
> 
> Please update the Fixes tag (and remove Cc: stable, because below one
> is still on the -next tree)
> 
> Fixes: bdac5c2b243f ("bootconfig: Allocate xbc_data inside xbc_init()")

Will do.

-- Steve

