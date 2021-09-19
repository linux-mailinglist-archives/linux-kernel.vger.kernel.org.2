Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8533C410C56
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 18:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhISQNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 12:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhISQNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 12:13:04 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2334610A8;
        Sun, 19 Sep 2021 16:11:38 +0000 (UTC)
Date:   Sun, 19 Sep 2021 12:11:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Carles Pey <carles.pey@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] ftrace: add unit test for removing trace
 function
Message-ID: <20210919121137.33d687b8@rorschach.local.home>
In-Reply-To: <20210918153043.318016-1-carles.pey@gmail.com>
References: <20210918153043.318016-1-carles.pey@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 19:30:42 +0400
Carles Pey <carles.pey@gmail.com> wrote:

> Hi,
> 
> This patch adds a basic startup self-test for removing a traced
> function.

Thanks for the patch, but note, because I'm highly involved in the
organization of Linux Plumbers that is taking place next week, I may
not have time to look at it for a couple of weeks.

-- Steve
