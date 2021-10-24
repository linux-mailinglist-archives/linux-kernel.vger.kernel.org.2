Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9125A438C32
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhJXVzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhJXVzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:55:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBD3C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:52:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so7387681lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGcra+weT29QDbFJeb2GMMbHD8nmk+xPQ61A0yy6Buc=;
        b=dMt46fk0KsnsI0CL0WhgAHfyeXWOZLkYgJY4TWFsOkppIh9ixzYsug0YmFh1+mZ5uD
         2S/IX26auyMNJ2J4I61Qz49lJ7ev2g2pX2Jv7RTMY+UYnPDlb7EgM1MyLNpH4w7ELnpu
         CaaS1MDj+LGhlmYFsS+4OAtY2usrMKPk0NxzFi9weCEIflMv4+9yTMrP6Xd9CUuOEIIW
         rauPF+x0++gDri9Q17072GyGQMllFV6r7YFdhj0WTe8b5iAEpALlg06JDEVHJSEWTCZq
         mEHqNkY0nPvyKdQfLVS62BRSpQ1HG12eH2NY0XMwXORghJ70h2Sz+u2KLYVZkdW8MYF+
         nQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGcra+weT29QDbFJeb2GMMbHD8nmk+xPQ61A0yy6Buc=;
        b=deN/9Z1rDsk8rcofnx9KEtA9AMf2KYnh90Jk1OE0J/4SanLCCUUm9p2w5fA9reK3Cj
         ukdw3px8dFder0usS7LgfiWLFwOERT595ge1Yie+TY0oX8WVWMepfrfbqiaPDSG6x0Wp
         Jc8IRRuLn3heembU03zEZ5Vo68liHU0f/fanpbCzRgiUuiS0Wr/EOUZITo80hMcNs7Yh
         ufl4XgnwpSej7AAyynrlczHeGUYEpg/3BD/9tbVXb7X8xkXGlSR58eDCx3y+k/be9HUU
         15Sy2829WzJB2N6rnbHtCQ7YTSzM39X9tLOWYYze/cJoszmSAbYZoarQLwPVUeWVg3HR
         +Sow==
X-Gm-Message-State: AOAM532a+qZhJAYhFuQdwff8YfSJAcY+eouyOfApcKgWfpfXnaJT7YAR
        8MiBYVZUb+WPkmPcTF4C3vehJzWVHBwoVugNXuRsYlou6aI6hg==
X-Google-Smtp-Source: ABdhPJybqQLtZteLK7c8/tTsew45j5rTVereodZKTUXVUDOygRZQikTgXlzcmo8V7PjXRTUExcmpWK+je8WLfhyAfZ8=
X-Received: by 2002:a19:c10d:: with SMTP id r13mr13257054lff.339.1635112367259;
 Sun, 24 Oct 2021 14:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634630485.git.mchehab+huawei@kernel.org> <70a3d6696de52a3d6112adbf7247a4b4ae9c7e11.1634630486.git.mchehab+huawei@kernel.org>
In-Reply-To: <70a3d6696de52a3d6112adbf7247a4b4ae9c7e11.1634630486.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Oct 2021 23:52:35 +0200
Message-ID: <CACRpkdb84V3hk4goi_Z8hVpF863TpqtCt+XY135nk+D3PW+PGQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/23] MAINTAINERS: update intel,ixp46x-rng.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:04 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> The file name: Documentation/devicetree/bindings/display/intel,ixp46x-rng.yaml
> should be, instead: Documentation/devicetree/bindings/rng/intel,ixp46x-rng.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: cca061b04c0d ("hw_random: ixp4xx: Add DT bindings")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It'd be great if Rob or you can apply this patch, I have sent my ixp4xx
patches upstream already.

Yours,
Linus Walleij
