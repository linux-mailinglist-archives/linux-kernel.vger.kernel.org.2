Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A040A421A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 01:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhJDXYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 19:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbhJDXYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 19:24:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A687C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 16:23:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y23so38997922lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 16:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8asHn/iYd03g83vgfgxo+lFvMDcDL8rsmQBpQeeHnK0=;
        b=p2CcespYqIe+M2AjipUxAHP9K6Vi0ifbq9m4GxyLkI3gV/vEZt+7Na2ASheJOcDaag
         NzwggfOJ5GRvhbWFrmr2TOk2gF2M48CGpklW3fkKnNELgLxc23/ioQuuxilSX0pDm26G
         emhJARxOj8i7L1ZxfmCeM1nt+tOQE3DmM0akSFQMotmOSqI0XhiyKCT59uhfDTIQWz1r
         NwPp4acNH9q+dcl9PbJcmmyTsXyX1y5FrjXuTomfEJt9ApLEV38Gemi63fOoHnsMHfVB
         eddiL3GEotR6ZA9idDdKD7JplqlmYGVYLB1uue1oOlqAFz4M6yu5qbILDB4Vr2wPiidO
         3FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8asHn/iYd03g83vgfgxo+lFvMDcDL8rsmQBpQeeHnK0=;
        b=FJJ75UXHw7MVn7pstZ8sYBpcxx9rZ6F8/3IQeCg+fTVKG5tUe75/2BUinSpZ7Bw6e4
         k3bVuHcgcO+DMJuJqrvu8MDa3rdPNY+04cw6ie/EtF7IqZYE627K7P+T/Voi0kruxBoF
         fELimEKQqOg7nP8pwH7Q2Gn6WcDBh6eL28bsfgG0IW0u2edDfw9oZJ24oNjve0LQDd+r
         IkUZ7NLP5wRxEH4D7wTk07+k/mWdG1l2JWdwdfHXzokNVAArkaT0FwzIRViOhsuRHP8f
         +/t9vjyyBinAjLMbJCfbdXjKJUZEaGaiRe/gcO0MmsrvWKqOjgCr6DOt0Am9Eu6F0MXN
         WiiQ==
X-Gm-Message-State: AOAM531zfwv6aJRrxnAQpefvjaD7guuTts4LtwDSmVbCYkzit1ftOcms
        mAYK2uBZ8mVC/pmS79oqCxUXP50p1fDLSBr/vCnagw==
X-Google-Smtp-Source: ABdhPJxBnNNC6CU4ZwFoxnRbyfB4pSz2595jYvt6QuBRmw//X5abCAwApH63HrjCOVWwTWHw6koNnYhIz9PTUTUxY0g=
X-Received: by 2002:a05:6512:2294:: with SMTP id f20mr17500184lfu.489.1633389778636;
 Mon, 04 Oct 2021 16:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <202110020501.RKX4zca7-lkp@intel.com> <20211004162936.21961-1-ndesaulniers@google.com>
 <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
 <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com>
 <20211004183806.5weyuk554ppe5olb@meerkat.local> <CAKwvOdkzviryHByOZj1K6r6HVKcC+4Tc43jXn4Eqk9EXGVpucg@mail.gmail.com>
 <20211004194521.e2syd25qzrgn5mzg@meerkat.local> <20211004203754.nvk4aijql7tevbnh@meerkat.local>
In-Reply-To: <20211004203754.nvk4aijql7tevbnh@meerkat.local>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Oct 2021 16:22:47 -0700
Message-ID: <CAKwvOdm_C4nYW1xWmf6RbjXoV76xZs8OCq6VfSKXKtJXdMta-Q@mail.gmail.com>
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 4, 2021 at 1:37 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Mon, Oct 04, 2021 at 03:45:21PM -0400, Konstantin Ryabitsev wrote:
> > So, this line:
> >
> > > fatal: command 'git hook run sendemail-validate -- <patch>' died with exit code 1
> >
> > Suggests to me that your git version is patched to carry the
> > new-and-not-yet-accepted "git hook" changes. It seems that it both opens a
> > stdin and passes the file as the parameter. When we find a stdin, we always
> > grab that instead of the passed parameter, but that's only a problem with this
> > change to git.
>
> Patatt version 0.4.9 is out and should fix this problem. Glad we caught it
> before the fancy new git-hook patches are in upstream git. :)

$ pip install --user patatt --upgrade
$ git send-email ...
$ echo $?
0

:) LGTM, thanks Konstantin. Did I mention that b4 has significantly
improved my workflow contributing to the Linux kernel?
-- 
Thanks,
~Nick Desaulniers
