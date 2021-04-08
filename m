Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63046358785
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhDHOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDHOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:52:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1FAC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 07:52:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r9so3555404ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKUnZqQO4ivizG+/bI3cfBd3j61a2uPrSNbS6BoWcw4=;
        b=WvsKI3bAiKzr4yA6PIJ+J4WQc05EROY+gken2DjzjtPfp7OIgsFCW1g/kYFsyZTfoY
         EQ7gjwhNWVJjN3L2KN3WKPNbKzgt/Tc4R3llPOO8z1we5eM8EHMbm0ChcvsZFFimcDtY
         dAAFhJoAyg9Hm/WFaMCv3rbkA1Aq16SRmw3gBD9iOTUtyrhyfiDWm+Pk8YLw4Hf+P102
         389CGKMF88Rd3q/aWHxwE3lOTE4JhCiRNV5HTpzG4LngCB+dmjkdi7yfBYxWbRpYmPNy
         3/JYZIeuXsN3zFDHNlMRERXGHAshUJFWwBSmZYOeNH5oeRYTguhUDfnzwB6OKJuNNaO/
         0ZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKUnZqQO4ivizG+/bI3cfBd3j61a2uPrSNbS6BoWcw4=;
        b=NnS4E23BUZ3ArlmOaiBLueWG8uwL4JodoexT/OKtLUB7nnzWUDq/y9sms8/eLZg335
         W/uXdkyxRAm4lVkVrar71Da/vevO5DSUO6uS+6vk3mFiKiezPW3K6oFM4AP72gZh1FMO
         XJ7dInfcwFOQpYrr9XWCCC4B5SrO+rZfPtibj9cSIIhiF4Iwa8owD4QhqzyreBUo7853
         VZztRbKusTYmwS75zZXNx81FoVHIDLlvVGVaS7FraQdnpdqpqg7lT/mwqOInLaOqOdPu
         3Jb3p7S6vEjhByJMckmXH7u0EzH2TUh22LI/6kaOTF8HPvE2Y6vUnzhcfYXT1Z6eEmOP
         DcLA==
X-Gm-Message-State: AOAM530Ix4+SXG6KGBztJYlIleH/dQicJYD0XbHV4V4bDx8Xjx31ZSXR
        SyiJ+/AO+7joTDJ88QdC8q+8NzWUbd+HJc/E7BHg1A==
X-Google-Smtp-Source: ABdhPJxb06i4f0DsYyOhGPqYUfA4C2NwI787MAcpv9SKq0DSvo1yuf3f+4KyaYvOxyjv2LApEQZd2400W5PfRPMhDY8=
X-Received: by 2002:a17:906:341a:: with SMTP id c26mr629983ejb.238.1617893558158;
 Thu, 08 Apr 2021 07:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210408130605.541796-1-gi-oh.kim@ionos.com> <CAMGffEkPRJ1vBi7+bbejS+Acttt269DjW9M6P8n=5xVZ50aGXg@mail.gmail.com>
In-Reply-To: <CAMGffEkPRJ1vBi7+bbejS+Acttt269DjW9M6P8n=5xVZ50aGXg@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Thu, 8 Apr 2021 16:52:02 +0200
Message-ID: <CAJX1Yta1nd-xMwzsFvk50RzWY_6CMbgfE-LH-SCQvPGdxDJ8pQ@mail.gmail.com>
Subject: Re: [PATCH v4] lib/string: Introduce sysfs_streqcase
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Thu, Apr 8, 2021 at 3:14 PM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>
> On Thu, Apr 8, 2021 at 3:06 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
> >
> > As the name shows, it checks if strings are equal in case insensitive
> > manner.
> >
> > For example, drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c uses
> > strncasecmp to check that the input via sysfs is "mi". But it would
> > work even-if the input is "min-wrongcommand".
> >
> > I found some more cases using strncasecmp to check the entire string
> > such as rtrs-clt-sysfs.c does. drivers/pnp/interface.c checks
> > "disable" command with strncasecmp but it would also work if the
> > command is "disable-wrong".
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> you should add the
> Reported-by: kernel test robot <lkp@intel.com>
> > ---
> you can add the changelog here after the ---
> v4->v3:  removed #ifdef CONFIG_SYSFS ~ #endif.
>
> The string comparison doesn't depends on CONFIG_SYSFS at all.
>
> It looks good to me.
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
>
>

Yes, I got two build error reports for v3.
Should I send v5 including "Reported-by: kernel test robot <lkp@intel.com>" tag?
