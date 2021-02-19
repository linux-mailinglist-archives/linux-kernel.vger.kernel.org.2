Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095E531F4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 06:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBSF3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 00:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBSF3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 00:29:18 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 21:28:38 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id kr16so3052078pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 21:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AvLozyDcH25jRkKKWIyP6Nofr0GcP2Q6XWWMywsDrN0=;
        b=VkYES0oOieTMFVLeyLFq+cdsdLbeSLobjwmQZnh/JL1sSl0EvD3ZpiYJhD+ujV0SdX
         e/uzYfk2jF9eE4cdLxM8cwhFqNP0+HNp5BWuYzHbjngp4xIIxAvY5MXuRps2o/NwTYad
         G5vemYe+XpQIgENNny1DZAoK+JZQ+/klIZxZ6CBZyS9avN6BifKg9MsxyztKh/7waqvB
         05HP0PzbzPoHTwneYGPDgirLbVUvWVPjFPsHT60TAkA5Y9yGgWcvL77GdvAZ8eGBOETb
         w2BQJfY/RZ8l4geiJmqjtjz9DXReCMF8yIQP2aipsIfE9xkyla8cDpE6Yeet6lOrgJxK
         fShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AvLozyDcH25jRkKKWIyP6Nofr0GcP2Q6XWWMywsDrN0=;
        b=H6qHxe43200+1kzqA/xLWZQ21LyIO6Bj00RNtl7/DagJErUgapcbHET6JueyGYD0Ay
         9MJw+7BuHopF8paTZywmqd8CtF6vBd/Rz03wovxbAuexrg1vdSR/QKiH/jNNGtnNZ+0+
         nh/Jiu5L46HkxauVbwsH36n85vhZXu0Ntz/zrOOxOlOQ1bllCZgWly2wIp82OTl9bNvH
         hQyg2nGgcDHPfwKFzUC6BVypQppUFkMNkvx3LI0xi/xvKYnfdTF5XG2FC5ozuVwN8IAA
         tLKxtrHJ0MKuyxeCiQQsmwHqn/+T35EyEDMy0R1VTG1vTOStAsH5Xh4N/yiAMm9GPVzU
         jxiw==
X-Gm-Message-State: AOAM533JLW3JLqpM82YEoNTKwldDnHTsYuZpl9/HrhUjvOz9S9/S1yxm
        7lq0ua89oouC7TFRzYTrso73BQ==
X-Google-Smtp-Source: ABdhPJwuHonCCkc+QV6kYdHdTi/IcngV0wemPqrdlRYYMpMOLvY9jjFxusAiV0C+vp+E025qJjrKag==
X-Received: by 2002:a17:902:e54e:b029:de:8c70:2ed0 with SMTP id n14-20020a170902e54eb02900de8c702ed0mr205600plf.3.1613712517504;
        Thu, 18 Feb 2021 21:28:37 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 77sm5355740pfx.59.2021.02.18.21.28.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 21:28:37 -0800 (PST)
Date:   Fri, 19 Feb 2021 10:58:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH V7 5/6] of: unittest: Create overlay_common.dtsi and
 testcases_common.dtsi
Message-ID: <20210219052835.n4cdtfbfwr33jfio@vireshk-i7>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
 <585e77b8c8a613103f3251af969514f2aa6d0e0d.1611904394.git.viresh.kumar@linaro.org>
 <a87385f3-2795-27cc-42bb-d5aab033e9a8@gmail.com>
 <e8dedc0a-0ee6-3d63-94ab-2be132fface3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8dedc0a-0ee6-3d63-94ab-2be132fface3@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-02-21, 23:20, Frank Rowand wrote:
> Hi Viresh,
> 
> I am in the wrong version with the comments below.  You are at version 8 now.

Yeah, it is fine. I have updated the patches already based on your
comments.

-- 
viresh
