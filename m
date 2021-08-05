Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9783E1CE5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbhHETk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhHETkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:40:24 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42BC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:40:10 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id z6-20020a0568302906b02904f268d34f86so5997435otu.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=u516B4IDOq5HPZ3Fekbj0IXtz4ADHjdylXCRO6f+AtE=;
        b=Mj7GAi0LhIrpfGb8uOKnGR/1zqnyjRwyav0vcbe0Y2ll2nJVjdD3w5fZLmJac1xna5
         cBnIfhhuhtP9c2xQQoTF7mNLscEpuTlg1IHdvxFvr8P7rQ+mwFDPbUoNftn96DU+s/RI
         6N+4Zs4ZI3Z+K6hgwc9kBUK41Isvxa6/s52ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=u516B4IDOq5HPZ3Fekbj0IXtz4ADHjdylXCRO6f+AtE=;
        b=Sr0UoDBPCh+ea+5TGuGrHBHMSx3lGxHEO3tYcjAW9N+myAugUmscl4NLwbq87wyDAL
         /QHxUwJdMc8x089K5A7ha6JYDG8/No2JE7l9Rm2vg2wcrIVTyLNvSj59Ht2OTqLmyb98
         h2IKYxck9nsQfI1W5KgYMGoHbk5QxmFg+ylSiMVASCQ9zLzt8ANUZ23lu4pZ3ogfkXiv
         gSXzO2vrl/dsAlceGA5GwSd1KNSFdh26Q46F/sld+b8KOjaBPLniz3SX8GVDigpn9mH5
         n4X5WpAV1CMiOfUXYSeO5A8C8fyuyiXIkqwHXspCuRJAcU5mi3C/mUME10Bg6CTE/8o0
         573A==
X-Gm-Message-State: AOAM5322JZVtiYJlkhW/EEoHMQNJBb35P9NQaYgNPRqrVcCQOg2TFrAT
        TZQv1sgDbnYYKWG5W0IvaI+arA8cecsqzbUCpG9yhQ==
X-Google-Smtp-Source: ABdhPJwSKh/dCjbC1x/LRZpD3rrmsUjweEJ0zHyBAS26I7atE8009pKiiiZweJ5j1Tia6FY8WUQO0zSJaxd9F3lNYn4=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr5020325otq.233.1628192409655;
 Thu, 05 Aug 2021 12:40:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Aug 2021 12:40:09 -0700
MIME-Version: 1.0
In-Reply-To: <1628180254-758-1-git-send-email-deesin@codeaurora.org>
References: <1628180254-758-1-git-send-email-deesin@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 5 Aug 2021 12:40:09 -0700
Message-ID: <CAE-0n5203g4CkF5WP1fQYU57fntXbdyVBsMsTKU_xPkgvbt+7Q@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] soc: qcom: smp2p: Add wakeup capability to SMP2P IRQ
To:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, clew@codeaurora.org,
        sibis@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Deepak Kumar Singh (2021-08-05 09:17:33)
> Some use cases require SMP2P interrupts to wake up the host
> from suspend.

Please elaborate on this point so we understand what sort of scenarios
want to wakeup from suspend.

> Mark smp2p interrupt as wakeup capable to abort
> the suspend.
>
> Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
> ---
>  drivers/soc/qcom/smp2p.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index 2df4883..f8659b0 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -18,6 +18,7 @@
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
>  #include <linux/spinlock.h>
> +#include <linux/pm_wakeirq.h>
>
>  /*
>   * The Shared Memory Point to Point (SMP2P) protocol facilitates communication
> @@ -538,9 +539,19 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
>                 goto unwind_interfaces;
>         }
>
> +       ret = device_init_wakeup(&pdev->dev, true);

Is smp2p supposed to wake up the device by default? If not, then this
should be device_set_wakeup_capable() instead so that userspace can
decide if it wants to get the wakeup.

> +       if (ret)
> +               goto unwind_interfaces;
> +
> +       ret = dev_pm_set_wake_irq(&pdev->dev, irq);
> +       if (ret)
> +               goto set_wakeup_failed;

Otherwise this looks good to me.

>
>         return 0;
>
> +set_wakeup_failed:
> +       device_init_wakeup(&pdev->dev, false);
> +
>  unwind_interfaces:
>         list_for_each_entry(entry, &smp2p->inbound, node)
>                 irq_domain_remove(entry->domain);
