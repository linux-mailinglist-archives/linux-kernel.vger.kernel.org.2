Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237DB43CBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbhJ0OV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242470AbhJ0OVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:21:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9972960D42;
        Wed, 27 Oct 2021 14:19:10 +0000 (UTC)
Date:   Wed, 27 Oct 2021 10:19:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Fix to initialize 'ret' local variable
Message-ID: <20211027101909.7dde903e@gandalf.local.home>
In-Reply-To: <20211027231646.cf5333aa08f70fe7f167e4d5@kernel.org>
References: <163534286875.793799.13298849524607405594.stgit@devnote2>
        <20211027100126.58769bf9@gandalf.local.home>
        <20211027231646.cf5333aa08f70fe7f167e4d5@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 23:16:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > 
> > I'm fine taking yours instead. But I'd like to update the text explaining
> > how the ret can be uninitialized and what happens if we set it to zero.  
> 
> Yeah, I'm also good for both, but the Fixes tag must be updated.

OK, I'll take mine then and update the fixes tag. Care to reply with a
Reviewed-by tag?

Thanks,

-- Steve

