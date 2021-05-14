Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2383807BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhENKyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhENKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:54:03 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE39C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:52:51 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id l25-20020a4a35190000b029020a54735152so2304929ooa.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4dp/rPp75R6Y/qX3FQ9ODyLo78JIjJBmV86qMPI9hw=;
        b=AUbULHk7/tf5AyYUjIWSbeu4IkSmx2+SJrx3UzBhDdE4vxVom0BfOz2sXyiVfCHpl+
         2dGW8KetJ71nAdiR2oPG3NOOYswiMQlWUvFWoqUTlRFPcjWUS+ZVd16/qcy9R/ImHZ6U
         J0qWvzfwMp2jgEAzA8IzVb3OoZnKyY64p4WVdO60Nje4Mc8ITaF/Z3g5bS8S0qE+zNv0
         QPAUcW5robvG09zHGuVBcA+lI7FP0iAHwlfUJ7ujr1t4Iyg2z7kQUitUu3WNhBwEkR9u
         1DB8C5mpG7fcD1dobzmgEzjAIjVVBwnGwP3dkdIlNpBro+KHDX4bdCRJxdkeQJbRerpE
         /cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4dp/rPp75R6Y/qX3FQ9ODyLo78JIjJBmV86qMPI9hw=;
        b=AeaMpYm7qGHweiGnNNKrCM6xBuCtE3g5lvTwJPxaf1AQILnCUwJFE6I6yYq8HF+ilx
         wGdW0VN84S3ePeeisxV4Lg70GqCyD99QHspTXLJcaPn0O/0uSb6tgymEnHAXJkfXIaru
         74kIwqHpTeSf1GzGoG/tHdhFgdigQFjTNZWzcZTXz/YBbzgzBjj+gACsi3M9M2mtbxHr
         +a5SWI61ZRqCfpA+XO6cgnZdDh2xaAzteyuZKDDL1RVlmi95L+V2cb6x9ah0yvSMbja3
         rEWG5VxznPZyV2CDFQIv695fQvj/2S8rgmKLUniwFwPB+VmeQXE7b1ydJ5B7IHs+jp7O
         UWng==
X-Gm-Message-State: AOAM533JcNDXf0gJWY2WFv+vHq0oqXDGXvFDZQOa/DxL6N2f037h22a3
        eD1jQqDW2czWNAW5MOx11TPuMkg87kQD4Vo/2UdIroBdCig=
X-Google-Smtp-Source: ABdhPJxDi679KzU4E+PyfsWscJkwOA/eKxqrRiaIovZfTJv54HYC9jvjZs0KevGpOdhKqLv5Nq6ec+Wsj0lL8G1sHi4=
X-Received: by 2002:a4a:b3c4:: with SMTP id q4mr25041775ooo.14.1620989570367;
 Fri, 14 May 2021 03:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210514092139.3225509-1-svens@linux.ibm.com> <20210514092139.3225509-3-svens@linux.ibm.com>
In-Reply-To: <20210514092139.3225509-3-svens@linux.ibm.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 14 May 2021 12:52:38 +0200
Message-ID: <CANpmjNOLSuqeTr8YOnvz-V=eudBwraNvm+9V+YxEBUCm=EFwxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kfence: only handle kernel mode faults
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 at 11:22, Sven Schnelle <svens@linux.ibm.com> wrote:
>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  mm/kfence/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index bc15e3cb71d5..161df492750c 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -813,6 +813,9 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
>         enum kfence_error_type error_type;
>         unsigned long flags;
>
> +       if (user_mode(regs))
> +               return false;
> +

I don't think it's required on all architectures, correct? If so, I
think this should be part of the arch-specific code, i.e. just do "if
(user_mode(regs) && kfence_handle_page_fault(...))" or similar.
Because otherwise we'll wonder in future why we ever needed this, and
e.g. determine it's useless and remove it again. ;-) Either that, or a
comment. But I'd prefer to just keep it in the arch-specific code if
required, because it seems to be the exception rather than the norm.

Thanks,
-- Marco
