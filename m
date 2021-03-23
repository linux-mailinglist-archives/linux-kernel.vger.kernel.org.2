Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9334673B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhCWSIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhCWSIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:08:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1CF3619B8;
        Tue, 23 Mar 2021 18:08:09 +0000 (UTC)
Date:   Tue, 23 Mar 2021 14:08:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] tracing: Fix various typos in comments
Message-ID: <20210323140808.4ef6a86c@gandalf.local.home>
In-Reply-To: <20210323174935.GA4176821@gmail.com>
References: <20210323174935.GA4176821@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 18:49:35 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> Fix ~59 single-word typos in the tracing code comments, and fix
> the grammar in a handful of places.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/r/20210322224546.GA1981273@gmail.com
> ---

Applied, thanks Ingo!

-- Steve
