Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A5A3C5D99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhGLNss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhGLNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:48:47 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFE9C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:45:58 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id r9so7226540ual.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/y3AswAn7xrfStWckKQ4mdfAYQv8LuashoWFVm7wmnI=;
        b=JIUoCU9T0XfyuPyJPuVrcxCa8UoWsH/qeP/iWmQomkfVNKt6Mnzy8lEYTsbBLAjQDY
         qA2lrYcGl7R7GwRo7zb4EcRYe0d2sy5LWLilGAQERXHWRpwcRsU4AXvQl2DgNurV6j9N
         GaO1ghyx3qKRzIY5oEx/5Ib8QbPhKF1MbPyX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/y3AswAn7xrfStWckKQ4mdfAYQv8LuashoWFVm7wmnI=;
        b=iauZQ8ISnqGMT7SEJpxH6ILo5pvWv4ofnWMOJPN+/dqlSecDNUQga/TGCKwGvqXxhT
         2JVFZ7eTaiyhrsXXyumVi5r659L3EBCLzUoF6iONoM1vYziuGKF3vaWkjd4T6cwQneAS
         DmvUKnXQcU2F/v89fD+ojW2esYv3+gGywePTW0zP3DUbhdhuJ+Om+93gn+MC6NLXceNK
         7lCAqphfuR3WXqvopouA12ebplNgyGzMuDEeeBT6PBeHI7f0Em7znBfYb0jy7DRRiViC
         JAuNJS3LYsG/mIN/Kjkp4VaFUtKao2uuyewG7ELyiYphzT3zvqzvlq3bQDEoRnVtHbmD
         XCxw==
X-Gm-Message-State: AOAM530xhhmEfBETZWWmxKQX5h1rEE+JmqmiZlvRBnMwx2ha+XaZlZhG
        yQtrK+AwjTcMROU65QLY8bEw1UFDTx77Iw==
X-Google-Smtp-Source: ABdhPJxcJHGk6UsIyNFSfSQU+HSGPNCN/Mg54R0afC4e68iCQu8ihw91JCKPRoEzOk9ww3rBnD58lA==
X-Received: by 2002:ab0:1e8b:: with SMTP id o11mr27920698uak.49.1626097557223;
        Mon, 12 Jul 2021 06:45:57 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id w4sm2019913vsk.30.2021.07.12.06.45.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 06:45:57 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id d2so7239638uan.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:45:57 -0700 (PDT)
X-Received: by 2002:a25:3486:: with SMTP id b128mr71633896yba.523.1626097181672;
 Mon, 12 Jul 2021 06:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <1624726268-14869-1-git-send-email-rajeevny@codeaurora.org>
 <1624726268-14869-2-git-send-email-rajeevny@codeaurora.org> <7f8562df-7e1f-dcfb-1c58-f1edd9dcc606@suse.de>
In-Reply-To: <7f8562df-7e1f-dcfb-1c58-f1edd9dcc606@suse.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Jul 2021 06:39:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8CaKObbQTCsX2GrP=O8aJUaWLZY3zgBMRATtSn6Be4g@mail.gmail.com>
Message-ID: <CAD=FV=V8CaKObbQTCsX2GrP=O8aJUaWLZY3zgBMRATtSn6Be4g@mail.gmail.com>
Subject: Re: [v8 1/6] drm/panel: add basic DP AUX backlight support
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 12, 2021 at 2:41 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> > +     ret = drm_dp_dpcd_read(aux, DP_EDP_DPCD_REV, edp_dpcd,
> > +                            EDP_DISPLAY_CTL_CAP_SIZE);
>
> This creates a cyclic dependency between drm_kms_helper-ko and drm.ko.
> drm_panel.c is in the latter, while drm_dp_dpcd_read() in
> drm_dp_helper.c is in the former. Please fix.

Yeah, this was reported Friday and I posted a patch to try to fix it:

https://lore.kernel.org/lkml/20210709152909.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid/

I see Rajeev had some feedback on it. Once I've dug out of my weekend
email hole I'll take a look at plan to post a v2 ASAP.

-Doug
