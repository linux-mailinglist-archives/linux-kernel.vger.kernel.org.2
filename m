Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393A840330D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 05:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbhIHDra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 23:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230055AbhIHDr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 23:47:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4410D610A3;
        Wed,  8 Sep 2021 03:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631072782;
        bh=zuq6RIw+f0ArU/LWvTeZWMHahyct37xSYgFfH6oM1hs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TSjBB3TiT58Z9+LaBxbAycjmC+ucVeAssLJ2tppqHPSUA06hNnvjKkaThe+7Ypi9Z
         v9y+cmVgW0YfxlLAiuzrQJe4JSvR3e+WIpu69g0v4KuDxIgXy3edf8UKGR8GA5zdM8
         ZUrxjmz5O3jRRiEH8tfUDrwrW56gOZtY1cTGzVNtw3TQ/LCNRhzRBa4hC8DT/zUDkF
         qNBwzGs1mdfC14QEmmA0PpvxKhI2eFn2+xHJKD4C9wYtCk+oUdaYIZ/AXz14EHaWNB
         L9upgScn7hrh+UGMZURbRWBwn0ZvfGA4SAx0seQptLjRQF8FU2vFxDeY2VZSCyl39e
         OJHGYdW3RRY3A==
Date:   Wed, 8 Sep 2021 12:46:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] bootconfig: Cleanup and reorder the init
 parameter from bootconfig
Message-Id: <20210908124618.3aee4435c5c65962c30a09b3@kernel.org>
In-Reply-To: <163077084169.222577.4459698040375322439.stgit@devnote2>
References: <163077084169.222577.4459698040375322439.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Sep 2021 00:54:01 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Here is the 3rd version of the patches to update the bootconfig.
> I added 3 patches to fix some issues. One issue is from Julio which
> fixes a compilation error ([5/6]*). And the other 2 are fixing
> ftrace2bconf script ([4/6]) and cleanup test script ([6/6]).
> 
> * https://lore.kernel.org/all/20210831033256.5973-1-jcfaracco@gmail.com/T/#u
> 
> The 1st one is for bootconfig memory cleanup when exiting init stage.
> The 2nd one and 3rd one are for reordering the init parameters from
> bootconfig.
> Since the current kernel concatenate the kernel cmdline and the
> bootconfig parameters as below.
> 
> [bootconfig kernel params][cmdline] -- [init cmdline][bootconfig init params]
> 
> This is bit odd because for the kernel parameters, user passed cmdline
> can override the previous (bootconfig) one, but for the init cmdline,
> bootconfig may override the parameter.
> Thus, this series invert the order as the following.
> 
> [bootconfig kernel params][cmdline] -- [bootconfig init params][init cmdline]
> 
> The 3rd patch is adding how to use the bootconfig for passing kernel
> and init parameters.
> 
> Thank you,

Hi Steve,

BTW, this includes Julio's fix patch we discussed in the other thread.
If you picked it, please ignore that patch in this series.

Thank you,

> 
> ---
> 
> Julio Faracco (1):
>       bootconfig: Fix missing return check of xbc_node_compose_key function
> 
> Masami Hiramatsu (5):
>       init: bootconfig: Remove all bootconfig data when the init memory is removed
>       init/bootconfig: Reorder init parameter from bootconfig and cmdline
>       docs: bootconfig: Add how to use bootconfig for kernel parameters
>       tools/bootconfig: Fix tracing_on option checking in ftrace2bconf.sh
>       tools/bootconfig: Show whole test command for each test case
> 
> 
>  Documentation/admin-guide/bootconfig.rst |   39 +++++++++++++++++++++++++++++-
>  init/main.c                              |   37 ++++++++++++++++++++--------
>  tools/bootconfig/main.c                  |    4 ++-
>  tools/bootconfig/scripts/ftrace2bconf.sh |    4 ++-
>  tools/bootconfig/test-bootconfig.sh      |    4 ++-
>  5 files changed, 71 insertions(+), 17 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
