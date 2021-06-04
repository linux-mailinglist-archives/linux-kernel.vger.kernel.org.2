Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0F39BB71
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFDPJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhFDPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:09:47 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F18C061767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 08:07:44 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a15so7254595qta.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M0MIug4uhteRxdWOVPqNkw3ATKplY4lCx/S7+si7RU8=;
        b=BUuszxg2VmWIb45n6Sy0XgAeOFUXiR0DYTIMBbaScwIRDkBvAWr4DKous4ZMXHVXPx
         TptzCxF1bLWSoXYfYniTJIL02O3mXFnXHjdpReyAEyciHoPP1/A6qXSM/T+a5famQ3fO
         3sc91jlHbreVV+YSD9Wf2ezEGR+nuTrHTj/xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M0MIug4uhteRxdWOVPqNkw3ATKplY4lCx/S7+si7RU8=;
        b=c8kuvdi9q2NGva2oYaya7Fc1bT1gOqzFKGyxL3Qn0WlFBOXcvxM95LVwYWHqL1x3k3
         MpkDX8eU95anG+KhzH4YuM1nuWFl0u+cExps+TPdFQfi74eBfg3fSfjL10dITbolPhMo
         xYnUmZs951470UQSgarmazbW/tAhOUPGkv005xiTRoiKhjgB6eXeKL08OHe4modxw703
         etR5t8NkmwpXS67a0hTuQHm9djQx8zRyFN7rF52PM5ubqsQo/syUAVZvlioACN5Zi/I8
         hKOsqYy4Xr0EdGrVuSnTiGpT58zeD4KODnOZxuzYpl2cJYRZY2Aux+gZX1pCbXt0x+4c
         ev0g==
X-Gm-Message-State: AOAM532S9+2LEsCLrvzi10XJg9LlJPalq+xqUrXnsOcH3Ow6fafr+QuP
        YGYkFp3NTIeCMrMP0P7AsZ2fsQ==
X-Google-Smtp-Source: ABdhPJxodCC4r10tdeEEZ++ru5B61RlYUeDhkHbCXsCZl5Ytxumdywew7iZczhxzr0149uigp2MlpQ==
X-Received: by 2002:ac8:46d1:: with SMTP id h17mr3793418qto.135.1622819263846;
        Fri, 04 Jun 2021 08:07:43 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id a191sm4165998qkg.61.2021.06.04.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:07:43 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:07:42 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0
 is disabled
Message-ID: <20210604150742.bssvnhm4gv72uw4h@nitro.local>
References: <20210601084830.260196-1-narmstrong@baylibre.com>
 <YLoHSJIOSRTyF0r1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLoHSJIOSRTyF0r1@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 12:58:16PM +0200, Greg KH wrote:
> Meta comment, you signed this, and it worked!

NOICE. \o/

> Looking up https://lore.kernel.org/r/20210601084830.260196-1-narmstrong%40baylibre.com
> Grabbing thread from lore.kernel.org/linux-amlogic/20210601084830.260196-1-narmstrong%40baylibre.com/t.mbox.gz
> Analyzing 2 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   ✓ [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
>     + Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> (✓ DKIM/lists.infradead.org)
>   ---
>   ✓ Signed: openpgp/narmstrong@baylibre.com
>   ✗ BADSIG: DKIM/baylibre-com.20150623.gappssmtp.com
>   ✓ Signed: DKIM/lists.infradead.org (From: narmstrong@baylibre.com)
> ---
> Total patches: 1
> ---
>  Link: https://lore.kernel.org/r/20210601084830.260196-1-narmstrong@baylibre.com
>  Base: not found
> Applying: usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
> 
> 
> Odd that DKIM didn't work for baylibre-com, but hey, I'll take a real
> signature over DKIM anyday!

That lookup happened to grab the thread from linux-amlogic, which is
mailman2-managed and is known to break DKIM. I'll try to fix our configuration
so that known-DKIM-friendly sources are given priority. This way, when a thread
exists on multiple lists, you'll get the one more likely to pass DKIM checks.

> thanks for doing this.

Yes, thanks! Hopefully, more people will start doing this.

-K
