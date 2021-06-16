Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97273AA617
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhFPVX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 17:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233909AbhFPVXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:23:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C7C610A1;
        Wed, 16 Jun 2021 21:21:48 +0000 (UTC)
Date:   Wed, 16 Jun 2021 17:21:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Devin Moore <devinmoore@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/6] bootconfig: Add mixed subkeys and value under
 the same key
Message-ID: <20210616172147.168c5390@gandalf.local.home>
In-Reply-To: <20210611085635.f1655f08b7d8abc009776b6b@kernel.org>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
        <CAOELnJzW4boH=WadqW31hbWLhmZgNLD9+EiN0GJGBe1RCMxFaw@mail.gmail.com>
        <20210610234809.9d1e92cb3f04842e14c3d011@kernel.org>
        <20210610122607.3817da31@oasis.local.home>
        <20210610123852.606aa3a4@oasis.local.home>
        <20210611085635.f1655f08b7d8abc009776b6b@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 08:56:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Do you have a set of bootconfig scripts I could use to load and boot
> > the kernel and make sure that they did what they intended to do?  
> 
> Yes, I have some example scripts. But maybe smaller example will be
> better for test?
> Let me break those example so that you can easily test that.

Do these scripts need updates? Because I was able to get two of them
working (boottrace.bconf and functiongraph.bconf sorta) but two seem to
require more features from the kernel (ftrace.bconf and tracing.bconf).

Anyway, I'll finish up the ktest script and post something soon.

-- Steve
