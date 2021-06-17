Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF813AA896
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 03:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFQB3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 21:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231949AbhFQB3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:29:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11041613CA;
        Thu, 17 Jun 2021 01:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623893228;
        bh=rHKWNQDQu2J1nzwHtrliXgn7o+q5DK5x84X97JBvbRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OR1Ihg2uqasIds/vUXH/LVYADFXlZKziIVg10/YL8oko7nQpRW0/OWgf99xB/zKCY
         8VYEB8GXH+fE/YEX4cQzj8uBE/hQw9f+x9Y+a1Xxnbd5JxKdWRwsRkxNbFx7IYMC7M
         v2wrfVyT19MdWpWSqnsjnvPmebSAtNT+FjAOUIiOJ/8PFqXwDs42bs0jRngIXrn4Zl
         nYWlPRtkdSoTAoDxarDJFoOoPAqSdQ0n9s9DpWXQzH52jH2aRudf+YWrXsNNybYEmc
         MwUWzq7ZV3Mkpih4wyJnAeQVHwFgKugEv7vHZKPRxEJg7NK44NTiC0Hzw96S4Fk1tx
         tMx857e2pH6XQ==
Date:   Thu, 17 Jun 2021 10:27:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Devin Moore <devinmoore@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/6] bootconfig: Add mixed subkeys and value under
 the same key
Message-Id: <20210617102706.a0317c13edc786ec490a2167@kernel.org>
In-Reply-To: <20210616151701.0c9c6059@gandalf.local.home>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
        <CAOELnJzW4boH=WadqW31hbWLhmZgNLD9+EiN0GJGBe1RCMxFaw@mail.gmail.com>
        <20210610234809.9d1e92cb3f04842e14c3d011@kernel.org>
        <20210610122607.3817da31@oasis.local.home>
        <20210610123852.606aa3a4@oasis.local.home>
        <20210611085635.f1655f08b7d8abc009776b6b@kernel.org>
        <20210616151701.0c9c6059@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 15:17:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 11 Jun 2021 08:56:35 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > kernel {
> >       trace_options = sym-addr
> >       trace_events = "initcall:*"
> > #      tp_printk
> >       trace_buf_size = 1M
> >       ftrace = function
> >       ftrace_filter = "vfs*"
> > }
> 
> I'm creating a ktest test for boot up on bootconfigs and writing a verifier
> for each of the configs you sent me. On the first config I looked at
> "boottrace.bconf", I found a bug.
> 
> The above should be:
> 
> 	trace_event = "initcall:*"
> 
> and not "trace_events" as "trace_events" is not a boot option ;-)

Oops, thanks!

BTW, I'm thinking to introduce more basic tests for kernel cmdlie.
For example, checking the kernel.* and init.* are merged correctly
in the /proc/cmdline.

But yes, this needs to use ktest because it sets the bootconfig
to initrd and reboots with it for testing.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
