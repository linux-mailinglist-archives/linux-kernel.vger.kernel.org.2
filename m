Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A41358C00
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhDHSQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbhDHSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:16:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103D3C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 11:16:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u4so3413694ljo.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulq9+7/XzXeIzl2nqk2FucNx47514zVp74Usoc4uijU=;
        b=n03iRr7PyYy/ltF+F7MAU2MwXmetlwnMRzBIbneniJ7KBCTR1YJz/QbbybCY7EiZsp
         AlTVLhaNugXDa92+QUMJoCAz3NgH6GKAlxOZrtUrCqsHfumf3yELWegEhuOJel4cO1fJ
         1sH9bYjbDmhPfK8p6sB8y2jEJikuCt2ZchEc7FtGYSdcDsLi6K/VC/nPI5t7qcJeXyZb
         6r6z7Yxv7+W6OG72m/WU7jXP7lRLQ7AUrs6YAwE2NNYYRjODtRqm63gd0+nFPLxHpXA/
         +PWOxAP1/Eh5bV1Ex8cxEI2bTsP4WSrK7eTdQW7VzOpS0PqkEUhWXiKg2UXmP/6gKmZy
         gtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulq9+7/XzXeIzl2nqk2FucNx47514zVp74Usoc4uijU=;
        b=ZJ8S73UOMW/bNsBa9klOqLRW/DaN/ankCm7WhjuYKsVIM7QfHbNob4JwyJodrFpaHl
         602NdaGGGH5dkFdCHjt2eFm3wZo1iImoL6s6IJ9Ur2HU4o+jJBKH1QCob/HlZhbfOZIv
         QsSqKsI1P0E+/I17ulnNqvn2rcPLy67d8r/fackzBAiODd7RDxHFg5vQv2S5Rxt55J1z
         mAAYJ/tPmObt6ie+9xqE3uCBvHG3S73uHeUFiWr4hlIJBC6zVQT7V/9wWKp4Ehvh4tGH
         Lz8k0dRwybC53V/9rbNQAT0EuFd9vD7AdST3aV6LPMT5kSrvdocN0KXwpo4FX5ejz5+J
         6kRg==
X-Gm-Message-State: AOAM532js7fllonfxvI4v9Rq8WfZVFKNM6esTYfBvSC0FO9gFL+HWGVP
        hnrlpaTw4nYWIPywBQgUCUNP7JMIDpoMeYR7zYEJyA==
X-Google-Smtp-Source: ABdhPJz/82lmQ5KDJrRejwphkj7Y29xUiYux6fI78IyO18ae23oEBWKZtKJGBSXKioR6JNire5M+u+6lLCJLkJIUzHw=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr6873579ljp.479.1617905794291;
 Thu, 08 Apr 2021 11:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210408130605.541796-1-gi-oh.kim@ionos.com> <CAMGffEkPRJ1vBi7+bbejS+Acttt269DjW9M6P8n=5xVZ50aGXg@mail.gmail.com>
 <CAJX1Yta1nd-xMwzsFvk50RzWY_6CMbgfE-LH-SCQvPGdxDJ8pQ@mail.gmail.com>
In-Reply-To: <CAJX1Yta1nd-xMwzsFvk50RzWY_6CMbgfE-LH-SCQvPGdxDJ8pQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 8 Apr 2021 11:16:23 -0700
Message-ID: <CAKwvOdk1OsTH0O7zB+ffWzZnwVNVKeoLD4NvTYETztPYyhW4Eg@mail.gmail.com>
Subject: Re: [PATCH v4] lib/string: Introduce sysfs_streqcase
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>,
        open list <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        laniel_francis@privacyrequired.com,
        Kees Cook <keescook@chromium.org>,
        Daniel Axtens <dja@axtens.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 7:52 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> On Thu, Apr 8, 2021 at 3:14 PM Jinpu Wang <jinpu.wang@ionos.com> wrote:
> >
> > On Thu, Apr 8, 2021 at 3:06 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> > >
> > > As the name shows, it checks if strings are equal in case insensitive
> > > manner.
> > >
> > > For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> > > strncasecmp to check that the input via sysfs is "mi". But it would
> > > work even-if the input is "min-wrongcommand".
> > >
> > > I found some more cases using strncasecmp to check the entire string
> > > such as rtrs-clt-sysfs.c does. drivers/pnp/interface.c checks
> > > "disable" command with strncasecmp but it would also work if the
> > > command is "disable-wrong".
> > >
> > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>

v4 LGTM, thanks.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> > you should add the
> > Reported-by: kernel test robot <lkp@intel.com>
> > > ---
> > you can add the changelog here after the ---
> > v4->v3:  removed #ifdef CONFIG_SYSFS ~ #endif.
> >
> > The string comparison doesn't depends on CONFIG_SYSFS at all.
> >
> > It looks good to me.
> > Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> >
> >
>
> Yes, I got two build error reports for v3.
> Should I send v5 including "Reported-by: kernel test robot <lkp@intel.com>" tag?

I don't think that's necessary.  I would use that tag if I was fixing
an issue reported by the bot; but v4 is basically the same as v2 in
regards to the issue 0day bot reported with v3. v3 just demonstrates
that there are drivers with possibly incorrect Kconfig dependencies
(missing a dependency on SYSFS perhaps). So the underlying problem was
not reported by 0day bot; 0day bot just helped avoid issues from v3.

Fixing the Kconfig dependencies would be nice to have, but not a
requirement IMO to this feature/functionality.

-- 
Thanks,
~Nick Desaulniers
