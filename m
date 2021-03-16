Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDD333E0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 22:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCPVgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 17:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhCPVfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 17:35:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A25064F79;
        Tue, 16 Mar 2021 21:35:33 +0000 (UTC)
Date:   Tue, 16 Mar 2021 17:35:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH 0/7 v2] tracing: Have ring_buffer_event_time_stamp()
 work for all events
Message-ID: <20210316173530.2407b8da@gandalf.local.home>
In-Reply-To: <bc865f7bb546cdd2c59443ff6f7411e02f313cd7.camel@kernel.org>
References: <20210316164100.546961804@goodmis.org>
        <bc865f7bb546cdd2c59443ff6f7411e02f313cd7.camel@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 16:16:03 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> This all looks fine to me.
> 
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> 

Thanks!

-- Steve
