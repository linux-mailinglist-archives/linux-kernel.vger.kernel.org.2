Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC137F3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhEMIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhEMIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:08:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D47C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:06:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2so37396182lft.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QctHHCbUmE9SKQZkFUYr3/NvHKRxwu7+aZMbj4K6Y0s=;
        b=UrrG78ANjwlxHajiwC6dWsS3HzweOg606bt2lUOLuehAG0yrzClCg+WnQ0OA8yEZ78
         47htgMiPMZbkfnutDCbgJjY/yD2njfUY02gXJjoSBRfX8TE2VQqMxdBldwSqe75XwGoS
         WLbz2hWUhZieap36G1eSpFvx0qXG3MmxZqtUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QctHHCbUmE9SKQZkFUYr3/NvHKRxwu7+aZMbj4K6Y0s=;
        b=d7ZLFBzXhWYOsJ8uDeMPRa1JpEEpArKYKZfhZWKZN1LYb3O5VOwZwHezdDWjYxZSPk
         f+LaiSTidfA2P0tT0Y2QFmKzcvIrcTOlVE2QNTShmuVUoRXlJLmtD+nOYZJ5hW2reaGZ
         jvKIPZepwYyJydHjX0U45bxPqazKQGRz833FAjbdqctFAOs0tkr3XIM06XvNVauTaY5/
         Ke5fEYFH4F4cyly3qjJEKOZpP9qMAvMUT/3IN8mKNauEY9yCDmDu1vRG38hdBSdxI953
         avaYzu/lYGiHcFwe7KRCGyPS5T5WeEEnfZ4GzorCOjz8ASM1l6H1TEUVHqgCG/zq/ROW
         +0tQ==
X-Gm-Message-State: AOAM532QfanfYyqJaCVxMsw1I9ifpk+wWeXJ8VWUHq5AGp+RKohsqu3E
        vyfxUuKMdDBxJMIhuxqeJj20E6JkKIIvPw==
X-Google-Smtp-Source: ABdhPJy9cqshekviOpJQ7wKF47LMiF+Rn/uxEnVrn4IQiPof3ps8/FcqL21PSXbSquykFalNhZgxPw==
X-Received: by 2002:ac2:5295:: with SMTP id q21mr26663717lfm.108.1620893208152;
        Thu, 13 May 2021 01:06:48 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id y22sm215741lfl.36.2021.05.13.01.06.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 01:06:47 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id j10so37372894lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 01:06:47 -0700 (PDT)
X-Received: by 2002:a19:550a:: with SMTP id n10mr14675259lfe.403.1620893207308;
 Thu, 13 May 2021 01:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210427111526.1772293-1-acourbot@chromium.org> <34782bc5-d891-8eef-d370-6cfcc547166a@xs4all.nl>
In-Reply-To: <34782bc5-d891-8eef-d370-6cfcc547166a@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 13 May 2021 17:06:35 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVykfSzXEA5_CWBpr84QduNDx24-aaf=0MUfxKcK69N1g@mail.gmail.com>
Message-ID: <CAPBb6MVykfSzXEA5_CWBpr84QduNDx24-aaf=0MUfxKcK69N1g@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] media: mtk-vcodec: support for MT8183 decoder
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 4:35 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 27/04/2021 13:15, Alexandre Courbot wrote:
> > This series adds support for the stateless API into mtk-vcodec, by first
> > separating the stateful ops into their own source file, and introducing
> > a new set of ops suitable for stateless decoding. As such, support for
> > stateful decoders should remain completely unaffected.
> >
> > This series has been tested with both MT8183 and MT8173. Decoding was
> > working for both chips, and in the case of MT8173 no regression has been
> > noticed.
> >
> > Patches 1-9 add MT8183 support to the decoder using the stateless API.
> > MT8183 only support H.264 acceleration.
> >
> > Patches 10-15 are follow-ups that further improve compliance for the
> > decoder and encoder, by fixing support for commands on both. Patch 11
> > also makes sure that supported H.264 profiles are exported on MT8173.
>
> For a v5 I would recommend that - where possible - these 'improve compliance'
> patches are moved to the beginning of the series. That way they can be picked
> up quickly without having to wait for the whole series to be accepted.

Makes sense, the current order reflects the chronology these patches
have been written, but I agree that improving compliance should be
merged first. Let me try to reorder things a bit.

Cheers,
Alex.
