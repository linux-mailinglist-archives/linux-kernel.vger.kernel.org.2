Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346504031F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343958AbhIHAqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhIHAqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:46:11 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D0C61130;
        Wed,  8 Sep 2021 00:45:04 +0000 (UTC)
Date:   Tue, 7 Sep 2021 20:45:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] tools/bootconfig: Fix a compilation issue with
 missing variable
Message-ID: <20210907204502.26f0e833@rorschach.local.home>
In-Reply-To: <20210908094145.babedcd252d8e8caf0e2f2ad@kernel.org>
References: <20210907230710.1189193-1-punitagrawal@gmail.com>
        <20210907202400.330f4ea4@rorschach.local.home>
        <20210908094145.babedcd252d8e8caf0e2f2ad@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 09:41:45 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> I've investigated that why this happens here.
> 
> https://lore.kernel.org/all/20210831033256.5973-1-jcfaracco@gmail.com/T/#m52f43f6deb874ee726b10ce25ba53e44697a275a
> 
> This seems a timing issue. I acked a "simplify" patch April, and
> the I wrongly worked on the linus tree for "mixing a value and subkeys"
> and send it to you June. At last, those 2 conflicted on your branch and
> your merge script might just merge it.
> Actually, what Punit and Julio did is reverting 
> 
> commit 30d103f2d460 ("tools/bootconfig: Simplify expression")

Yep, I came up with the same conclusion ;-)

-- Steve
