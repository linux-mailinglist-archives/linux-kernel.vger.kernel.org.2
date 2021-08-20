Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8750C3F254F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 05:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbhHTDaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 23:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbhHTDaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 23:30:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D886BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 20:29:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h1so591661pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m0sG6HNEqWhqC0CeVVryRPgZqvHD/ht80kWZ9SsRV5Q=;
        b=D00ouktdQh5MbXzxcNc6u9fD9+yFYjduyXj/ggJG2HjjkeiB6ybDKUgSwcv1gbKSpV
         jq1SU1lO9XHuwcb2aFzzAhIuPSUsiE70Bp74Qo4zTlUIRiGwsAujiFed2M5zKISDeD1v
         ci94pzNGtWzMuN5Cy32TGj85vvbN1bKIoruAhxen2YVEO7i3OZ7XJJ+B9CTcse9FyK+c
         DxiUqPuEjRZeQkoKziqQzf8K8hR5aAIh87qQ/k+WkAcc/tQk5/NO/g+tElhuscvLEmau
         UsYy+DVAEUeWW0d7QVPnfNe2u1Jnu5/K2XexzZdcJb5U2K18yHYnf+8Ne8nhCJHl3Yz1
         PITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m0sG6HNEqWhqC0CeVVryRPgZqvHD/ht80kWZ9SsRV5Q=;
        b=Gpl/N8zmyW3MK2MUTzrn8O8JbUkfSv5OCBmRxT2Eq9gv4Y9Y/4mnMDi2Afke7mSFq7
         eD/YsIvO6glII2Mq2/yGIpThcArZc9umFWJ4SNcxih8A79Onm3vtKJ41aj2rJqY/ahPr
         cbLfYSXv5LHU/eveXy67L466AVzIXBUjOBt1iElNYvZTiDk5lyT6J+dy5j5D3jluTA1y
         WNWw7lMRJbmBZL6bLd/j/n35l5srv8HcjCTWjwDYtg29BXrCI4FIJQ/kcjUr+l1Pc+Y4
         Sw/gqRB5jRE/eg3jF42qjWuNH2IfelD08lQezykPRY7BDaWW+tIe+6fsW6mAOO9HXSaV
         oE5g==
X-Gm-Message-State: AOAM531WpJVJsJTV0HUKRAPeS8GRp4ELoZxCxCOGyqNEtdxqMNkMURDm
        rzfV/CyzF1o/4S2sZAQiYXmM/g==
X-Google-Smtp-Source: ABdhPJzsWONpn/nU+p39za84qQxpK6KZY9p6xu70i+SP/EhBA6Jmd3xqATtzwKo2xEmQ8jepckPaLA==
X-Received: by 2002:a17:90a:fb97:: with SMTP id cp23mr2346062pjb.93.1629430177117;
        Thu, 19 Aug 2021 20:29:37 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:549a:ad5a:e5bd:8c8a])
        by smtp.gmail.com with ESMTPSA id l2sm4864369pfc.157.2021.08.19.20.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 20:29:36 -0700 (PDT)
Date:   Fri, 20 Aug 2021 11:29:32 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        George Sun <george.sun@mediatek.com>
Subject: Re: [PATCH v5, 01/15] media: mtk-vcodec: Get numbers of register
 bases from DT
Message-ID: <YR8hnAiKHLpa1bri@google.com>
References: <20210811025801.21597-1-yunfei.dong@mediatek.com>
 <20210811025801.21597-2-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811025801.21597-2-yunfei.dong@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:57:47AM +0800, Yunfei Dong wrote:
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
