Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8937A9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhEKOwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEKOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:52:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A3DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:51:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id c22so2077416ejd.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kHw7pNQPBdOqfK9M7S599Sb7absGKA5ntaivvMQmEc=;
        b=l0Aj1l8G2tqpw7hRA4dGCHbFOrXIZiYU2naM9qT3fCkEMGIc0gXlGSAv8a+WQdIAPY
         ZGV9xQLO3HDfolvdpmkZBDovyF0nTVTrPLC/IYDex1QtrZ/hJvOb1asl0eAEu/HPMI4c
         SXKdR1Q6XrkIMOQU4RaChHHCvrg7axYULBh24acONkhEXfGIKZCCQNsbe+7PWYGBYmD/
         Uid2ak7cToXSBBgmMo9AgcvEWSGBe/mLETiEFrUMqet3oqqedVlfqOPeEUKuTlbiK7XF
         LsVk96OWZsH4/fVQDWbbnSyZSKkeR3rb6wKSQCJl6l+N/OQB52UBi4GquM7UIPrYpd1g
         5P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kHw7pNQPBdOqfK9M7S599Sb7absGKA5ntaivvMQmEc=;
        b=QwDx3ykfOvSUCQuACt0PMc/8tEvm9gFRrBvLjMyCRWIzoMeWt0IaCPDlMRZFyGZA4b
         ZKWZ+pSyxZdZ9YmduCE8Ti8LQSbSCXK7gIzrtXy1vzzUTACGdxFBuBAXPWMODcBvXGTT
         mxdYOBe3GykK3+0QUQ3W+YvTSSO6zf8Foa8OKhVceqA3YlAxLNiIKR59WAQoH7lwST4f
         mPoCsyRU4ROE2fqGFGgmxsmyK9M4nCCuJ13riUeJWGw61Mj9CEEEpB2/1draPB9BoB3z
         E4bbqxxEozEEixpjkXEMhJl1vVcSMGZXWf8boe8pw3u7XpuhD1b39t03grpH/PhwwhdA
         Bimg==
X-Gm-Message-State: AOAM533UHPy3qoGmnv/83WOffJW6cVcuPle9ZRnrfb5MuGzMkI+RtNFS
        C4Df8ZG/nnxPM/o/t2GQVzrLFpntskD1caAbxMO0
X-Google-Smtp-Source: ABdhPJxeyUx5yfm5j/7o9DvQcbv6fmcTzE5yKV5g6sTibWQ3azkQDv6Zn7Y6AnXA+45QWeskABmI+kLB7266SZdsetk=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr31849943ejb.91.1620744692432;
 Tue, 11 May 2021 07:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210423103533.30121-1-zhe.he@windriver.com> <20210423103533.30121-3-zhe.he@windriver.com>
 <CAHC9VhQXawubMsKg2F282k-bJqZFT=vNurZAeAPKLU1ZZpYKeg@mail.gmail.com> <c8493e20-c7fc-67e4-f2cc-81601535f21a@windriver.com>
In-Reply-To: <c8493e20-c7fc-67e4-f2cc-81601535f21a@windriver.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 May 2021 10:51:21 -0400
Message-ID: <CAHC9VhTEcp0KHHt8fNgEXXUHtL+yJh9MtjEBrnLmT-Oumo-CVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] audit: Use syscall_get_return_value to get syscall
 return code in audit_syscall_exit
To:     He Zhe <zhe.he@windriver.com>
Cc:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:19 PM He Zhe <zhe.he@windriver.com> wrote:
> On 5/11/21 6:38 AM, Paul Moore wrote:
> > On Fri, Apr 23, 2021 at 6:36 AM He Zhe <zhe.he@windriver.com> wrote:
> >> regs_return_value for some architectures like arm64 simply retrieve
> >> register value from pt_regs without sign extension in 32-bit compatible
> >> case and cause audit to have false syscall return code. For example,
> >> 32-bit -13 would be treated as 4294967283 below.
> >>
> >> type=SYSCALL msg=audit(1611110715.887:582): arch=40000028 syscall=322
> >> success=yes exit=4294967283
> >>
> >> We just added proper sign extension in syscall_get_return_value which
> >> should be used instead.
> >>
> >> Signed-off-by: He Zhe <zhe.he@windriver.com>
> >> ---
> >> v1 to v2: No change
> >>
> >>  include/linux/audit.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Perhaps I missed it but did you address the compile error that was
> > found by the kernel test robot?
>
> I sent a patch adding syscall_get_return_value for alpha to fix this bot warning.
> https://lore.kernel.org/lkml/20210426091629.45020-1-zhe.he@windriver.com/
> which can be found in this mail thread.

At the very least you should respin the patchset with the alpha fix
included in the patchset; it's a bit messy otherwise.

> >> diff --git a/include/linux/audit.h b/include/linux/audit.h
> >> index 82b7c1116a85..135adbe22c19 100644
> >> --- a/include/linux/audit.h
> >> +++ b/include/linux/audit.h
> >> @@ -334,7 +334,7 @@ static inline void audit_syscall_exit(void *pt_regs)
> >>  {
> >>         if (unlikely(audit_context())) {
> >>                 int success = is_syscall_success(pt_regs);
> >
> > Since we are shifting to use syscall_get_return_value() below, would
> > it also make sense to shift to using syscall_get_error() here instead
> > of is_syscall_success()?
>
> In [PATCH v2 1/3], is_syscall_success calls syscall_get_return_value to take
> care of the sign extension issue. Keeping using is_syscall_success is to not
> potentially changing other architectures' behavior.

That was only for aarch64, right?  What about all the other
architectures?  The comment block for syscall_get_return_value()
advises that syscall_get_error() should be used and that appears to be
what is done in the ptrace code.

-- 
paul moore
www.paul-moore.com
