Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD2F3D19EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 00:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhGUWGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 18:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhGUWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 18:06:39 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D95C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:47:14 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s23so4557307oiw.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Eb9LtJ+dHz6N32929nApb7lA/UIZOw51y5HXWJHV+No=;
        b=ae7czq1GJIt6/U9uknbS3lZhF0Es0qC8uQrp91abICEwPi2CmNsX/81grbYaBxloeg
         kCN1dcAW83duYP7JjCCy91IMC0jaz9ZWXIRAaTl+9OpXpqGC8GiOLvedJ3B9mudH72L+
         1BPc6oEPkUa4OwveafowmjlXgZIVXrVT9Ky/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Eb9LtJ+dHz6N32929nApb7lA/UIZOw51y5HXWJHV+No=;
        b=q3wUC9i/qBHrR67leGWBLkj1VJqR9x6oLlG/nGRdWtxPpt5fdIDH27QfseyZD3FcSx
         Exa+P/FoMwy6ktCMGvO4EX/fIgl5sopW0xD8MkaWeWTQP46z64dP3m6M7MEx/dmv1wLt
         JNZlWnLuHzRh2dABntFjxabECNbygViTLD3e71pX7S+9apsR8tq6MQvZyHEZlWNq4QgV
         ZHBEOmtRDWo4zDmJ3XrR3xcMuWq9sAQQ41AEIn7P1QAouLnBmmn6D93a1NrzlKHGI6bm
         IibEaQU5616Aqiu3KgL6TFW/Vq+Ly4nyv1RkElKzuYqMFYodq6EIHlhWtgMeOwyql6ab
         2i0A==
X-Gm-Message-State: AOAM532G99djBTg6DyYNUJbuGHmafDZKwSFHd90l332NxCH7HX3BZtP8
        eiE/Fod3p0QDlkN9OM2p5LwMFyxt4mFUILyDcKjDIw==
X-Google-Smtp-Source: ABdhPJxKLlU4iEyDub6KsvBCRzbn8E5b7zF0GhNns46okWb58lLiQ4aPNlO5eLKI5knszc6xGab98KGS2NnMz0rUrBY=
X-Received: by 2002:aca:4dc6:: with SMTP id a189mr4162941oib.166.1626907633575;
 Wed, 21 Jul 2021 15:47:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 22:47:13 +0000
MIME-Version: 1.0
In-Reply-To: <1623650391-28144-1-git-send-email-dikshita@codeaurora.org>
References: <1623650391-28144-1-git-send-email-dikshita@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 22:47:13 +0000
Message-ID: <CAE-0n52YzaP=Av9dfh8_87WBfD6DFgAb3a7i-TBg8inxQNnzhQ@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add venus DT node
To:     Dikshita Agarwal <dikshita@codeaurora.org>, david.brown@linaro.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dikshita Agarwal (2021-06-13 22:59:51)
> Add DT entries for the sc7280 venus encoder/decoder.
>
> Co-developed-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
>
> change since v3:
>  - added firmware node back.
> change since v2:
>  - removed firmware node.
> change since v1:
>  - added rpmh power domain and opp table.
>
> this patch depends on [1],[2] & [3].
>
> [1] https://patchwork.kernel.org/project/linux-clk/list/?series=449621
> [2] https://lkml.org/lkml/2021/4/9/812
> [3] https://lore.kernel.org/patchwork/project/lkml/list/?series=488429#
> ---

Is this going to be resent?
