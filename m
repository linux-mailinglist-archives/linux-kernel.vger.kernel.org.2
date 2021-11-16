Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E0453CED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhKPX4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhKPX4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:56:06 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19623C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 15:53:09 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r26so2210032oiw.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 15:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=KFUf/CthI/bS+ZQgvAygcfDGxDGo7QNEjise0MnefUk=;
        b=mK/6ikPS6kaJlyMjmNnOBa6iOsd2iYbIqMHzl1BXEDg/YUNMNxad5YIiG5G+Gv0Mha
         lg4L8Z5bJIKf4WzbYdu1iSQCh7v2Hn7N8xF1Ke78/rjwmlLkOzB2v1tYFHErHCGfBV9d
         qOLpnuRbRmNkN8FNDgGobx6YnmCyo/78RyVb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=KFUf/CthI/bS+ZQgvAygcfDGxDGo7QNEjise0MnefUk=;
        b=4ojC7L7ozQdD/L4D9KFGvOYAiSflR2FrMZb/RzajyvLSBqsudD3Ys1dy/l/Hxmc4QS
         P4oyMcg0zHvqnbDO23Hw4sORmAMHTSY9SOjd5Z94hm7HS/kXlOg4EenVGt5MDP+DTwxj
         esM6iNDeEMfUNN5KsdUToNiJiuBLDSXXjhCmBd8twtKqipBNJQC4dwvdq8I9bLNd2FiH
         3K5kLrjRjINCW/bqx09kcBIuNpoZE1SUO+6/1+6ZKAD/DAt+7ICVfK4vdV5KVZwU3/2i
         3Jr9K+ftJoPa9Cm2vtdnCjY5V1sS9iCZUuQj4CJIOh07Ze0uEfzD/cUb3Tr1osOxickv
         Z1Ww==
X-Gm-Message-State: AOAM530KbMspS6bjl1hUbxqUO78KSQ/fLYq+ehK9AX5XBEiMfaasvpLm
        1tNExRZFa8zjayGsHXFkH1EvU73pXgKM1Jq/lQTcPw==
X-Google-Smtp-Source: ABdhPJwccuxLou2oRfuz+ayeUbq55/sG63cd1jzCiEn4K2zwqAWWmXhnujN2bMQ6TSnBc66iJtbNr0QrzdjedXY/oZ4=
X-Received: by 2002:aca:2319:: with SMTP id e25mr56712319oie.164.1637106788501;
 Tue, 16 Nov 2021 15:53:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Nov 2021 15:53:07 -0800
MIME-Version: 1.0
In-Reply-To: <00ea01d7db12$43b6d9b0$cb248d10$@codeaurora.org>
References: <1635860673-12146-1-git-send-email-pillair@codeaurora.org>
 <1635860673-12146-4-git-send-email-pillair@codeaurora.org>
 <CAE-0n52effcajLwjOY_v-pjp68ytkb-zo4R9EHp3CQi=yB8nPQ@mail.gmail.com> <00ea01d7db12$43b6d9b0$cb248d10$@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 16 Nov 2021 15:53:07 -0800
Message-ID: <CAE-0n53Djw69-Q6VOrayhdgefiWOWqAjmuFj0MkkwyEMaS0sCw@mail.gmail.com>
Subject: RE: [PATCH v8 3/3] remoteproc: qcom: q6v5_wpss: Add support for
 sc7280 WPSS
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, ohad@wizery.com,
        p.zabel@pengutronix.de, pillair@codeaurora.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sibis@codeaurora.org, mpubbise@codeaurora.org, kuabhs@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting pillair@codeaurora.org (2021-11-16 09:49:05)
> >
> > Is this documented in the binding? If not, please add it.
>
> Hi Stephen,
> "firmware-name" is already documented in the bindings.
>

Ok I see it now. Thanks!
