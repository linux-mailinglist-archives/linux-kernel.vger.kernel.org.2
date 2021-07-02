Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B723B9BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 06:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhGBEzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 00:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhGBEzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 00:55:37 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE251C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 21:53:05 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y76so10208669iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 21:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xA/EyhzFSdsz2sFUNgzwIXBEHw1bTOcRizpVrKwHnM=;
        b=dvzH83kdx5KIUmDVS1w0rMisasSOJ6Ccukbr8vTiM4s/WjHlF/yx/4+Bk9Q6lEJDgR
         Tkx9f4CuZyje++eY/P5t1ukwyC31q1YCPAk5cCjsy62kuOtRdByvF3GU/AW0vdvHcxEE
         iewpk/DHrdNe8EBlHHAvfMArsB6CCwwV+wTbjCG4D1wuDbV5Ex3y0Y/aV9T8Y5+XBNCj
         LAAe6OZwusANIPlvsXl8zUZAnIfzphE2fjbBYX/vbbGG9aOhq/khkgFzjATkg16sTHSL
         Cp93Fzo3wDmW9KdhbY8xP1EFMYlUqVEdWJKvi2nzyulMAT9WcnQvO6JrFDbzlPZSbQxf
         e3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xA/EyhzFSdsz2sFUNgzwIXBEHw1bTOcRizpVrKwHnM=;
        b=CXQAZQPHpCKLLesKWMmNNZEtbui2/yf/RVAlCp5KfdD2W5/cLg6ZhrnhC7Aa2Lrlr5
         J6enZDVzVEAWbjhBg9TpZ7xEO5SoPl7QUjTVBfJu2m0eIfoUt9f9pJzTSvFRj+4R2sZj
         QKtR9PILafVhWp/cu40YCYaN6P/xeMQ5AlTRwEa9OzAgxIXNKKIsGVs76TEFW+tY/cdg
         O7mu5yyU4wSOf7iWvfh4j5kSliVJfgORJ3ogPCE45JZnquXJVaQ+9YCrEHANoGnpWDrK
         FMwVzVa5sf41cVOrCSjE1atTbEcQEgdEQbyqaluafzr4fhwWShuSObSfqOMCFT1/5Z9d
         A02Q==
X-Gm-Message-State: AOAM533E9wLtlLU7nJXUqndZOVLRvhEIhp34CAxyMHFS0riWJ7x6Fci3
        w/XO4JAto1kVEmxcg03aG6FRQUielDTKHLJkMcWTiw==
X-Google-Smtp-Source: ABdhPJzER2PdkKXa7rEiTZOGbSGSbVenXZ4wan7olcH+FTxEnJUIZmIMF3c1B9X5F+NiSOvBNYDudS5hptFhheGDthQ=
X-Received: by 2002:a05:6602:15c5:: with SMTP id f5mr2245918iow.53.1625201585165;
 Thu, 01 Jul 2021 21:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210629094339.874120-1-fshao@chromium.org> <20210629094339.874120-2-fshao@chromium.org>
In-Reply-To: <20210629094339.874120-2-fshao@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 2 Jul 2021 12:52:54 +0800
Message-ID: <CA+Px+wVXREb73UfZgFJx7Ncy2+dtPO1fyM5wWxjF7gD1WnTQ4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: mt6360: Restore error message to regmap_read failure
To:     Fei Shao <fshao@chromium.org>
Cc:     lee.jones@linaro.org, Gene Chen <gene_chen@richtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 5:44 PM Fei Shao <fshao@chromium.org> wrote:
> This adds back a missing error message for better log readability.

I have no preference for the patch.  When the regmap_read() fails,
mt6360 will fail to probe and return the errno anyway.
