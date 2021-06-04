Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F69F39BD8B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFDQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhFDQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:48:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8045C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 09:46:04 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l7so7461696qtk.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QmdH7mKnFkOZAH2JI/GCXFdUAnEZ4TREjy0wt14hYvE=;
        b=C9WM3GBnDyo1IuG8vugzF7OJuv0/qSLc2h5rlH2vs9hPAsnhLP/AiXMndOeLbpR2IM
         Ohtn8XR2SA70sT+Glx2x+oDv2XvXp4XsXKCzRp3r/+xQ35mo133BJzGzSP18qJtL2g6h
         Aj3waqvEMKM8rNoNBayZGxz6o91LWXuicSMxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QmdH7mKnFkOZAH2JI/GCXFdUAnEZ4TREjy0wt14hYvE=;
        b=YH1yMuU4KCan4nR47KQXiNAtVD2u+e8OzqHqUSSoeLFD/3gqa2fnzIcw2+2oXWwDfQ
         hTeJljogUaEYDPTP0qaMbpBXGMnPJNWdVanjxr1Y87lYSWEGPnJDRzS7gK8PBJGTkdle
         CXdWf064rAhC2CVpPvJWVDLV6IfzU98sWqnlN5GP5tnBda0RPdyFBW0bqtHVoPUC6QMB
         A+cgvXxcEIWKSbgz3uHFn7YSZgAOAO1yM9627LYjJC5kjVNxyWvLlCKMom23csQUnTB7
         PnlbkbWeP7orYkpWcOJ7XCzTgeNO9B0ON4z+M0+mvPPMG0QGsy6cceMCA8hQNnCupGyN
         Ckcw==
X-Gm-Message-State: AOAM531G7MhRQtJ3uD0+8yC4nP4JLER8H0w3b+A7H9JorhEh/0wRSIal
        4QtVPsgbdpGLonWKKuSFgFEdpQ==
X-Google-Smtp-Source: ABdhPJznrW8naIl7grTb0byn0Ki8g1mPccqfo2n3/Mzyg7GeZgz4J4vGwn8uDK7aL0u3V5bKWZOOgQ==
X-Received: by 2002:ac8:544:: with SMTP id c4mr5373272qth.299.1622825163185;
        Fri, 04 Jun 2021 09:46:03 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id d1sm3969137qti.72.2021.06.04.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 09:46:02 -0700 (PDT)
Date:   Fri, 4 Jun 2021 12:46:01 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0
 is disabled
Message-ID: <20210604164601.hrlgkrsghhqtho6m@nitro.local>
References: <20210601084830.260196-1-narmstrong@baylibre.com>
 <YLoHSJIOSRTyF0r1@kroah.com>
 <20210604150742.bssvnhm4gv72uw4h@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210604150742.bssvnhm4gv72uw4h@nitro.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 11:07:42AM -0400, Konstantin Ryabitsev wrote:
> > Odd that DKIM didn't work for baylibre-com, but hey, I'll take a real
> > signature over DKIM anyday!
> 
> That lookup happened to grab the thread from linux-amlogic, which is
> mailman2-managed and is known to break DKIM. I'll try to fix our configuration
> so that known-DKIM-friendly sources are given priority. This way, when a thread
> exists on multiple lists, you'll get the one more likely to pass DKIM checks.

This is now in place -- lore will now prefer results from DKIM-friendly
sources. E.g. grabbing the same message-id will now return the thread from
linux-usb (via vger) instead of linux-amlogic (via infradead).

    $ b4 am -o/tmp 20210601084830.260196-1-narmstrong@baylibre.com
    Looking up https://lore.kernel.org/r/20210601084830.260196-1-narmstrong%40baylibre.com
    Grabbing thread from lore.kernel.org/linux-usb/20210601084830.260196-1-narmstrong%40baylibre.com/t.mbox.gz
    Analyzing 4 messages in the thread
    Checking attestation on all messages, may take a moment...
    ---
      ✓ [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
        + Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> (✓ DKIM/googlemail.com)
      ---
      ✓ Signed: openpgp/narmstrong@baylibre.com
      ✓ Signed: DKIM/baylibre-com.20150623.gappssmtp.com (From: narmstrong@baylibre.com)
    ---
    Total patches: 1
    ---
     Link: https://lore.kernel.org/r/20210601084830.260196-1-narmstrong@baylibre.com
     Base: not found
           git am /tmp/20210601_narmstrong_usb_dwc3_meson_g12a_fix_usb2_phy_glue_init_when_phy0_is_disabled.mbx

-K
