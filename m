Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B981C31DC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhBQPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhBQPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:22:48 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67BCC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:22:05 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a1so6384145qvd.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=jEUJ4tuSzMlCFaDxKESUP4P7qK84eWSvOivquTyWX5Y=;
        b=qudaP6PHL1+kBMkuR1VK5nZ7j1sTJaiB8rnO8lQS5SseH8+BVDxYCG8v++KmwfKpv8
         lrhiv7Xvb65MP/h/mamThTPzjpFJNYxXNeUo6tJjcRPgtAUK5zHovxcwTPAx3Ikg4DhU
         Vl9zgK68E0qcJdCpr8cL3/iA/dg+BTgNOApam32OwrdklJHczH4WcfUIRLzBlKxFxPNT
         dr729DO5hrujGZNd3KgU2qVyzjZ1w+mxH5BlQNY6F55IrgarBqfzrH16NQG3Ig1gg7Mb
         Df4BpqnX3cZkcVsnpf4LbgxRjV7OEpchIn6rXy/Lg5u6q8GFVu3MgLBtdSXyKqVh3zCp
         Hemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=jEUJ4tuSzMlCFaDxKESUP4P7qK84eWSvOivquTyWX5Y=;
        b=Db8HqeSiZk0nj9QgmafIv+rxGmpqyp5jBgNupSnUMQeKk/Bndq4WX8dwAcTsf68uYb
         8Kd1H4DOHrZpzlKBKr9X5DK93eH7sxq4xRhW4WO8PyjJYnshII0OKRtebv/XPTA+WsGQ
         WMy2SoRo3RXW+OPRl7pAyb1xRFIanjjWk4usZS4pY7JXyeAghXrcCldE+GREXdXT3KcH
         RkqtjgI9RebjDxEHgTaaAtJ9qSWdDM+8ka6idchkrcqVIz0bEaPBw/qXe5F9cUakxFjF
         obEkOSD9+WOj3OmxhAtmTIew+uR/yZbSX0EsGE8zBm++KE3M4fYihba7z0FxQYlJqeEl
         OO5Q==
X-Gm-Message-State: AOAM532jhcxJ/z4tgxSsbptkWrMKxSW4jtr+hBQiLnJ3T2UjYgicXJCI
        falqi+ufHsltE/2AadkqPQ4=
X-Google-Smtp-Source: ABdhPJz7RmY45lveGN8ApiXwlXmQRHlPNbPqWTQFjHssHxI1muZWdBLwUiX2ZXgDHulOrThcfmscdQ==
X-Received: by 2002:a0c:cd0c:: with SMTP id b12mr3000377qvm.10.1613575325217;
        Wed, 17 Feb 2021 07:22:05 -0800 (PST)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id f26sm1737569qkh.80.2021.02.17.07.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 07:22:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 17 Feb 2021 10:22:03 -0500
Message-Id: <C9BWPQC23WXC.2TUP0Q9J7VAX5@shaak>
Cc:     <geert@linux-m68k.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Vinod Koul" <vkoul@kernel.org>
References: <20201211191241.21306-1-liambeguin@gmail.com>
 <20210113114941.GD2771@vkoul-mobl>
In-Reply-To: <20210113114941.GD2771@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Wed Jan 13, 2021 at 6:49 AM EST, Vinod Koul wrote:
> Applied, thanks
>

I can't seem to find where this was applied, could you point me to the
right repository?

> --
> ~Vinod

Thanks,
Liam
