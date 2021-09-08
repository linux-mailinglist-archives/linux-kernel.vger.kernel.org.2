Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ED3403314
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 05:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347506AbhIHDtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 23:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232366AbhIHDtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 23:49:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E15E061152;
        Wed,  8 Sep 2021 03:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631072881;
        bh=JLkt6Qk4cBOHL4WvzMpDeS8CtQ+PtEq+Btqu/k4uqsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=evc4gC9uu8KD3daYOAFZohbBNb3ZxYbI/0N1xTNpqcEOzsKFld9GlXy3eemWBxnDg
         jAkOBkiQKVxQTU/NXBsPsclgQXm2OcDlsVW8y6NE4QubsnI8ppUChhHY4sWPAl/TRS
         StzCwdhPV1V52b6Z5iBx8d9GBz1/nFNsaHyu1nLBLxEXrZp0d3nuZF6NMKLm6ZGt2E
         HLOT3AWOo/2zEHqBIy2gFdhXJqdZyjxtFAJwDYxZGyCjwtz77B5aF33SaRI6Nru4nH
         3T0rLlTU9F+N0g6mD+1kxp8Osn8vM06JIpYsekXd9QFMA53rbHXoFbQejsfGqK4TNJ
         4r/CfdwRdXF0w==
Date:   Wed, 8 Sep 2021 12:47:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] selftests/ftrace: Exclude "(fault)" in testing
 add/remove eprobe events
Message-Id: <20210908124757.b80638d630436bebf1280836@kernel.org>
In-Reply-To: <20210907230429.5783d519@rorschach.local.home>
References: <20210907230429.5783d519@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021 23:04:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The original test for adding and removing eprobes used synthetic events
> and retrieved the filename from the open system call at the end of the
> system call. This would allow it to always be loaded into the page tables
> when accessed.
> 
> Masami suggested that the test was too complex for just testing add and
> remove, so it was changed to test just adding and removing an event probe
> on top of the start of the open system call event. Now it is possible that
> the filename will not be loaded into memory at the time the eprobe is
> triggered, and will result in "(fault)" being displayed in the event. This
> causes the test to fail.
> 
> Account for "(fault)" also being one of the values of the filename field
> of the event probe.

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Fixes: 079db70794ec5 ("selftests/ftrace: Add test case to test adding and removing of event probe")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  .../selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> index 25a3da4eaa44..5f5b2ba3e557 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
> @@ -22,7 +22,7 @@ ls
>  echo 0 > events/eprobes/$EPROBE/enable
>  
>  content=`grep '^ *ls-' trace | grep 'file='`
> -nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."'` || true
> +nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."' -e '(fault)' ` || true
>  
>  if [ -z "$content" ]; then
>  	exit_fail
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
