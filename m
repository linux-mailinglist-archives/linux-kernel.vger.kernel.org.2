Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA863E2F53
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbhHFScX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhHFScW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:32:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3214A611C3;
        Fri,  6 Aug 2021 18:32:05 +0000 (UTC)
Date:   Fri, 6 Aug 2021 14:32:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 5/9] tracing/boot: Show correct histogram error
 command
Message-ID: <20210806143202.1b608894@oasis.local.home>
In-Reply-To: <20210806230043.cc3700ca5518651c3efe5748@kernel.org>
References: <162818075888.226227.14156763636028793396.stgit@devnote2>
        <202108061028.Wme82Hlq-lkp@intel.com>
        <20210806230043.cc3700ca5518651c3efe5748@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2021 23:00:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> This seems that the base tree is not correct. I worked on Steve's 
> linux-trace tree for this series, including 
> 
> commit e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
> 
> which introduced "xbc_node_for_each_subkey()" macro.

Thanks for confirming. I figured as much.

I'll be pushing more 5.15 changes once my final 5.14 fixes land in
Linus's tree, and I can rebase on top of rc5.

-- Steve
