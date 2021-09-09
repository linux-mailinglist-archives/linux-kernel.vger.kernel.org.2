Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31B5405771
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376828AbhIINe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355472AbhIIN1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:27:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7CCA611AF;
        Thu,  9 Sep 2021 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631193990;
        bh=a3bT7GSmxcw16oXsYXwr/n43BCxD7t2q1mwywi1x61w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BVyYvQgRY6/luw8KIAOpkDML+MaMvuxM4s1K7Ya468SHgB8hsscveChC+zmTn5Ko4
         ajHr17nViuQe4am4kgU5cRdTuVqOMzYX6VvS8eM3obfnBeHnfOfgsEkNJpsif42j3s
         L6ckyHrNVQ3g++ZmZ5KiLsi5fw7Si8WOLN5OGwcw0s7aIxdn0HAV4Zb70y/46z/7N8
         DfnHgh7Jjt0PMjsZXHZZX605wInocMYAJ/pHqRxjNOLna6QkZ6lZRM07RaUlOItJPW
         thbJ2q8WObYfCHYHjAlgTu1Zoy2Mpbh3L00yfIuf1LZ1V87iEtNOeo1n2vWVzVbduP
         QsrAMi33ZMzkA==
Date:   Thu, 9 Sep 2021 22:26:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tracing/boot: bootconfig: Fixes and API name change
Message-Id: <20210909222628.7bd301e0179b9dd4b1c9170f@kernel.org>
In-Reply-To: <20210909091123.29f17a6f@gandalf.local.home>
References: <163119172318.151131.7138254940364392100.stgit@devnote2>
        <20210909091123.29f17a6f@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2021 09:11:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  9 Sep 2021 21:48:43 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here is a series of patches to fix some issues on boot-time tracing
> > and bootconfig. Yesterday I sent a bugfix(*), and today I found some
> > other issues.
> > 
> > (*) https://lore.kernel.org/all/163112988361.74896.2267026262061819145.stgit@devnote2/T/#u
> > 
> > This includes following patches.
> > 
> > [1/3] tracing/boot: Fix trace_boot_hist_add_array() to check array is value
> > 
> > [2/3] tracing/boot: Fix to check the histogram control param is a leaf node
> > 
> > [3/3] bootconfig: Rename xbc_node_find_child() to xbc_node_find_subkey()
> >  - Rename xbc_node_find_child() to xbc_node_find_subkey() to avoid
> >    confusing "child" and "subkey" words.
> > 
> 
> Masami,
> 
> Did this go out correctly?
> 
> I only received this email, and this email is not showing up on LKML.
> 
>  (https://lore.kernel.org/r/163119172318.151131.7138254940364392100.stgit%40devnote2
>  gives "Not found")

Oops, please ignore this. Maybe something went wrong. 
Hmm, OK, let me resend it with [RESEND] tag.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
