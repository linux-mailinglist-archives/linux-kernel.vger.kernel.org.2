Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFE23E8F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhHKLQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhHKLQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:16:09 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BCAC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:15:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n6so3912056ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4L1scxTWu6C9n26vo2qgoZeLEILa/cvadfoeBRn16c=;
        b=PBc4H6TCN8oNeqbaSgDwDWagMBXKbNt1oKWB35rQaKRrQtpSKCgtaCrQCExT3sbXU3
         EtL2uzoqZr4BiELxdl+Ag+4acwfWjjW1GXa5Qc0sjQzLjVwazoUZaGYZc0MPqNoOImuN
         erckDhpJnqjfJqupW69vQsiXFvAcQyHG1nvsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4L1scxTWu6C9n26vo2qgoZeLEILa/cvadfoeBRn16c=;
        b=oBNEVaK3w+yrG8YxiCgxT83ArGPWVsUedZKhAiLFwAO/PCMgXuZWhnYOLMpvvdjItL
         9B983BrZ4EkvVJM8Rxj8ONK8hWCI/9xtOEEcTM6uI+qj6mDhqtwVnz/n2VAuE+RZ7uBs
         /iwNsiSsvAzkMbPlUkWBCX8qvtuRTsdSfSycd3VGrvchPupqG70LTh+8uwutVoKMgOVa
         Sw60MCGhuCko+fSALYybdAFwOyIfie1aNngGe/Ito42OWYGyHhWsZHChaBclcsny08R4
         kSeDO4F35kZFLCt6ihDec6xhzFs+f0WWAHw5DdfZlRJtWENBzkJgnj/nRSxLAilKxsGw
         Es/Q==
X-Gm-Message-State: AOAM531Kk55JUVStOUbO68NqkkqpZ5uoprrsof2peTh5z/Y7jLgdy8TA
        11NaCUXTBjoUxDKvp+EtD1vAbD9i2RfwaAnl
X-Google-Smtp-Source: ABdhPJxqQuTVPH+lde1iKvhkib30mdLjNIjK75c9IrHtt1gcZndAvCCsg6VSDMZRi+bfzpUJaZxpfg==
X-Received: by 2002:a2e:1658:: with SMTP id 24mr22708952ljw.429.1628680544061;
        Wed, 11 Aug 2021 04:15:44 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id x22sm2329815lfe.16.2021.08.11.04.15.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 04:15:43 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id c24so4846206lfi.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:15:43 -0700 (PDT)
X-Received: by 2002:ac2:55b4:: with SMTP id y20mr24729347lfg.33.1628680542749;
 Wed, 11 Aug 2021 04:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210802121215.703023-1-eizan@chromium.org> <20210802220943.v6.2.Ie6d1e6e39cf9b5d6b2108ae1096af34c3d55880b@changeid>
 <0aff1abb-734f-c714-6ecc-c906862255c3@collabora.com> <CAOak1e8n6JpNKODfM57OTtbCNz8UBbj+wefwipVWP_Ep6SHmHA@mail.gmail.com>
 <014b8075-8588-d741-e6f2-edc0567e8c8f@collabora.com>
In-Reply-To: <014b8075-8588-d741-e6f2-edc0567e8c8f@collabora.com>
From:   Eizan Miyamoto <eizan@chromium.org>
Date:   Wed, 11 Aug 2021 21:15:25 +1000
X-Gmail-Original-Message-ID: <CAOak1e-+v1e+x1SE_Pr2T8eH+gyLikBL6J243ry5tkWAVVx7tA@mail.gmail.com>
Message-ID: <CAOak1e-+v1e+x1SE_Pr2T8eH+gyLikBL6J243ry5tkWAVVx7tA@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] mtk-mdp: add driver to probe mdp components
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     linux-kernel@vger.kernel.org, wenst@chromium.org,
        houlong.wei@mediatek.com, yong.wu@mediatek.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        chunkuang.hu@kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On Mon, Aug 9, 2021 at 5:53 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
> You can send it also as a separate patch. I don't care too much.

Great. I've sent a separate patch to make mtk_mdp_comp_init static in
https://patchwork.kernel.org/project/linux-mediatek/list/?series=529639

I will continue with further work to use the clk_blk_* API.

Thanks,

Eizan
