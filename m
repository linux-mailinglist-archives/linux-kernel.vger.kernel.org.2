Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41A9355D59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 23:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbhDFVAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 17:00:46 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:43961 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbhDFVAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 17:00:44 -0400
Received: by mail-pg1-f177.google.com with SMTP id p12so7298794pgj.10;
        Tue, 06 Apr 2021 14:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fQLaQc5/GaCbi7FW0HmczstHI38aj6TzWQieMfsdo/Q=;
        b=Bp9tK6r2WjaZFdViP9V6O+S6foSWd5VddKkWQmXCyCHBGPzpyT27bqjBZRIFkwKe5K
         jMPzMHse5iFkKsaGBJcZEPdoUpKW42GobU158ptDAxCi9kL6pYIVM1A55ukqtk+kHe7+
         byWIuyFkzlR262P3vZU5Zim0jQrgSrcXlk8saSm7wMeYGdACzoa3PIaH+ndpudJzhZl2
         CcxSthtmPSqQ7AxiWcc8VuGxByVMfqIe3AJaxElYk8j9MVLXrt2IPr8lIFtAO1JtowuM
         TKtGr3F50qgYWe1MkwnBOdvZ2EJNsYisflfh2REIitIfkHoL7YCP3Phj46dIAbZgJVOx
         9ucw==
X-Gm-Message-State: AOAM530/S40TShmu2W4YfYP05R/ObCqy7Vst3NSsLZy95rqXMyNuo5/V
        SrRjAmsRSI/D2DuHmoVlb8kXKdW+b3I=
X-Google-Smtp-Source: ABdhPJxzMprke+6saz2YcivdY4CO3En9U55zbwbKUELZtPC7/SZJGMbYevQneaoHZfD1eIOxr67tJQ==
X-Received: by 2002:a63:5458:: with SMTP id e24mr81330pgm.170.1617742836057;
        Tue, 06 Apr 2021 14:00:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:277d:764e:de23:a2e8? ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id w2sm14367882pfb.174.2021.04.06.14.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 14:00:35 -0700 (PDT)
Subject: Re: [PATCH 02/11] block: drbd: drbd_interval: Demote some kernel-doc
 abuses and fix another header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
References: <20210312105530.2219008-1-lee.jones@linaro.org>
 <20210312105530.2219008-3-lee.jones@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ed6f1b85-ba63-52fd-16f2-cd8777c3fdd0@acm.org>
Date:   Tue, 6 Apr 2021 14:00:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210312105530.2219008-3-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 2:55 AM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> [ ... ]

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
