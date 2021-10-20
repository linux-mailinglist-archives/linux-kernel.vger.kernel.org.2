Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1943536D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhJTTJb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Oct 2021 15:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhJTTJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:09:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC3A2610D0;
        Wed, 20 Oct 2021 19:07:14 +0000 (UTC)
Date:   Wed, 20 Oct 2021 15:07:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Huan Xie <xiehuan09@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Add trace any kernel object
Message-ID: <20211020150713.21363402@gandalf.local.home>
In-Reply-To: <CAEr6+EDf1hcm2SawO07+69KnBrODmiM05AqeeBwN+4wuyME=6w@mail.gmail.com>
References: <20211014014445.5734-1-xiehuan09@gmail.com>
        <20211013222056.312bec0c@oasis.local.home>
        <20211015220832.f9a13bd4ebbc4881b1e68163@kernel.org>
        <CAEr6+EDf1hcm2SawO07+69KnBrODmiM05AqeeBwN+4wuyME=6w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 00:04:40 +0800
Huan Xie <xiehuan09@gmail.com> wrote:

> Thanks. The trigger seems to work in combination with kprobe/uprobe/eprobe.
> 
> I have been trying to implement this feature in recent days, But my
> code does not look very elegant at the moment :-)

Feel free to post what you have. I swear I wont judge you based on your code
;-)

Just add "[RFC]" to the subject of your patches, to let us know it's not
for inclusion.

> 
> It seems the result of 'cat  trace' should also need to be filtered,
> Because it will output the functions we don’t want to care about.

We can work to make it attached to "set_ftrace_pid" and "set_ftrace_filter"
and friends, so that it can easily be filtered.

> 
> I didn't expect this idea to be a relatively large project. :-)

Kernel updates never are what you expect them to be come ;-)

-- Steve
