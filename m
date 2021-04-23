Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50186368C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 06:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbhDWEno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 00:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhDWEnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 00:43:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91526C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 21:43:04 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y1so8987912plg.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 21:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vmwMfJKV2MTnV8e34ZcnkdOiNEV3WHgx/mF/LO5zhjc=;
        b=RYueedh/cAfcFVTIodUVgv+DSG8NBbF0QpyZO+xaUpKWH18+PY4lPB29KMYH9dUfOR
         lJkdYWiDlbqCIBtzV8KIBo73ujgxGIGMCRfFlA+cAjqHMCT2hGpklHCiIU9J1geUVXkx
         DH9CKKHwPPMhWh2oeqjVn1gnki1vuhFplYKQxzuSSxg3FujyaQ6Av2i6GWw6B4Ehpkmg
         qCpONwsOlQRCSI0lHafPMHKeMQxeJhkHv3ENcuT/vZEpnamG3FXylHBQXHBTeU6eKX3R
         R70dPddH4xPRuDHa8omrcc67GVQucJt0VUnKNl0J61GfTo2KqHRfFck06uEM9pROj6bX
         oqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vmwMfJKV2MTnV8e34ZcnkdOiNEV3WHgx/mF/LO5zhjc=;
        b=Elh1vDx+zlm8aA4Oo5ihEcprgK68tRnaMHm9pq1iFGb65cVEuSOAKQZxJt94kGMRmu
         gigyvHXAb4v3yREiGSIu66ch6SnTaXofCJk9GT3CjY1mYpeUai97nH54Dt/SDyRvs7br
         wLL3ilczMcmdZSx3Rjo5N7/+d6DAsWiGSBk004+nti0EDPS+91tEAS669U6jClByPAw5
         3LGU8y9/g//UNmqkfQIenXUuMBVhLfsrCqaFLEWSovOvvh37FiSQnsZHkkzX22WPOLiC
         pjh0RYUGBKTzwzmwoLEs34l0ljQlOeXamwzfxqElAsJnkspawwFdrAo3KfYunaXT0xL7
         dVCA==
X-Gm-Message-State: AOAM533JYibWKV5oSOLQab89Ikb9RCt/r1cDUlNEFnJ0WqP5ZVlDmPuX
        +2D4kfW+vRSwdYXtBB+GauGY2V7iK9RM69Ff
X-Google-Smtp-Source: ABdhPJxK2Og4+NYNGBddpr8IYw3HqTOQjisfWTquNVdzdYRnApFSJvMMN5algJYF50FdZYhhcfRV3w==
X-Received: by 2002:a17:90a:6c88:: with SMTP id y8mr2462165pjj.38.1619152983812;
        Thu, 22 Apr 2021 21:43:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u17sm3351189pfm.113.2021.04.22.21.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 21:43:03 -0700 (PDT)
Date:   Thu, 22 Apr 2021 21:43:03 -0700 (PDT)
X-Google-Original-Date: Thu, 22 Apr 2021 21:43:00 PDT (-0700)
Subject:     Re: [PATCH v5 0/6] Add SiFive FU740 PCIe host controller driver support
In-Reply-To: <CAHCEehJajVGWnAwvX+Jg3_U=WNxaNq89Xq3uvcfcHzt04qNfMQ@mail.gmail.com>
CC:     lorenzo.pieralisi@arm.com, jh80.chung@samsung.com,
        zong.li@sifive.com, robh+dt@kernel.org, vidyas@nvidia.com,
        alex.dewar90@gmail.com, erik.danie@sifive.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        mturquette@baylibre.com, aou@eecs.berkeley.edu, sboyd@kernel.org,
        hayashi.kunihiko@socionext.com, hes@sifive.com,
        khilman@baylibre.com, p.zabel@pengutronix.de, bhelgaas@google.com,
        helgaas@kernel.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-f3dd2202-8d2b-4e17-9067-c4521aac8125@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2021 19:37:50 PDT (-0700), greentime.hu@sifive.com wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> 於 2021年4月9日 週五 下午4:54寫道：
>>
>> On Tue, 6 Apr 2021 17:26:28 +0800, Greentime Hu wrote:
>> > This patchset includes SiFive FU740 PCIe host controller driver. We also
>> > add pcie_aux clock and pcie_power_on_reset controller to prci driver for
>> > PCIe driver to use it.
>> >
>> > This is tested with e1000e: Intel(R) PRO/1000 Network Card, AMD Radeon R5
>> > 230 graphics card and SP M.2 PCIe Gen 3 SSD in SiFive Unmatched based on
>> > v5.11 Linux kernel.
>> >
>> > [...]
>>
>> Applied to pci/dwc [dropped patch 6], thanks!
>>
>> [1/6] clk: sifive: Add pcie_aux clock in prci driver for PCIe driver
>>       https://git.kernel.org/lpieralisi/pci/c/f3ce593b1a
>> [2/6] clk: sifive: Use reset-simple in prci driver for PCIe driver
>>       https://git.kernel.org/lpieralisi/pci/c/0a78fcfd3d
>> [3/6] MAINTAINERS: Add maintainers for SiFive FU740 PCIe driver
>>       https://git.kernel.org/lpieralisi/pci/c/8bb1c66a90
>> [4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
>>       https://git.kernel.org/lpieralisi/pci/c/b86d55c107
>> [5/6] PCI: fu740: Add SiFive FU740 PCIe host controller driver
>>       https://git.kernel.org/lpieralisi/pci/c/327c333a79
>>
>> Thanks,
>> Lorenzo
>
> Hi Palmer,
>
> Since the PCIE driver has been applied, would you please pick patch 6
> to RISC-V for-next tree?
> Thank you. :)

Sorry, I got this confused between the Linux patch set and the u-boot 
patch set so I thought more versions of this had kept comming.  The DT 
is on for-next now.
