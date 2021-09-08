Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955BA4031D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhIHA2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 20:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhIHA2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 20:28:35 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6300D610F8;
        Wed,  8 Sep 2021 00:27:27 +0000 (UTC)
Date:   Tue, 7 Sep 2021 20:27:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] tools/bootconfig: Fix a compilation issue with
 missing variable
Message-ID: <20210907202723.59e68c59@rorschach.local.home>
In-Reply-To: <20210908091346.65e6c4c58bc31676e942ccb2@kernel.org>
References: <20210907230710.1189193-1-punitagrawal@gmail.com>
        <20210908091346.65e6c4c58bc31676e942ccb2@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 09:13:46 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Punit,
> 
> This has been fixed by Julio's patch and we are waiting for merge.
> 
> https://lore.kernel.org/all/20210831033256.5973-1-jcfaracco@gmail.com/T/#u
> 

And I need to catch up on my patchwork inbox.

I'll put this in priority now.

-- Steve
