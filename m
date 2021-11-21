Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85B14586C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 23:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhKUWs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 17:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhKUWs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 17:48:56 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA5C061714
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:45:51 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id u74so34036909oie.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvzqzjlUtR/uUV6rdRQhnrcRFsdkeDMA5YTrcbT+UY8=;
        b=NOp5oHJeoOz8s7+N2fsGELM0dQhj4u5a12ybc9fVQCPC71rSGb82EB2dapaaCDB//S
         eLVmXU5JUJ+xcecD5N7nMGgHd9kepgq+EZ1topdZnCbpR8VFnvP3IbNjrz2pYvcRpouP
         Yp1rX7sWtgrmZcJAuwIf+srtSqB9R7h3SQampaC9qNsZzOYixo1MC64mPQtJtBOPM/fm
         2vKJpueuPzw3/jrTPGTiOHa/wBwDhzKCotMihhpsFlyia/loFtDB3JUTwUpdRQu5P3zS
         y73YYRTsR6u2ndeBJRlo9eHHtBXSZHyI7GxLgSbrN73dPxRJvhWkIoM6vh/4RjAY1zY5
         8txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvzqzjlUtR/uUV6rdRQhnrcRFsdkeDMA5YTrcbT+UY8=;
        b=lCIu/LEBYH8hWI+8KmsGoENC9W9keF6zM4MlSBxmR8uIHuFI/QOPDr9/br2qZYD7wy
         ODKXbf4P6bPC3yqo0tWZga8zVqotw3igH0PdprW9F4S8YF2lDrDmu1X5VqGW2H9H3okW
         L2HS4k6iO5oKi6sikV3dod29fSGi1HhPKxeH5YMEL0GsOTkADZnVnuda+PHRdTI3Lb1u
         u0JGzFCKouXdnD7iGxRo0aepfAB8fRPpsUrBOet6OUCo3hmQ7YsiiiHgPfQx4HLFqsVL
         HXxXDjADbXGyj2bXO57eiK7NoQXLGFjPS0ggRDgb64nfabiY3Dg6PId9O1vx5t7px/g4
         QUjA==
X-Gm-Message-State: AOAM532eVWjOjGorneHCX96KDqvg8hATRAr9q2hrhIYtvQXFbuY3ZZY/
        uZ6uIBybBFjxOXSvjCk4nCZLCXh6X1JdvIpq59QQy4XNuPc=
X-Google-Smtp-Source: ABdhPJz4jdu/yKCuIL59ucO3qFeK0YICxwGZH4ovUAptoJ7aWzQ3tIEGKrT/xMMGC5qFKl14P1LokkatoV3Pp4ITF0E=
X-Received: by 2002:aca:120f:: with SMTP id 15mr16982446ois.132.1637534750221;
 Sun, 21 Nov 2021 14:45:50 -0800 (PST)
MIME-Version: 1.0
References: <20211118112548.14582-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20211118112548.14582-1-kavyasree.kotagiri@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 21 Nov 2021 23:45:39 +0100
Message-ID: <CACRpkdaf=HnWDSrWM81-k58RvooCwOZitkGb0oWze5gK3zoDKg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Extend pinctrl-ocelot driver for lan966x
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, robh+dt@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Manohar.Puri@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 12:27 PM Kavyasree Kotagiri
<kavyasree.kotagiri@microchip.com> wrote:

> This patch series extends pinctrl-ocelot driver to support lan966x.
>
> v3 -> v4:
> - Minor description fix in lan966x_pinmux_set_mux().

This v4 version applied for v5.17!

Yours,
Linus Walleij
