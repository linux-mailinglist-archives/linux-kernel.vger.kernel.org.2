Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506A3422BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhJEPCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234964AbhJEPCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:02:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2D861381;
        Tue,  5 Oct 2021 15:00:11 +0000 (UTC)
Date:   Tue, 5 Oct 2021 11:00:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>
Subject: Re: [for-linus][PATCH 00/27] tracing: Updates for 5.16
Message-ID: <20211005110009.3baac4cf@gandalf.local.home>
In-Reply-To: <20211005135733.485175654@goodmis.org>
References: <20211005135733.485175654@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Oct 2021 09:57:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> for-next
> 
> Head SHA1: bf094cffea2a6503ce84062f9f0243bef77c58f9
> 
> 

I just realized I used the wrong subject tag. This was suppose to be
"[for-next]" not "[for-linus]".

-- Steve
