Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2A4588AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 06:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhKVFIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 00:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKVFIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 00:08:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58A08608FB;
        Mon, 22 Nov 2021 05:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637557542;
        bh=It9uNrF9t0SJYZGl0l2SZiSXS8XCeYrR6BZoXqfBGSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FwvdO2SlqZJVa9w3DF2Fg4i0OFOFzqebEr1lycBrHOnyIqA2Yck7PwOQAUjXpYcgY
         CzFy5Xp8UOpxZr6CkzRKekm5eUNaQImbdLGRsrUaijxCIdwNLbUV1m5KGAjVENX9Wr
         9kkDzvZYZ1TVqeZKwliOFZEpz7Hh4yHxQ2NQCHaOxFt+ISXT3yzopV6kFwvyKX8MpB
         IiVfGC2N4s2h8SH3Ixe32gje8mgCkEp/npsN1Akbd/0xd2LJB4264BJNDws43qcYMB
         xfZxFQ4pxCRiW3UBPvUa7Ifb3C1VFm/TPRgLBGacAM8WepLMVNJzyY4n9MeyOaZUrW
         QE2x8z1rLYBqw==
Date:   Mon, 22 Nov 2021 14:05:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 4/5] libtraceevent: Add __rel_loc relative location
 attribute support
Message-Id: <20211122140538.a981ac0bdaa1b375f9545433@kernel.org>
In-Reply-To: <20211116172332.655bae77@gandalf.local.home>
References: <163697159970.131454.2661507704362599471.stgit@devnote2>
        <163697163637.131454.1385316505107139633.stgit@devnote2>
        <20211116172332.655bae77@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 16 Nov 2021 17:23:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 15 Nov 2021 19:20:36 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add '__rel_loc' new dynamic data location attribute which encodes
> > the data location from the next to the field itself. This is similar
> > to the '__data_loc' but the location offset is not from the event
> > entry but from the next of the field.
> > 
> > This patch adds '__rel_loc' decoding support in the libtraceevent.
> 
> Note, libtraceevent in the kernel is deprecated.

Without this patch, perf build is failed even if I installed

> 
> Care to send a patch against:
> 
>   https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/

this libtraceevent.

So it seems that the in-kernel libtraceevent source and header are
still in use.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
