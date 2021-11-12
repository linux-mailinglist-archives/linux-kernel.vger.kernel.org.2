Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF2044E5D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhKLL5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 06:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbhKLL5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 06:57:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48262C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 03:54:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d3so15028010wrh.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xz6YO9tCi5FN4wwADc5RuSYXbQOxI0FfjZ6/8K/fqrM=;
        b=GasCN4JtdArIIS+5Qcq84OctFN9Jpn3uAD/FCH0Ygj+/MKZXblNqSGH+Zswh5qq5pV
         vl9VqzCF7wn1QPA5OxLualPg+dWN5hGHFNadLz023hDpSTa06QRyke2y/R/9nwgPf/lR
         WAVwVWPjDZTxvsKwciHcisC0Y1A69IjDTNsBGWnR0UXfmWeyPVBF5DadotRaJzsfzuff
         P9DfrJKJQ1JQwk6xtekeOJ+UrNdmNiVOzeBh4WWYLSyRB5BdY2CVvJqMduWGFkQVbuoI
         nv+PJiiyw494bYgAsQvevPDDFfkdQSo+JPrbKYRUzvvPMV7F74H/aeot0ChaCVHRMUPq
         LUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xz6YO9tCi5FN4wwADc5RuSYXbQOxI0FfjZ6/8K/fqrM=;
        b=gl9HdNb1wQ7T471UqHGsGoJYdr82TxmBu327ECnYrNwKAG8lXhYtm2oVvvigyeTZK5
         qSeB3NXFPorpwNAWxs5d5Ku7AimZr6BzmETLM3/cTzku9DGhx3jrkTKb4BTFW2V9qdxB
         21//tX4P/uqVsqkpHd8aY4w+BsuH6RUR57Flgs+6npw4tQ26ZIWdkJs8k0MX6HcosOZ8
         2K6B8bE7Bwbnb6xHlk2oeM2Za5tUHH7nfXuY2WYHTq+EaD6g378y+felharf0HIpwcd2
         2tSK3/jN34SixrP5zXE1HG+H8ZRAiRry42VMgP56vmd9BAi5tbG8o5/jcCypizBBw6mc
         DJCg==
X-Gm-Message-State: AOAM530k7+qYp4zUeoC8jP/7U4I5Rei9Yn3gjvyhMsoJiGNgglv/DkDP
        kv4+S9FY6yuZmlywJqKGrSH3mg==
X-Google-Smtp-Source: ABdhPJzKY1hxDEOL1WG7UNNqDzCOwMyQuKQTZu3mQhH9+LDBluzp2qvZX7JbowsrVOatJpuxV8ukdg==
X-Received: by 2002:a5d:6d88:: with SMTP id l8mr17459513wrs.270.1636718091828;
        Fri, 12 Nov 2021 03:54:51 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g13sm5191616wmk.37.2021.11.12.03.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 03:54:51 -0800 (PST)
Date:   Fri, 12 Nov 2021 11:54:49 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [RESEND PATCH v2 01/13] backlight: qcom-wled: Validate enabled
 string indices in DT
Message-ID: <20211112115449.pg2h3gjzxok6dqho@maple.lan>
References: <20211112002706.453289-1-marijn.suijten@somainline.org>
 <20211112002706.453289-2-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112002706.453289-2-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 01:26:54AM +0100, Marijn Suijten wrote:
> The strings passed in DT may possibly cause out-of-bounds register
> accesses and should be validated before use.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
