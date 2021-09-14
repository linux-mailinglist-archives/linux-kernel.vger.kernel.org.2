Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4BA40B460
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhINQT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhINQTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:19:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DD260F70;
        Tue, 14 Sep 2021 16:18:37 +0000 (UTC)
Date:   Tue, 14 Sep 2021 12:18:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-linus][PATCH 1/2] bootconfig: Fix to check the xbc_node is
 used before free it
Message-ID: <20210914121830.5714f8b9@oasis.local.home>
In-Reply-To: <e5c7ce5b-93f0-b305-de32-c99d0390eb28@suse.cz>
References: <20210914144809.297030763@goodmis.org>
        <20210914145033.337080566@goodmis.org>
        <e5c7ce5b-93f0-b305-de32-c99d0390eb28@suse.cz>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 18:11:01 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> Should have replied here.
> 
> Tested-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, but I already sent a pull request to Linus.

Too late to add the tag. :-/


-- Steve
