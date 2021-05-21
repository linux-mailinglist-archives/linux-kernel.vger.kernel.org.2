Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C1538C848
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhEUNis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbhEUNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:38:38 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194FC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:15 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k16so20112674ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUwH+KODosjJUjMPg9IAKpCYIeQTuD5ncp4ytmLDie0=;
        b=aNjUpsBMwnoOWHtnNBd+eSQErCc858AmiFEP8AvYFaSagPhuT2fvH7rWkwTQrxL3Ul
         fPQuXIHHlGeGl/q0PP1aGI95i/ejhMMhqyZj8xZ83N5Gi5u4DwSpdQ42Kux30GWa0Dxa
         5nutkCCxQacYk5uzd8c9V3OjMbVMMkdZF7/z8/u1bl4RuxT1AbCZwCGAHwK4Bok/smgf
         HPnOFo21uoQlN5DHATaQBTF/titNesNJzFGRuMT1Kn88ZNy7LAvqXKy6krOEp/HbkBsN
         WuDy6oTZ+TpSRrV/UIoatZ+O2o+lvahPUFfexxgnME6b+6Y3p34HA3eCy2+umxnB5ZiS
         NknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUwH+KODosjJUjMPg9IAKpCYIeQTuD5ncp4ytmLDie0=;
        b=Yc5v4rKDlwET12ifPgiDEAQQf2+OGWp4tLhBcM574VZ1tFQZxY8ylkFTH2V0QjhVnV
         ZyKRvYDXGzEqpK/Q4h4E0i8S0SpJUYMijq1MfNKpx/+e3not8c7u/veopnR41S9gAd29
         X+raaXt8obmI976FazFGN1PdYGQISizwknYWcPToOyMmMZv1Hz2XXXzpIklOiygrhMiK
         FV3aZZUZEHFgABsvX3zIruTmtZHOXZca9SLnpZss6qjWaztmBpw8bsdcGq8ZxE+UCVMj
         kMvKx9R+HO533aBL3djli7ro8Y6qAdtq59P4GLXJKCRpwCnxVH7Gc99dEwO2rgm7qbEs
         G+9Q==
X-Gm-Message-State: AOAM531mkLwMkbfnTBVwKA7dP2LTMeiF1KUMCnSP0x24Rz8V/wdkg/iL
        KTfmYxnbKDhyWs/tAixRQSawMBSYLld7z5YNi8OKPg==
X-Google-Smtp-Source: ABdhPJzYJYUU4TXfu6NnTqNo4nok573ifIKYNvqaNAYKOX06Pzb5kUyxROhQJWDiS7PsLu06XjkoCqwZdt9bQjGdtK8=
X-Received: by 2002:a5d:9744:: with SMTP id c4mr12255133ioo.76.1621604234778;
 Fri, 21 May 2021 06:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-3-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-3-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:37:03 +0800
Message-ID: <CA+Px+wWf0JphnZOMLh5d0Q0DP-b32Pk4xzTE9cADHEXquUsLhQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] media: mtk-vcodec: vdec: use helpers in VIDIOC_(TRY_)DECODER_CMD
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:30 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
