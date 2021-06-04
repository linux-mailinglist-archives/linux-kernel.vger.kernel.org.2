Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD18439B3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFDHeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:34:07 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:47018 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhFDHeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:34:03 -0400
Received: by mail-lf1-f47.google.com with SMTP id i9so12581120lfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmvzwN2PhN4D6doozCLoTCSRtV8PNmRSUf70knyKygY=;
        b=VKgonetGhwkdh3p5GzyHz3fb2C2eHBZpW8vXddarJjps4MoO4NYl/ZaW2aGXwsKhl2
         RwHQG2OhGJl26h/UkO36x5csPdcUn3lzQXGWTfWm9To/J/9WLnADo3laZGOsrup0s9mo
         PLlIEaSb1N2gfIw73iu8mkBgdTmXK6LxRbSdLhHf06NhizoyCP9QK7+N4NXQ1RPBoBE1
         2bG4fK/zSKDmWehB9q67v9DPEtqpXa5lpqS0t0k2docp3/xjIHm0fZMDxgJduvvfv751
         HeM4q7rRAh2dyL3WZ2gb6fz/G34Q/36lSMzl1oMlRIyfnYWp7alGIQQ0VkELhive9AdR
         EHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmvzwN2PhN4D6doozCLoTCSRtV8PNmRSUf70knyKygY=;
        b=hN3GLHrzKCgJwTdDG/8AI0nAx0fTjjOWmaKUUrJCCv+7mbg+39+jAafDpJFk8DFOuZ
         F3Z5jZs5Kjb2lp1Oe3pGXLwdCM5nGlI2pdczqELuCV86UtPCjYYoPUKqtTPeQiEZ67Dj
         2s1Cs8Xh7oaNRjXIThRRYpgnT5/AjJ59Vf40aLQzNHsOBHbZbJlzTG6cQu9wp+VXiba3
         HI4los4zIFjbjywjhOGLvVdgP+M4bJjCsEj45cv0JZlkS4wJDc1wcmDfMLBgHjAzas18
         b4Z8O5nzgLVK4Hwtmgm+9oqpzyrII+o8PR3AvPUJ24G1GHqgR3pQflvdhqPisNh2nKSc
         TgAg==
X-Gm-Message-State: AOAM530++HBtxQMD0RIbabgQrAolKdz8s8cPlG65yB3SO4RYSvk8TZ34
        6pcZDg/OGNTRVb20U+6Im5j8hGGMhBRWNQrfoONTCw==
X-Google-Smtp-Source: ABdhPJw/g7Ppk/QNRZ6RrxFDv9My3nGxs8YayvDdjsIPhq6PB228bvlEC8Xzphi5oB3P7V9LawXhGQiPjxxch6U+B+c=
X-Received: by 2002:ac2:4c8f:: with SMTP id d15mr1829213lfl.157.1622791876843;
 Fri, 04 Jun 2021 00:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210603043726.3793876-1-dmitry.torokhov@gmail.com> <20210603043726.3793876-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20210603043726.3793876-2-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 09:31:05 +0200
Message-ID: <CACRpkdbyu9tYwwN=yhx_5RWxKngBy10U5rqD=VAd+YhoEWo-rA@mail.gmail.com>
Subject: Re: [PATCH 2/7] Input: cy8ctmg110_ts - do not hard code interrupt trigger
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 6:37 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Rely on the platform to set up interrupt polarity/type properly instead
> of hard-coding falling edge.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
