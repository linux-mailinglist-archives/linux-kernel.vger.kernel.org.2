Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925BD3C1427
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGHNXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhGHNXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:23:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF6AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:20:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q18so15507766lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=phystech-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=KE8NOJiJ0V+TtARi6NSHG/thecWx9xet0pqt8oRBjLs=;
        b=TktgSi9h1vOl9BnxmPyh+CZu0cJ5B9oe+agvxvU4Fq8zgoBfhYhuuP+zHnNnwKYmMx
         03rQceYgdIJKZBKtnZoGcGvpvpoGm20uXu0io0djHcgZr5Pr5BaOyv4oXv6Ya9TorfHC
         ohIPjwXYVd2vDd8SxXQFnFJ+lugFSxwupif6IiDSarP5ECB7uRr941UjLX8IDjqSCS14
         +f2ZTePeJRVYNSCFp/F1xnsO7P9yhrd1m3Zsetyu316Gv4JrdcSSpriryQ7s7QGogojE
         vxdv5Xp7Vs7MdPGNl8R3L9I0X/lN2XACe8jIYU5DNSRFjyN+UxtsZLwWF/tzCOlz/kY0
         3KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=KE8NOJiJ0V+TtARi6NSHG/thecWx9xet0pqt8oRBjLs=;
        b=f269CJPWLdvdQKnZHCnJlj+aJ4nt1PXAfILj4Dm2qcX4qCbBLjW3guXLUGrIDR5efw
         si86ueZVyNY/f5WpvUnR1uhdc29a80QsKjdQDqMC5VrelJ8ksHZ3DdnQYdN51W+I+8p3
         Yb+03S3wikQCE0wugvi91AcrpuYdq5vRJ/O4f+cm7vxpV3MjF68gx9tASGvjXQ8Gblyx
         izx/ogJSEjDS0zxbnbzYuE1KsP8Hx1QlVNnYblOMN0DafbRo7V4k9+v7DVUm3nNFaaNw
         XGLMn54pUgVCubMH1wxf8QWtIlkQL4bp0rE7M4jLkHiwoNaB/VU+vHgO7uH5iowKlGp7
         YWew==
X-Gm-Message-State: AOAM532lkLOPN5kMkiVptfowf1GlqTZsVj/UKkZvdRuiMknnom5iEoWA
        LV6o/nSAfk0KpwTKNLdVojShrQ==
X-Google-Smtp-Source: ABdhPJy/KBaddQl0NdAnrXytzOMs65zvpx8CPI3qr2KR+DTHRjxfTu9ToD3HyKMytUcBg9uNx85Xyw==
X-Received: by 2002:ac2:548a:: with SMTP id t10mr9720309lfk.247.1625750455529;
        Thu, 08 Jul 2021 06:20:55 -0700 (PDT)
Received: from 192.168.1.3 ([2a00:1370:810e:abfe:9c62:44e3:b0ab:76fd])
        by smtp.gmail.com with ESMTPSA id n6sm197799lfi.2.2021.07.08.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 06:20:55 -0700 (PDT)
Date:   Thu, 8 Jul 2021 16:20:51 +0300
From:   Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     sean@mess.org, mchehab@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, linux-media <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, rockosov@gmail.com
Subject: Re: [PATCH v2 1/2] media: rc: meson-irblaster: document device tree
 bindings
Message-ID: <20210708162051.13953369@192.168.1.3>
In-Reply-To: <CAFBinCDgQHA1vmunNBdER0BfiKt8XYZ+-VBs3c21+S3bYP7GZQ@mail.gmail.com>
References: <20210707141323.20757-1-viktor.prutyanov@phystech.edu>
        <20210707141323.20757-2-viktor.prutyanov@phystech.edu>
        <CAFBinCDgQHA1vmunNBdER0BfiKt8XYZ+-VBs3c21+S3bYP7GZQ@mail.gmail.com>
Organization: MIPT
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Thu, 8 Jul 2021 15:09:30 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Viktor,
> 
> On Wed, Jul 7, 2021 at 4:13 PM Viktor Prutyanov
> <viktor.prutyanov@phystech.edu> wrote:
> >
> > This patch adds binding documentation for the IR transmitter
> > available in Amlogic Meson SoCs.
> >
> > Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> > ---
> >  changes in v2:
> >    - compatible = "amlogic,meson-g12a-irblaster" added
> >    - clocks, clock-names and mod-clock updated  
> thanks for updating this patch with my feedback!
> 
> [...]
> > +  mod-clock:
> > +    maxItems: 1  
> in the change-log for this patch you mentioned that mod-clock is
> updated as well I think that mod-clock (as a whole property) should
> only be added if it's an external input to the IR blaster IP block

There are 2 clocks connected to blaster module, and mod-clock is just a
selector between them. Meson IR blaster driver should choose one of the
modulation clocks. If not through a property, then how to do it? 

> 
> 
> Best regards,
> Martin

Best regards,
Viktor
