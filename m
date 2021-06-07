Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4839E6E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhFGSx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:53:59 -0400
Received: from namei.org ([65.99.196.166]:35242 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhFGSx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:53:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 92D6C527;
        Mon,  7 Jun 2021 18:46:38 +0000 (UTC)
Date:   Tue, 8 Jun 2021 04:46:38 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Sasha Levin <sashal@kernel.org>
cc:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, James.Morris@microsoft.com,
        mikelley@microsoft.com
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
In-Reply-To: <YL1UucKH0GfXddZo@sashalap>
Message-ID: <eaf8e14-12d6-6e3a-f5e5-8b504647eb48@namei.org>
References: <YLx/iA8xeRzwhXJn@zn.tnic> <CAHk-=wjXKsJVk+LPiOSiBACchPJLne7O+U+jmvw8CaLBYn-3=Q@mail.gmail.com> <YL029aQZb09G3ShY@linux.ibm.com> <CAHk-=wg7+-Q-jvrwQmyZtQ3pirAUcAQmvUpiLu=0nJv8NObntg@mail.gmail.com> <YL1HLdmh55uGAIs/@zn.tnic>
 <YL1UucKH0GfXddZo@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2021, Sasha Levin wrote:

> >
> >Let's see if Sasha can dig out something... CCed.
> >
> >@Sasha, can you figure out who we can talk to whether Windoze reserves
> >the first megabyte of memory unconditionally?
> 
> That's a great question, but I can't help there anymore :)
> 
> Adding James Morris...

Adding Michael Kelley.


-- 
James Morris
<jmorris@namei.org>

