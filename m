Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D833374E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhCKODh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:03:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233725AbhCKODY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:03:24 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F343164FAD;
        Thu, 11 Mar 2021 14:03:22 +0000 (UTC)
Date:   Thu, 11 Mar 2021 09:03:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cao jin <jojing64@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org, vbabka@suse.cz
Subject: Re: [PATCH] bootconfig: Update prototype of setup_boot_config()
Message-ID: <20210311090321.2c749b76@gandalf.local.home>
In-Reply-To: <20210311085213.27680-1-jojing64@gmail.com>
References: <20210311085213.27680-1-jojing64@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 16:52:13 +0800
Cao jin <jojing64@gmail.com> wrote:

> Parameter "cmdline" has no use, drop it.

Actually, I wonder if it should be using that instead of boot_command_line,
as the cmdline passed in is boot_command_line plus anything that the
architecture itself modified.

Masami?

-- Steve
