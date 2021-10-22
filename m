Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3D74377A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhJVNGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 09:06:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49306 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhJVNGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 09:06:01 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 324655051da6db55; Fri, 22 Oct 2021 15:03:43 +0200
Received: from kreacher.localnet (unknown [213.134.175.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 208BE66A92E;
        Fri, 22 Oct 2021 15:03:41 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Norbert <nbrtt01@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>, frederic@kernel.org
Subject: Re: Performance regression: thread wakeup time (latency) increased up to 3x
Date:   Fri, 22 Oct 2021 15:03:40 +0200
Message-ID: <4674203.GXAFRqVoOG@kreacher>
In-Reply-To: <YW1ZjroFfmKM9HJe@hirez.programming.kicks-ass.net>
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com> <8691a8ec-410d-afe8-f468-eefe698c6751@gmail.com> <YW1ZjroFfmKM9HJe@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.233
X-CLIENT-HOSTNAME: 213.134.175.233
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeljedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetgefgleetgeduheeugeeikeevudelueelvdeufeejfeffgeefjedugfetfeehhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrddujeehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrvdeffedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehnsghrthhttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghho
 sehrvgguhhgrthdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopeihvgihuhhnfhgvnhhgsehhuhgrfigvihdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 18, 2021 1:25:02 PM CEST Peter Zijlstra wrote:
> On Fri, Oct 15, 2021 at 09:08:58PM -0700, Norbert wrote:
> 
> > > > > On Fri, Oct 15, 2021 at 12:43:45AM -0700, Norbert wrote:
> > > > > > Performance regression: thread wakeup time (latency) increased up to 3x.
> > > > > > 
> > > > > > Happened between 5.13.8 and 5.14.0. Still happening at least on 5.14.11.
> 
> > So git-bisect finally identified the following commit.
> > The performance difference came in a single step. Times were consistent with
> > my first post either the slow time or the fast time,
> > as far as I could tell during the bisection.
> > 
> > It is a bit unfortunate that this comes from an attempt to reduce OS noise.
> > 
> > -----------------------------------------------------
> > commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
> > Author: Yunfeng Ye <yeyunfeng@huawei.com>
> > Date:   Thu May 13 01:29:16 2021 +0200
> > 
> >     tick/nohz: Conditionally restart tick on idle exit
> > 
> >     In nohz_full mode, switching from idle to a task will unconditionally
> >     issue a tick restart. If the task is alone in the runqueue or is the
> >     highest priority, the tick will fire once then eventually stop. But that
> >     alone is still undesired noise.
> > 
> >     Therefore, only restart the tick on idle exit when it's strictly
> >     necessary.
> > 
> >     Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> >     Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> >     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> >     Acked-by: Peter Zijlstra <peterz@infradead.org>
> >     Link:
> > https://lore.kernel.org/r/20210512232924.150322-3-frederic@kernel.org
> > -----------------------------------------------------
> > 
> > Is there anything else to do to complete this report?
> 
> So it _could_ be you're seeing increased use of deeper idle states due
> to less noise. I'm forever forgetting what the most friendly tool is for
> checking that (powertop can I think), Rafael?

You can use turbostat too.

> One thing to try is boot with idle=halt and see if that makes a
> different.
> 
> Also, let me Cc all the people involved.. the thread starts:
> 
>   https://lkml.kernel.org/r/035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com
> 




