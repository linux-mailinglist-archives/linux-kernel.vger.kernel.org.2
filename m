Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0AD340B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhCRRSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRRSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:18:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19676C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:18:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so3487068pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q/dGxKGWMn9sfMz1b8CCSg+fiC/dJhHGZJq+3SdzjOQ=;
        b=WVWbyAI5kfosqOyzscCScjiH7ZCnvPLgynzAoQ7C8JvvuMRmVO+nfLQVdRcBcbhBl3
         3CAeupwS4atfV2Uk80gYt5uTO+qtyNw+uAc7j/oep/H3uv4GOvIOY24izAyzE2DQ8VW7
         kUqFutxVa5UtqjSHyhZiVeHY4i4xf4tXelALM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q/dGxKGWMn9sfMz1b8CCSg+fiC/dJhHGZJq+3SdzjOQ=;
        b=HbBaGhtb14ZOXwABj2L5ZD2aqWhd6zJLH8/UO6fPjtrFW+3NMho80L2h5JLdT9y1vI
         eiuDagQBgVfmqS3CRfb+THfRswCQ66jnXGRhBkEABOZE/00AiaunTwxxy6df/FAEPZlM
         C9mfb0ajlNrx9qJ29b/bzyptpoIj619F19GmiZNA74WmzPQvQzBDPxUM3VNkCYHqBGGg
         2z2d1kjPpXIjKtmDPDbhTy9WL5rjgwnnx39BriEY8ew1IrG0Cl49EuaiBpWfUJYZs0nG
         XtuMZkGYMmARWT7/EqGIqaUZ9VNQqH4Fs+AIdwuJrfMuHxP1baTYcyECWsuV55qs0BOt
         GR1w==
X-Gm-Message-State: AOAM530qWZCe9kMCRzZVBBHCPPAnp1qqxmO5raYsXdCgBVqo///8GBk+
        ImRGL+kfAQ/KPDWV9IetMqU7lA==
X-Google-Smtp-Source: ABdhPJwjpWZE1h3EfmpA8uaekrYi2l/kcDS5O6e6heHIWgnAfkX7fPzdsgqyeP70KZ8aaKjMwXs8Rg==
X-Received: by 2002:a17:90b:f15:: with SMTP id br21mr5479022pjb.234.1616087881552;
        Thu, 18 Mar 2021 10:18:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3cf8:6a09:780b:f65d])
        by smtp.gmail.com with UTF8SMTPSA id r23sm3063398pje.38.2021.03.18.10.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 10:18:01 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:17:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: sc7180: Remove QUP-CORE ICC path
Message-ID: <YFOLR4pem0mRFkoQ@google.com>
References: <20210318111009.30365-1-rojay@codeaurora.org>
 <20210318111009.30365-3-rojay@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318111009.30365-3-rojay@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 04:40:09PM +0530, Roja Rani Yarubandi wrote:
> We had introduced the QUP-CORE ICC path to put proxy votes from
> QUP wrapper on behalf of earlycon, if other users of QUP-CORE turn
> off this clock before the real console is probed, unclocked access
> to HW was seen from earlycon.
> 
> With ICC sync state support proxy votes are no longer need as ICC
> will ensure that the default bootloader votes are not removed until
> all it's consumer are probed.
> 
> We can safely remove ICC path for QUP-CORE clock from QUP wrapper
> device.
> 
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
