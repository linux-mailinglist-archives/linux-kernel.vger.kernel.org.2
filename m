Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636B03DA8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhG2QTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhG2QTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:19:37 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B56C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:19:34 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 3so3670442qvd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQOpyHR0dniHjwxjRmNhdF/ycVh6frpl8ClqJFnJ9xQ=;
        b=ic/+jL/sRZ9YoobekO1A6TTBbRQSbO+0ZcaQ1XhRlWBY3radRJChbEef0Q7ltIrJIz
         GELxuymuBGzolOq87K5y7cqjYqwH1HVuiJHEo4OrtIt1w13Zq27SYklgQZi02gEdupO9
         OAnmex7mBJ1NfOgBYxwJ9gHRM0/OW2wT10jGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQOpyHR0dniHjwxjRmNhdF/ycVh6frpl8ClqJFnJ9xQ=;
        b=EMqv7dObgto+XywqU2jqfRHewdkIoU4LqS3zipcnObWdv4NrkXiQRMLPBshzwA5hbU
         XXRf+YrroiN+FdN38hshbnvcFY1wzGg/gri+0l374MoQsNLMf3Ji3wTXTVnWScB7P2XI
         GJVkw2fXBKX05i0sjwJjfXI4/gaJ4tA5h0Fb7BJFP7zPMVNWkKjG7+Z+zX7G9+QmcT0Q
         tlAuJMaJmP+6xYtJoZPC7DbofKN1rJwigC/PibzZ+5m8Ibceao8S+GHqRKhxVuE20BMW
         Fi79XWjWqdOYKWxrMfAbfZ95Xy4gm8hAf47g+q/NXB3HjzPjDRzUE5i5BjJoZRLi2aJK
         /2Yw==
X-Gm-Message-State: AOAM530waiEU7cQ7a6Zb4iD34vAy1e9197S5w0mJKwsltBi7TOfHtHz7
        XxkH5cq6JplkodOjE2ZVZFWfV3VMur2J6Q==
X-Google-Smtp-Source: ABdhPJxqHZxzqs8Xyr/ra+hJNZgIJts95PVYTjKgIBkvcvVlQDYuu92W6ye2XmQd/aAI28mlWiu04w==
X-Received: by 2002:a05:6214:2ce:: with SMTP id g14mr5630242qvu.46.1627575573023;
        Thu, 29 Jul 2021 09:19:33 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id j2sm1981467qki.93.2021.07.29.09.19.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 09:19:32 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id w17so11064746ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:19:32 -0700 (PDT)
X-Received: by 2002:a25:2904:: with SMTP id p4mr7599226ybp.276.1627575571977;
 Thu, 29 Jul 2021 09:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <1627560036-1626-1-git-send-email-rnayak@codeaurora.org> <1627560036-1626-2-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1627560036-1626-2-git-send-email-rnayak@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Jul 2021 09:19:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vtp0HGFpoS4cdZOQ0GUBbhiyw=TuYxWNTGVAyMUKMhvQ@mail.gmail.com>
Message-ID: <CAD=FV=Vtp0HGFpoS4cdZOQ0GUBbhiyw=TuYxWNTGVAyMUKMhvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: nvmem: qfprom: Add optional
 power-domains property
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 29, 2021 at 5:01 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> qfprom devices on some SoCs need to vote on the performance state
> of a power-domain, so add the power-domains optional property to the
> bindings
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> index 861b205..a498a08 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -51,6 +51,9 @@ properties:
>    vcc-supply:
>      description: Our power supply.
>
> +  power-domains:
> +    description: A phandle to a power domain node.
> +

I'm trying to channel my inner Rob here by saying that this
description doesn't add anything and this should just be:

power-domains:
  maxItems: 1

Here's an example of Rob saying this:

https://lore.kernel.org/linux-devicetree/20210712151322.GA1931925@robh.at.kernel.org/

Other than that, feel free to add my "Reviewed-by" tag.

-Doug
