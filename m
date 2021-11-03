Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790D3444059
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 12:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhKCLIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 07:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKCLIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 07:08:45 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C06AC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 04:06:09 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v64so5379261ybi.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QuFzByOa/ahTteU7KyBq/Rkqo8t0eAAuiK1WJGAOQHI=;
        b=iD0kdGbu9ktT8LuDgKz9kKXPy+LGlaWlzv3nbtWKyUpFpAEQ9/jqsTnvLr+NLlLU/i
         ZPsKKTYCBkYtW++WYql+KSbfQIV/KCJq6LC+gYnrK8MT6cbwAD9/SvLLGuAE2kS78COg
         UVunOW89tKRipZHYvak1GLMFyaIauGPL++cvF2RP9jLzn5NsW/lE3WUp6jD0C7csW6cQ
         gUP+lW2SRW0JHLnM09F22lv3uJdZ9rasfQXvp250b/Q9YR51xlBJYyXjj3YnXVte+zPJ
         mU3sdGA7PYDZAIwP3B2rbBfm3dPKWfvexNDkSRz4CiiujgSXslq2Sl+jGLsqRVEvD9KT
         MQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QuFzByOa/ahTteU7KyBq/Rkqo8t0eAAuiK1WJGAOQHI=;
        b=eVBZ5G22mt4nbuLua8Ts8fcp4xID2CWnIVJ0RP2VxbKHLwA/TkV49KgT+intNe4Tvm
         cXBX5wB5KJXfbPslzX8GqacH7hNbdbokxg/uQh3DzPqne8maYDh9oLNtVgZgs6KsYwCf
         2kHthGjZTIjPvW+BbihlXGSu5CX0t7BBB6VBs2pRutSGTZsn47lKz3CRR+wjPgeTWjzU
         419B5SjD0psNjFLul7udR+13Ehx6r7G7lTau4EqJkTh8O+qcHI3XKldOqnq4TRt5/Jkt
         jQfTHqk2klc9zeGI/OaHRaTCWB2jB/R0pXFi/hwu2uRQqpyEWhQdLStYoisOraVOnGru
         HB6w==
X-Gm-Message-State: AOAM5339zy/R1csrg24ENIsqSx+m2YFCdnUP0yCvJkroG82SyR4IVGiu
        6+C/fgo07rLxbxAS10rsD47EAE2TWCh2Dg3/Ln8=
X-Google-Smtp-Source: ABdhPJxjRUK1k4kWNXXoAEE3oWbgjzngciL9jq8EvZbKT+GWSaOuVzpdLJReccUhiFWnUJklM8iTWFM3P+rhu0SbFIg=
X-Received: by 2002:a25:a264:: with SMTP id b91mr17586899ybi.58.1635937568487;
 Wed, 03 Nov 2021 04:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211103104812.1022936-1-javierm@redhat.com> <20211103104812.1022936-3-javierm@redhat.com>
In-Reply-To: <20211103104812.1022936-3-javierm@redhat.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 3 Nov 2021 07:05:32 -0400
Message-ID: <CAEg-Je_3n9vFpP-vmVzkbDZY154g3xOK5JqPN7r9kGXJ1Zp0+w@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm: Move nomodeset kernel parameter handler to the
 DRM subsystem
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 6:48 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> The "nomodeset" kernel cmdline parameter is handled by the vgacon driver
> but the exported vgacon_text_force() symbol is only used by DRM drivers.
>
> It makes much more sense for the parameter logic to be in the subsystem
> of the drivers that are making use of it. Let's move that to DRM.
>
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Please no, I'd much rather have a better, more meaningful option
instead of "nomodeset". If anything, I would like this option to
eventually do nothing and replace it with a better named option that's
namespaced by drm on the command-line. That was part of the feedback I
gave in the original patch set, and I still stand by that.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
