Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0297C396987
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhEaWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEaWGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:06:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E8FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 15:04:55 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so12263725otc.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ue5n0UpI5EqeaS+j7+t9xnc2N6UugI+y/wlKjXvZ9B0=;
        b=tQae9Nr2rxLB0lFr7vREg1l/5tofxK6SHjrIwZUN/4EAM3zC3cbO2xQJg6KtQ24jz+
         fWfNXqs4Z5P5sqyBew2Owpq1QL/8P5fyONiJQ6ehvJCx2DyqEoFkvhpywx98FDB+jp7E
         gbBNnYT9EtrB6SJY7y6Sh0omYq/WNUxFEfEDtvxHaJHf6uW0MGQlvwnS3fCqbY7gZk/i
         dEz5f0BhlXez/vzQpG8TcYn12w83Ri8zq1LQK+8eI2qtBBC2CYQeast4ai3R2rEfciA4
         s2TPKzK+hpdi2YhOXRGMFwnAgMZNz27elJAQ3HjHokhBB3jg/uJklrjNbIH0uoKU6VrN
         +2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ue5n0UpI5EqeaS+j7+t9xnc2N6UugI+y/wlKjXvZ9B0=;
        b=Y5cE+RMZVdKA6dgyOGX9nh4CWJIawl9bMC5L0uQBUVb42/w/XUVcEmOKM5VbaW3skB
         xw3544NDJ40Nq+IHE8Ii6dwXxOLyvqbN3F0j6XwIoeORiOTm5GNdeOz2G26ebtMptpqP
         pzryaR/R1uU3Dp6xAvS14aBg3NNNtT/IWuqUxGB3t6gQ1sY4ruBywXyNjG1fFv69NNR/
         h6hd50aGkMpSOu3QkRKFVzXf5wrmo+0y2+i1qiudhzsTmEWmujBp4B0oSyVLF/tr8SHy
         7m+I4Fabm6Z6c0wnFRI7/UioKEMRvuagX49AyCBEZq/TmpS4OVp6cmRXAMg2zJ5R4a/I
         2iOA==
X-Gm-Message-State: AOAM531O5EMasCWbfDdgOYrQ46Ch48+ZTowGv4BtAYu4CByZ9JtqficL
        4RQENYsBzo9FzKZmFXcjkEXn5pnd1Rr6bQ==
X-Google-Smtp-Source: ABdhPJxcwoUVpexwvq3Wsn8EnHbKmjTIh8RHtDZQJb8ubOn5aemktzs2jcu5a9r02dk1rNsVjFPZrw==
X-Received: by 2002:a05:6830:2703:: with SMTP id j3mr7260923otu.140.1622498695281;
        Mon, 31 May 2021 15:04:55 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f80sm1999395otf.32.2021.05.31.15.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 15:04:54 -0700 (PDT)
Date:   Mon, 31 May 2021 17:04:53 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sibi Sankar <sibis@codeaurora.org>, robh+dt@kernel.org,
        sboyd@kernel.org, agross@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] reset: qcom: Add PDC Global reset signals for WPSS
Message-ID: <YLVdhU3Zz/TWtwCX@builder.lan>
References: <1619508824-14413-1-git-send-email-sibis@codeaurora.org>
 <1619508824-14413-5-git-send-email-sibis@codeaurora.org>
 <0c5f747fe0a3f757a4160e4fd28cc2b56a57a39d.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5f747fe0a3f757a4160e4fd28cc2b56a57a39d.camel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27 Apr 02:58 CDT 2021, Philipp Zabel wrote:

> Hi Sibi,
> 
> On Tue, 2021-04-27 at 13:03 +0530, Sibi Sankar wrote:
[..]
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> for the whole series to go through the qcom tree, or let me know if you
> want me to pick up patches 2-4 next round.
> 

Philipp, please do take patch 2-4 through your tree, that way we avoid
any potential conflicts in the driver - and things will come together
nicely for validation in linux-next anyways.

Regards,
Bjorn
