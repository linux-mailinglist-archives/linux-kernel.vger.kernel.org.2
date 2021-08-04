Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AFF3E0860
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbhHDS4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbhHDS4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:56:42 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F81C061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:56:28 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id z6-20020a0568302906b02904f268d34f86so2256106otu.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=VcqvjU1bhq3QLbhM94VyWBNxMowkTRxB2SS37S2YMHU=;
        b=eow6uihoHcyolO28gBNzCMo+OcLJeolWeLIfML7V5HBkrGBB2+RPREORTfmPViraQc
         Utis+pBR22PU8tP3USQ7Vn4auPnVqU04uhgMtRgeHLloRRdcMsaJTc0wdBSyOIf7hiW0
         jA6mZMzCH/w9Oczg1HXmHbHAvA4Dl7a6lj8Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=VcqvjU1bhq3QLbhM94VyWBNxMowkTRxB2SS37S2YMHU=;
        b=UhZpwzA+yOH+rwXy8zLwTGmnU8HrAonTDsSYCXWSYGb0TDurFP18TMT71WC8eiiNNz
         yz1jmoGsWluGxZt4lZ8dW3tEeEba67hD3c+tKgW/yyTxCHu2VDRnZ23TfLduymqmPBvi
         jU5o/H5+Iqb6woKEmQij8pcrZjG3qnN+dWNB2YCbOW0zTSh2xZxING8jZwj0M3hgVBJy
         tlTITmStDnGn3Ss619DnyB4budTFtroBqayX8aF+VwhGl4H+bPzRZJhVIUk45O/obPpS
         7DQ26wfTjyXTD/JVsLWXYZSjfDSwuUvubjxH28Lro05m1wMAYh/1jkLipHbTVZAvnh4D
         7RBw==
X-Gm-Message-State: AOAM530ZCBmXYSobJkPZu9Esb/E62loyzGj8Q8lzD05BnV7ikN7PaYBf
        Je2c89Y3duA09YVEtD9lV00UvesrspL8cwFLdUjjww==
X-Google-Smtp-Source: ABdhPJzr7nO7f94SsRcOCzg0xCQZV6WBYtk8lxSr4M4jRgk8usQPXYX9eUO1QierzYm6lnMFOVeugytO9vsj9NDOexc=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr850033otq.233.1628103387954;
 Wed, 04 Aug 2021 11:56:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Aug 2021 11:56:27 -0700
MIME-Version: 1.0
In-Reply-To: <1627581885-32165-2-git-send-email-sibis@codeaurora.org>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org> <1627581885-32165-2-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 4 Aug 2021 11:56:27 -0700
Message-ID: <CAE-0n53YRQamHMcb1T0oRkSO0_Shhskzpr4oX60UpiEB8ZY63A@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: cpufreq: cpufreq-qcom-hw: Add compatible
 for SM8250/8350
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2021-07-29 11:04:42)
> Re-arranging the register regions to support per core L3 DCVS would lead
> to bindings breakage when using an older dt with a newer kernel. So,
> document the EPSS compatible for SM8250/SM8350 SoCs and use them in the
> CPUFreq-hw driver to prevent such breakages.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
