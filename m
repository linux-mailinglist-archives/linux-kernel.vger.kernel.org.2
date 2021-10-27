Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3C43D2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhJ0UfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 16:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhJ0UfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:35:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09070C061570;
        Wed, 27 Oct 2021 13:32:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so3359486wmz.2;
        Wed, 27 Oct 2021 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sjCuKNh1yjlRgR6DvoqZX0D0sZsEs3xv02gdO6DMZSU=;
        b=QN2HR+PjJ/qec7A4XkCaVCHbCeG+mB6D8BGtx7pnBR6++r3GWCAelTL5BfEpNgJMYB
         8JrOudA212Tliv2ecQsRwPJVzNIDNnAEjQv1OubvH5EnRhSmm8dVuCB57lzhamudYg2N
         wlXD1zyAVrv7TVeLEZXo/tA/IBqS1AxQmHECfm/YUA9M2AqubtGK13OYwQi7pDlWiJnr
         NKeutv0RhIZHeA04TaHGbd/AXPzzVD7n2HahM1HdQ1Vlgdsgxa7aHQrwAk59m9nnFQxW
         L8Rh9nz7v2tx7TV8d+0gJuRgHbg+aSv5SOHkpeqteDWO0cs/5Ukgj8RUOZWWW1jwXreh
         f9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sjCuKNh1yjlRgR6DvoqZX0D0sZsEs3xv02gdO6DMZSU=;
        b=gCdnpajemF22bogNnqMysX0ffVk1Wb/FEkCurtGHYnl2y4KyLeJgqTOAnhGdSOCXCK
         T72g4FzPJEmmUjFv9WJb3DP+tAc63MEZnS6MrvzX3dusKEQ0QB8YliAUPe3U+cSzYrmX
         ATg3TSYz+J9pftJciFyUIEijAZUQ2PXkYQkCB+eiFKtsHyQQcvaXuV83E3zc/O5Hr2+u
         Wg/b8tPEi2CJ/iTud6D+NChrkbccOXQvvvSWmRhk11zXKPcERpk5gUYyt7dywWR+gBBN
         eq5rewtUpDS9nNhOH7dJXsqr6/eH0IULsrwha6eGc5i0WPFhgF0EN8QBIZjs7aD4h+qU
         dAPw==
X-Gm-Message-State: AOAM532GxIkFfb0G6aaH3AumhDuofdtKoqVmsoGWYJhk5a+wrq8DJj3n
        H7GGX3qQEnWYJPq4wBoS5QI=
X-Google-Smtp-Source: ABdhPJwa7rZ9GnpJhLzIESGzO6+qhPBCdlnaifHwG1LGOid6JmFECGlm7b6OIjbN5bGzwG2G/iBIOw==
X-Received: by 2002:a05:600c:2259:: with SMTP id a25mr3987853wmm.124.1635366763180;
        Wed, 27 Oct 2021 13:32:43 -0700 (PDT)
Received: from debian64.daheim (p5b0d79c5.dip0.t-ipconnect.de. [91.13.121.197])
        by smtp.gmail.com with ESMTPSA id b8sm1265951wri.53.2021.10.27.13.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:32:42 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by debian64.daheim with esmtp (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1mfpbG-0016cW-Cl;
        Wed, 27 Oct 2021 22:32:42 +0200
Message-ID: <b9e56efc-c060-df62-8aec-ad93b0b08764@gmail.com>
Date:   Wed, 27 Oct 2021 22:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] ARM: dts: BCM5301X: Fix I2C controller interrupt
Content-Language: de-DE
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mnhagan88@gmail.com, Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jon Mason <jonmason@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211027193730.3941945-1-f.fainelli@gmail.com>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20211027193730.3941945-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2021 21:37, Florian Fainelli wrote:
> The I2C interrupt controller line is off by 32 because the datasheet
> describes interrupt inputs into the GIC which are for Shared Peripheral
> Interrupts and are starting at offset 32. The ARM GIC binding expects
> the SPI interrupts to be numbered from 0 relative to the SPI base.
 >
> Fixes: bb097e3e0045 ("ARM: dts: BCM5301X: Add I2C support to the DT")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thank you! This fixed the MR32 iproc-i2c issue.
It's working now (will post the patch for the MR32 tomorrow):

# cat /proc/interrupts
            CPU0       CPU1
  24:          1          0     GIC-0  27 Edge      gt
  25:     110418     108252     GIC-0  29 Edge      twd
  26:        476          0     GIC-0 117 Level     gpio, ttyS0
  31:        128          0     GIC-0 121 Level     18009000.i2c <--- YES!
  32:      49477          0     GIC-0 100 Level     brcmnand
  33:          0          0     GIC-0 109 Level     mspi_done
  34:          0          0     GIC-0 110 Level     mspi_halted
  35:          0          0     GIC-0 104 Level     spi_lr_fullness_reached
  36:          0          0     GIC-0 105 Level     spi_lr_session_aborted
  37:          0          0     GIC-0 106 Level     spi_lr_impatient
  38:          0          0     GIC-0 107 Level     spi_lr_session_done
  40:       7227          0     GIC-0 179 Level     eth2
  51:          0          0  BCMA-GPIO  21 Edge      keys

and the attached AT24 + PoE-Power monitor can be probed + read as before.

[   12.042576] at24 0-0050: 8192 byte 24c64 EEPROM, read-only
...
[   12.077671] ina2xx 0-0045: power monitor ina219 (Rshunt = 60000 uOhm)

Tested-by: Christian Lamparter <chunkeey@gmail.com>


Regards
Christian
