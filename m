Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CBE3A7DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFOMQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:16:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D38BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:14:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c18-20020a05600c0ad2b02901cee262e45fso984558wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2yUpdKXuueEJR7Grd51IuYKFivE+uAw9SSis33zJwE0=;
        b=pJ2fJ0cJzz+8f992aJWBPE92ZJ03fRJ4kVQTNEhTf0+gaIcuroQkOQ1sumb4hrdxg0
         Qz1ZNFbvo8JPtAjw7VTceo1lvapPx8rrSmaMZqkBwsl4OiqdmoYpBZwl/Vl3Bc2jZ6sR
         cNdWzN7JfnCmWvYm8zhYUkTA/c95PbbWW2vCmc5JiwZIUtgCdKKn+mYwOfprBmJGOQel
         /QnIdsEquLtKIiPYkNl+PzVViWlHZKAyg/lif00XN7L3MXbma4jv/0wjwOMp0gWsT1qQ
         bJTlf4zqb9/qkl6u7quDy8GfpJpUrYmDm2fNSjrdfe9y2e/yqjjtEweUQdiFHlFmmnPx
         gBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2yUpdKXuueEJR7Grd51IuYKFivE+uAw9SSis33zJwE0=;
        b=oHIDj6bVemh36RveHWiVwN3nHX6d/zVklqPpxsO1t7DcdgMjDVSJUsLNj7mGPJvO29
         dY79p7rVAhXth1ZOVqUsYTuP19VaaEXNLe31r/EvFMzJA7tsDzg35WUUiXX4KqroOjVQ
         h85Ow48Y/yBJ/NFG0aBUj97s3C58Lmm1QnKwoWxkS4KLLmBhMcCXso630tBF19NjrsWv
         GjuNqjpK/c736WbamDHUrRjoJkuOoW81sMLCutfe5kEGquEotZjPwginHl3Lznz/3343
         FleUXh3QCjIRZ9e7R2nYF09B+AVO3Iy3Yq37oJeWZ0jNU1KRYvfPa5bbv7d/iM7Mq2jW
         BkjQ==
X-Gm-Message-State: AOAM5305aA+7ZKpvSevXUmY9OkqcDD3OsrSxKdxdBAHKt40WQADr9rWf
        6U5GmDdDy6s1zBybQv5rxhlY4w==
X-Google-Smtp-Source: ABdhPJyp4PycBUYkxUa8hysHsesgw2BBzWPItgzO7eikAq624+brJC6RC8VScKLxLGFqIWHwwdQP1w==
X-Received: by 2002:a1c:1dd3:: with SMTP id d202mr22280104wmd.78.1623759250081;
        Tue, 15 Jun 2021 05:14:10 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id b26sm2045476wmj.25.2021.06.15.05.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 05:14:09 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:14:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] mfd: kempld-core: use DEVICE_ATTR_RO macro
Message-ID: <YMiZjyATKGcBZz6z@dell>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
 <20210602114339.11223-7-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602114339.11223-7-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021, Zhen Lei wrote:

> Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/mfd/kempld-core.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
