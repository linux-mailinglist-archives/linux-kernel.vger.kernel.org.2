Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3275F3A3091
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhFJQ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhFJQ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:28:05 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149C460C40;
        Thu, 10 Jun 2021 16:26:08 +0000 (UTC)
Date:   Thu, 10 Jun 2021 12:26:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Devin Moore <devinmoore@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/6] bootconfig: Add mixed subkeys and value under
 the same key
Message-ID: <20210610122607.3817da31@oasis.local.home>
In-Reply-To: <20210610234809.9d1e92cb3f04842e14c3d011@kernel.org>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
        <CAOELnJzW4boH=WadqW31hbWLhmZgNLD9+EiN0GJGBe1RCMxFaw@mail.gmail.com>
        <20210610234809.9d1e92cb3f04842e14c3d011@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 23:48:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve, can you also pick this series? (except [1/6], which you've already merged)

I may have already done so, just haven't pushed it yet. I'm using a
separate branch for bootconfig tools.

I need to set up a test suite that tests them.

I should set up a ktest config file that reads each of the example
bootconfigs, and boots the kernel, and checks that each of them took
affect without doing any other side effects.

I'll work to create a ktest config sample to test them, and send them
out.

-- Steve
