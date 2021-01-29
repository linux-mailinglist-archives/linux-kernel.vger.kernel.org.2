Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB1308A39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 17:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhA2QaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 11:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhA2QaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 11:30:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F3264E02;
        Fri, 29 Jan 2021 16:29:33 +0000 (UTC)
Date:   Fri, 29 Jan 2021 11:29:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>,
        <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kretprobe: avoid re-registration of the same
 kretprobe earlier
Message-ID: <20210129112932.41e56f4f@gandalf.local.home>
In-Reply-To: <20210129222947.f873666f4e6110c62b7439f1@kernel.org>
References: <20210128124427.2031088-1-bobo.shaobowang@huawei.com>
        <20210128130621.41d99638@gandalf.local.home>
        <20210129222947.f873666f4e6110c62b7439f1@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 22:29:47 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> I'll send a patch over this to replace those check with WARN_ON() since
> it's a software bug and should be fixed.

Please use WARN_ON_ONCE()

Thanks!

-- Steve
