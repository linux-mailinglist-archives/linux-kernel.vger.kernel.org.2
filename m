Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258A53E1132
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 11:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhHEJUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 05:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhHEJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 05:20:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E39DC061765;
        Thu,  5 Aug 2021 02:20:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y200so5869340iof.1;
        Thu, 05 Aug 2021 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gmxmbal5kN8ALwaA2TjN7nOaacEIqVHPBww5o4ZLZEc=;
        b=OTPZ/ue8FcpPntTRetaZvV8hc8RlWy4XkuE+tMA6Qhva/AlRgX3auNlI7HPA6+z1o3
         RQdc8lK1I0XdtJI+wvPo5hcETJGwZY7n8z+rIKfMMvwyUuP7J+/Zyg7x4ldMpuR+qC+D
         X0V7XPd7lHhuJMx+yufSuxAxE8aloRNUKA6oOJ9Y+GpQN3rZ0TBLxhGMkbfXaY+gMMMk
         5Hab3YAiMmwkbdY/qIvj5rRVxj08OiMDIl/xKygyhWEek6Cl0gyVorEotDqenuPEei5h
         PFeiWo277J9nvXLcWtdbffBURbQzRqze1M9GrvmBL+FI7tvWiV2vM7PJvdbowaGyxUAU
         BZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gmxmbal5kN8ALwaA2TjN7nOaacEIqVHPBww5o4ZLZEc=;
        b=IzDzFJYPqHZR9lxkIZAzOMCl2K0yNqaampU4bShc8a9eoloXjqeOv11pCn3ZkpJeHv
         t0KPojfzUXTKsU3RZ5IP7AmMTvJX5lhRhKASG7nbM/iNPv5MNgQY3/Yi4+Dxm6uuxkeq
         pE7xea65HsiA4kDi9v8HgRjyZe5YFYZXRR23PTgjXeoubDaOgv66I0oSbQ1up5uBOi7O
         QKwVHkBqoGl0j3SY21iEALAxVJko8XCjErfJGxbe0kdfNdcR4izxv15sdt1uTw1+gXrF
         QeIkhWy2UDJVh/PN6Vt2g19bgnTeIY7NP87etl4nEQVo+FRLLLou6+58lxY5GR5REeTB
         Xoww==
X-Gm-Message-State: AOAM533x+EKr9ulVfXYRJWglKUbC1gVIOHEB/inaYlVBzpH1ZbuyJift
        BFkpJB/Ab+QKXaqmXunrWvYoDd/p3ftCOyCfryM=
X-Google-Smtp-Source: ABdhPJzj90GzKVMvuigvCbMYK6QaClIQIGsSj4o9T55BNJMS+gKSjLMfX+sql1HcMcsIKDElrvqSZjS0mJLvMJ7GhxQ=
X-Received: by 2002:a02:b047:: with SMTP id q7mr3722748jah.130.1628155217097;
 Thu, 05 Aug 2021 02:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
 <1627098243-2742-3-git-send-email-dillon.minfei@gmail.com> <CACRpkdYReUdg_7oSTqcsA_+9tS9w6MH90=KV1rGyr4YWT=NW-w@mail.gmail.com>
In-Reply-To: <CACRpkdYReUdg_7oSTqcsA_+9tS9w6MH90=KV1rGyr4YWT=NW-w@mail.gmail.com>
From:   Dillon Min <dillon.minfei@gmail.com>
Date:   Thu, 5 Aug 2021 17:19:41 +0800
Message-ID: <CAL9mu0LfcLS1iNQnamxA_oTrxu8eEBpUm+u92V2d9-8qz6hvow@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] ARM: dts: stm32: fix dtbs_check warning on ili9341
 dts binding
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre TORGUE <Alexandre.torgue@foss.st.com>,
        Peter Robinson <pbrobinson@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        kbuild-all@lists.01.org, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Thanks.

On Thu, 5 Aug 2021 at 17:11, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Jul 24, 2021 at 5:44 AM <dillon.minfei@gmail.com> wrote:
>
> > From: Dillon Min <dillon.minfei@gmail.com>
> >
> > Since the compatible string defined from ilitek,ili9341.yaml is
> > "st,sf-tc240t-9370-t", "ilitek,ili9341"
> >
> > so, append "ilitek,ili9341" to avoid the below dtbs_check warning.
> >
> > arch/arm/boot/dts/stm32f429-disco.dt.yaml: display@1: compatible:
> > ['st,sf-tc240t-9370-t'] is too short
> >
> > Fixes: a726e2f000ec ("ARM: dts: stm32: enable ltdc binding with ili9341, gyro l3gd20 on stm32429-disco board")
> > Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> > v4: no change.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Please funnel this patch through the STM and ARM SoC tree.

Sure, I will let Alex know. Thanks for your help on this driver.

Hi Alex,
Should I send v5 with Linus's Reviewed-by tag on this patch? thanks.

Best Regards
Dillon

>
> Yours,
> Linus Walleij
