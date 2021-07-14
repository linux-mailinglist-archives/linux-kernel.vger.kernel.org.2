Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77013C93A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbhGNWQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhGNWQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:16:18 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 901CC6101B;
        Wed, 14 Jul 2021 22:13:25 +0000 (UTC)
Date:   Wed, 14 Jul 2021 18:13:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [GIT PULL] tracing: Add __string_len() and __assign_str_len()
 helpers
Message-ID: <20210714181318.735a496b@oasis.local.home>
In-Reply-To: <20210714175633.3b53346a@oasis.local.home>
References: <20210713171143.7784697e@oasis.local.home>
        <CAHk-=wj5Pp5J-CAPck22RSQ13k3cEOVnJHUA-WocAZqCJK1BZw@mail.gmail.com>
        <20210714175633.3b53346a@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 17:56:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> That "(len)+1" adds the extra byte for the '0'. Hence, it is similar to:
> 
> 	dst = kmalloc(len + 1, GFP_KERNEL);
> 	strncpy(dst, src, len);
> 	dst[len] = '\0';
> 
> Where the requirement is that you want to save len bytes of source into
> dst, where len must be at least the size of src.

Sorry, that should have read "len must be at most the size of src".

That is, the caller knows how big src is, and is telling the trace
event that all characters up to "len" exists.

-- Steve
