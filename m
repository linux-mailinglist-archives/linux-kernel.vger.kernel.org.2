Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49D365EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhDTSDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhDTSCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:02:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5063C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:02:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o16so6494564plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbT6P4sTnHjPVBNP+gpODkwhWALRT12GXZ+BrAU9z6c=;
        b=IK3Klm6cN5YqBN7qVuJ4lLmzTgfg3eCcqpFIHbGZOJH1ExUBQp0z3TU+fzS11X9elp
         nMS/d5adt4C5erUZjmqL3j0sGxixcUKBKBU/XVjwwhNYpvycOGFJUZunmlzn5qykoY3E
         t6lZw6dvzFt5qu67rp+6m0PPfV6Phco9cMnWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbT6P4sTnHjPVBNP+gpODkwhWALRT12GXZ+BrAU9z6c=;
        b=JqTFdnGJDpekjBV8cN5+Dr99/pK6IXjoRYWh4A6lm7sp7lsbvijg4FuXTv9205ni2V
         CIb8aqhIuKf6hYyrKC1l8ybZFlwxiEsha2Us2aEcprfp5p0gzLUxphKzEhkA49+s1t/+
         R5AN+vCP82R2lqtBReDWYCrkIDP5004l3XZ8dbKf304KB3PVydU4b9Rrvsnx0RLtrQol
         HXi5dTnxbws2dxNf0tA4w57xY3lUbLvw+L5sAmPUDLeQQGh5j2waI165nFUyVN6nZgda
         W960jvFN0CNFldtOfCzXwCUmke7gGPL+w+f8DrYDlWuyMhPkO0CvXKrU6OIN9I0P886s
         DnRw==
X-Gm-Message-State: AOAM532yf5c2+H5VRoMl3CV9muvz0aJzPMGiD2ES6HptwBDq6Jgy1IeZ
        j4OKhXzT9pfQlNaPcucYMefym5xTyBRmdA==
X-Google-Smtp-Source: ABdhPJx1smAbs/nJboZ6ngogE39uC6bgXMI37IgfFLX/P1zHxGxFgpyakNxvN7zFAybgcJgGWkDOiQ==
X-Received: by 2002:a17:90a:302:: with SMTP id 2mr6540846pje.34.1618941732683;
        Tue, 20 Apr 2021 11:02:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7a9:7e56:e9c3:13e8])
        by smtp.gmail.com with UTF8SMTPSA id f10sm3103078pju.27.2021.04.20.11.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 11:02:12 -0700 (PDT)
Date:   Tue, 20 Apr 2021 11:02:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [RESEND PATCH V3 5/5] arm64: dts: qcom: sc7280: Include PMIC DT
 files for sc7280
Message-ID: <YH8XIyp/l4C0JPvc@google.com>
References: <1618398783-7834-1-git-send-email-skakit@codeaurora.org>
 <1618398783-7834-6-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1618398783-7834-6-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 04:43:03PM +0530, satya priya wrote:

> Subject: arm64: dts: qcom: sc7280: Include PMIC DT files for sc7280

Please make sure to distinguish between the SoC (sc7280) and the
board (sc7280-idp), this patch primarily adds stuff to the board not
the SoC, this should be clear from the subject.

> Include pm7325, pm8350c, pmk8350 and pmr735a DT files.

How about something like 'The sc7280-idp has four PMICs, include their
.dtsi files'?

> Add channel nodes for pmk8350_vadc.

It's not super important, but I don't like it when things like this get
sneaked in with a commit message saying 'Include PMIC DT files for
sc7280'. I would suggest a separate patch. And please mention that
the channels are for the on die temperatures of the PMICs.

> Also, add the thermal_zones node in dtsi.

This is not the right patch to add it. This patch is about the sc7280-board
and doesn't do anything (directly) with thermal zones. However other
patches further down in the stack of in this series require the
'thermal-zones' to exist, hence the node should exist before these patches
reference it. A dedicated patch adding the node seems like the best option
to me.

