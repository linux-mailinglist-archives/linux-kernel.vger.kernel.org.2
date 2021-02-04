Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAB630EC29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 06:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBDFmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 00:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhBDFmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 00:42:18 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297C0C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 21:41:38 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i63so1400867pfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 21:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aCDGFq4xRBK5mgfCD5DBK7C/OlTDtGq3KySYxLnb6V0=;
        b=e5vgzHEOJTeTAfepoItU4E8Q4+EL3HLGsErqa8A12qTgtKvW2zwh0eW3rz25fl4Yza
         002S2DgGKiJL1Ry7CKyPoEHcNIMKsLz3cJOMPWHjbdr9w6Gq9uAZPMyEHk9g0Ja+hcmX
         6Mlm7Y99JzrU4djv0+xXxc15oZ5GOt2dwb/GDciH+6ATNh2Ep+YWqtrJTsyN7CgN9cgJ
         Uo2ozxZAh1+QpK4Vi4upH9fV/XhmPS2XFACFi1T9gF6sEIs//lDpA+RlqGdDX6uQqQyv
         tD4ioTmbvuCS5p89gJiNlrSj+pDKLHD4lzpCXntEq+E94XJy+hhmEhbRaA2iaq70gfLp
         rj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aCDGFq4xRBK5mgfCD5DBK7C/OlTDtGq3KySYxLnb6V0=;
        b=jab8spd3+fCs/n5EezPZjhPo+JjLru2X4bOoHO0YDPbRntKa+BWodMkobP6a+kMhiC
         r5Ot2DkaXuKwesY3aHtFpfI20glbs3E3/r4EtEytq0bouR1bZOVHnOc9o9Nmxh2N7Oca
         TCMAKZRHsG3wnZXBr4uNNCirQ438FELj9j4fBFXemghIe6PKp6LkW8Q1LMIsRkTr6QgS
         UOIrnxvOVRgo5xpX7F81tc/Fsldt+xz8lXVU6kGBb/+On5BJZsZMnCkB4c05iqQtDQdP
         cDCTdTpbvsW5jYOATE/Wc68cG3+KJfsm5tIKshnpUDYmJRrTXxhXnxCmedf226lKp8Iq
         bA2g==
X-Gm-Message-State: AOAM533xHA7UKD2lNyHmMN0dgr8uf/VcTfzJSeJi/tG1HqB/PgB6+NMv
        65sDFUkFgLHHQd7QUFyubiYuxw==
X-Google-Smtp-Source: ABdhPJz+EIkvKW6QGPS/paYHE/y25MQxjPOSqBSAdpajYneGEMHYsouDucbelHEyI9TG4/cMV0Nx0g==
X-Received: by 2002:aa7:98c8:0:b029:1bc:4f59:4bc1 with SMTP id e8-20020aa798c80000b02901bc4f594bc1mr6439140pfm.72.1612417297692;
        Wed, 03 Feb 2021 21:41:37 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k10sm4423518pfk.0.2021.02.03.21.41.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 21:41:36 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:11:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        "MyungJoo Ham )" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v5 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20210204054133.sb6vymf56u43bpwe@vireshk-i7>
References: <20210203092400.1791884-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203092400.1791884-1-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-02-21, 17:23, Hsin-Yi Wang wrote:
> The devfreq passive governor scales the frequency of a "child" device based
> on the current frequency of a "parent" device (not parent/child in the
> sense of device hierarchy). As of today, the passive governor requires one
> of the following to work correctly:
> 1. The parent and child device have the same number of frequencies
> 2. The child device driver passes a mapping function to translate from
>    parent frequency to child frequency.
> 
> When (1) is not true, (2) is the only option right now. But often times,
> all that is required is a simple mapping from parent's frequency to child's
> frequency.
> 
> Since OPPs already support pointing to other "required-opps", add support
> for using that to map from parent device frequency to child device
> frequency. That way, every child device driver doesn't have to implement a
> separate mapping function anytime (1) isn't true.

So you guys aren't interested in dev_pm_opp_set_opp() but just the
translation of the required-OPPs ?

I am fine with most of the stuff and I would like to take it via OPP
tree, hope that would be fine ?

-- 
viresh
