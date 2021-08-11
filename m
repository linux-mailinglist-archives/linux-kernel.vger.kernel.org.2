Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF843E89CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhHKFjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbhHKFjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:39:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B08FC0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:38:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f3so1233175plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9C16aGrQd4DbmatTkdrN+5r9o60LDqyKnHni66oi5yA=;
        b=ay0Z1NCDG8WPAn0RRxsixr6dpvr8p3y035Y6DM7CKPLF66XtxVf/sGr/q2+7hVyGVL
         xcflIio6ixnfRRGtcl/5KkgLtZOB7FIEkp1fyih99x8YgYKnxcwd4L96wIA66wTHDsS6
         De+km3kdPeHefFd9x6AgF1K79DBr4IUgdVRzH6rJTP0gfnRgWkwSaUCSdvIsdz0pE29k
         Or/CuxzYPn3vrRDz3/rr4lIpxBYsK1B96T2ed09VcExRXsLwDGAfGQu9RLou53lMuYy+
         mDzGmi1oL4rp6XLd3heku9vLzLtzx9jnhtzCLTovxxPd6wZpbQxYW6reVTjUdWqNGGVL
         6/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9C16aGrQd4DbmatTkdrN+5r9o60LDqyKnHni66oi5yA=;
        b=JmnmKwXSzR8vXgoU0neIJkioCWr6wBbe87KhrWKe4EtjW4W/nPt/dGYHBS+KpP5bfO
         fCEP6xPcQVAhVTq26RdUENrNguQ5JKpwCbB9JxbB6NF0fdiMpV4oQ37Zbzz8fSkWZl+A
         B6T1RcBmQvvrgjC+iTUxj5bJO8ZXGmVkYt9OtCe0QO1RWT0prPKbxet2AAif5w9HZRSU
         boe/8Buf5dObklozcxe+oUZolqRuE07f/sO0oqnuAwSfa/lJ9vX6XuirFRXSlyJdNR/L
         u97W9FNNLvCbtshOHKwOpWKokHVCMESGNP/W2A35d4R2CxmeAOdXukOew8Io3MERAXNA
         VMfg==
X-Gm-Message-State: AOAM532JdeS1fTTfLWfrkp/LvuQECs0Ij3gsCLUZdexL/HnSiRV3fiIP
        elPdJJjULOT58wAI+OxR6GOWDQ==
X-Google-Smtp-Source: ABdhPJz670d+mhV5NHPn4IBMMT7nwf5ci7sI0cLkCTuYIabeyKuBFTWpGjH65c1d6erAUk37z2/Zog==
X-Received: by 2002:a17:902:9897:b029:12d:17ac:3d40 with SMTP id s23-20020a1709029897b029012d17ac3d40mr14926473plp.67.1628660336982;
        Tue, 10 Aug 2021 22:38:56 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id o9sm27927871pfh.217.2021.08.10.22.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 22:38:56 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:08:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH V4 0/5] virtio: Add virtio-device bindings
Message-ID: <20210811053854.37uf55p62r525ees@vireshk-i7>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <20210804035623.flacrogemvjina3o@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804035623.flacrogemvjina3o@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-08-21, 09:26, Viresh Kumar wrote:
> Michael,
> 
> I hope you will be picking this series (Now that it is reviewed by
> others) ? Just so you know, Wolfram needs the 4th patch, 4/5, to base
> the virtio-i2c driver over it and has requested an immutable branch
> for the same.

Michael, we need an immutable branch with the following patch:

  uapi: virtio_ids: Sync ids with specification

This will enable Wolfram to apply the I2C driver for 5.15-rc1 and
maybe Linus as well for the GPIO driver.

-- 
viresh
