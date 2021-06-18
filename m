Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339293AD049
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhFRQZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231898AbhFRQZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:25:32 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F41FC61175;
        Fri, 18 Jun 2021 16:23:22 +0000 (UTC)
Date:   Fri, 18 Jun 2021 12:23:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] bootconfig/tracing/ktest: Add ktest examples of testing
 bootconfig
Message-ID: <20210618122321.663dee8a@oasis.local.home>
In-Reply-To: <20210619011305.c5a3061c44b860c9038a26bf@kernel.org>
References: <20210618112647.6a81dec5@oasis.local.home>
        <20210619011305.c5a3061c44b860c9038a26bf@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2021 01:13:05 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> BTW, some bconf file indent are mixing space and tabs. Maybe it was by me.
> Could you fix it when you merge this?

Will do.

Thanks for the reviewed-by.

-- Steve
