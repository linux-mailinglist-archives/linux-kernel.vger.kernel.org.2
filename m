Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7DB3FA4FB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhH1KX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbhH1KX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:23:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1536EC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:23:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g13so19988025lfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OxLig78dAqoxosBKMwaBsTeV8nh1tFLfxAZZJhisw/8=;
        b=MR7jqwl/eTSmUxA+WWkgCBwW4sHAq8sPSvOyoIkhN4y1+jpH9855fAyGlnERiOTuiK
         KgmNtHFYdCy0KQwPr868pDh1h2ebBF7UWGxULpMLMEG894fgXehhhK+iMvtUrk8gysmQ
         d7M0r0YW2a5bMTGfccYiMQ5oSrmPn91a1nBMN3ToPwIsssgazas3vvZSl3l5ibf8YuUF
         7SPxRC6z6YIQ+LzXWfaJZnXWJyAcKkJ9o63xidxiqNPclMtyJT4291P0I4B/TfjHCBXx
         pUoz6DJKrCXKfXz6uOj+8m4wGZodvbUrP+Pu5B97nxDZYqM6/TccTb9jjx6jm9Fq9+KW
         6ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OxLig78dAqoxosBKMwaBsTeV8nh1tFLfxAZZJhisw/8=;
        b=mWHUxzUayrKDKk+sHXsq10W9y21oG+L4ewNWNq6Owfjcx6gWmbTcS0l2L5U+Prv7dk
         P+QoIdqgFWrvCG/l6QHvXFn76bISa8YcAIAkzgvA9HNL0UcnAOLQC2rQvD2mKXLbJ3ao
         NaEpY+hG9Zu8DkVbhW/TdxXS/89mBW9HVqbsJ4wHEym887sQAuj07+M6NPRUF78pw8dE
         7XKbbjSSLeMONigenKPGEpBenI83qnST8jsIDigQST5hyRGy+LDsHSdKSCQ8GAH+g2v1
         W5+yLYea2cFW59UY8eOvy8nenVCkDT1n+o9rF3bg1t86T4q4azM7UoTamXwG3mWn88VB
         Jblw==
X-Gm-Message-State: AOAM533LCQgN2lqfmQ+E5MB/3dHcfT+sBSHTBERAsX2mihXVt6Sxr6lf
        tSL6+ULpJ1+7T9c2bDo/4G6FCs+WWwopUA==
X-Google-Smtp-Source: ABdhPJzSCg2wRltK9ix/7rIGPCUhyGhUD4Zh9MP6AmopLjBRkT0CpFE9CiZ2kNWj1GO/lYKiKQTyFA==
X-Received: by 2002:a05:6512:238e:: with SMTP id c14mr10398615lfv.324.1630146185896;
        Sat, 28 Aug 2021 03:23:05 -0700 (PDT)
Received: from kari-VirtualBox (87-95-21-3.bb.dnainternet.fi. [87.95.21.3])
        by smtp.gmail.com with ESMTPSA id y10sm918666lfh.40.2021.08.28.03.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 03:23:05 -0700 (PDT)
Date:   Sat, 28 Aug 2021 13:23:02 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, hello@bryanbrattlof.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix docs typos and references to
 previous struct names
Message-ID: <20210828102302.d7nhe2bkw6h5quqa@kari-VirtualBox>
References: <20210828101242.GA6841@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828101242.GA6841@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Re: [PATCH] staging: pi433: fix ...

This is version 2. Subject needs to be [PATCH v2]. If you generate using
git format-patch add "-v 2" in there.

On Sat, Aug 28, 2021 at 10:12:42PM +1200, Paulo Miguel Almeida wrote:
> In the comments there where some grammar mistakes and references to
> struct names that have gotten renamed over time but not updated
> in the comments.
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
> ---

You should have log here what did you change from previous version as
this is v2. You can also add who ask this change That should be like
this:

---
Put your version log here.
---

>  drivers/staging/pi433/pi433_if.h | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.h b/drivers/staging/pi433/pi433_if.h
> index d5c1521192c1..855f0bebdc1c 100644
> --- a/drivers/staging/pi433/pi433_if.h
> +++ b/drivers/staging/pi433/pi433_if.h
> @@ -5,14 +5,13 @@
>   * userspace interface for pi433 radio module
>   *
>   * Pi433 is a 433MHz radio module for the Raspberry Pi.
> - * It is based on the HopeRf Module RFM69CW. Therefore inside of this
> - * driver, you'll find an abstraction of the rf69 chip.
> + * It is based on the HopeRf Module RFM69CW. Therefore, inside of this
> + * driver you'll find an abstraction of the rf69 chip.
>   *
> - * If needed, this driver could be extended, to also support other
> - * devices, basing on HopeRfs rf69.
> + * If needed this driver could also be extended to support other
> + * devices based on HopeRf rf69 as well as HopeRf modules with a similar
> + * interface such as RFM69HCW, RFM12, RFM95 and so on.
>   *
> - * The driver can also be extended, to support other modules of
> - * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
>   * Copyright (C) 2016 Wolf-Entwicklungen
>   *	Marcus Wolf <linux@wolf-entwicklungen.de>
>   */
> @@ -33,8 +32,8 @@ enum option_on_off {
>  /* IOCTL structs and commands */
>  
>  /**
> - * struct pi433_tx_config
> - * describes the configuration of the radio module for sending
> + * struct pi433_tx_cfg
> + * describes the configuration of the radio module for sending data
>   * @frequency:
>   * @bit_rate:
>   * @modulation:
> @@ -46,7 +45,7 @@ enum option_on_off {
>   * @repetitions:
>   *
>   * ATTENTION:
> - * If the contents of 'pi433_tx_config' ever change
> + * If the contents of 'pi433_tx_cfg' ever change
>   * incompatibly, then the ioctl number (see define below) must change.
>   *
>   * NOTE: struct layout is the same in 64bit and 32bit userspace.
> @@ -81,8 +80,8 @@ struct pi433_tx_cfg {
>  };
>  
>  /**
> - * struct pi433_rx_config
> - * describes the configuration of the radio module for sending
> + * struct pi433_rx_cfg
> + * describes the configuration of the radio module for receiving data
>   * @frequency:
>   * @bit_rate:
>   * @modulation:
> @@ -94,7 +93,7 @@ struct pi433_tx_cfg {
>   * @repetitions:
>   *
>   * ATTENTION:
> - * If the contents of 'pi433_rx_config' ever change
> + * If the contents of 'pi433_rx_cfg' ever change
>   * incompatibly, then the ioctl number (see define below) must change
>   *
>   * NOTE: struct layout is the same in 64bit and 32bit userspace.
> -- 
> 2.25.4
> 
