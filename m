Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC9403554
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350060AbhIHH3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349763AbhIHH3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:29:12 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2A9061164;
        Wed,  8 Sep 2021 07:28:04 +0000 (UTC)
Date:   Wed, 8 Sep 2021 03:28:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] bootconfig: Cleanup and reorder the init
 parameter from bootconfig
Message-ID: <20210908032802.3a33ac81@rorschach.local.home>
In-Reply-To: <20210908124618.3aee4435c5c65962c30a09b3@kernel.org>
References: <163077084169.222577.4459698040375322439.stgit@devnote2>
        <20210908124618.3aee4435c5c65962c30a09b3@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 12:46:18 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> BTW, this includes Julio's fix patch we discussed in the other thread.
> If you picked it, please ignore that patch in this series.

Yep, I noticed this, and simply pulled in this series over the other
ones (including Julio's patch).

-- Steve
