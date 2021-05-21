Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD638C843
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhEUNil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbhEUNid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:38:33 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:10 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id l15so13072722iln.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOxukUP4jIrT4sl1iFyJVxJdWx5J7pFUcynvJLSMuxM=;
        b=c1dx51qHrwD5aaCshUIp6eeEm5WABOQk4ytjO09vCI4TEEK7opgsVS+XHPnEunkJ7F
         w13th/NxTytTPbVBSewh40x8g8OQx4xTpImb8PblIt6tAcfGRE13hTZXlP67q9qG1fgn
         QLhgjjB7gz0WDz3O4dZ/mDh/lkSc7Cvlg8y1J80G6/5xct40gLUMQzjEgoyOyg+X9aLC
         gYFPg6Msv/chUf67TngUnnXsk5g8WB/3zx4ECYOOiPP3WawGE77DBwTn81kYkcNFU4zJ
         2OdQhWbO5Nbl4nWXqaMYTUIbUXS72HUg2RI58+LZ4L6H5Xi2qce+1+LUf4N/TBqPa946
         PI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOxukUP4jIrT4sl1iFyJVxJdWx5J7pFUcynvJLSMuxM=;
        b=kdQAdOg9Jl7YzpWi0kKkPLporMrtKvTcZQUfXnyHDSc58ne0wIFxAkEdxAoDN4WHYg
         fPqmdrROyxzcmHKVu5+avO7XZaSMTyqa3VGB0DcwNIpXchlRwph4bwNdE3n0HpqMDrXH
         bSML2BRjNlpHsOAB5rTPHQLQOIKyxChUm/TEY1o/qCjId3bsxx4gkuwQ9B36cpNWDKdq
         bSAq800pIp790kLeVugQVeRicWtjKS4KdRRw2x45dE9haFtRnCPRC2vw8grgPTRcUTbN
         D0Q8JNmBwG9FdqTQJ1PISszIJse5GDMah19VF3ENpkbaFWB43gGRo5h2uo4uk73XZqNn
         5i8A==
X-Gm-Message-State: AOAM531hDcuDElQowZaggr7NrQBI0a+Vp5RyQkfKIooZTJ48wlIIzlH5
        tAhsSOBquFa3CIxIDHSEdYnHtr1ooPGNRvPcIexT2A==
X-Google-Smtp-Source: ABdhPJzEiyCios8dWI/Acg2dtT/0zWtA9aBNoDZXPirEUp2D/T+FjiXdNJf5mkQUXPKh50k3T9wd7lZpe5lr8WVOUow=
X-Received: by 2002:a05:6e02:92f:: with SMTP id o15mr13043037ilt.127.1621604229383;
 Fri, 21 May 2021 06:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-2-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-2-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:36:58 +0800
Message-ID: <CA+Px+wV8_rCxH=OuwjeUsVpL5Vk5kN_BymA5QRjwhDOUn-iT6Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] media: mtk-vcodec: vdec: Support H264 profile control
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
        <linux-mediatek@lists.infradead.org>,
        Hirokazu Honda <hiroh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:30 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
> Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
> [acourbot: fix commit log a bit, move to mtk_vcodec_dec.c]
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
