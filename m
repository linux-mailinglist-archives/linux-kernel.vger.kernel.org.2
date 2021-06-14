Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC503A6FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhFNURH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 16:17:07 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:40951 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFNURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:17:06 -0400
Received: by mail-yb1-f182.google.com with SMTP id e10so17198106ybb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPAnMLQk7hVqO5coR0wKdyEqk3yCrFigz73mgfLmDDA=;
        b=Oy1LMMQVKWjcGglXjI5/GMhXpu+UVfVaifc7EzzUCNkuS3HkG2nVpU8TL1nN/39mab
         8qCctyoWv5uXmtS+XGXPL5KePOYlsAZCFZT/KksiEKqZsWQDtGXoM7RDaibGmHPO1Xya
         8/KZQFbwPtiL+hhxOqiBdUiRVwKJvrQKGDKIT52YmYoE5aJTUGHmP6F2zrGds5P0G8KM
         7gBbvXdjeDcuNMeNq8DdxNpjq9eFeh29WHMZ0xS0rt8dNTpZszDRJchTTz3Lcl3+/8e4
         Va39J6RK7EmzM6EOXRq9dYS7YpDWDhveOtgMPBcWds3ERK53OgQ1qhQ61Xk1Thh5iBX0
         IT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPAnMLQk7hVqO5coR0wKdyEqk3yCrFigz73mgfLmDDA=;
        b=J9uDxwPq0Nv3WtNFdharu008r7/Xjk+L3vYytbVTz7mnKsfj4fqWfIMoszJ2NKvr7M
         X2rWN+ZkQss4bBt//crtfJtLPERfrQZcyIOl+w3rJiO/OFYM4puNa+TPONeQq22ybJNt
         eaKyb1XM2pmg/YdLMxswhH60yR6YMVCoMImNx3/IsLL3aCQcVFrvqICo0HXueaU5YJcc
         /+W02yMFSQ74+0PCUxQrOUytNMnOaSbpEZ26aHvwggH7twx3K+lweY9b61n8VYKnlUAs
         3/g24ELhoBXcYnc8x9z59B5hIgAMEWzjZKT/T7pNmendtEnspxJEb9726CsZqkrTDmUQ
         A4Pg==
X-Gm-Message-State: AOAM532vHEI96pSEInxvcVjEBrXAQsK8TvmqdSxHaFKG7pX+xWXy9MKv
        8yZBOaiqHBHEroSOywXvIi3t4zy2SfWSCe+4vbK1KA==
X-Google-Smtp-Source: ABdhPJzy8k0LHFs+Ud8M6AwiZGZ0gS/tF12cwe2oQDFAmo52RHbpVaqLDkV7ZHrdpuetfKzOMZT80vNsp6GO0E1tsLk=
X-Received: by 2002:a25:420c:: with SMTP id p12mr26545373yba.25.1623701642805;
 Mon, 14 Jun 2021 13:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210603164900.46020-1-srinivas.neeli@xilinx.com>
In-Reply-To: <20210603164900.46020-1-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 14 Jun 2021 22:13:52 +0200
Message-ID: <CAMpxmJUsOS1YwMFhgBVesSgBdjrEXLxTE0RLrVL0T+ux3=gvLA@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-xilinx: update on suspend and resume calls
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 6:49 PM Srinivas Neeli <srinivas.neeli@xilinx.com> wrote:
>
> Current AXI GPIO driver checking for interrupt data in suspend and
> resume path and reporting as error in case of no interrupt connection.
> As per AXI GPIO IP specification interrupt connection is optional,
> driver logic is updated in suspend and resume calls by reporting
> debug message and enable/disable clock in case of no connection.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---

Applied, thanks!

Bart
