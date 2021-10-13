Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159F042CF02
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhJMXPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhJMXPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:15:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C0E860C4D;
        Wed, 13 Oct 2021 23:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634166781;
        bh=ff/h9KDJlUBI6feY+QII5BtvbX/wkx8OS2q5HtuB0oY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2hcz8RgKEaU2Ilmff0+KI4DGBARFO3FxpK9sn4jtertw3hPf7ewCKH54jH8HmZj7F
         HO30FO9+MYZw1x07lR3DmOklSDfsaQB2LW3guADGVbAew503XD+CzyLqsSWLBYxLcD
         i7+q/lV0eR6nw95p3R5SnZML8NZSSujz3CPHCdwE=
Date:   Wed, 13 Oct 2021 16:12:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     rostedt@goodmis.org, bp@suse.de, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Make unknown command line param message clearer
Message-Id: <20211013161259.39e88182200b7a582c0cf632@linux-foundation.org>
In-Reply-To: <20211013223502.96756-1-ahalaney@redhat.com>
References: <20211013223502.96756-1-ahalaney@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 17:35:02 -0500 Andrew Halaney <ahalaney@redhat.com> wrote:

> The prior message is confusing users, which is the exact opposite of the
> goal. If the message is being seen, one of the following situations is
> happening:
> 
>  1. the param is misspelled
>  2. the param is not valid due to the kernel configuration
>  3. the param is intended for init but isn't after the '--'
>     delineator on the command line
> 
> To make that more clear to the user, explicitly mention "kernel command
> line" and also note that the params are still passed to user space to
> avoid causing any alarm over params intended for init.
> 
> Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Thanks.

BTW, I'm still sitting on your "init/main.c: silence some
-Wunused-parameter warnings", awaiting a response to Rasmus's
suggestion:
https://lkml.kernel.org/r/f06b8308-645b-031b-f9c6-b92400a269aa@rasmusvillemoes.dk
