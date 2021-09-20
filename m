Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73DB412A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhIUBmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhIUBjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:20 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FB3C03D749
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:43:47 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id m14-20020a4ad50e000000b002912a944a47so6247549oos.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=jZilAWTtlxib5UiTFHrd1oo5lANOqZ4zGoC3s+xI1Z0=;
        b=c8K6bBkASy9LhBdg5fqDar23fZZpMZq79/5LTgHDq0MLd2uRbU0gbK7LGcsxQnXsKs
         DHHQxTM+/VXWQmDr7vewoXfZj97vgARrJ9JYUl3Kjzn7wuTRkl+ivmsKoYbFZPmVMdI1
         hNM/YX3sLKFUaqWXfXhprJgjEHUAVuGR7J2/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=jZilAWTtlxib5UiTFHrd1oo5lANOqZ4zGoC3s+xI1Z0=;
        b=ip+3NQX9r5Xxs53QlFRjbC+1V0d8++3gYRIOEDn5SKpe/HS1gCLlUOeueXLdRkoBN9
         bwWAHy2QKSisioxmA/qKkyELSSZjTURWW13IziqnNJgvidvsuP9niUCJ3vCLh+yLnMn8
         AXNB0AFwGZjMBv00PxdjJ+Es2OcXhseerA7+vpUlBqf9i7Eo/CB+PYElWPoN237DEHP+
         lvyQdKl4d8g4TwxuWIEYwR9lFnm4tFuTsU3o8ugiq6QO+d4U9m5QhX7FVE/djJnwppUE
         93mWAlXykBhZ4bFpBp1SSQKPJ3iZb2fP55nXBO5jbgHg+scgR61B3Vrgt2waEWQ4LNgY
         PIDA==
X-Gm-Message-State: AOAM532eV1WNylgFAkVUNPxyq9+SGTWzfOWSRi6uKgdcA6XXb3h4X50q
        EcfwZEaVPFz1CMzYDtYvwTlIuodYODQ6InHaMEsTcA==
X-Google-Smtp-Source: ABdhPJzJzusg5DvAffEXijW//YgVgAEw7k66hAc3zmtsDWl6cUtcCwqNtXZvRricLpDqAodbFZtg27A4gNFf88jXZM0=
X-Received: by 2002:a4a:c3c2:: with SMTP id e2mr8183815ooq.8.1632167026504;
 Mon, 20 Sep 2021 12:43:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Sep 2021 12:43:45 -0700
MIME-Version: 1.0
In-Reply-To: <1631872087-24416-6-git-send-email-rajpat@codeaurora.org>
References: <1631872087-24416-1-git-send-email-rajpat@codeaurora.org> <1631872087-24416-6-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 20 Sep 2021 12:43:45 -0700
Message-ID: <CAE-0n53fVzeAo9ch60_BcfHUvqSRA2SEE-2c8zQhPJwcY7or6g@mail.gmail.com>
Subject: Re: [PATCH V8 5/8] arm64: dts: sc7280: Update QUPv3 UART5 DT node
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-09-17 02:48:04)
> From: Roja Rani Yarubandi <rojay@codeaurora.org>
>
> Uart5 is treated as dedicated debug uart.Change the
> compatible as "qcom,geni-uart" in SoC DT to make it generic
> and later update it as "qcom,geni-debug-uart" in sc7280-idp
> Add interconnects and power-domains. Split the pinctrl
> functions and correct the gpio pins.
>
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
