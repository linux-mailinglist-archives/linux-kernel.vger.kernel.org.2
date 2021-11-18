Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95439455244
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbhKRBjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242280AbhKRBjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:39:02 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C72EC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:36:03 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so8037134otk.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AhzHSZs+Qa8irjDJBSbiDerC3r5X5aUFn4Yh1dCXuiY=;
        b=fPJFCZrZDYPW7rI9Lm6fPh6QD9XgZHl/s8q8VHTXo8fvTuTF/mA6Ndahnnbd8JvErR
         oVZwdNm7tdDMQOib5lM5Bw3J+3AU16knFPb1jZjnTc53YrtC3NsHAgsNh9vqiMfE2aab
         YXpfsz+2BW8yaNsheds+mEGYgXxqj2nhxej88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AhzHSZs+Qa8irjDJBSbiDerC3r5X5aUFn4Yh1dCXuiY=;
        b=dFnfQ1k+7iIRT4JvqWhV2/WcF1dAeYJbRqVvOu1jKxlEKjOEC7EwbymJHiHdCCeev8
         WQNg1xk+CDrB+kakLkgUISnRbpBqtq9LbLE/37CZRQupjIgm1geUCvtB5mOQAa99TF+F
         7e4P/dWDAoA03h8TrLiwEHO9kMkexxTdzUWASpCtvjnNDgvHOkiQ5pN95Ur67aEK42lp
         lIao01w1ll0F07Z8Tfq7pnEmZhDrvai9OulPbRyjCYd51GBrOATySLeiOQ+mBLdQj/e4
         luVsPgpdCW9xpPqtyP4/tlXpkYF7lWu+GMj3M0K8aUkaltaLJdmhNnfkRhCgh0x6QPzJ
         WeSA==
X-Gm-Message-State: AOAM531SaxSpNh3n80zvgjoBa6y4qFg2Kv3WSxwbVNWt1z6bA4e+yrfn
        T7KYkoZE0wD8rkXHOJtzgwXRa+zsedmE8inloqJPhg==
X-Google-Smtp-Source: ABdhPJxA6UsC92g8SAKBgSzoBtfVLdpNY2c/dKRjkWuxetjJ+zee2Xo61LDyLtogfQRcPKmnnkvJPqcfailm/WkSPBY=
X-Received: by 2002:a9d:70ce:: with SMTP id w14mr17764642otj.77.1637199362910;
 Wed, 17 Nov 2021 17:36:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Nov 2021 17:36:02 -0800
MIME-Version: 1.0
In-Reply-To: <20211118010453.843286-1-robdclark@gmail.com>
References: <20211118010453.843286-1-robdclark@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 17 Nov 2021 17:36:02 -0800
Message-ID: <CAE-0n50rwKPLubV3TENkZABUGHjdiQ=fAB2XtH6rkKuF68QK1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: rt5682: Fix crash due to out of scope stack vars
To:     Rob Clark <robdclark@gmail.com>, alsa-devel@alsa-project.org
Cc:     Derek Fang <derek.fang@realtek.com>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2021-11-17 17:04:52)
> From: Rob Clark <robdclark@chromium.org>
>
> Move the declaration of temporary arrays to somewhere that won't go out
> of scope before the devm_clk_hw_register() call, lest we be at the whim
> of the compiler for whether those stack variables get overwritten.
>
> Fixes a crash seen with gcc version 11.2.1 20210728 (Red Hat 11.2.1-1)
>
> Fixes: edbd24ea1e5c ("ASoC: rt5682: Drop usage of __clk_get_name()")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
