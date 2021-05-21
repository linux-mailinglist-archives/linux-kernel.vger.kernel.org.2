Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C238C84A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhEUNiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbhEUNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:38:44 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C2BC061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:21 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k16so20112989ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUwH+KODosjJUjMPg9IAKpCYIeQTuD5ncp4ytmLDie0=;
        b=dX68k/vqLQj7dEmcf+9f2n2EFSx4AmpIebAbLKUYMqcDzhpqHtyMUTDlaIANEMTQsm
         187GxMYB9OrBNQXrUvvJsaluMvSvkVPpAgNcjbmQrMAbHPDBpKlkosomU3fskO2L94+F
         srMjBjOya61XzRSzr6ZTQ15Juai3s2sPr3JfdrASXUTXuNglJjhDPyCGG1IEx+w2+r8I
         rb5kjSSUJZF1C61Gx5ydkY2g4qx9FtuYgDN2uHBsWWg2M+KQyf9dLUZc9sLu83O9gc1w
         3xAu0b+0WxrjaE5tTOGlMbzaEFgEEmEVg2ok+Rx1idLZMDGFyqCYaps1Iqj/WFAbc0rx
         j3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUwH+KODosjJUjMPg9IAKpCYIeQTuD5ncp4ytmLDie0=;
        b=r0+sdW2jCtH1NrFFpCUt/FM3D+v6QVRBQ8kJJoDoKFvAIwLzAPEdJpM+UTTZbuvGhd
         RjKREkQKV4F/HLDM2hzOMG+9nWlTPkt/NkwhFMQZF7WkQoriYgKNJlx2qOqPtoAidhIc
         ClybbNWgMGRsacCh+rI7Oeu340GV/ApU6pYXqa4H+d0hJM8JJh9e8IvBkGXvfwbWHb6f
         luiK4RJD/wsweaHmI4QGKXi1dL+RuuKyJAoD/e/bBFtmLK2xUiJ39T8/YS3zCzEF5ntd
         1OeOBJ1+s9OqRM3j7gZuW7ZpDAogNpx1/dZhri5nZ94Oo0+fJrs1oaWeiHHBS3suDuKa
         C7Yg==
X-Gm-Message-State: AOAM533f6aE63qne4MwGHEqedlp+fW1d/QYE71Vm9LyxXi8PUph5ZXfh
        P4EGrx9nl7brl+Ygeb0UuzwjGiuf3VcmDoanN8h1ZQ==
X-Google-Smtp-Source: ABdhPJxErXiEqANMcxd2fY+DnyF8+B5zbKwXCw+ONC3YxWp9MxJ/qb64jURWmaHd53lAI1/HJu6xOy0eGOwj7DmXTHo=
X-Received: by 2002:a5e:8c11:: with SMTP id n17mr12081480ioj.53.1621604240549;
 Fri, 21 May 2021 06:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-4-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-4-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:37:09 +0800
Message-ID: <CA+Px+wVAAg95YkB4nXb+Emr8Ce5GpfoHhUe5B4iUViRWdfVCZA@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] media: mtk-vcodec: vdec: clamp OUTPUT resolution
 to hardware limits
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
