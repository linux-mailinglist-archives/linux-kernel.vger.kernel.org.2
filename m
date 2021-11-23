Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528C645A234
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhKWMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:10:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236031AbhKWMKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:10:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEAEE61002;
        Tue, 23 Nov 2021 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637669242;
        bh=YTmYyIIpXkeZWWGAVllylKecB/+EQhhfNcfw77Pr1l8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fZ7xu4dFGOgIdkee+vukNk50UdfsqgKj3ovFF1kF2qBND++A8fdotJiRkHLt1bu9v
         VoGGdZzcY3As6qVJryMe0G2gnfUaMG/SxAL0ZOV4pAtfrWplEiLaT4b5gqRMQaUXfx
         oGqJSmHe9t2g6mbMaC7vdaVgly60TPlKmD8wAmd3M8aDt24+BCttzA8rONEH9+fGa9
         neQQaLzoFXiVwA5LqoZcjOak6RsB92C43d+4v7gJKZ4XeyS7wtuQvwhO60K0BVnWht
         bRN+YFeqThq4RGKLzOvKsOuEDCUYDszj/38fJbTyWUkvOeVnOqPYMQ918IIXpVcMys
         VyAuNJ3pmFrKg==
Date:   Tue, 23 Nov 2021 21:07:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 4/5] libtraceevent: Add __rel_loc relative location
 attribute support
Message-Id: <20211123210718.73b83f64d6e50a038731cbe6@kernel.org>
In-Reply-To: <20211122112520.5de93c47@gandalf.local.home>
References: <163697159970.131454.2661507704362599471.stgit@devnote2>
        <163697163637.131454.1385316505107139633.stgit@devnote2>
        <20211116172332.655bae77@gandalf.local.home>
        <20211122140538.a981ac0bdaa1b375f9545433@kernel.org>
        <20211122112520.5de93c47@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 11:25:20 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 22 Nov 2021 14:05:38 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > So it seems that the in-kernel libtraceevent source and header are
> > still in use.
> 
> I believe it's still used if it's not found in the system.
> 
> I'll include this patch to the code as well.

Thanks! I sent v2 which fixes some bugs and covers bitmask too.
So please pick v2 up.

Thank you,

> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
