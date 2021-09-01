Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB13FD2A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhIAFFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241867AbhIAFFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:05:37 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589C2C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 22:04:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id bi4so2222493oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 22:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=p8e7JkeHrWXVLh1MnUKItckaxSfNSDYY50SArchtkhg=;
        b=iKhQHWUjGc6kitjMj/4aFfuK5hnjf85PJAuyGFLfsjm98jwSTCo3WJkM+6B9rnZrJ3
         XeCNcTCH+Bjt/19WnqWb+OJPAfRifb+a1avCcNV8SuV/uHWG2smfn6A3grVkODpxHHVF
         hhDapZ/sEKcFkBAJTbyLASirtrHoX+gvIwLRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=p8e7JkeHrWXVLh1MnUKItckaxSfNSDYY50SArchtkhg=;
        b=rnSeAfMKim7mvZGKZ0jfGZoPSrvdhsAlzNMQZxEsz0YAjSaonFrQmExedxTW7kpG0b
         r0SUZxtLo02nX+i4ZVSkK6QAxuSSgVsI06HrXXIDObe/NhLrJegbZ6RHQ6o08nvLDA/B
         Bp5chsEOGsJFeVkTespWz9/3uoaL+0TMX4UYskD40oZKPxehbrJAYq53fUWJkDdEGYh3
         BOl+0Sm8VXx2mOSUOBFxkg8duolxTbn286sDaMsM+0Mu1E7Niwk0E0Ex2ZDt6WoUTZhk
         ce1pHNVj0jK+Zx/cjE+cCkCSvwRee1vptvE7zzBT/Jmb2C9Jg+q22G3If+JZMBCoT7Mq
         KiKw==
X-Gm-Message-State: AOAM5324Pp+EbynBgk9AgwRB6W16fZHZdl9p/Dv3Zn3TLN+pKoXNogXu
        XYjZF9IeewlrAM4QU94ZMJCOUdAfzy4fDq9ZNAPs+sCAbdI=
X-Google-Smtp-Source: ABdhPJyTV7/lFyg1x6j69L4Ied61ZtzKWwbVYP+niMFttTrFi7QCrPGoum+eE0eBzLOBShQH1PQbNpCyZnVyoyHSUpc=
X-Received: by 2002:a05:6808:909:: with SMTP id w9mr5913567oih.164.1630472680751;
 Tue, 31 Aug 2021 22:04:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Aug 2021 22:04:40 -0700
MIME-Version: 1.0
In-Reply-To: <18995b9913c9acb7880b01a4f61ee5d0@codeaurora.org>
References: <1629983731-10595-1-git-send-email-rajpat@codeaurora.org>
 <1629983731-10595-7-git-send-email-rajpat@codeaurora.org> <CAE-0n51YGqp701EzUs1Q1PG89SECVQDdUPsiJ8P95xFj0UFs=A@mail.gmail.com>
 <18995b9913c9acb7880b01a4f61ee5d0@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 31 Aug 2021 22:04:40 -0700
Message-ID: <CAE-0n516KfBJWeZ_nG8C34xPLHohWTXw9sOFbt2HjRBA1uULmQ@mail.gmail.com>
Subject: Re: [PATCH V6 6/7] arm64: dts: sc7280: Add QUPv3 wrapper_1 nodes
To:     rajpat@codeaurora.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting rajpat@codeaurora.org (2021-08-31 08:28:51)
> On 2021-08-26 23:41, Stephen Boyd wrote:
> > Quoting Rajesh Patil (2021-08-26 06:15:30)
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> index 7c106c0..65126a7 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> @@ -225,6 +225,10 @@
> >>         status = "okay";
> >>  };
> >>
> >> +&qupv3_id_1 {
> >> +       status = "okay";
> >> +};
> >> +
> >
> > Why enable this here but not any of the i2c/spi/uart devices that are a
> > child? Can this hunk be split off to a different patch?
> >
>
> Currently there is no usecase on qup1 and hence not enabled.
> Regarding splitting this, I did not get the exact reason why we need to
> split. This patch adds all the qup wrapper1 nodes and we are enabling it
> in board file.

I'm happy to see this part dropped from the patch. If nothing is enabled
that's a child of the qup then enabling it serves no purpose.
