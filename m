Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0683AE52C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhFUIrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhFUIrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:47:15 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B09AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:45:00 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id 68so8770861vsu.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqc6mYCTnX3G1/+4gTg7lVP1C5NTClRqE5ZPFXvX0Yk=;
        b=J/fWvETLjOn/GtW/JjG96pY0hPt5QYXsnDa0KiwR5TJCXGsPAwAMehPL7kiKh0DPnF
         tbgKMBg8jmeF8sQ+Zf58nuwxe0/srnBFYgk7uS1N7hoOHPM1Fbpx5fnU3H24k25+MRA3
         XvxdYcKbW4aPpsA5WpqL6sg+IxjV4vlzo2XYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqc6mYCTnX3G1/+4gTg7lVP1C5NTClRqE5ZPFXvX0Yk=;
        b=iEjgddRdYx1O/HnJyQbendi3kUOjqglXo6YKBAa6LeJI6/Zf32Ke1KwnZwcV/ahq9L
         pFbUZUSwqbec6FCskCuFBTJyWU+WLuTWxPvXtvMEqvDf1dWpRA39PInHfMx8LK8wUCu3
         Hs6CjlIDWyeGCwR0Hyu42V9aREHvNRdUBVcY2B+ziizY/FBqHyXfWyUPhy9XeJ38dm+Q
         Lsi9O/xconExroLsE+P7GuAW4PZqbp32y+eLAxibQS+Wy9xYMwwPXcEWNb9bmDIWKzen
         tSICYZNmrN/wkqqMA15eAFPlj58K6I0CgBNmH7MFuQUrQyU8USRxrwU+rBF7fxOkbU+u
         qdqg==
X-Gm-Message-State: AOAM530LvrREc/+wzKsziqFPlgE5VLrGxvvkOoHlbKkZvPSwsDSV/gdj
        xjJfq68J/4wBynLPY93AUT+xrLYMKKOeWA3DUmzt8Q==
X-Google-Smtp-Source: ABdhPJzfGZZGHK81cg2PLydWMfpNPAVEBG3yip9ZIDbO+5m7X0px+1Z98X3E6igGMUtXdRda/P8PpoLujgaPZcJ5/H4=
X-Received: by 2002:a67:e252:: with SMTP id w18mr3592727vse.9.1624265099317;
 Mon, 21 Jun 2021 01:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210604014617.2086760-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210604014617.2086760-1-zhengyongjun3@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 10:44:48 +0200
Message-ID: <CAJfpegv3XMq_mBtcMaPP8c66nrtuQs4b1Por3btJDPVz4jH88w@mail.gmail.com>
Subject: Re: [PATCH -next] virtiofs: Fix spelling mistakes
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2021 at 03:32, Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Fix some spelling mistakes in comments:
> refernce  ==> reference
> happnes  ==> happens
> threhold  ==> threshold
> splitted  ==> split
> mached  ==> matched
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Thanks, applied.

Miklos
