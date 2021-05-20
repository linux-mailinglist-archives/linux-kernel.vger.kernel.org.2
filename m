Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3538AE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhETMe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhETMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:33:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1EBC0E1EF5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:39:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j14so15566639wrq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rOR/bE6KeQ5HZ3FZ82kLVJ7uz1OxpfmHwQwUe9gKcNs=;
        b=NZr70dRmEM0JMXAWO6zmUcOkBIe/qjOpjpzp1IaGbh67LHHyOvFaZLweiqdQEHPrX4
         GKtci8trVgcHmMkHT0ee0RghnbnilbIgQS2Sed9iDBJQgTZOFW+1YRdteD1w74NcRetM
         C0la3E2/beovJg27Nec9wf6h4nj4YeWhB4X9vBVeBFDZQ4HxqIxirJ7mVIDkqXmQxPMM
         tYXKwMLhG0M/Dg0izKm3UlokCh2KSlXruugL1CYzBiREmC8ZIo2oLkcQ3uQrW+OfQ0dP
         GHvKtCzUXRrvY98J5VB7AiRn3RGl3/iB+XVt1PKRSjGby02HopKbxcOR+zoHJKggOdRx
         YBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rOR/bE6KeQ5HZ3FZ82kLVJ7uz1OxpfmHwQwUe9gKcNs=;
        b=Qcf36j4n4XW2L2tLo/3dUOjjQz+yHN/hxOpl7K010CyKXLbJ3HQrSJGWxrPXdRnvig
         o+zpQ/Kxwjjc6PQJko+OeCKhJK3QkvD0qRx4xknsDj+ljsRhmW/uRmw0WhGFlhxZL/B3
         RRtU6kSFEfqVmoKoqs3x6BI9vKeppaZLn+L5gJ2RAHcWc2a7EGP124TfJSbG62IX+uO9
         OHuxL0pqGezVFnB7c7RW9yh39vNb7FS4ozAWdhCDJfjmtrUxevSqTQ0owhngOp8sM/++
         bA/clo/rLX/9DUBz3KOdkxT2ZwNco4S6TkBBrVVaHHCPWc0tC3WdkKIqlepDAt/PgnGI
         vmKg==
X-Gm-Message-State: AOAM5322Vt+w6f/Q2Dza0Zipda3Vw6GgKqnCMkVfTyhwQc3fDy/PxXH5
        iboD7iBJ02FWwDfqafwJ6FQzcw==
X-Google-Smtp-Source: ABdhPJyXeIV+dQjn1qVkcKlSbCmMspSSPlaH/0NkZU7TQGJqPfLIDWDnR2nLd0Zd8vmh/3KNV26pBw==
X-Received: by 2002:adf:e607:: with SMTP id p7mr3813981wrm.358.1621510773767;
        Thu, 20 May 2021 04:39:33 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id d3sm2934456wrs.41.2021.05.20.04.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:39:33 -0700 (PDT)
Date:   Thu, 20 May 2021 13:39:30 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linus.walleij@linaro.org, linux@armlinux.org.uk,
        robh+dt@kernel.org, ulli.kroll@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] crypto: add gemini/sl3516 crypto driver
Message-ID: <YKZKchyUeeQwedXF@Red>
References: <20210518151655.125153-1-clabbe@baylibre.com>
 <YKVbW8T92bY3NG4u@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YKVbW8T92bY3NG4u@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 19, 2021 at 11:39:23AM -0700, Eric Biggers a écrit :
> On Tue, May 18, 2021 at 03:16:50PM +0000, Corentin Labbe wrote:
> > The gemini SL3516 SoC has a crypto IP.
> > This serie had support for it.
> > 
> 
> Please describe how this was tested.

Sorry I forgot to write it.
It was tested with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.
Furthermore, it survives hours and gigs of write/read to a luks2 using xts(ecb-aes-sl3516).

I forgot also to write on performance, which is quite good.
On a luks2 partition (2To with bs=4096), a fsck comes from 14m26(without CE) to 8m48(with CE).
So it is really usefull.

With bs=512, the performance is similar with software.

Regards

