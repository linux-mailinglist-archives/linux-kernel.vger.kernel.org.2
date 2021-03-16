Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7A933DD5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 20:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbhCPTX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 15:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbhCPTW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:22:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4D7C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:22:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a13so2323558pln.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0VC+p+Z8Uz6RVI2DpAr2wRVpa/92FQmj4xytfLON9UI=;
        b=HS1C5XOvmd7BrynnHitq9flEQ41kZu/HfhVJrdM3Wag4PbJl62PxYlebxiLibkwUKR
         pZFdNKA8aEYWSE0WSRB+4maz698wfg0hDEdbjwqF9dfuXA1ws+CxuULIX2yUaQU8HSSL
         REPwHgG8frFMCQ/afNc57BYh41MpfZDvj+3i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0VC+p+Z8Uz6RVI2DpAr2wRVpa/92FQmj4xytfLON9UI=;
        b=atK7+/02lmK8vSuszhojWd2Atoxeaj+uau5aoXfLzAnWd8i9fUFbU6Q0Xe/WNQ6+At
         OTdENuz169kfqeCbvxS0bv36E9ExEMMx9lvOsS/cunez255EqyE6NRs5qOpmGdYkp4yv
         fBQ9P8y9H3wBa79QHl6pxTZWPHt3Yg+fOQsQWCmowBgH6HDyJtZzJ4qTZe9zapC6z7UF
         X3vOLeaGaZOJn6VB+6SF19u5o0zGU++QiqfzllhulHHU9Ipl7QkQ2tTHHrfnoEkJCmM3
         n+lEA+TY5iTsZZqgYvDOanhXvyxIJYLfPCAhb5McPTnTOUh9lB8i2ItmDQf9UZ1diq07
         HnVA==
X-Gm-Message-State: AOAM532tSjlbe/5T9d249mqk6NkVOynMPrQweuyDwYnafb+1mWZCbykM
        uzJvTFiFUGyHScWdxTt1NhIQdw==
X-Google-Smtp-Source: ABdhPJwNZFJvq1N7CeA4f6y4eYd3t9RW1It3cXNIU2ootejNNuW75dc2bfD+qv1tMWCU9H6/P13mCw==
X-Received: by 2002:a17:90a:5889:: with SMTP id j9mr584736pji.69.1615922578251;
        Tue, 16 Mar 2021 12:22:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b471:7d:bf21:d7dd])
        by smtp.gmail.com with UTF8SMTPSA id y22sm17073992pfn.32.2021.03.16.12.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:22:57 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:22:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        David Collins <collinsd@codeaurora.org>
Subject: Re: [PATCH V2 1/5] regulator: qcom-rpmh: Add pmic5_ftsmps520 buck
Message-ID: <YFEFkNi9JCr3lDlN@google.com>
References: <1615816454-1733-1-git-send-email-skakit@codeaurora.org>
 <1615816454-1733-2-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615816454-1733-2-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:24:10PM +0530, satya priya wrote:
> Add pmic5_ftsmps520 buck as this is required for PM7325
> and PMR735A PMICs.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
