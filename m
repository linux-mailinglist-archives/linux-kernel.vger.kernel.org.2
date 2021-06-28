Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA4E3B65A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbhF1PdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235676AbhF1PG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:06:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2502661428;
        Mon, 28 Jun 2021 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624891911;
        bh=0fU6ytIbzI3Hs+P8qc4M2FD+CAf9lVRjYrJS0Ry4iRY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GU2wPjB+GrXfGw0bXUN6yAj5Ds7poPUMYYtOn1Wm3FVPmiBa3yUqxMKpFiE4JE2k+
         66prmiXdfjQtP72lElV03X+kxBTgL+KROzPUwv8vcgKnPgEyzeYrT5wEOvoYFmpc/F
         nKIueb33x1LHouFeG2ciaqTL3ujw+vwLUgOlhN0+tgvXUVhYHWYz4Ed/WThIwDSj6x
         j1gS++M0OZ2vsKonDnS2qBrjTcolS9YhYbZwiK9iguY50KYRIT1NrK1SRUv8mB0kTu
         wYLHK1TWVzEvHK0NXI5gbvlT6qAVCCb1TTbGr+Et8Q8yImWXTbJnyw1sWWkYv1VFZN
         uZfhEICTFtaiw==
Date:   Mon, 28 Jun 2021 23:51:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: selftest/ftrace: Add test results to "-h" help text to
 ftracetest
Message-Id: <20210628235149.56142f8679933761701959f6@kernel.org>
In-Reply-To: <20210628095015.4b8b1cb9@oasis.local.home>
References: <20210628095015.4b8b1cb9@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2021 09:50:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Peter Zijlstra recently had to debug jump labels that were failing in
> the ftracetest script. He became frustrated as there was no easily
> available documentation on what the meanings of UNSUPPORTED and
> UNRESOLVED were. The only place they are documented is in the code.

oops, thanks for adding the help message!

> 
> At the very least, add the results to the help text, as I find that I
> also sometimes need to figure out what those terms mean.
> 
> Now "./ftracetest -h" produces:
> 
> Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]
>  Options:
> 		-h|--help  Show help message
> 		-k|--keep  Keep passed test logs
> 		-v|--verbose Increase verbosity of test messages
> 		-vv        Alias of -v -v (Show all results in stdout)
> 		-vvv       Alias of -v -v -v (Show all commands immediately)
> 		--fail-unsupported Treat UNSUPPORTED as a failure
> 		--fail-unresolved Treat UNRESOLVED as a failure
> 		-d|--debug Debug mode (trace all shell commands)
> 		-l|--logdir <dir> Save logs on the <dir>
> 		            If <dir> is -, all logs output in console only
> 
>  Test results:
> 	PASS		The test succeeded
> 	FAIL		The test failed, but was expected to succeed.
> 	UNRESOLVED	The test produced indeterminate results. (e.g. interrupted)
> 	UNTESTED	The test was not run, currently just a placeholder.
> 	UNSUPPORTED	The test failed because of lack of feature.
> 	XFAIL		The test failed, and was expected to fail.

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Link: https://lore.kernel.org/lkml/YNmflj%2FWpFG5Ivmb@hirez.programming.kicks-ass.net/
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 8ec1922e974e..f34580c70650 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -21,6 +21,14 @@ echo "		--fail-unresolved Treat UNRESOLVED as a failure"
>  echo "		-d|--debug Debug mode (trace all shell commands)"
>  echo "		-l|--logdir <dir> Save logs on the <dir>"
>  echo "		            If <dir> is -, all logs output in console only"
> +echo ""
> +echo " Test results:"
> +echo "	PASS		The test succeeded"
> +echo "	FAIL		The test failed, but was expected to succeed."
> +echo "	UNRESOLVED	The test produced indeterminate results. (e.g. interrupted)"
> +echo "	UNTESTED	The test was not run, currently just a placeholder."
> +echo "	UNSUPPORTED	The test failed because of lack of feature."
> +echo "	XFAIL		The test failed, and was expected to fail."
>  exit $1
>  }
>  


-- 
Masami Hiramatsu <mhiramat@kernel.org>
