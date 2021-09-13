Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877A4409E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244307AbhIMUhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbhIMUhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:37:40 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD1EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:36:24 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y6so19584103lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fG83zNwJ6AEtZlqV5o/swjIcx9hYCI8SL/BVfl454VE=;
        b=IUJck906OdpTvfTIgvkQ8mFwO9GEvvDsy4H3UUuEiIy9Et4Idn3yyCsMgt9g3J2ybU
         MLApaBSW//CkOZDYcLxNapgJOMdMM1RGoLNKv9XqlGJThoZSmEUCqfnzlljz65i5MqCi
         WSWfCu+/7Nu+HZCt3/ljVB0a9dT7BQQjq6QkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fG83zNwJ6AEtZlqV5o/swjIcx9hYCI8SL/BVfl454VE=;
        b=yfnw29NoAXTxs7qRs0PfZBgO2kPyLnRgmL8RrCsinmDKtx5PscYT8ShKpsTxGzUXQj
         etyy4gYmE+/ryg+bWlunBhvmMQBArQq10wj6lIVq0cPPraa3vhnUVz/J5bKsBU318vFC
         jkTXCYBSGU87M3CWKLv+7YlZ14ANqcYtWnnNKmmUeUr4cNBQCcpcROlG5yn5Z36lgX6u
         AWtDiM2xNO6foXophjiVRleEXN6YuHOVU+4z+1m43/eBv7uVAVKvEp8+bntijMucfu2m
         PG/dHGqzZVmlGjfNNp7dLK20Ac22Ma8+dZQyWFFfzTHey2nhGFXDjRlZBq5jSfMe9r2j
         dGPA==
X-Gm-Message-State: AOAM5309eCb51b39DkJ1JF0y40yS5uEQ1Jt7W/cERK2L1O8UQH0XUsOC
        batd4izkrQMhHvapEr18JPQQAgxTcoBfcuhw+N4=
X-Google-Smtp-Source: ABdhPJyV4TjOPUVAtzu2MynMaiPblML/ZR53+d7OUMDhTVzLCRtC8rVN7An2KbJWA0ZdKak+DwfFeA==
X-Received: by 2002:a2e:9805:: with SMTP id a5mr12416947ljj.155.1631565381873;
        Mon, 13 Sep 2021 13:36:21 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y9sm1097438ljm.5.2021.09.13.13.36.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 13:36:21 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id i7so7546914lfr.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:36:21 -0700 (PDT)
X-Received: by 2002:a19:ae15:: with SMTP id f21mr816872lfc.402.1631565380851;
 Mon, 13 Sep 2021 13:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgbygOb3hRV+7YOpVcMPTP2oQ=iw6tf09Ydspg7o7BsWQ@mail.gmail.com>
 <20210913141818.GA27911@codemonkey.org.uk> <ab571d7e-0cf5-ffb3-6bbe-478a4ed749dc@gmail.com>
 <20210913201519.GA15726@codemonkey.org.uk> <72507051-9608-9502-790b-c49dd46a843d@gmail.com>
In-Reply-To: <72507051-9608-9502-790b-c49dd46a843d@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Sep 2021 13:36:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-3qcB4_Oh6XMwvWHcJj34ada7b3m_Y8Gq4y_wa4eBfA@mail.gmail.com>
Message-ID: <CAHk-=wg-3qcB4_Oh6XMwvWHcJj34ada7b3m_Y8Gq4y_wa4eBfA@mail.gmail.com>
Subject: Re: Linux 5.15-rc1
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 1:33 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> OK, so this device is buggy too but not the root cause. After checking again the
> stalls happen for VPD access to both ports of the Intel network adapter.

I really don't want to add quirks like this.

If this happens to a major manufacturer (whoe _defined_ the PCI
standard, for chrissake), then this is not something where we want a
quirk to avoid a boot-time delay.

That commit needs to be reverted. If reverting it is hard, then we
need to revert everything it depends on.

              Linus
