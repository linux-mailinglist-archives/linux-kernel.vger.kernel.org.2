Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060DE3F4163
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 22:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhHVUHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 16:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhHVUHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 16:07:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A7FC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 13:06:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a25so5688019ejv.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xo073HecdrENZFwBS6Ln9E6uG6+bInrbYzCVBgGcUuY=;
        b=GQ8w7HCFN8TB61i0H/Vzirn2bkxzGi2h3gcDLEAjKBbyU3VS06wQzENMJwTRPOzFPu
         QeZ2XL9xhIJ3x8kt4/G7ztNNWYA+UfgmbdvsSMeJYmGpFmTagAd3+GAS27FrfX05roF8
         7Z8pmw6+9oHINPuHiVzQzrRYrlqzsQyQa5JGkx26oFnXi5nuy5DT0v/UKo2nBTwpyg27
         4wSA0vlvYPnxhd91GgdDS6OXD29rQXfkYgDw6lzHdfIE1MaVjNfGj1h7Erdr1DSGvf/3
         SyhCfQUuSu1r0T91m5vWSYNJCyHfkBYxvafvSg+vchs99cNFMwQ+OEq6xwgKDqatU/LG
         4Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xo073HecdrENZFwBS6Ln9E6uG6+bInrbYzCVBgGcUuY=;
        b=JcxMdMDyGNcSsSIQstigtcRT2hzw0crTkrV/m3o3WHh/jIQbPdsrLqbO/E49LXSH5x
         49s+FDMHZ1gwTuYe2U8fH7sOtzXS282KfDZv1a6LVAIsDQxvGY0ZhTTjdfiQGt7kbt97
         /8nebwIFPUc+0FW5VcD8klEvl/YKCn284UShvbvJSR/gvfhLP8rJE6a6KHcLcnineBm4
         nuqzvXd4OB0qpxQRbPfRYjp79JL/gMWHzm3jeC3SnSIrdN6TGrBAs/fy3fj2aYWOqoQU
         wrH/Ta9285CKtQ5lQyHdWWp6r3TiNf/2zw8n4DrY/tHYWMPkr17zlc3JPYc9fJkwWEtE
         VJ9g==
X-Gm-Message-State: AOAM530OFWg8RVHRDCjPX1KpvsJ7seaOSNlDvPX30BCEdpaTJ2wQSXE0
        le+z08W3WlxacO/FUq48UVk=
X-Google-Smtp-Source: ABdhPJyqBPXjFCQyoklkdgNhuUTOyjbomYDpsgDzBZ1dKQeYFt5KqpUSh89WE469LWFmaGrjHpFmGQ==
X-Received: by 2002:a17:906:ec9:: with SMTP id u9mr31432397eji.243.1629662789247;
        Sun, 22 Aug 2021 13:06:29 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id bs13sm6161338ejb.98.2021.08.22.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 13:06:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/6] staging: r8188eu: avoid uninit value bugs
Date:   Sun, 22 Aug 2021 22:06:27 +0200
Message-ID: <3600115.G8iuhHfNpT@localhost.localdomain>
In-Reply-To: <9ef4cd9f-4f0c-bc6a-76d2-b9e30f6744a4@gmail.com>
References: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com> <15979623.JslXr83I74@localhost.localdomain> <9ef4cd9f-4f0c-bc6a-76d2-b9e30f6744a4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, August 22, 2021 7:38:11 PM CEST Pavel Skripkin wrote:
> On 8/22/21 8:36 PM, Fabio M. De Francesco wrote:
> > On Sunday, August 22, 2021 4:35:05 PM CEST Pavel Skripkin wrote:
> >> Hi, Greg, Larry and Phillip!
> >> 
> >> I noticed, that new staging driver was added like 3 weeks ago and I decided
> >> to look at the code, because drivers in staging directory are always buggy.
> >> 
> >> The first thing I noticed is *no one* was checking read operations result, but
> >> it can fail and driver may start writing random stack values into registers. It
> >> can cause driver misbehavior or device misbehavior.
> >> 
> >> To avoid this type of bugs, I've changed rtw_read* API. Now all rtw_read
> >> funtions return an error, when something went wrong with usb transfer.
> >> 
> >> It helps callers to break/return earlier and don't write random values to
> >> registers or to rely on random values.
> >> 
> >> Why is this pacth series RFC?
> >>   1. I don't have this device and I cannot test these changes.
> >>   2. I don't know how to handle errors in each particular case. For now, function
> >>      just returns or returns an error. That's all. I hope, driver maintainers will
> >>      help with these bits.
> >>   3. I guess, I handled not all uninit value bugs here. I hope, I fixed
> >>      at least half of them
> >> 
> >> v1 -> v2:
> >>   1. Make rtw_read*() return an error instead of initializing pointer to error
> >>   2. Split one huge patch to smaller ones for each rtw_read{8,16,32} function
> >>      changes
> >>   3. Add new macro for printing register values (It helps to not copy-paste error
> >>      handling)
> >>   4. Removed {read,write}_macreg (Suggested by Phillip)
> >>   5. Rebased on top of staging-next
> >>   6. Cleaned checkpatch errors and warnings
> >> 
> >> Only build-tested, since I don't have device with r8118eu chip
> >> 
> >> Pavel Skripkin (6):
> >>   staging: r8188eu: remove {read,write}_macreg
> >>   staging: r8188eu: add helper macro for printing registers
> >>   staging: r8188eu: add error handling of rtw_read8
> >>   staging: r8188eu: add error handling of rtw_read16
> >>   staging: r8188eu: add error handling of rtw_read32
> >>   staging: r8188eu: make ReadEFuse return an int
> > 
> > Hi Pavel,
> > 
> > I've just read your v2 of the series. I had no time to read each and every line,
> > however, I suppose that I saw enough to say that I think they are a huge
> > improvement over v1. I really like your patches and if I were you, I'd drop
> > that RFC tag.
> > 
> 
> Thank you, Fabio! I appreciate it :)
> 
> 
> With regards,
> Pavel Skripkin

Hi Pavel,

I've read more code of your series and I'm ready to give a formal ack. However,
I'm not sure about the rules: can it be also given to RFC or only to "real" patches?

As I've already said, they look good and I like them. So, the entire series is...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

If the rules don't allow to formally ack RFC, I will be happy to ack again the final product.

I also want to say that I enjoyed discussing this work with you on this long thread. :-)

Thanks,

Fabio

 



