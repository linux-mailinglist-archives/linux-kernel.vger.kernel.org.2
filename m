Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077463E8BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhHKIZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhHKIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:25:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEE4C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:24:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w1so3803397lfq.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVm6z+/Bdr1n5Fxa4kSmJVT5Ljn0y9dUOJYnV8Z4PAA=;
        b=npDtkwz0NnMywdciIG5W0LkfTTOnjggjeCnH3sgoLPN5Hccs4URBbWq0lmrVIjgkvq
         xbw1AbzO+nfE/1+yQfqze5oHl+jtYm8kIc0fIISaS/9tYulHcumxsocgP8gWH6N384vJ
         /wcpWMM9natlQocS/RkP4b+cv2u+VIoEG6se5sHXdymoQP6TbjNPWzqaYk1u1mIzV1m5
         k/VXeVLYNelL05P2GONZFDXEVKbEMZuK5Wdc/nVDbRe4k2XMzG2/KcI8HKBwvc/QK+7R
         Xaih6iEM4iWlhD2N2TbtPpV0Txi6EiQpWa5BMj7p3CWEQ5XAdC2r9qfcwTXEOKqm33+t
         m2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVm6z+/Bdr1n5Fxa4kSmJVT5Ljn0y9dUOJYnV8Z4PAA=;
        b=Whr6nlje+hZArf7FH2e2OuI/6ZRkD/6E5zmjTEHE/FszmOvakrjKNPLxR7+b+nYW9Y
         d0oSteblZvnKvHcAjEmUeezgcM1osBFhB2PYvmeObLaDaTPuI/ITk8Pst7T4+tRa80qQ
         OinaqIUHdoAZRh+1Yjm2CFt2S5XK3dAQF7TrE4eC4slHBZX/uKV5Pg5oTx7AU0xKXOqN
         km3y2cIhR+u9ihcIw0ZXJRmW7C/UhzUrO08+2+MyLtz+h28bX61PQ5qJadB+alkZtT4B
         HGkLY00kWd5xzzqIW9Oh7GPBpIX+XmT04aLT/UQbGnIJtGUBfGd605lP4amgFlnbn4qb
         K3jw==
X-Gm-Message-State: AOAM532rTMpAiSgg1YfW/E3zxEJpcNeBmZHGWzmbJl8n2Pro2uatZjLk
        q6sxjN1KyEtr8WNqLHhQT62YsmJSKZ2vFyV9Gp+EiQ==
X-Google-Smtp-Source: ABdhPJw4NdVqOP8gfyXv+14MvH9T3lyPveKwazy7JVk+5XTR/vz5E6tNfn4zvYKymCGWRbOp10vWB0/n7S2SBJmBe0Y=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr24116051lfu.291.1628670284748;
 Wed, 11 Aug 2021 01:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210717174836.14776-1-paul@crapouillou.net>
In-Reply-To: <20210717174836.14776-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 10:24:33 +0200
Message-ID: <CACRpkdakKpyb375DY+D5BgS6NK4c_LoLRmQ_hh-F8KQpR_wtvg@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: ingenic: Fix incorrect pull up/down info
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     =?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        linux-mips@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 7:48 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Fix the pull up/down info for both the JZ4760 and JZ4770 SoCs, as the
> previous values sometimes contradicted what's written in the programming
> manual.
>
> Fixes: b5c23aa46537 ("pinctrl: add a pinctrl driver for the Ingenic jz47xx SoCs")
> Cc: <stable@vger.kernel.org> # v4.12
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied!

Yours,
Linus Walleij
