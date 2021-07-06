Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABE23BDA4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhGFPiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232559AbhGFPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:38:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEA526143B;
        Tue,  6 Jul 2021 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625585724;
        bh=B5ndKLBRnsbGgiAAi6EO4ull1KjiqhstMo32ykPivlM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N9PoSSloHNP5ViPbsp0EplkTGVvw1AWx65iwt8FmmeW+OaZvU0jVwUOfxxEbACuTF
         L8NNtVE04QSPxEXBBuAlCUcV2Kvo4ECWXertrSCdswKPCWLQblq0pXXrBJm29c6H4T
         wIxk430VqGZKn0Xj4rug0XJMHi82MygYK5htLCOx6OT8rOp61LEdh8vCVolUl2oHGH
         g1EK9knalRdAi3FKy57CokIoQMcV6ymSdLCH88Bj9CNcpdnrwYfgh48JQo5QoZMdqt
         MT7WhDJudLtiOhcyWwewnzqjQ59FqTSE5LA2jf/USRmJoGxEwsfEFPhYpus2F5riZH
         argsl3KnlMN7Q==
Message-ID: <f74b047f4f270615e05a97f8f600b929af677018.camel@kernel.org>
Subject: Re: [PATCH] tracing: Add "grouping" to histogram logic
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Date:   Tue, 06 Jul 2021 10:35:22 -0500
In-Reply-To: <20210706112659.74bc2b2a@oasis.local.home>
References: <20210702175648.1172476c@gandalf.local.home>
         <20210703190725.8082fc92c244e26abec0bf8b@kernel.org>
         <20210703082713.3643b4d6@rorschach.local.home>
         <CAM9d7chNNYdg5OPir=1QuyQ0OqdZJ=jbW5iy+6o9kSNuqZ1i_A@mail.gmail.com>
         <20210706112659.74bc2b2a@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-06 at 11:26 -0400, Steven Rostedt wrote:
> On Mon, 5 Jul 2021 13:32:53 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > > Yeah, I just picked '-' but then realized it would conflict with
> > > other
> > > key words.  
> > 
> > Also we already have ".log2" flag for a logarithmic histrogram.
> > Then we might have something like "keys=FIELD.bucket=SIZE"
> > for linear histograms.
> 
> I like the above idea.
> 
> Tom, do you have any issue with this?

No, that makes very clear what it does.

Tom

> 
> -- Steve

