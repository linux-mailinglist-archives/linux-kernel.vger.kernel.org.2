Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA335EFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350216AbhDNIku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350214AbhDNIjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:39:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275AC061347
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:38:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id v6so28854568ejo.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vhZ72Xg0BjOB8Y+YSTZaT0YeKtDJ45/09IKX2ejXKzU=;
        b=gaiStzZagd8zAkEqqAKTFG81x7D+nyIHgzl6IOJE8VyQCaPv9Iae8hpRTB6pt71rd0
         rrF5QicWAEIMxLCAvXR88QdOcT6rQW+MogInjgTXdHt5a7WRU7Tt0IlKCMWuknUDo2iB
         Cz6jvWZtpXex64fuEPfnwok8HyphGmagniPMJ9VXLuT2Kq5Ify8+RFJn6OBPvwWBsKKG
         K7JAXvVIkrMbcVjibJ2Qwb3WcvdLQ2oalcuerPyLwS55SQ98W/4JAxUA5pG5eT56EgvF
         ogDa+291qqrpmn4kfvIB5djabdzsH2ynqYEWNYpZ4y/4O3/AW1HfmZ+QRUbshgjFL6sZ
         /36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vhZ72Xg0BjOB8Y+YSTZaT0YeKtDJ45/09IKX2ejXKzU=;
        b=TT5YRKtLF+CGUnTX5C2bKGplJXqNW3I67s6coZYddAjP8A51JagSEq1L/gmeh2cc4a
         QPwdo5wxvkUAPwnHaGYc4lFUbH3s2s1HxFzBWlrNS0X7HKSzgj9w/amT3e5C+qt9OD4h
         Ifhp+/tKow/4d5nzBxtntPl1dxDREWC6g1lsJkBTy+9r562WGJEQVjDf6lik9ccpJwuf
         x5URYfOS8Ilq4mP7m5vun/d7uitrdyTK6e1OPKURD3Q1dv+h1NOTHuFhckjf5kW3HeBY
         03xj4QFYg/Cx42Lkl2imxUevHJjGE3FFsaxe60bi5q5A1z3K334CRhWiR4V93npC4ZL7
         T0cQ==
X-Gm-Message-State: AOAM530rCWiu8bt3OdpuJ9W7Fl3znNBOKyVgcrCSZh/ij/3sQE0yZCpH
        0+aE9KwdaBIXYKGTczFHRZutUw==
X-Google-Smtp-Source: ABdhPJzQiYHdbxLZKSHPErRc+GwkdWizSUBzC7Y3CpNNw0NP18kwZPRTExKYXq+MLBKbjHipA6b0/A==
X-Received: by 2002:a17:906:34da:: with SMTP id h26mr27108722ejb.496.1618389502585;
        Wed, 14 Apr 2021 01:38:22 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id q25sm476360ejd.9.2021.04.14.01.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 01:38:22 -0700 (PDT)
Date:   Wed, 14 Apr 2021 09:38:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org
Subject: Re: [PATCH V2 3/4] dt-bindings: mfd: Convert pm8xxx bindings to yaml
Message-ID: <20210414083820.GH4869@dell>
References: <1617976766-7852-1-git-send-email-skakit@codeaurora.org>
 <1617976766-7852-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617976766-7852-4-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Apr 2021, satya priya wrote:

> Convert pm8xxx bindings from .txt to .yaml format. Also,
> split this binding into two: parent binding(qcom-pm8xxx.yaml)
> and child node RTC binding(qcom-pm8xxx-rtc.yaml).
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V2:
>  - As per Bjorn's comments, I've split this into two, one parent binding
>    and one child node rtc binding.
>  - Fixed bot errors and changed maintainer name.
> 
>  .../devicetree/bindings/mfd/qcom-pm8xxx.txt        | 100 ---------------------
>  .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |  54 +++++++++++
>  2 files changed, 54 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
