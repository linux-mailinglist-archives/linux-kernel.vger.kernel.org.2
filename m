Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5C43D8373
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhG0WyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232506AbhG0WyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:54:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8722860F90;
        Tue, 27 Jul 2021 22:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627426463;
        bh=FixOnT4n62zd3WCjhcEaUVTcSt68zeKvAj/CsPDOdVM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OwdHcMIazcEPhAYOvmWgnXsgfYMBgos7AHUkMY6nw0KqAHLlpa4CGCBpfupOrN2Vz
         6e2eWbC6F8qY5nZR9LoDqlQCIXphIXBStWY1o/YQjErUqA/lhHUwtvDrvblayfIvsd
         DHDjF7VyhWW/7RQXVZHOWwUGjDF+y+hwQyXZPi4oNE7N8TMAwLnlwq3TETPZPOsG1H
         IVOukfOkGtJ51IxtHDhH3Xa3NxQJMyjntjvFwwZ7Xa+ZpcDDoHJtvcE9XsjLymiwW2
         oNct7Oyhg4dU1JbcXwBfEWknLATXjMRIJtvsQ10hi1yUfxpCfAhrlcbQRZWJS7uJWb
         t07DxwttTgLrw==
Date:   Wed, 28 Jul 2021 07:54:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
Message-Id: <20210728075421.7274872181a6b92ce5bfa037@kernel.org>
In-Reply-To: <20210726092818.7d94027d@oasis.local.home>
References: <20210722142705.992001628@goodmis.org>
        <20210722142837.458596338@goodmis.org>
        <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
        <20210722123234.636d5363@oasis.local.home>
        <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
        <20210722212438.5933e714@rorschach.local.home>
        <20210724193145.c63b44aa843e05ed9c0b4fdc@kernel.org>
        <20210725111830.2f424ae3978443241b6d4a2d@kernel.org>
        <20210725124502.54fa65251b5cd5b76fdf5f19@kernel.org>
        <20210726092818.7d94027d@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 09:28:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 25 Jul 2021 12:45:02 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > And with this change, hist trigger can correctly detect a string type in
> > the operand in the expression and rejects it.
> > 
> > Thank you,
> > 
> > >From 5280d1efe4415a621cf69a1dc4861ab928b0ff1c Mon Sep 17 00:00:00 2001  
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Sun, 25 Jul 2021 12:34:00 +0900
> > Subject: [PATCH] tracing: Reject string operand in the histogram expression
> > 
> > Since the string type can not be the target of the addition / subtraction
> > operation, it must be rejected. Without this fix, the string type silently
> > converted to digits.
> 
> Masami, can you send this as a normal patch. My scripts do not work
> (nor do I plan on having them ever do so) with patches embedded in
> threads or non-patch emails.

OK, let me resend it.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
