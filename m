Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466FC38C869
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhEUNkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbhEUNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:40:01 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919EAC061347
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:38:30 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id g11so14237029ilq.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QraQWaDbrIyFsDMVDfzA8DAF+rb0LcMH/Egy8Qs4g6M=;
        b=R461x5DK6Oy+M09t3cWQkEm9qrL5KcZdvIqarLkvpajChuPAlkpVwHWArHhhag+kNN
         ZUbfsrYK7Xo22UI7ZiYZaBIwArR64x21Fic42DI3jbRhffIJB6XaXyDhNrFyv+2Qs4zm
         iN+3hDGEbZIQeXEgXuMmoikSuWstvPWPqHHKuoy/kWqnlNiLKV2i+/zd6hVP7BJYpRDO
         mGC7GcQ0zYXUp5zqpipVO4ojdGqa7D2LcsNFt3SpdYFOECkDUgX08qSsOdqTDNJlvgX2
         rj5EMMWMo678I40ElCFzUaPcLoMmQL+dkfUzWc3IxeAE6JUDaf+SgmXSBY7QQwAQ2c3j
         XSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QraQWaDbrIyFsDMVDfzA8DAF+rb0LcMH/Egy8Qs4g6M=;
        b=b9EdbbOdUMCqcbBvGUCBHHXjoI69RG5v5UTgdJ0G9FsHkjGdojnUWrYjRX6YSoZSpp
         lvO5e0uC3RIyRrrkTd9djsiT2WtL6ckedN0fq05aa9D3uOQxS9UXjaHtV8Ma/KMub8zX
         KxeOuH+RColDxzlo2oLiM6XYx/fDbkBXvDTZpEXgZDxx3nkkg6D0tctB8Pkc611/5wzJ
         ICt9uCLH5GXqGBgTb7cvo5v/TmxCU6Mc+BVOTBfgbj23ndQOFYE1Xzo/hq7eQM+GZcGK
         E8hi5FlGa/ctyLyVXARL3ecIWorQBzY64SchJ5S9E193XByEynIwYHwiOH6K3REjjXZq
         yGxg==
X-Gm-Message-State: AOAM533Bg8WrKfmcBBeKGxw4UZVInBVd3M9o5ZteTBqWgSKB+W8uQqgs
        01FLyzNoCEK+/aO9qFKHQElweKiplNKB48lyWnKe5A==
X-Google-Smtp-Source: ABdhPJyIr36lrjSTCZAWI/wXVI6gkeLvcx9vdH9kY86wAPm6nJ+y4Bqp9zyM3RNpCdzm4Ydp/VZdmrTH0prPxSxav1g=
X-Received: by 2002:a05:6e02:92f:: with SMTP id o15mr13051528ilt.127.1621604309819;
 Fri, 21 May 2021 06:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org> <20210519143011.1175546-13-acourbot@chromium.org>
In-Reply-To: <20210519143011.1175546-13-acourbot@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 21:38:18 +0800
Message-ID: <CA+Px+wUBJ9xxf709Ze3npnUV-NOp1DT969GWQsGTg-WuVkF+nA@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] media: mtk-vcodec: vdec: add media device if
 using stateless api
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

On Wed, May 19, 2021 at 10:31 PM Alexandre Courbot
<acourbot@chromium.org> wrote:
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> [acourbot: refactor, cleanup and split]
> Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
