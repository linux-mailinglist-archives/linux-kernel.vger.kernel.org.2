Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C70315F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhBJG3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhBJG3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:29:31 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A32C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 22:28:51 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j11so632602plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 22:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImBUIA0A5z4zu1ljmU+gZzbb8HAuUJogg1wP+5zwUbk=;
        b=DUw6eMkU0eBhuCSORTKGS+JyCx2qs7yzRH3yy9YVkPlJaHT6ilo6P/B8SU8cfUIq8V
         IP/mfrKYv7YGcNgdBOgx7+qGiHackEqMtJcxDiz/swUxpTsT0NoVWVnUtJruN+QKZfPX
         b4+Bd/jhW0rlSuQKQkWKy0G4HWwQm2QFH3S5M4gczrElNVgSIWp94MLTS9buNuzhPV6C
         bXfp+nNrImP1jxAPVz15NivSPpcc30bf199p4OyaSmsWPqvDxlCiCaKx0jwFOfeFz0Af
         HF7azcgqV4BanjHbWgS9OoLhOJoIoUiydPSNaw+ZtcnweEP/T7NRX+qNg+HyCY6Y7xcG
         LEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImBUIA0A5z4zu1ljmU+gZzbb8HAuUJogg1wP+5zwUbk=;
        b=OojfuDEBSRKs9tF5PZQahCmUUaXYunA+kG49/Q+udarzS6HtsZE4Y70fhL4f9JLa7M
         14vueaPBEsz2uijoOILD3Vf6btTag8tcwdBiO5dzIoCv+N5RsFLe+QEuZGNKIHVBcKjV
         ogLackibb0RxbVp7IazlmSkRBTLfJF/OQ14DbdzcimM/5wAarodyRI9FpkIfM5ntxuEb
         tiBPTfhgoiQcmMg8p6+c7gYC0ac/y891UYIbIhPPcNJwvfNqrPXj8IAnYLnGi2tQxMyh
         DhtHxiyRwGgcgs9C3fYLAym6P1ZtW08Plg0zwyyIKKFAbqCGX8ZYieeeLeU1ahknHCKJ
         xkdQ==
X-Gm-Message-State: AOAM532rkRJtCC4b6o4TxtAkDZckky3biYpTG0F16ZL11UnyGZFQ2bhp
        m2Z0ZTB7s/E4xHzSaIk0hI4USA==
X-Google-Smtp-Source: ABdhPJztSTXXotJS8BlNUGcfUb+YKsIm0OTEolA60d1LZr8gDdu5xOqjO3uSb7OI9QolMT+ltUPDGg==
X-Received: by 2002:a17:902:e741:b029:e2:a9c9:69e3 with SMTP id p1-20020a170902e741b02900e2a9c969e3mr1687711plf.28.1612938530672;
        Tue, 09 Feb 2021 22:28:50 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id ob6sm847416pjb.30.2021.02.09.22.28.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 22:28:50 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:58:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH Resend] mailbox: arm_mhuv2: Fix sparse warnings
Message-ID: <20210210062847.tptyycw6au5baype@vireshk-i7>
References: <db5dd593cfd8b428ce44c1cce7484d887fa5e67c.1612869229.git.viresh.kumar@linaro.org>
 <CABb+yY3QkiZqWLJ8LmXXVy0n-UN1YxxbBOMcnTmHTe6WLeKmpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY3QkiZqWLJ8LmXXVy0n-UN1YxxbBOMcnTmHTe6WLeKmpA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-02-21, 00:25, Jassi Brar wrote:
> Yup any bug fix should be sent in rc. But this, imo, lies on the
> boundary of code and cosmetic issues, so I practiced discretion to
> keep it for the next pull request lest I won't have much to send ;)

Fair enough, would have been better though if you could have replied
with this earlier. I had no clue on what's going on until this email
came from you :)

Thanks anyway.

-- 
viresh
