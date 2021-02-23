Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D48322FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbhBWRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhBWRm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:42:56 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BCBC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:42:16 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b8so16407452oti.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuxpnNTlbfa73guZtbI9Nhw2M5eDcrgPYdz+56/6dWc=;
        b=nL7g6q8SnspLBcq5aEvtCrCr3oFPtCOiDmIqpH/qqMlZziUJUYYGB1TYNT+enHAzgr
         Z/OFIDGQk12kO0nGCzONaDmuuJkcrMZW3UcTYlvGR3x01ZHu4IubuwwkkEsbGEx6rfB9
         Gp4r62k2MmPgvJZ2mcXa2KPrtsuGyggwln1hhuuinLpX2/BXFTN8W+xUY2JFqSGQwqVg
         UfuMuwBpwNUNjETK1v+CMb9oBmAX8WW3TbhX15OdSdenJdqRXNEOIs4pig9/Cu8oSbs3
         m1a9vdSG/Qn5S2k4wq3EUYQXMdDk050JMfAay/4u7wdx5YeQJadfrZhpZYSAiKcrTdhX
         lPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuxpnNTlbfa73guZtbI9Nhw2M5eDcrgPYdz+56/6dWc=;
        b=iZomAClCTpPTRqn1LzqZlrzwieqw2H2CtBZys0mwoXlpXFKbGfnhdUEHPqDISpPuas
         sIVPAQc62ySrcnuISKv8s6AHHKBtLowT5lZMWBJqv51/u7tnx01LAt3o/OVs67aAZn1B
         eQmflOmZDzSyLngprEICLZ3VaC4i8lLPNn87ymo/WV04YOnj6B5bmOqQ+N882PCBT+jh
         w3klwiu4zFK6a4pawcy3ggjRB1lpsAMpHfgTtpPiLrZGN91ZzEHO28D84FFZvK2DKpaG
         IV4QDoEB+Sww0SEQC9dTEwns2cRMyVg2CBfG7cjlK5SMKJMzOGneAOKkAsdYamq0oEVV
         8mbQ==
X-Gm-Message-State: AOAM531B0/ycIqFX0pHtW3jQtX4RXnx6bQ2NjhsAFcJtTCkCNORyHaXt
        VvRxQZd77CdVdwl6JVeCnPGWiBYnUr+P/2xQCQvRe2nZf7Q=
X-Google-Smtp-Source: ABdhPJyjUKxqV7AOCUKsVQCtpD9QXKbaGWwKvSlqdCwpSOtCsB5w2Yrh1m7QIxBjt6ChpY/dQqLXO/Ytyja4DaevaZg=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr10635173oti.132.1614102136101;
 Tue, 23 Feb 2021 09:42:16 -0800 (PST)
MIME-Version: 1.0
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
 <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr>
 <20210222234457.GA36153@24bbad8f3778> <yHvp7KbQD2pF5dR6krMc_Zuq9a8GxkYSSiIpjBenuiCjwpFmFxpAOpfzhp0DfHQhH2Z3P81-CGpwmmXp0zjifT93vBXXYd5kJsSucQgXFZI=@emersion.fr>
 <CAP+8YyGdr0jkf5_K8ofKMzZn5Koy_vkxyKKHkyVDqDz2sWvL_g@mail.gmail.com>
In-Reply-To: <CAP+8YyGdr0jkf5_K8ofKMzZn5Koy_vkxyKKHkyVDqDz2sWvL_g@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Feb 2021 12:42:05 -0500
Message-ID: <CADnq5_MXK_H-g4GReU1dGca2PAXsGjbzg47kcWjXFQ4DrYG8tg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
To:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc:     Simon Ser <contact@emersion.fr>, Stylon Wang <stylon.wang@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yeah, fdo ran out of disk space so I moved to gitlab:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next

Alex

On Mon, Feb 22, 2021 at 7:26 PM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> I think Alex moved to gitlab for his branches
>
> On Tue, Feb 23, 2021, 12:50 AM Simon Ser <contact@emersion.fr> wrote:
>>
>> On Tuesday, February 23rd, 2021 at 12:44 AM, Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> > On Mon, Feb 22, 2021 at 11:05:17PM +0000, Simon Ser wrote:
>> > > On Monday, February 22nd, 2021 at 8:25 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> > >
>> > > > >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:38:
>> > > > >> warning: variable 'i' is uninitialized when used here
>> > > > >> [-Wuninitialized]
>> > > >                            timing  = &edid->detailed_timings[i];
>> > > >                                                              ^
>> > > >    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7:
>> > > > note: initialize the variable 'i' to silence this warning
>> > > >            int i;
>> > > >                 ^
>> > > >                  = 0
>> > > >    1 warning generated.
>> > > >
>> > > > Initialize the variable 'i'.
>> > >
>> > > Hm, I see this variable already initialized in the loop:
>> > >
>> > >     for (i = 0; i < 4; i++) {
>> > >
>> > > This is the branch agd5f/drm-next.
>> >
>> > That is in the
>> >
>> >       if (amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
>> >               || amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP) {
>> >
>> > branch not the
>> >
>> >       } else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
>> >
>> > branch, where i is indeed used uninitialized like clang complains about.
>> >
>> > I am not at all familiar with the code so I cannot say if this fix is
>> > the proper one but it is definitely a legitimate issue.
>>
>> I think you have an outdated branch. In my checkout, i is not used in the first
>> branch, and is initialized in the second one.
>>
>> https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c?h=drm-next#n9700
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
