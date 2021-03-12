Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F7A33836B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 03:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhCLCKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 21:10:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhCLCKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:10:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3915E64F8E;
        Fri, 12 Mar 2021 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615515031;
        bh=V6ZvNj6XSpZOBUQwzNl682EpcR1ckvZ0dJOHQLZ733o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mn2vuTqNkYscib3zkR+kFZRTGWtIbdxq/UYJzcELt9fwIrN4sF24yE6seUsJciHa3
         FkR6svu8RuW4EzcXc1aGXcIAMBN8hQEVES0ABflxiwi1P2ZsbgwVs1DKfTnOedj6TK
         iRdeducYSFn0JFkvahT6PCGsvUzbSoQS78mjSNz1C8gaeAeGQebOejcg6vSA1WsRMp
         0DmiK+/SFzVEMU/GEI16FRullIlktEew4v19fiX7ohjmgJKhMTwihQpsQbcieie4mP
         oYuDTKXZruL9/sL2nsYCHkvL2j2nTejvMe1fMkm35Kt98+T+RtonKW7y3IMP/i0AH9
         AC+SyLzflYN8A==
Date:   Fri, 12 Mar 2021 11:10:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Cao jin <jojing64@gmail.com>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, vbabka@suse.cz
Subject: Re: [PATCH] bootconfig: Update prototype of setup_boot_config()
Message-Id: <20210312111026.a29a97de021aee0ff279850c@kernel.org>
In-Reply-To: <20210311090321.2c749b76@gandalf.local.home>
References: <20210311085213.27680-1-jojing64@gmail.com>
        <20210311090321.2c749b76@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 09:03:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 11 Mar 2021 16:52:13 +0800
> Cao jin <jojing64@gmail.com> wrote:
> 
> > Parameter "cmdline" has no use, drop it.
> 
> Actually, I wonder if it should be using that instead of boot_command_line,
> as the cmdline passed in is boot_command_line plus anything that the
> architecture itself modified.
> 
> Masami?

I think the policy is that boot_command_line is the reference command line 
string passed from user, and the passed cmdline is modified by architecutre code.
But those are usually same in most cases, because boot_command_line was also
modified in setup_arch().

For example, x86 setup_arch() overwrites/modifies boot_command_line itself
by builtin_cmdline, and copy boot_command_line into the passed cmdline.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
