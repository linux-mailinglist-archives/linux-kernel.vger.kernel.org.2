Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1267E3EA1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhHLJSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhHLJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:18:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA0C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:17:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t9so12258915lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlnCjZjx1dq/H2qB63RqlDicLcJRpH3K8WfM9ayn2uY=;
        b=EphcxfV2jMbb4CHVOqy3ezGW28YDwekOHaZ77TrbNfDikUWohM+aH+V2xCkggA2tRJ
         6QmtuDQGjMgmgpSfVhhljhqz0e/bP4/EPKEAm/FJjoP4//hSVjZIpXxKt+kYgclkZH4S
         0+OaWQVe9m1s3gvCiX3KL5E1rUNnjxpL6HEyiQ7uKd0Ve8ctjaigfJGYtdNG0E/h+HeI
         B/e36bSwX05jzgu66ae4g71KDlQDti9VemRedfgUe4kpDYw5lCoxqXaqp15oOiWqb4kY
         HoX9NAMX/jseubevEFuaP2Y1hI0cjX5ZqQ2qOnhIDjjwANZrqBADROPh3pP6iFn+42r5
         oQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlnCjZjx1dq/H2qB63RqlDicLcJRpH3K8WfM9ayn2uY=;
        b=WmiWwEtqAE0a5P7GZUlNE7Wlt+6JcGEe8VIm6Q8l4t5YrWA4bHjHHOxurLn/KNa2k6
         eHwFLJQmw+upZzSLnh9irOYlfeyBshRDDcLHVpjesRCSLXWCNbu+31fFbCvgyV3hcyYm
         mx2M4VXuH7/yOcVRoZqShJqik0gyH4S9FmuD1RH3pgMcnK+199K4tlV0p+bO10Tclxlg
         v/s9ylh3K7HX55CJA71nsaYdkkYiYJ5wC1MtAT28zN5fxDUYbyzdyCoz1MJsDB0KiBUj
         LWD+uufukUbcNL1OHNkeRTULan1d+kifVujOr3ScAXoTR77UFZ2grUzvTL+bIJsg4udH
         ZFtQ==
X-Gm-Message-State: AOAM533wtCDUbTYix4TAKF19/dURvfPPzkx/IucFNX7z5J4a3sJ4KoVL
        O9tstjDZPSXawQI+NDr5cfxda6wmLcVQUxxqwBLzLw==
X-Google-Smtp-Source: ABdhPJy5J/bkEHHotUgSklMelctUg5orqWwIVjsNVyLt2OpPUcZYHiaTzeAbTeNPshUHqLcdFRkQL/VKcn4CGp4bqY8=
X-Received: by 2002:a05:6512:3250:: with SMTP id c16mr1814844lfr.465.1628759871726;
 Thu, 12 Aug 2021 02:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210809201513.12367-1-mario.limonciello@amd.com>
In-Reply-To: <20210809201513.12367-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Aug 2021 11:17:40 +0200
Message-ID: <CACRpkdY10DoJdaLnGSwT4icPQRR23vhaDYiY9aShaBs4oU91NQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Fix an issue with shutdown when system set
 to s0ix
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Raul E Rangel <rrangel@chromium.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Gabriel C <nix.or.die@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 10:15 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> IRQs are getting armed on shutdown causing the system to immediately
> wake back up.
>
> Link: https://lkml.org/lkml/2021/8/2/1114
> Reported-by: nix.or.die@googlemail.com
> CC: Raul E Rangel <rrangel@chromium.org>
> Fixes: d62bd5ce12d7 ("pinctrl: amd: Implement irq_set_wake")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Patch is applied.

Yours,
Linus Walleij
