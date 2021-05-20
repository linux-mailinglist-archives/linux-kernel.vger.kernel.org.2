Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C083038B121
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbhETOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243637AbhETOJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:09:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DC236109F;
        Thu, 20 May 2021 14:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621519664;
        bh=O+hLBEJ2ZIQGEZpp1BxNoPTa8xc8xbPH2+SrmZT9mEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VHrlt+6mt4eQGpcAGlYuXuXwOaSkhA8QyeMNdN4DSeWX3yZ7ogpy9MfG8Kdce+hQD
         X2H5pEp3zaj8Yq7/2+lfcorzigNB91cO5z1/keCnwnc2N8Oefy6B2uYrHnG6AF7hE+
         PT/GW7SJ/Be0OwYdRp1qyVy7S9hZlHddAJRUwwsUV9El3X2tSlnG3Pm3p06k2poSQS
         PGh/EuT41/NfwwtHjlqn4h3D6C3ZsjgR5V7oHQhll8bzSRsEzRy7nGovUtQsk/4Jzn
         +bWSnMv+57IHCPafwzYq0u85A8Wb+TCqSdyRviXIdNNzYHM2jsOnNcOfghehjL5ZAL
         hnqB9Gi+1xNrA==
Date:   Thu, 20 May 2021 23:07:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tools/bootconfig: Fix a build error accroding to
 undefined fallthrough
Message-Id: <20210520230738.605c92033e16c13b86f7c99c@kernel.org>
In-Reply-To: <162087519356.442660.11385099982318160180.stgit@devnote2>
References: <162087519356.442660.11385099982318160180.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Can you pick at least this fix since it is a critical bug?

Thank you,

On Thu, 13 May 2021 12:06:33 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since the "fallthrough" is defined only in the kernel, building
> lib/bootconfig.c as a part of user-space tools causes a build
> error.
> 
> Add a dummy fallthrough to avoid the build error.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4c1ca831adb1 ("Revert "lib: Revert use of fallthrough pseudo-keyword in lib/"")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/bootconfig/include/linux/bootconfig.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
> index 078cbd2ba651..de7f30f99af3 100644
> --- a/tools/bootconfig/include/linux/bootconfig.h
> +++ b/tools/bootconfig/include/linux/bootconfig.h
> @@ -4,4 +4,8 @@
>  
>  #include "../../../../include/linux/bootconfig.h"
>  
> +#ifndef fallthrough
> +# define fallthrough
> +#endif
> +
>  #endif
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
