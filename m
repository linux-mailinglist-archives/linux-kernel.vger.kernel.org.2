Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8660F438EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 07:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhJYFPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 01:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhJYFPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 01:15:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005FDC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 22:12:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d5so9627670pfu.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 22:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MHOpmbvcINsWhfRdDNQkPeyRi24VKAfRpmc6DJa3fyo=;
        b=kC5eDl2h924in2t60MD14iTuL0pcDbTxB1SmArcPDs3IL9hHUsdXafP/+TepNUOtVg
         A/fOVnZqo32vWXlDoz0kyAQeLFNCL4SQskRnkmHBeObrQ6mcAJZQRRZcUCovLa9gRRjk
         JYLFZmWKdDd5IZFUBHCuwrKCUED96XCCt60/QzDXVIWzCSjk/cwi3ziTB/mt836/3iA9
         1IqbPHqUCukRO2fzQtdzdoAiKvBoyvJHjdGB0uq7OwGnrHLLfm3IC92cnd1JpVXw+bTe
         4kAYeqF6CcQYRnKmfG25650dmMfY/+tESy49UwdHPKk19pSYDsO/H5zEgrl3g2OPUCvm
         /nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHOpmbvcINsWhfRdDNQkPeyRi24VKAfRpmc6DJa3fyo=;
        b=1lBrvAs8dtTD53R+cQgqmyVIxaB1J41Foqws27aT9tabdB/HiGzc/LDh6etIbfnHi+
         b7BI1KvuKHozwuun7uoylqyEnmYSU3BbHBhC+NQJDEeMECt9OiOeT/H4XoJ9EjoLDQNY
         fQur5Dl6BxCn8yF7irpDRBg8JdHwAmZiBr97gK6II9lZhMEZ0apilkiDIOlYngp3yEKQ
         OUTIrmfarMLdnePyBZi+AfQhXnPFzg/U/vGnYCar1xsSMFj+d86BxP5lRxYYlj8UYOhT
         mf/kYpLr6OlyaenEN8VrmcLBwCE3FfJpBTSupl7acpevzTLWX0l9Qkxiz8OBOyIuR7UG
         hzGQ==
X-Gm-Message-State: AOAM532EJKJ56/IM4xE8Q3e0mh3Ym0D+n7JCpFzSUKAnE6KVRkVGjlBa
        seumgimqDRbdlrPh/vX2900=
X-Google-Smtp-Source: ABdhPJz7NMRtr+4acKF0FpawvSqsydzB2qw/w10uJQMqV+vSqlGcuPYHmLggJr0JkYFnO+eHap5izg==
X-Received: by 2002:a63:6888:: with SMTP id d130mr11969137pgc.234.1635138770319;
        Sun, 24 Oct 2021 22:12:50 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5780:a9e3:4135:1d16])
        by smtp.gmail.com with ESMTPSA id z3sm13619025pfh.79.2021.10.24.22.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 22:12:49 -0700 (PDT)
Date:   Sun, 24 Oct 2021 22:12:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        282827961@qq.com
Subject: Re: [PATCH v6] tty: Fix the keyboard led light display problem
Message-ID: <YXY8zrEbkhdO6ikS@google.com>
References: <20211021020511.18016-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021020511.18016-1-changlianzhi@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 21, 2021 at 10:05:11AM +0800, lianzhi chang wrote:
> @@ -1524,6 +1543,9 @@ static void kbd_event(struct input_handle *handle, unsigned int event_type,
>  	/* We are called with interrupts disabled, just take the lock */
>  	spin_lock(&kbd_event_lock);
>  
> +	if (test_bit(EV_LED, handle->dev->evbit))
> +		kbd_update_ledstate(handle->dev);
> +

Why do we need to update led state on each and every event instead of
trapping individual EV_LED/LED_x events?

But thinking about it some more, I believe doing this here is wrong.
LEDs are routed in this way:

   device <-> input core <-> input leds <-> leds core <-> VT

with the last step assuming that we are in default configuration and we
indeed assign one of the following triggers to appropriate LED on given
device:

kbd-scrolllock kbd-numlock kbd-capslock kbd-kanalock kbd-shiftlock
kbd-altgrlock kbd-ctrllock kbd-altlock kbd-shiftllock kbd-shiftrlock
kbd-ctrlllock kbd-ctrlrlock

I.e. the state of LED of individual input device is not necessarily
attached to LED flag state in a given VT.

Re-reading the patch description, are we saying that we are maintaining
kbd->[s]lockstate, but losing kbd->ledflagstate when we are doing
transitions to and from VC_OFF state? We need to keep in mind that we
are trying to keep states separate on separate consoles.

Thanks.

-- 
Dmitry
