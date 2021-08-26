Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B2F3F8FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 23:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbhHZVCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 17:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbhHZVCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:02:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A06C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 14:01:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so6638627pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 14:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eaEOFUvxAPmXM8YqjP9hrSbXI6bvOJzogOXXHMDAi9Y=;
        b=kh5LnsgUcKg/RvMIIzNT3fv4UD2swPDy7glvvQYE0ZB8hjzNwGEJ9FAnb+qH7eQ2Lf
         Uw6ey7PjUjaTDM1RGQeUrJ4eLdFcvGwAxC/y97lHAEs1ukzs4EqXQA9Y0K+tjIbH4gb0
         pjtj5cMK2g1pa9S3lZy7gZ75v/ENCr6QCENHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eaEOFUvxAPmXM8YqjP9hrSbXI6bvOJzogOXXHMDAi9Y=;
        b=a40EHiDwJXzE+6SpRSxEynglEH1gXc9ZeeYJPSQzLWtz90H5PzRvhtuBfhNcy6fzU3
         SSJvF5gROH1sYPKjlIBpYtOi/VVV0/qEvI6PQ/t2RGDuk5LGa0/+GCKKt2DOdcI9wCPs
         J/fFkszl7G7WOh2krwT/vCcYY8SpmrygYqfcLCvYqRRgb8uI5eaVjs+F2YxoG65ToS0x
         fHHwEkhbLY15F7BzUJRWn7c5Sr4Sy1waJKckQ17/SCcyruxNZjtWQ8nkYTzyyMwsbUQt
         7Zbqjn+WvMvbuiw/0v/s1am9mN/gRj8KezqctMr4P58hjD7bwykHqpZYOssy2ItAIVpV
         fDkw==
X-Gm-Message-State: AOAM531dKdbEpnl0KyFIwQit24cshx5QfLQC+H7Abry2ng5KdjzlX4Sq
        8CoA+dvvdwHnTN/TyuOMI0mPMw==
X-Google-Smtp-Source: ABdhPJxlBshtNEiT2wxuAMODJVNJvZKjjqbFwuV5Epe2WvhKQXV+AW7NuuyXydGv7EM8R2PMxKesCA==
X-Received: by 2002:a17:902:c402:b0:12d:b2fe:f0f1 with SMTP id k2-20020a170902c40200b0012db2fef0f1mr5214913plk.9.1630011706372;
        Thu, 26 Aug 2021 14:01:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:bd0b:bcb8:ebdb:c24d])
        by smtp.gmail.com with UTF8SMTPSA id r14sm3825563pff.106.2021.08.26.14.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:01:45 -0700 (PDT)
Date:   Thu, 26 Aug 2021 14:01:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajesh Patil <rajpat@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, sboyd@kernel.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Subject: Re: [PATCH V6 4/7] arm64: dts: sc7280: Update QUPv3 UART5 DT node
Message-ID: <YSgBOP/hMob3Ff+4@google.com>
References: <1629983731-10595-1-git-send-email-rajpat@codeaurora.org>
 <1629983731-10595-5-git-send-email-rajpat@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1629983731-10595-5-git-send-email-rajpat@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 06:45:28PM +0530, Rajesh Patil wrote:
> From: Roja Rani Yarubandi <rojay@codeaurora.org>
> 
> Update the compatible string as "qcom,geni-uart".
> Add interconnects and power-domains. Split the pinctrl
> functions and correct the gpio pins.

You could say that uart5 was formerly treated as special
(dedicated debug uart) and that the change removes this
specialness and makes it look like any other UART.

> split the pinctrl functions to match with SoC dt

The message should say that this is about the 7280-idp

> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>

The change itself looks good to me, the above are only nits to improve
the commit message, so:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
