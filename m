Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D5365C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhDTPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhDTPlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:41:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0022DC06138B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:41:17 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t22so19562545ply.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RftfUOzx6cuYVUbwyHqCRiPh7HztqAU4DiiO5zyA3ug=;
        b=fsVuqnPUMW3p/omuF7n1o4se+xOnZjrzVPiRse/XOC7wqPl2IbqcuN+ck/bjnmuuMz
         yksubT3cxv+iKgqnJk7WilF5ckB52ofvx7nRgJlokICnawZH83nVUJ42GqSJ2XWAKCSU
         VjImonYgA4W9Ecy29FUhtSqAWu5wFdtMsP+q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RftfUOzx6cuYVUbwyHqCRiPh7HztqAU4DiiO5zyA3ug=;
        b=MHdQ4YZol1swPhQnUHIALQuzeTc3xoZTyALJ/j3EJXuMghKOUcJ0OsiOTJptfjEoiz
         tQVcHZE0KqvClivEE4zXloCqh6lSViqEm4f7BQOsT3tBQ8vezURxgImHvF2ASEGBxtkL
         8ODt3CMPwWmyTHPrUdwEF5TmyEMY1GkAP85rxhuPPELl8KNzJkVnC+zGz5TcUISTOVVm
         9krhqMNoLcHaZm5XyYMgW0FR1ShZaDg1epRWEp7CkfNqJBWkoNXaAiiU1ZkRxbL19x9E
         mHF4or28EarJwLT92kFQcriv+WRsBgDi/X4voJfUNF8SX5ItFibg4gBAfHqPjZix4tVM
         SyYA==
X-Gm-Message-State: AOAM531rt3S0ialzYqCZwYEqYNaG+mRjhhP1oKpXOzQ7Yud7kfqwVB8B
        TYPzbUv88vY9JHJaLmQRgo9OmKNlldONFg==
X-Google-Smtp-Source: ABdhPJyWJPfsuWZo7IEr8dHnuW0/nVwSsCN/bl7cQL44qRDfQmhRVvVzLKpaT1eUJ/ohOgU3tpWf8A==
X-Received: by 2002:a17:90a:cb85:: with SMTP id a5mr5831006pju.124.1618933277027;
        Tue, 20 Apr 2021 08:41:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7a9:7e56:e9c3:13e8])
        by smtp.gmail.com with UTF8SMTPSA id w6sm2544287pfj.85.2021.04.20.08.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:41:16 -0700 (PDT)
Date:   Tue, 20 Apr 2021 08:41:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V3 1/5] arm64: dts: qcom: pm7325: Add pm7325 base dts file
Message-ID: <YH72G/Jj7LunQzLu@google.com>
References: <1618389266-5990-1-git-send-email-skakit@codeaurora.org>
 <1618389266-5990-2-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1618389266-5990-2-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:04:22PM +0530, satya priya wrote:
> Add base DTS file for pm7325 along with GPIOs and temp-alarm nodes.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
