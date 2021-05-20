Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8862F38BA00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhETXIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbhETXIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:08:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C46986135B;
        Thu, 20 May 2021 23:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621552037;
        bh=G9CeJ0rQ7Bewu0xcb76iJjR+WJgCZGQghU0Z6+C505E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RiAHReLRvzdFzhN2EPwBXnulBNEyGPmj1eGT9lbwdPv0faWUOmmxumf80srN4o8kz
         qKAz5WpAvm+92UAj1XET5Dy+AC8GxQMaox/lHfLZ0jGGzScr6X97vh+sW/+dZ8eIll
         fBYzcbQVFWksyLgHhu5A47rWgZH1ObABJ6/nxZlnAjBsPpJ9Pfm8DyJtr9MkROlpRy
         k04Qhx19lqCx+3QMFBm+88yM0KV6eeWo6tdKTLGTcjSDWrpU0VwuJRTD6tYxInilY+
         dj2TpESj/xkdPNK1vRQQkrl4skWIwImbp8LqovFoT+4dtOi2O8aQjR1MQIVT9quOgY
         SmeZg2Ybe1CzA==
Date:   Fri, 21 May 2021 08:07:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tools/bootconfig: Fix a build error accroding to
 undefined fallthrough
Message-Id: <20210521080713.3b7a45a26655995b88372d59@kernel.org>
In-Reply-To: <F1DB079A-8194-41E3-BF15-EB6F5A23CDF7@goodmis.org>
References: <162087519356.442660.11385099982318160180.stgit@devnote2>
        <20210520230738.605c92033e16c13b86f7c99c@kernel.org>
        <F1DB079A-8194-41E3-BF15-EB6F5A23CDF7@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021 11:47:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yeah, I have it cued up too. Can it wait till next week?

Yes, of course. Sorry for interruption.

Thank you!

> 
> --Steve
> 
> 
> On May 20, 2021 10:07:38 AM EDT, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >Hi Steve,
> >
> >Can you pick at least this fix since it is a critical bug?
> >
> >Thank you,
> >
> >On Thu, 13 May 2021 12:06:33 +0900
> >Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> >> Since the "fallthrough" is defined only in the kernel, building
> >> lib/bootconfig.c as a part of user-space tools causes a build
> >> error.
> >> 
> >> Add a dummy fallthrough to avoid the build error.
> >> 
> >> Cc: stable@vger.kernel.org
> >> Fixes: 4c1ca831adb1 ("Revert "lib: Revert use of fallthrough
> >pseudo-keyword in lib/"")
> >> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> ---
> >>  tools/bootconfig/include/linux/bootconfig.h |    4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/tools/bootconfig/include/linux/bootconfig.h
> >b/tools/bootconfig/include/linux/bootconfig.h
> >> index 078cbd2ba651..de7f30f99af3 100644
> >> --- a/tools/bootconfig/include/linux/bootconfig.h
> >> +++ b/tools/bootconfig/include/linux/bootconfig.h
> >> @@ -4,4 +4,8 @@
> >>  
> >>  #include "../../../../include/linux/bootconfig.h"
> >>  
> >> +#ifndef fallthrough
> >> +# define fallthrough
> >> +#endif
> >> +
> >>  #endif
> >> 
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
