Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C43C5336
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350714AbhGLHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344519AbhGLHUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:20:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41493C07888D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:15:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i5so11551929lfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UK1Y5g539CKatjuPdctwi+Y6V9Y3jMH6RRf3GAMgDhk=;
        b=XPq1yB4Q9KnbAlVdrXDOF1w4DOhSizTO991lcc5YQQslOq2iGDkb+ZgeHD0js2E0Nf
         rM7KGWhmHX8R5ARw7t+SvhYRN+6U+n+CdNk5gXJ0MnztVNp2+MH9gTYEZrY8s05cv+Uw
         hSalsRRU6VerZxVXHYzsbQjIEikaCcg1lgTrjbDJKuB0KqQjFnm/3N4iBvIM5iSdM3VA
         Wz8ZFi9GGiUPvstRbGcvbql7fEGVgpCrgZgj/vByfSt2V1Bz3IsEEsaT8KypEn5S5wge
         +W2Kt8pbA+G0m27mQ9GQGI+GO0FbbN9JLew/XbXyiMWbJ4NNzzRdGHmtw9GA4FcCAun6
         zzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UK1Y5g539CKatjuPdctwi+Y6V9Y3jMH6RRf3GAMgDhk=;
        b=Ftcofyn83ts79ca6vtF+U/ZezKyxCZvORfG7la8/4HeloOzM8UiARbSwA3QpNS+L9O
         mKmg7FbDpLjnDS8s8wzCm+BvdYNQ8VKPTO6UQ7BCgBDu9/DjzzwQ0sMF6WYFNkSP0QyH
         MJQlfiAGmkmvCb+aZ5TE5UeFsurczk0TRh/U3Rwd/zb9hKertyhPxEp26HKfSs2tXDC9
         fvwkfRE3a/3N41kSR53ieEkWdofqetBOzMqHliDAwO3S3AQLsA/c9BBClgeBge/GbfHn
         shmVl7co0DBx+e8Vqk26ZW04uO7Z6HIx6tCyqSV+C0dqeXRHrCgkUTkOaoUCX5pi2M1B
         LVsg==
X-Gm-Message-State: AOAM533iAK9qqTYmaptmjpRZEv9QbUaJKQ8ntnJ7i2WeZ/Ow0IBf2/5W
        Row6RtmlgEFriwMJBB4uKuGx3QYgNsFM2c1w+lgWTA==
X-Google-Smtp-Source: ABdhPJyqXXOatQtSyYe9abXgr7XsslWdGSg5A3DZ60wSdYdjmaDnDckEHEWo2vaEAj7LHF8asiGHgblloGQkAODkH1o=
X-Received: by 2002:a05:6512:2115:: with SMTP id q21mr9439856lfr.546.1626074099524;
 Mon, 12 Jul 2021 00:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210709104320.101568-1-sumit.garg@linaro.org>
 <20210709104320.101568-3-sumit.garg@linaro.org> <CAD=FV=WrfJEH-VYcf9ULC0pA5x0ju422c8GM1G1y33mJOmv1Fw@mail.gmail.com>
In-Reply-To: <CAD=FV=WrfJEH-VYcf9ULC0pA5x0ju422c8GM1G1y33mJOmv1Fw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 12 Jul 2021 12:44:48 +0530
Message-ID: <CAFA6WYOCbCwopi58iTdHOgxnSO0Sff78OKiOvfPLEzkLew9AVQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kdb: Get rid of redundant kdb_register_flags()
To:     Doug Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jul 2021 at 03:07, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jul 9, 2021 at 3:43 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Commit e4f291b3f7bb ("kdb: Simplify kdb commands registration")
> > allowed registration of pre-allocated kdb commands with pointer to
> > struct kdbtab_t. Lets switch other users as well to register pre-
> > allocated kdb commands via:
> > - Changing prototype for kdb_register() to pass a pointer to struct
> >   kdbtab_t instead.
> > - Embed kdbtab_t structure in kdb_macro_t rather than individual params.
> >
> > With these changes kdb_register_flags() becomes redundant and hence
> > removed. Also, since we have switched all users to register
> > pre-allocated commands, "is_dynamic" flag in struct kdbtab_t becomes
> > redundant and hence removed as well.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> Looking at v3 responses [1], seems like you forgot to add again:
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>

Ah, it was mistakenly dropped, I will add it again.

> This also looks good to me now.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
-Sumit
