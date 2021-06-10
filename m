Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411FC3A2E85
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhFJOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhFJOs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:48:56 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 675CF613DE;
        Thu, 10 Jun 2021 14:46:59 +0000 (UTC)
Date:   Thu, 10 Jun 2021 10:46:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] tracing: Fixes for 5.13
Message-ID: <20210610104657.2ccc2ee3@oasis.local.home>
In-Reply-To: <20210609204317.48df7807@rorschach.local.home>
References: <20210609204317.48df7807@rorschach.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 20:43:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> Peter Zijlstra (1):
>       recordmcount: Correct st_shndx handling
>

Please don't pull this one. It appears that this patch breaks the PPC build.

I'll send a new pull request without this patch added. It was the last
one in the series, so I don't need to retest anything.

-- Steve
 
