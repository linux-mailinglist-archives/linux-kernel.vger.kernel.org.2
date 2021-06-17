Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168033AA8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 03:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbhFQBdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 21:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231942AbhFQBdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:33:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F3FA613DE;
        Thu, 17 Jun 2021 01:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623893469;
        bh=4bZkR1INf9ybbz9fXnKXchjnFUHlk3G7Ir2Bgtu3/bM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D8oco6CfXMtSMEWVuS8wpYP6Se/bhI6L2/cIlkWJZn1tSkHMmK7fc8JxDqSbD2PKl
         c1sAyXEPz96eNGlvUpxapVgrM6ikuCAFzq0Vdo2punf6BXV+J6jN0Xago1Xd9/fihU
         atwFNnFtjU2/cU0nQhrYuiw06HdQCC1mtp9q0oWZ8M6XDsTNvBWjfZEOcGlX1xI807
         pNh33EBibEMv3gkAyWhIa57QXymLNx+QM67/Gxm0Wyo4ARWjM7BYcNORKM2uRIUdH6
         UYvqubjgPO6bUBpFkgODJ6DyW9JdPuwj7f75LbUiE9zzXgVHQrpo8xWjceuVnCchfK
         OCl9pHrmGZyUg==
Date:   Thu, 17 Jun 2021 10:31:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Devin Moore <devinmoore@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/6] bootconfig: Add mixed subkeys and value under
 the same key
Message-Id: <20210617103107.56842df65e5b9737bb6d11af@kernel.org>
In-Reply-To: <20210616172147.168c5390@gandalf.local.home>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
        <CAOELnJzW4boH=WadqW31hbWLhmZgNLD9+EiN0GJGBe1RCMxFaw@mail.gmail.com>
        <20210610234809.9d1e92cb3f04842e14c3d011@kernel.org>
        <20210610122607.3817da31@oasis.local.home>
        <20210610123852.606aa3a4@oasis.local.home>
        <20210611085635.f1655f08b7d8abc009776b6b@kernel.org>
        <20210616172147.168c5390@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 17:21:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 11 Jun 2021 08:56:35 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > Do you have a set of bootconfig scripts I could use to load and boot
> > > the kernel and make sure that they did what they intended to do?  
> > 
> > Yes, I have some example scripts. But maybe smaller example will be
> > better for test?
> > Let me break those example so that you can easily test that.
> 
> Do these scripts need updates? Because I was able to get two of them
> working (boottrace.bconf and functiongraph.bconf sorta) but two seem to
> require more features from the kernel (ftrace.bconf and tracing.bconf).

Oops again. Yes those include some extended (experimental) syntax.
please ignore it until I updated boot-time tracing.

> 
> Anyway, I'll finish up the ktest script and post something soon.

Thank you!

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
