Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45E36EAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbhD2Mnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhD2Mnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:43:51 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50D9C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:43:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d10so8673113pgf.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=crS9ky0D82Wt0+fljR8qv3pG4hOh+6EKRJ+LxnWrSUM=;
        b=Xi9/ECHF1kiL4sZQf8ePRrM4sFvJothu07czMfM7+0rwkeT5dz/ETyQhkXAU5BFSQ8
         0dkUq2GFrQNUGjO3JTGEikhD+BcmDJ1rRkFvQ2sfpG5mJTu4idtkCnYXLlIKP+inBLP0
         xGd59D2SvVU6Q7vhQ3ckga/4AVopXB+jq3ntU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crS9ky0D82Wt0+fljR8qv3pG4hOh+6EKRJ+LxnWrSUM=;
        b=Tp9ewSnI4UR2+Ks6egwLQxWUrD8bBZtzrbnb8816SvSTjHDjPaLOyds3DesVOHIV70
         B4TXjqgmhEd9qwNAMUuQ5lFScLrYQtu3Q5fzIqhrEadbAw4fxoEhNoGyXH76gybF8Roq
         v/Ft5tNkaH5scqfv/Zs34qgwuXXHW4OlsQa019Zs3k5V7U8y4pKv1UAoIYSTuTNsTXGZ
         i/QVYl2ch9yBferpVFKHbTox5cIiCpZv2NB0oL7jIX9eZi3gEUmv3xYi8M/O8/yyYtTk
         KIrJiSXxBBBc5BUzujEzRdO0szWMRjTx51QeVK00FmnTz1T2IHlFqtgW5yuL10PPMdvx
         nglA==
X-Gm-Message-State: AOAM530URSFIDqLzf70duVV7EQpDoqeaZ7TTOxPG51J5QCI6tni+NtIL
        WUCbnOA+RPDR6ns1T7DZ2+KZ/Q==
X-Google-Smtp-Source: ABdhPJz2MzWWnfUD0vMOFMEvRNGbWDQvlbTZcrSRb22eap40StYH4HAhvSDiQFk31bfH/TttXMOHyg==
X-Received: by 2002:a63:5458:: with SMTP id e24mr31905415pgm.170.1619700183382;
        Thu, 29 Apr 2021 05:43:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:59f:ddfb:1a03:fe23])
        by smtp.gmail.com with UTF8SMTPSA id k17sm2467759pfa.68.2021.04.29.05.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 05:43:03 -0700 (PDT)
Date:   Thu, 29 Apr 2021 05:43:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document google,senor board
Message-ID: <YIqp1g//jV7gxepo@google.com>
References: <1619674827-26650-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1619674827-26650-1-git-send-email-rnayak@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:10:26AM +0530, Rajendra Nayak wrote:
> Document the google,senor board based on sc7280 SoC
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
