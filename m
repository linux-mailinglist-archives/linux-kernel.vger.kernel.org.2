Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A92F4015C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 06:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhIFEoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 00:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhIFEoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 00:44:14 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C45DC061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 21:43:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so3020639pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 21:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3zWdOueDKtAVWRvfy9UP9yg3qL1geWqf5YsZ2lnxtUo=;
        b=pHag5NqN7NmLLdCbx6/9eOnpQtF7ZlLiKc0HpXCLEHtYhFph+QMys170qxyVKIziAJ
         enhc3w7ko88B/HrujeSJFW01Tsp70YxHU5h7+qcxRx/yPlTwmNSRAygOJ/VqxGqskb78
         n8uNACU1NwyC3ZYEZa3Zvk2c+yxY/GkY692LDiF6q15ZWgGC74nDpAXLre+X+TESFFnL
         DMkSwFFLmbQlek3KbcJp8a/1dp0UEvsdaG1SQv9RSw0l9n26nA05ViLHUoE2ydq/s842
         jpLOLaILRNKQHmHgsHh1CiqQpd1G8rrWRD6m0F8jrPKzpRL3gtF128GTM3KoKaW4P0yj
         Cslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3zWdOueDKtAVWRvfy9UP9yg3qL1geWqf5YsZ2lnxtUo=;
        b=m1XJ5clkCcAerrs/WJh6fPhId7qDTA4ib4fF/DXULiZctE+F+FZ6befEjcu4K138cR
         bUWkxBgFrjN5YY0IRKBprzl6EtSfdbH4nwadeCZsah+I3Lut9RowrGV5JmyJJULrdyif
         c6hAdL940ZdvHjp+raiG8TZYiUAOEFgrfbF0I4Ik/8KLstgqSfQg0yV/Uhhvn/hOcoi/
         dkwm12ascVRY5Enk+rvNTzTL4P4OSAK8ZsbER8lmgdJse0czU1y+1P5pXl+2LLM4AutF
         pqy+5G5gxfTdapeccbyGTgRu+31onmUX19ETfNcR3Q2/UBT9puFVmUJ+A+WO6r9haZy4
         SDTg==
X-Gm-Message-State: AOAM531kULasLLg2PH/mh2xQfqh4rdJ/WVYcgZXDRMot7PPAlgZrXLDE
        yT/ooPM7GPuAjuae7GB5drFu6w==
X-Google-Smtp-Source: ABdhPJwe0pj97liB4LbsuYiSoF/Xal92iCreh5AfSiBr0sUl9OcHufz0zEsxfvXQheepjecetEIs7w==
X-Received: by 2002:a17:90b:4b4f:: with SMTP id mi15mr11975932pjb.120.1630903390124;
        Sun, 05 Sep 2021 21:43:10 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id m28sm7594271pgl.9.2021.09.05.21.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:43:09 -0700 (PDT)
Date:   Mon, 6 Sep 2021 10:13:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wsa@kernel.org,
        wsa+renesas@sang-engineering.com, arnd@arndb.de,
        jasowang@redhat.com, andriy.shevchenko@linux.intel.com,
        yu1.wang@intel.com, shuo.a.liu@intel.com, conghui.chen@intel.com,
        stefanha@redhat.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210906044307.se4dcld2wlblieyv@vireshk-i7>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <20210904160059-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904160059-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-21, 16:01, Michael S. Tsirkin wrote:
> Same as with qemu bits, I am confused as to what is the status
> of proposed spec changes and whether the driver will work
> with them.

This is already merged as well.

The current version simply fails to transmit the messages in case the
length of a buffer is 0. I have patch ready to make it work with the
proposed spec changes, just waiting for them to be accepted.

> Let's let the dust settle on them then, then
> resubmit?

It doesn't break anything for now since we don't have much users and
we know zero length transfers don't work. I will submit the necessary
changes once spec is finalized.

-- 
viresh
