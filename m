Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891B8386DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbhEQXni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235483AbhEQXnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:43:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8917860FD7;
        Mon, 17 May 2021 23:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621294940;
        bh=aqMfkK7qEIfU5V+cQq42a7rIqTso5yLBwzqvz3YnN9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=amicfxHVxgpl38tNps7BF/ynRUXkGhFrgSV4XMxeTkVODBrFBcJRKL6n09lLuIrS+
         xIw20mOPh8EeBeKuHeVTHHimPewY9bAPCQcldJjBnA0squ5L0iuZDBiEyMFAMT0ANE
         U0Zjhb/pacYrzHeABcZ73s9K8sLpC/InXrS3F/jrxCUBTEVF0lqNzSpcr1DBme2wUD
         PkuWlw20qxGFRcNe4Mk/758lik+MNEivTschfixT1/Xotuh08Ha7Yu3cEVwRZsH1Ro
         AWO49smwGGhxkpUFVSCttBGbfL/DHbWZru1ncovjcelr//APi+THWO3OBbLV3afBAb
         IX0sVDBlu2mvA==
Date:   Tue, 18 May 2021 08:42:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: Re: [PATCH 1/4] bootconfig: Change array value to use child node
Message-Id: <20210518084217.3d27aa5c3d75255ffc5777a3@kernel.org>
In-Reply-To: <20210517112434.570fd87b@gandalf.local.home>
References: <162117692155.9011.16682190750100804269.stgit@devnote2>
        <162117693103.9011.18172892676114426345.stgit@devnote2>
        <20210517112434.570fd87b@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 11:24:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 16 May 2021 23:55:31 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Change array value to use child node of the xbc_node tree
> > instead of next node.
> 
> Hi Masami,
> 
> This says what you did, not why you did it. Can you add a comment about
> what the purpose of this change was?

Ah, yes.
Actually, this is an internal (and intermediate) change.
For co-existing a value with subkeys, the barrier is an array of the value,
because both of subkeys and the array elements are using "next" field of
the xbc_node. Thus this changes the array values to use "child" field in
the array case.

Thank you,

> 
> Thanks!
> 
> -- Steve
> 
> 
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/bootconfig/main.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >


-- 
Masami Hiramatsu <mhiramat@kernel.org>
