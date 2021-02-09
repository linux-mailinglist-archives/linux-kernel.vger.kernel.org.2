Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CAE31558F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 19:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhBISBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 13:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbhBIRpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:45:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18C564DB3;
        Tue,  9 Feb 2021 17:45:09 +0000 (UTC)
Date:   Tue, 9 Feb 2021 12:45:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Cheng Jian <cj.chengjian@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Warn if the kprobe is reregistered
Message-ID: <20210209124508.73609489@gandalf.local.home>
In-Reply-To: <161236436734.194052.4058506306336814476.stgit@devnote2>
References: <161236436734.194052.4058506306336814476.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Feb 2021 23:59:27 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Warn if the kprobe is reregistered, since there must be
> a software bug (actively used resource must not be re-registered)
> and caller must be fixed.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---

Applied. Thanks Masami!

-- Steve
