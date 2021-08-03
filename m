Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190CA3DED2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhHCLtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbhHCLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:49:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF009C08EACB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 04:47:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r23so27771428lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etK0elpS05hz7Km273394Meji45lu69rkvmUfpsPSIQ=;
        b=Tfds44W/7N6OvbAyP0TRdJLdBh4VucrnQroHeSiqwZDxfmA/2aGndP7kOTFdbAzzVv
         qffehGnqve2NBSPHMYGdm9DisaX3EvAc4/s09ESqikbBbjAv9wW0b59PQCadqWSEVKKC
         Rty/MzA4FfFXkICzwfYucun6omh3dosNSMpc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etK0elpS05hz7Km273394Meji45lu69rkvmUfpsPSIQ=;
        b=EjGB/tsa7yh+Icha1vpocQ/VlMj0XIuJKwAtY8a4b0DsCkyKPesjsiGnS8OhIKiAoE
         W5Yj2p4q/i/IsOS7OYilHrGbm000nn/ei2XcouTWDkF3CnEpIkO0YGcdmTM7eT5/c+jt
         7+ae10PX121Gh3iYOjks2Y3CpdN7A7sEk734OKHLSa0en49vR75QZXsnxfltXWNu0AS1
         qBl//PwYZitzZSDA9n3/4H6LS057bc6E3N3aa2WG73eXnQBnKVBYpTT3kYpLcj0R3yX5
         odOCiBGzgxZqUJz3vDP1qQ40M8x7iRYM43DTdIZKdChDI4CECAY5kA+v76BxMg0RUuK5
         Kblw==
X-Gm-Message-State: AOAM533/TiBULNGZQMsP7BaezMYZ3nZyei9IuYsr/C/V394360rFdxLs
        uPRiyuKD2V3DK5iQWj0L/bYi0SEwNRcMww==
X-Google-Smtp-Source: ABdhPJxnRA2BAOxC6TRmilDxX1tpPYN4h8hiDbQTwdPteQ9Out36rXL/JS97V18KToOow+cUZOx3EQ==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr14017249ljj.498.1627991220971;
        Tue, 03 Aug 2021 04:47:00 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id c3sm1179780lfi.199.2021.08.03.04.46.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 04:47:00 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id u3so39212965lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 04:46:59 -0700 (PDT)
X-Received: by 2002:ac2:4433:: with SMTP id w19mr6028378lfl.30.1627991219371;
 Tue, 03 Aug 2021 04:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210802121215.703023-1-eizan@chromium.org> <20210802220943.v6.7.I2049e180dca12e0d1b3178bfc7292dcf9e05ac28@changeid>
 <CAFqH_527RL56P=zEg7yTaeeqTvFOjT3ThxpX-Qumk25dR6+-bA@mail.gmail.com>
In-Reply-To: <CAFqH_527RL56P=zEg7yTaeeqTvFOjT3ThxpX-Qumk25dR6+-bA@mail.gmail.com>
From:   Eizan Miyamoto <eizan@chromium.org>
Date:   Tue, 3 Aug 2021 21:46:42 +1000
X-Gmail-Original-Message-ID: <CAOak1e90y_2aaD4ssH9WfqUUXjUSWkN_rLW51NujkD7oMayhew@mail.gmail.com>
Message-ID: <CAOak1e90y_2aaD4ssH9WfqUUXjUSWkN_rLW51NujkD7oMayhew@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] media: mtk-mdp: use mdp-rdma0 alias to point to
 MDP master
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree <devicetree@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric, thanks for your comment.

> > ... Instead of depending on the presence of a mediatek,vpu property in
>
> Looks like there is something missing in the commit message?

That line is a continuation of the commit message header, I.e., it's
meant to read:
"use mdp-rdma0 alias to point to MDP master Instead of depending on
the presence of a mediatek,vpu property in the device node"

Eizan
