Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EBC38D079
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhEUWEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUWEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:04:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B41C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:02:56 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t24so5530819oiw.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 15:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=N4WDRHJzz65u4VfeYJW6joOLDC2TOf7BbCNb8jma3Ds=;
        b=lfkQEcoJDzWkpaNQkq45vsQfYAFYQvjFjWDhsaxUacnqXj1TyseJXeorDzXc0RtOQz
         Aiy46ofTKuXrN095DXIH4oEfrR9k5TP0SxQU4Xk07U+Gy/2ozQpC6gZI7ACKzlSrleuL
         +tvdyizaE58T36IItLv0VfNZs9UI4xHjHn4WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=N4WDRHJzz65u4VfeYJW6joOLDC2TOf7BbCNb8jma3Ds=;
        b=gb1nw9OviEK1jWqxo0OED61t6h9YTxdfkdMI1YOcxV/mlSqqlIFRK/S+2uEWhzFhya
         a9wi1VaiIPcBj7bhhgtUav/VRIj7ZLKm2+VB45wnz/fWet7uMROWG9RGXfnGY8ffuHQg
         Aie6FF+Uyg87ii9XxeOltOzB99w9bkDvgBgKl5Px4s1k9qZlyyEmWwHKXGX2FAb7NcOd
         nZBD47AU8M3Xdk2slYBVv/ctG4fxpJiJQ76C3seBTYcbGZcm4AtzBhZJmiwlYV9UNfhm
         JWusctRMFtpmFZKsuvL8Uw7SyYiXvB2hNdqxklA1G01TBUdi220eMexrof9ReobGmSeq
         Z7yQ==
X-Gm-Message-State: AOAM530+UUjJHIizLwIP3UM23Z+e+k+KvcHWF9gCuiNTeLtORwALTaCc
        9A0UOxqNqv25J/8xO+ZIGgPfSBlJ8xyIB40JsUbdqw==
X-Google-Smtp-Source: ABdhPJw8zLpWLEyiCx8j4huFdDMF7DGsGTaKrD11EDdPJJUOzIBohDVQogjM8wrT9jJfSnGqSuMKQOWpX69bGjp2DEs=
X-Received: by 2002:aca:654d:: with SMTP id j13mr3780480oiw.125.1621634576454;
 Fri, 21 May 2021 15:02:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 May 2021 15:02:55 -0700
MIME-Version: 1.0
In-Reply-To: <20210521140031.1.Ibaca694aedfaff823feefa06b29ae746c641dd1a@changeid>
References: <20210521140031.1.Ibaca694aedfaff823feefa06b29ae746c641dd1a@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 21 May 2021 15:02:55 -0700
Message-ID: <CAE-0n52vsTV_GPRQ4Fyvm7WQ0HHZ3r2GK4F+qv8qm9659WqTmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvmem: core: constify nvmem_cell_read_variable_common()
 return value
To:     Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-05-21 14:00:57)
> The caller doesn't modify the memory pointed to by the pointer so it
> can be const.
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
