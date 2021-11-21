Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA96A4586E4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 23:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhKUXBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 18:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhKUXBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 18:01:19 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB085C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:58:13 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q25so34349069oiw.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 14:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/5OZU0dPITJ79B0ldHvptsJJjqxj5kJ42lpkT+u7EAE=;
        b=dnSoV/tSD+rfrE9UnR0LqWTICHhNjqERhGtexoeub25ZTDwZbCaePnvxpiyrmLQnW5
         oRjynhxCJKKJWK12DJMB6oF6WhnngL5V+F9GvAQlIgDz4aVHqo0Lbg2vFjtwIi+XrHzJ
         Tnji7disVwfdrSyVd/BphgXXA0tR4CI86OmfFowviZFLOAKQnt6xiaLO9zl7BbDrN6Ri
         y4VPAsYFAmPVyea7JCLuALUcewsNt4WwpBQJ5kAallC7q6ySyLiEr5nqdy7Rp9NUCoDO
         eLiom8oxJngJefdNG2Dlx4f8S8S9GBng8O+3QOlVZh/UZoWgXy3P/l5KcflHjgLyRApS
         6xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/5OZU0dPITJ79B0ldHvptsJJjqxj5kJ42lpkT+u7EAE=;
        b=ryFPCE6KTjc9fb5sDNjipU0HNc4CiIiBy0rMUQV7CrBlGNOTh/ai2+vs9mIRpUEHrY
         S+lTqoTgds8lMo6KgDCsRKBkxTGDZxxy06tnYPVKpeOuGfih2069hct48pXfwYH3T/f6
         04LAauu4qWqW82WJXKraglWhED/4lEi5IoM4BrKGJpF54vr9ppuHtb5sAcip4bSuA4rl
         mGh4Zt7H84u6L+PJFlaPsSrtteeIf0/uVIcK8917Pd8taNGVOhdiQS0kA3d00sk/GdBd
         aiHzcH/Qh/k6M9yuhGT/d7NpsOu93dQ1YfYHqQ18nCtyZaclNj7oLGA0Hy7CIr16Hdpf
         3ROQ==
X-Gm-Message-State: AOAM531TtvrRqPL0uXCesRWkpDdrkdTCbG97bvLdUUc/CCGerVLKhBVB
        YhXcHSzp3Mr6f02aCcyPhuPR9DMNSdCBgb+aOE49nvzdc60=
X-Google-Smtp-Source: ABdhPJyVeByS26CUTL6DtZHU3tOXB2fRzb6opZhfyZVeuemgt5Kvq+XhBTiDAtDzxeTbOO6EexIMaBes3AiawHPQtzw=
X-Received: by 2002:a54:4791:: with SMTP id o17mr17766392oic.114.1637535493362;
 Sun, 21 Nov 2021 14:58:13 -0800 (PST)
MIME-Version: 1.0
References: <20211110165720.30242-1-zajec5@gmail.com> <20211110165720.30242-2-zajec5@gmail.com>
In-Reply-To: <20211110165720.30242-2-zajec5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 21 Nov 2021 23:58:01 +0100
Message-ID: <CACRpkdbfMFa9wt2XqhzK6-ZbAgRPPu3C7o2=4PbK2FEYFgkJ2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: use pinctrl.yaml
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 5:57 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Also fix some examples to avoid warnings like:
> brcm,ns-pinmux.example.dt.yaml: pin-controller@1800c1c0: $nodename:0: 'pi=
n-controller@1800c1c0' does not match '^pinctrl|pinmux@[0-9a-f]+$'
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Looks good to me, Rob?

Yours,
Linus Walleij
