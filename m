Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828104410AA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 21:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhJaUCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 16:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhJaUCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 16:02:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC2EC061570;
        Sun, 31 Oct 2021 13:00:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k7so25170860wrd.13;
        Sun, 31 Oct 2021 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SpNxCIMxVQjiaNSaue5Hm6sDwGlTxu2qu8st3i8XD8U=;
        b=dZl8R3/s/TLmzkj1xajyLiAgS/Lfywl3PuNCNFTrWL5+626RLhYZXRA2imaeCWzfrh
         RW52Pz8p7UfhVeQixHUo1Wotedm86s/iNIMIHcSf8iR6symoFoeN+fLgqKvl4cxlBHB5
         MqtHkBEbw2aBRlesoaJCI/ZFMrR+jelgR6AKzFDjPHVEdZ1CajOSq6/Qkplfgan7eGrl
         EXgKWD+YP8RsPQfvbRBIYb2k4GR3e4ZB06vFmRCHeUZlfPlZgNkzmo1e3w2BvIDu8mqi
         E7KkxLzDreRUYvlyMZPUw5QY8zvBfYA5vLwjyI3zBkoVbuo0BFz9BBt7dW+NgWqPw/+/
         JhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SpNxCIMxVQjiaNSaue5Hm6sDwGlTxu2qu8st3i8XD8U=;
        b=7Jm71j+IBfLUe222pNLEEaPzcLpmHWE5wl56SB4oEhulXF/etNPRv0vY7w91765v1b
         evR3Xs5nGDvRBwcXg/Uhap807nl/awkEsOMmHzwP/r0WiFNrkdtfBzSHmUibf7IAn40X
         R9tSAiVUJjQh91FbNLJadkPB4JKwkgNBpz6FEQ3kMlbob8l5lc/PiTQjWUurf1CkAvY1
         EkVd11Ua8+UdBYIpCeYgCc7zesLmYEWvpX4Sl/M0j+DDjtNiW0ByooTt86PiRaBJ61nT
         qJ3t6MuGz6js4/CZR6hw6/2AqeqBMtxbla2ov14rjqIZcqwpjmv+6sMmeBmXjzaGzHIY
         cYoQ==
X-Gm-Message-State: AOAM533nFzqm7jkpzyr+x/OXTtUaVJXXaS2x5IIQn35ZuzFof/+fNszN
        fBBIXsB2heDTlfGfx/SeEio=
X-Google-Smtp-Source: ABdhPJzG3HcAqMcAnxuq03WjObeieaffNLOpo8ZNGAPQAShrMmPp+jytEm+DBbgxZjkXCutTmyFl2g==
X-Received: by 2002:a5d:64a6:: with SMTP id m6mr32782014wrp.100.1635710405617;
        Sun, 31 Oct 2021 13:00:05 -0700 (PDT)
Received: from penguin.lxd ([94.179.15.8])
        by smtp.gmail.com with ESMTPSA id p3sm11582127wrs.10.2021.10.31.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 13:00:05 -0700 (PDT)
Date:   Sun, 31 Oct 2021 21:59:54 +0200
From:   Denis Pauk <pauk.denis@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, thomas@weissschuh.net,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tor Vic <torvic9@mailbox.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus
 WMI.
Message-ID: <20211031215954.7be1aaa5@penguin.lxd>
In-Reply-To: <20211030153424.GA3972535@roeck-us.net>
References: <20211030153424.GA3972535@roeck-us.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Sat, 30 Oct 2021 08:34:24 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Sat, Oct 30, 2021 at 12:17:04PM +0300, Denis Pauk wrote:
> ...
> > a/drivers/hwmon/asus_wmi_ec_sensors.c
> > b/drivers/hwmon/asus_wmi_ec_sensors.c new file mode 100644 index
> > 000000000000..9d02023e0c61 --- /dev/null
> > +++ b/drivers/hwmon/asus_wmi_ec_sensors.c
> > @@ -0,0 +1,612 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> ...
> > +#include <linux/nls.h>  
> 
> Why is this include needed ?
> 
Its required for usage of utf8s_to_utf16s.

Best regards,
            Denis.
