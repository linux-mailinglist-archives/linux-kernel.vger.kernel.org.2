Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B542FE43
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbhJOWgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238903AbhJOWgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:36:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E0C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:34:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y30so25882140edi.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPP9H53mtCsbQNk9doEzzimC+EjafFfLHkPsfpk1gug=;
        b=Wrmsv1r6CTDbsg6ohN8jcWCEqyPhEjWAqgDfsYvSTD6Z0wUTDq+sgfP0+HD652SaPn
         cBaOtOtCzGLQgEoeMxHfnHkrGiH+JocjZBkkCI1PEGlxKtOY3SQNH5tsK/SrVSkPJsKE
         qSDEP3gCzAKhu4nBYxhktV0Nga3FDmNdmAnd5h5Oa1/eOfPcbveQe63JZpQeth53nKJp
         tGOMwAnFv6lkSLgRyRz7bkGPG3oKDA1PSIU5Ok/Ys+0Wme+189tyJDzt1uPZvfn/pG5B
         +hIQZkuG2b1XNg1U9aImPBbo+CbVio/NzAH3MGaMZZsT0jgTREkOfUBsHBGVozTgM7Tn
         d+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPP9H53mtCsbQNk9doEzzimC+EjafFfLHkPsfpk1gug=;
        b=qbyY2NfUDiZRrqzJbR2X0wp6CiuuSY3gBllVXB/w9RNsEtJBvBAz7oDsbKIx31QhNm
         IkMknNS3TTlJ/VTUDD773RUTaMbPwCcC+CaDjpMfL1C4UNOoZL22jGz4oFSP2zeV1pEI
         owGb37W3UXOWQLCoNt5LHWg/zWsRsxH6V1/9IRCiTHImXbXn8ejMJmCMK+0nz5bpWrQ7
         ogahFOntkg2PuX/HToXY8pSNHYl+VIcODgVh+c7Q7R4+FubUpMuxxR0UhDxCQE6Z08hV
         A8N9KeDE+/05vAcAIBRhzZzE+SW9DxbtWrFMV8r2GF1RSB4plszKaLY9d9jnMfKo3jiT
         KAGQ==
X-Gm-Message-State: AOAM531Pwia7QQ78JY9ILKiQpaT017R0ojwBy70urhHE0gRXJcrGYhcs
        Fr0jotEYFES7yHU+Yz/Usu5yONTBJH62on+Bu6Q=
X-Google-Smtp-Source: ABdhPJyLJjJm67G6BpfJ0eTf82WNnFvO//ihG40tAdRB1n2RDizdnyDHqAIAfAPSbXh3mmlgYBj8ihlZGtJNQkmzTZQ=
X-Received: by 2002:a17:906:fc0a:: with SMTP id ov10mr5837689ejb.536.1634337255917;
 Fri, 15 Oct 2021 15:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211015141107.2430800-1-narmstrong@baylibre.com> <20211015141107.2430800-7-narmstrong@baylibre.com>
In-Reply-To: <20211015141107.2430800-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 16 Oct 2021 00:34:05 +0200
Message-ID: <CAFBinCBwO0CJMPA3K6e8OxXcinzrA5LrSqaKu1XtZPWLXT8Krw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] drm/meson: encoder_cvbs: switch to bridge with ATTACH_NO_CONNECTOR
To:     Neil Armstrong <narmstrong@baylibre.com>, sam@ravnborg.org
Cc:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil, Hi Sam,

On Fri, Oct 15, 2021 at 4:11 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +static const struct drm_bridge_funcs meson_encoder_cvbs_bridge_funcs = {
> +       .attach = meson_encoder_cvbs_attach,
> +       .enable = meson_encoder_cvbs_enable,
> +       .disable = meson_encoder_cvbs_disable,
> +       .mode_valid = meson_encoder_cvbs_mode_valid,
> +       .get_modes = meson_encoder_cvbs_get_modes,
> +       .atomic_enable = meson_encoder_cvbs_atomic_enable,
I did some testing on boards where u-boot doesn't initialize the video outputs.
It seems that meson_encoder_cvbs_enable() is never called with this patch.
meson_encoder_cvbs_atomic_enable() is called though.

From what I can see in drm_bridge.c [0] this is even expected.
Does this mean that we need to move all logic from .enable to
.atomic_enable (and same with .disable -> moving that logic to
.atomic_disable)?

The same comment applies to the HDMI patch.


Best regards,
Martin


[0] https://elixir.bootlin.com/linux/v5.15-rc5/source/drivers/gpu/drm/drm_bridge.c#L717
