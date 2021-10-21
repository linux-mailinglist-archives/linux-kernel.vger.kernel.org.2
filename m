Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9438435E88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJUKEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhJUKEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:04:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7FAC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:02:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so195943pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BVnVh393zqs+84Ef+7Cf6iAJo6ZlU0xwDAUM9kkhz7A=;
        b=L0P6ru9Sdt3Kdw1AgYtoHF8/6+sT0zhbAb4VlT1zg5jBKqzZ6i5KpIvQahH/Q/BMH0
         qlxK8YyQyZTYW9N9ZntBirrgfwuq22gAa35X9xnxN5RJR1YjJtI+s4sxlvuT9EJNXzXq
         LFewtytzRkeX24WlzwCzdMhAW1ajQ7G6u0LRtfmG/V+8fOfSpZvCj4WsFaVDeoarN1Kt
         jjP2h1h/VBMrYb/v1g+9o4hGCfq5Ly2JeYFuMfHFQZBpQTT8z/GaclGjKQOJVfVGGUeJ
         4FVN+3AOm4l/FnM1VSiyiwuv0w0/B9JkWjjup3XKCYOgcfE7017HU0qFbTIYsYw/gItO
         98OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BVnVh393zqs+84Ef+7Cf6iAJo6ZlU0xwDAUM9kkhz7A=;
        b=gdCrOiGTOR/3Ochw5LfeUMlzCOV194IM3hfU51ypUVAuG596u6AJB8mdPV40C8JdfI
         gLPrlsJW6Gb9WzwKqIZ3peJQUn22xmZAAFzuaOHNgbaCZyRoiBCHXr2HZk2j7PBTDJtS
         IiDBKwl15uWBn2BkS/umMvP44P+Jlk8nA5BIBJ57wH0Eb6P/SNyRYHEpYTjjC6yShl+A
         LErF+600V2eZqpu/qfzmY/CFOyt6N6tBgRcovpM4C6WMVJtAQPRvQy1ngGFIli9sUbRK
         iTsQig6EIKQtMMxr0+ynzszxdexp7MEqAdLi77fSQ4QIlL5NtguDsJTaT5VBYx30w783
         cR6A==
X-Gm-Message-State: AOAM5322e7ggfHD4CRLSu4DxAIBnwAoV1DH23lwYNr/c2LdiSmz5eWOY
        5L8XRDSmppbCVlozcGu3jU/Jhg==
X-Google-Smtp-Source: ABdhPJysIBA1vMLVVhG7RvAgGrnuG23Fk9MBvt6JS6DNMezsStHl+NQU6P+RdR52kZcPu5WqYgTdHg==
X-Received: by 2002:a17:902:8d8d:b0:140:638:a87c with SMTP id v13-20020a1709028d8d00b001400638a87cmr1049898plo.9.1634810543093;
        Thu, 21 Oct 2021 03:02:23 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id 23sm8849156pjc.37.2021.10.21.03.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:02:22 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:32:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH V6] gpio: virtio: Add IRQ support
Message-ID: <20211021100220.oxwwfj6jegxdvmxw@vireshk-i7>
References: <8ca87330fd348fc5199ad08904ec90cc6a91a1bf.1634723848.git.viresh.kumar@linaro.org>
 <CAHp75Vctj-v8W+LgdVpYgRVL3fLdcFnOFRFg74LeCc=xLD+w4w@mail.gmail.com>
 <20211021043443.snhqpac5ofmxfb7k@vireshk-i7>
 <CAHp75VdKn7Sze9HxN0gBgbuQS2K6oB+SQsufw576Rkfg4-osOw@mail.gmail.com>
 <20211021095229.lqeb7dtxv4ix2vc5@vireshk-i7>
 <CAHp75VcBowxFoseXKwU2VjNcu75ttvHW_sno9MihHL88+oP1ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcBowxFoseXKwU2VjNcu75ttvHW_sno9MihHL88+oP1ew@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-21, 12:58, Andy Shevchenko wrote:
> I admit I haven't looked into the specification, but in the past we
> had had quite an issue exactly in GPIO on kernel side because of this
> kind of design mistake.

> The problem here if in the future one wants to
> supply more than one item at a time, it will be not possible with this
> interface.

Why ?

> Yes, I understand that in current design it's rather missed
> scalability, but hey, I believe in the future we may need
> performance-wise calls.

-- 
viresh
