Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80C7348CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCYJ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCYJ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:28:21 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE802C061760
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:28:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g8so1467447lfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYI+PuLtimhXH77xMKx0d9cmeN1WTmp9BxMwwXCReuc=;
        b=vkzZ2N2UrRZK5RBwQrQvsfRbVolmmcIiwHGBhARupxqNSDLeSev5dOC8UG/dIL2rf4
         yMuWSVyBRtrQdgtoazo9ipzP1CYUQvSfFuMRAHBCb5L5wngj9mwiuSxdSwcBO/tyqxgy
         MenwoiIXh96QhrN/0K7wklslZj0ue96gv/4dyDUrUl9ze2rsSqdGCuAQ/mQkETIMfWDc
         tJaVq9+8YyARo4Y7YBqdzP5XKqLqs7PnHgG+D6nt/WClVwbGDCJ7OtYGpCsV+uG85gTn
         T/tsQ6lxBa02bW/g29IbIKCgrIr0gLI7QFlTAQ5zL+kZuZKIQrSnDpnPn2XjkYacbRxX
         Luyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYI+PuLtimhXH77xMKx0d9cmeN1WTmp9BxMwwXCReuc=;
        b=bgNe5FhIOhiK0JwjOQzkpMP+Z0Tk8qOLZ+PvNbITYpcPDvgPt4xeM65IwaGCFcl5Ju
         pdr9FRURZ6Hivqoyve+pnpawpMpSrUoa8yjVizuteSRGB7nBt/YMYu4x2Z8EotnLZM6c
         imrwzufmTGlr9Vu5qlL67oE+rPqpw2ioRyjMXnYIWdjRG8rBo7/MRdfqhfLfN16kJnhM
         kd5kBc+cs1VVDejBRGRUDCecKQq1Fpo+VDHCyqWmKsja/VXR5hekOXkl203VgJjzGJzy
         yD7iMZr1O5DDUBeG+1Kbk7KnqLbDJ55mgfaKNAlU9yPZlomNSO4ZxLwhJBz0IZxr1Udx
         PX/A==
X-Gm-Message-State: AOAM530nWBImux726BCJz8eAXhHxtH08LTTikO192q1Y6Yso9SbgQXNi
        29xCsyfehuJC0pNraEyhuweO1zgaLQtLgrvxoZW/DQ==
X-Google-Smtp-Source: ABdhPJy2Z4Gos2vxj/iljbGSCtdK0ftBcKclmf8nmtikeFu0/ui1OQLJdrfnXCEhSNQC1St0TY+IoxAm8bt9VLy7J7M=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr4757768lfe.29.1616664499245;
 Thu, 25 Mar 2021 02:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210323145509.139393-1-hello@bryanbrattlof.com>
In-Reply-To: <20210323145509.139393-1-hello@bryanbrattlof.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 10:28:08 +0100
Message-ID: <CACRpkdYYV8HLf+HCXbkiRPZFZww+1L_mq3VcqJ5Jse4hY9TkDQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: chip should be plural
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 3:56 PM Bryan Brattlof <hello@bryanbrattlof.com> wrote:

> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
