Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B76383D12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhEQTSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232147AbhEQTSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:18:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32E64610CD;
        Mon, 17 May 2021 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621279038;
        bh=bclKj3T5OzMHwLMDNU1qKI1Dt6RViH88PuPQbMHGRr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KyL2dYeDr8a1Y7Nyx672Enhc8n14G0dS9jL60PBUVlds1wh0Kdck4guWmafFfhg3J
         V/ekBJ1Ql309JKIuC1rjKGqWTk69+8rbZC3OXkgujcOA1IwG+WanN1rZzn8DFNq58P
         /4Ge3UjjnbW/X2xIj/v3ah6CBy+bqbmzwaeUf2DnCjnnyQh71YCuAu60u1LC/sRfdX
         A6sthgM1T6iZHrLWLnp8kj4P0Zaksio3dAh/JeYsqNwFSoJb6sigvVkmFUsiWMpdSa
         1iPEgKN+HfvtijCxyo4Gyzw5hjVgmCocJjrLVI/Sc8TKaf81WO2pcQnEypbxJ/7TF8
         RkyiDl/acaF8g==
Received: by mail-ed1-f43.google.com with SMTP id f1so8221677edt.4;
        Mon, 17 May 2021 12:17:18 -0700 (PDT)
X-Gm-Message-State: AOAM532i4vG8E7/FdVOGp00Zfb4EVe5XRevYp5PWWTyzjt6mBHKVILlt
        wldue9jApE5nsrm2DrfyI96UjX9mXOWmjQig+Q==
X-Google-Smtp-Source: ABdhPJxwWUTWR46pVeUhN6Po3a3w6B9MWb0twgV12pS8uxUBoS8TpJ9ffrEiu87zRYE9GCN0FD+HyoyXgJTdXkElYnA=
X-Received: by 2002:a05:6402:54e:: with SMTP id i14mr1895380edx.289.1621279036856;
 Mon, 17 May 2021 12:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
In-Reply-To: <20210517155458.1016707-1-sudeep.holla@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 May 2021 14:17:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK6B40D8dRu8KoOsx6eSzRXx6KsSEu5mjDokPEAy+p4oA@mail.gmail.com>
Message-ID: <CAL_JsqK6B40D8dRu8KoOsx6eSzRXx6KsSEu5mjDokPEAy+p4oA@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:55 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The CLKSCREW attack [0] exposed security vulnerabilities in energy management
> implementations where untrusted software had direct access to clock and
> voltage hardware controls. In this attack, the malicious software was able to
> place the platform into unsafe overclocked or undervolted configurations. Such
> configurations then enabled the injection of predictable faults to reveal
> secrets.
>
> Many Arm-based systems used to or still use voltage regulator and clock
> frameworks in the kernel. These frameworks allow callers to independently
> manipulate frequency and voltage settings. Such implementations can render
> systems susceptible to this form of attack.
>
> Attacks such as CLKSCREW are now being mitigated by not having direct and
> independent control of clock and voltage in the kernel and moving that
> control to a trusted entity, such as the SCP firmware or secure world
> firmware/software which are to perform sanity checking on the requested
> performance levels, thereby preventing any attempted malicious programming.
>
> With the advent of such an abstraction, there is a need to replace the
> generic clock and regulator bindings used by such devices with a generic
> performance domains bindings.
>
> [0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang
>
> Link: https://lore.kernel.org/r/20201116181356.804590-1-sudeep.holla@arm.com
> Cc: Rob Herring <robh+dt@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Rob Herring <robh@kernel.org>
