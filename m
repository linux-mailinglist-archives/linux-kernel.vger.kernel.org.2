Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA153315D13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhBJCRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234142AbhBJBVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:21:52 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F000464E05;
        Wed, 10 Feb 2021 01:21:10 +0000 (UTC)
Date:   Tue, 9 Feb 2021 20:21:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] tracing: More synthetic event error fixes
Message-ID: <20210209202108.14fdb0dd@oasis.local.home>
In-Reply-To: <c9ca97ed663c2f04d45734883f17833a6c6a6ff5.camel@kernel.org>
References: <cover.1612208610.git.zanussi@kernel.org>
        <20210209160909.28cc8d3b@gandalf.local.home>
        <c9ca97ed663c2f04d45734883f17833a6c6a6ff5.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Feb 2021 16:58:12 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Did you apply '[PATCH v7 5/6] selftests/ftrace: Update synthetic event
> syntax errors' before you ran the test?  It actually removes the test
> that failed.  Here's what I get with all patches applied:

I thought I did, but I forgot that I applied your patches to a staging
branch, and not the one I checked out on the test machine.

Just checkout out the correct branch and reran the tests. They all
work. Sorry for the noise ;-)

-- Steve
