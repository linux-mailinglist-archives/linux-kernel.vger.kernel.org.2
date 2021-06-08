Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619363A057A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhFHVFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:05:50 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:33323 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhFHVFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:05:49 -0400
Received: by mail-qk1-f171.google.com with SMTP id k4so21729982qkd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tI5apJy6qAcGNcp49inXli13iJ5zzU/EHf7L81CBh78=;
        b=JMUKNYQ/Uorm1mPfiretBAqd1KKOje4jcX9qzjAaDdhKuzgxVOlRkeNXNuGVt9waek
         lVUvoKhsvypiE9mSDAbMSjUU6ys+QrVwF10LQw+K/iw41mnZ5/fonFLU+LzFfeaqRfju
         m5Xk+XBo/o2olnwXRL/YUwjnu9PT4U7LZ9xkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tI5apJy6qAcGNcp49inXli13iJ5zzU/EHf7L81CBh78=;
        b=E/KBH6JHzTkrkqJR8UqeEZdzIV9B/0gPXp/QjxSvOXklwYlq+kaeuWa0tKX1gElA3U
         Hlh/hjZ0i+qzjUlh0nhmqJ1+NWkeW4eV1yrQLkLqgj/yP87xNKxSX9VVNk2dADqEWTdO
         yu4XnSrPwLGhBxOacfTMMFFpYA7qOwsh+t1IN8XHYJCJRBXR6i2P40WY+R0YVID/9VbQ
         1iNDpwsXGMavChObCrLIdtSQ2g679DlkEykb0kenuiEmkH3L1FU0Z02ILnee3VHsPkqP
         ido3Zd5fFEYg1h9rFmzoaOjkYyiGLuquobKWw2qOycPkxavZuRmQErCk39mWKoLupia1
         TQEA==
X-Gm-Message-State: AOAM531TPZINUqAqcGT/Cdhqbd6eJ/jbDSw96Xef53Xi8hApGR5GuF5I
        W/R3IozlTBbbLThmDcf9nCDVeM1yUW2TtA==
X-Google-Smtp-Source: ABdhPJwjkGXSjizYr5iYxlPqH6qdRB9/Dms7NIMexgEKFHE3/E0PdfudZkt5EbIAidcdC+xE3u85SQ==
X-Received: by 2002:a37:62cb:: with SMTP id w194mr12956268qkb.83.1623186175269;
        Tue, 08 Jun 2021 14:02:55 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id q64sm6063177qkb.73.2021.06.08.14.02.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:02:54 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id g38so32179287ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 14:02:53 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr34051315ybp.476.1623186173429;
 Tue, 08 Jun 2021 14:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <1621927831-29471-1-git-send-email-rajeevny@codeaurora.org>
 <1621927831-29471-2-git-send-email-rajeevny@codeaurora.org> <4df7dcddd5aca799361642ea91c37fa94e8a4fef.camel@redhat.com>
In-Reply-To: <4df7dcddd5aca799361642ea91c37fa94e8a4fef.camel@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Jun 2021 14:02:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wy-a_rCrx-mjDwr07CN=281ZyomVX7dcFiWrzFExcTTQ@mail.gmail.com>
Message-ID: <CAD=FV=Wy-a_rCrx-mjDwr07CN=281ZyomVX7dcFiWrzFExcTTQ@mail.gmail.com>
Subject: Re: [v4 1/4] drm/panel-simple: Add basic DPCD backlight support
To:     Lyude Paul <lyude@redhat.com>
Cc:     Rajeev Nandan <rajeevny@codeaurora.org>, y@qualcomm.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lyude,

On Tue, Jun 1, 2021 at 3:20 PM Lyude Paul <lyude@redhat.com> wrote:
>
> oh-looks like my patches just got reviewed, so hopefully I should get a chance
> to get a look at this in the next day or two :)

I'm going to assume that means that you don't need extra eyes on your
backlight patches. If you do, please shout and I'll try to find some
cycles for it. I've always got more things to do than there are hours
in the day, but many folks from the DRM community have helped me out
with numerous reviews over the last year or two and I'm happy to pay
some of that back by giving reviews if it'll help move things forward.
:-)

-Doug
