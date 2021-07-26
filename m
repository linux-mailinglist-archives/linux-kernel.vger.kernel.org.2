Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C063D593A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhGZLc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhGZLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:32:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A48CC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:13:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f18so15010964lfu.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkVsind2FREvYoiAIwU/wtHv+3lFoPKWq+BzKSJr8LM=;
        b=sro0m7e7O0QHcEGBHPoUHSiPK41MX8FCGe42yubSaZutVwV05uUU4jSXoEV55MISvB
         CCgv5lbLdUtGzR1oXR+AbHgCcuL3tLuQhE052bQX2mXHpQOCcom5E+Kwa39TZj3W7opr
         eZrD9IhY+sj9z6gVOo8HQVhu44MrE8+CfRHa1BPnpD//hqEnXZzZ7ijaVBdf9we9T/cv
         uv2nw7ZJa/RpoXNAAW1fgXW0FXfQGXdGrIPKtq3vh+ZSz24DpDsfe3VbfeY1F/ATMt9h
         gepBXw82Cb73Vefz9LB/xm58gRUXzlSpv2qSWGo+qYcEjt2VpAAMuK1DsjIr7fuPVrPo
         7obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkVsind2FREvYoiAIwU/wtHv+3lFoPKWq+BzKSJr8LM=;
        b=i+rLxDPU45XPGuRG7UejlaYT/eHy1s99E1H8/freQOCuUkoBSHbPBR4f7vBXxtbY4b
         OQREyWRD/XQYIeDcerKT7pnuZlhnE+dCOEp6jgwZIAOO0D8mQqHh28TmIBZtEYShx6/U
         d88dD+AbAO976tXEFAFBAXgcYXUzyfuWdYoee0W+znsUeUFtnO6Qo9lsYNg7XhkR1kB2
         bODzNs1P9OSBpziEQ4xB8zlYAeIhrQpBrV/WjXmrgleQhy5DrjEttn+rdjd+FjNmJiRG
         ux6vzujUld9hruJ+PGvpiMq8WXCNHcWDn5oaINQGTnRvnulEtux9Y6RHPFx20Ul7nH1D
         nzbw==
X-Gm-Message-State: AOAM531qBU6mTQACjAeVbqtixlvkGnSAjv+eYvghbO3eWuDB+taUHpdB
        Wb91tc4EnTqOH8bLo1cGtE7vmiWH48FjNSpN0wEe/O2JziE=
X-Google-Smtp-Source: ABdhPJwXUrroVJGsC9LvoDXNLwilRg5E2/8m3lfMHzr5wT501AjmY7tK7VUV10q1fcPPN/BHmtIe4GrhWpAhLZjWyvY=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr2615881lfu.291.1627301601894;
 Mon, 26 Jul 2021 05:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626947923.git.mchehab+huawei@kernel.org> <7dbff9673e8703cd60e78f8b2110349d86d60a87.1626947923.git.mchehab+huawei@kernel.org>
In-Reply-To: <7dbff9673e8703cd60e78f8b2110349d86d60a87.1626947923.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 26 Jul 2021 14:13:10 +0200
Message-ID: <CACRpkdZK0dLie_mv=B1P0i-965u2S-EnmVQ-BxhXUkzozqFbUg@mail.gmail.com>
Subject: Re: [PATCH 05/15] MAINTAINERS: update arm,vic.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:00 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> Changeset b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> renamed: Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
> to: Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
