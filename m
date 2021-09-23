Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4F416777
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbhIWV27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243241AbhIWV2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:28:55 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB71FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:27:23 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso2632403oon.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=EUO9/yL8lYqvnNfVuNoJkSi+TEZqLFgHFGyYVZDmMP8=;
        b=Nos61hEkqppzT+FjmU9ibuwTce1kgFehjjl2tqTbdkumPXwyQ2nIPAhrZDmyCenqsP
         PvkxrIGuP6oQbhr1OKY+fJDfG2vlGN4oWWwdMweMMKYh1Lnj7Cnma7UVQQrjA3JZGzVL
         nOqyfVMHmowyaEKnT6s96EKXidbcCygAiBkiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=EUO9/yL8lYqvnNfVuNoJkSi+TEZqLFgHFGyYVZDmMP8=;
        b=Kl+SDmIANM3Q0r0dvyCzKk+GFOuZqlIlakbn4rNmWMdmocHCDZaRqkh8IAinXLOaHF
         XqrOK//7XzwnRAjj5Q/onX/6uOYIuXgOinu+m8Aek3DECDIebGkz+QRltaetgPnYrKYk
         KQVjQi6V/NTfVOgQBfv2SBTZ0N02GaixowQnhLa/EV+6YQlEPd4OgYKVKxBW3LYjmk4f
         0JVIGOWMnE0kAKS8jZ15KOsDw2TdsXXBZ1uJgPEaIt01ojJV7rr78fSQ+4puzbIC8nQD
         hmLhJQjNIjwV1jgFje/R/MVdtHw921O1kci/ZdNl7LNn8ScpCHmcfrhIXa5HcMcYOMix
         GX5w==
X-Gm-Message-State: AOAM533RwXfZBfj7quXP6RxRhAFinJCx5qPRsGPt2JxrEUrReZCoI+qx
        ny/ATYGoCv/8//NtoeP5jN2Jthov3cpTGPWSxNyVWw==
X-Google-Smtp-Source: ABdhPJzLg/c4iq6I9UelgivT+3scwJlKaWKfZU82sV6BahirlwQBeXwQ/FFuN2uWjDcBSEtDrrM79CQp0kpNvY/wl0Q=
X-Received: by 2002:a4a:e214:: with SMTP id b20mr2757000oot.1.1632432443127;
 Thu, 23 Sep 2021 14:27:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Sep 2021 14:27:22 -0700
MIME-Version: 1.0
In-Reply-To: <1632399378-12229-1-git-send-email-rajpat@codeaurora.org>
References: <1632399378-12229-1-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 23 Sep 2021 14:27:22 -0700
Message-ID: <CAE-0n52LRpd2R5Heyk_2KeEPN7pCyQrHk0putL=rGiWfHiP=cg@mail.gmail.com>
Subject: Re: [PATCH V10 0/8] Add QSPI and QUPv3 DT nodes for SC7280 SoC
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, mka@chromium.org, dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-09-23 05:16:10)
> Changes in V10:
>  - As per Stephen's comments, Removed <&qup_spiN_cs_gpio> in all spi ports.
>  - Added "&qupv3_id_1" in sc7280-idp.dtsi file  because EC and TPM
>    are using "qupv3_id_1" node.

Thanks. Looks good now. It would be great if qcom maintainers can pick
this up soon so we can have usable i2c/spi devices on sc7280.
