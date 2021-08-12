Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4287D3E9BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhHLAbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHLAbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:31:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4725C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:31:11 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so2866954otn.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PLCgWUlIwJKxfCShn29qzVeYMAxb9Jy6/zN3VIhO6gc=;
        b=F+OYirtrBGe89AnSkLHY5okk962mMXPAjiVYp3bwDE3Y0e6yJEGiSoJa1Amx7Jm/zz
         fSUSKYN5T+ZdYRgOOq1FEn2NxKXPC+HEYR9HYicAEF4RmfkFpX5U9cbrlwF+eUFD03FY
         Tq0DAX9aAxh4iU/4ulEK/J7zMULXUXeWovJbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PLCgWUlIwJKxfCShn29qzVeYMAxb9Jy6/zN3VIhO6gc=;
        b=ThoD7KINd3+/B3c24M6Ii6SXi0vKGm9e+bqrcfSslpr/X3HycfR1GEQOHflWywg9ov
         b5W+qH7vfgGONfkOt3J0q+oLqDyELjs2bvKUfY6nTzAzerbkpyT+UDPyN21DK2G+apOc
         Uo4mRVtcuhngwCUdBGW9YIORSEfaMWUMfG2FVKd9T/4pZ24dahiBmw9F/6gxrtzMtinV
         ABvPZJaD/IEg8JcK9Lx/rsTwVc1VSja+F16VmmVzjP762Twqmh6Lfm6ucsn/lKEhsQIx
         JpKb0ZWPFyF3vKKpvROXgUmKvTxnJOxYR36H/Iw0cV10QpDw7z4zSAwWJqNHL+6LOvjd
         yG9Q==
X-Gm-Message-State: AOAM530bRrAaZsrzLNiOuei/AdBC78UqdZsMY/4aYyoEzYXYmR5qsFKh
        X4qbjQqH1C5cdXBGKxqhQi+10koZASWYZSiL1BXp2A==
X-Google-Smtp-Source: ABdhPJyG97deqUVD5kKCSHP4TSJP+P7NfrbuOt/mh2i4whlYEQ588RKKNWLWiM2kuB+OHQvyR9jjX5MbyQcTVdydZn8=
X-Received: by 2002:a9d:5542:: with SMTP id h2mr1286181oti.25.1628728271301;
 Wed, 11 Aug 2021 17:31:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Aug 2021 17:31:10 -0700
MIME-Version: 1.0
In-Reply-To: <1628726882-27841-3-git-send-email-sbillaka@codeaurora.org>
References: <1628726882-27841-1-git-send-email-sbillaka@codeaurora.org> <1628726882-27841-3-git-send-email-sbillaka@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 11 Aug 2021 17:31:10 -0700
Message-ID: <CAE-0n50RF7fCC+Vic9DpT6gjcYrmTzd+7M6Y9SAhgLoD=_Sq7Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dt-bindings: Add SC7280 compatible string
To:     Sankeerth Billakanti <sbillaka@codeaurora.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     robdclark@gmail.com, seanpaul@chromium.org,
        kalyan_t@codeaurora.org, abhinavk@codeaurora.org,
        dianders@chromium.org, khsieh@codeaurora.org,
        mkrishn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sankeerth Billakanti (2021-08-11 17:08:02)
> The Qualcomm SC7280 platform supports an eDP controller, add
> compatible string for it to msm/binding.
>
> Signed-off-by: Sankeerth Billakanti <sbillaka@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 64d8d9e..23b78ac 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -17,6 +17,9 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc7180-dp
> +      - qcom,sc8180x-dp
> +      - qcom,sc8180x-edp
> +      - qcom,sc7280-edp

Please sort this alphabetically.

         - qcom,sc7180-dp
         - qcom,sc7280-edp
         - qcom,sc8180x-dp
         - qcom,sc8180x-edp

>
>    reg:
>      maxItems: 1
