Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1A5345AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCWJWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCWJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:22:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAD4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:22:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z1so22638301edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qKUJ5cS7t5qZrFEe2OGQcQD9LzNwI7HBU0FIAsskN/M=;
        b=aD27ISn1dwlQwTmPHimEchFsWtWkh/eA/7UG/zpFNJfszFfS1ZmiNzS9qRIl8eJxw/
         aHrgWmKxFGSuOtLAcGQ/+kedlQA+dzS39WIWPRWraIaF2XjQSnv58t0tm57XByUDXNGc
         xohbxzUTUf9Zx0M3/2A2McNCV+fbKmWlYE/C2aQXjjzK4q0jpt2fPKAV+VHR4bTTdwR5
         XsAZP9PKla9GOyAmAhiYZORJ4y2NTTo7ybDDFRgkmvJOKCMYIAmJG6H166rc5bbHndOD
         xbFnawMwaIL5f2+VsOsyKHX5B+4lyHb+VQ54bzGAvTkP9TpT4mNrlTzlVS15ITTayXsJ
         qmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qKUJ5cS7t5qZrFEe2OGQcQD9LzNwI7HBU0FIAsskN/M=;
        b=BIS/W2oACGAqeEe3HoZIFiMxtVb9Hu80Wx0wzNNhzf4rZJADYcJlJL0bFAHBya44pN
         7DG/Wh6wvN0d5/s3TV2SW5Zj4hp8Vkl8FqVCSzgwkofZQls4hQx22iouoeqXbxN2YZjN
         nOgjHfrg4ctZSN/tqVKbcik8IbDazZn2WJpbEyAM7UYQ0kTfyKERVYhQh+lBhp++SrVC
         gqQQ/qbN3DUWZg9D02itHxmNoqxoys8R3xC1izoWcK3VY6Er24KZpIxFAR8Ki0Nky8ly
         5p79dZny9aS+ckl0/N+rQY8RyfY3gGQmFdeBZzayujaZdRgf4CIEiCrMdDvytX18L403
         4WjQ==
X-Gm-Message-State: AOAM532V8NFPxdZF0D/CZXj/Brf2TKublw59Gu5aleVfIbBX3QKDl7OD
        A9xrpsfZn7LmcTmBLSdoT/L4CGfBF1yV5w==
X-Google-Smtp-Source: ABdhPJymv+eT/VmgPO72vzdJd0KUcu1IYzF5CgkP4y9GYQpwFt9fMFxSOQ5NwBiMOn3xANlPcKBM8w==
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr3678507edu.252.1616491326308;
        Tue, 23 Mar 2021 02:22:06 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id w24sm12886573edt.44.2021.03.23.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:22:05 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:22:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] mfd: intel_quark_i2c_gpio: Remove unused struct
 device member
Message-ID: <20210323092204.GO2916463@dell>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
 <20210302135620.89958-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302135620.89958-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021, Andy Shevchenko wrote:

> The device pointer in the custom structure is not used anywhere,
> remove it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
