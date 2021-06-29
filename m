Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676003B7459
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhF2Oc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhF2Oc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:32:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34DAC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:29:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t3so31581375edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wB4FiBGvprIuCCVuYdV/lm3OI2xK185EMQiNBS5+SnY=;
        b=wL3H5lyRBK5V/gXc3JaN7+WlnvM+aSSUjtlISo9Vc3LeZ+PpWz0DrnfrsBnlWeqKes
         NwuxAaxJNLC4QQz5voli9f9L89eVz01LM+4ZHLDFkvAuhueSdpJzgHxf+P3cC9F+GBnk
         eGMMtHb/kLRepfvZJeNScS/WhZ0Re4kSyV/NiPD0FB8u3w7kFTlsnmWr7d0fyR6VKLsA
         ILHxyqOVKj402ILaNBi3cIJLrLSVQqxCy5ui9hWvVfVdNohDdnqPdGFgblpFWAKTK5sm
         8DVUC0h3NbMXg5x9dTs19fWFhD5jM2Hg7odtl3xpaWAs0qJnizUO83LLoLokEYpj7UU2
         hGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wB4FiBGvprIuCCVuYdV/lm3OI2xK185EMQiNBS5+SnY=;
        b=HzkNfHYnrZ8Z7ffbV9rm5RO5v2UewSU8eCj4g6U8xY+xCl07Ind1ZM3sQfAbbPmMTY
         5tnEMWKKDh78dzixNc6jS/24hP1yNjTbTG2mlOuB6rU5LzphzIXLLjQfFPaCz7WutCtP
         HdFcoAVA3iiviLBF35v1SG4LRgXp9ghRCCilYrH+y528gR4NKWPW4jVosRZ92m/F32kB
         eGS9vrB4WLdrAP1gI04TFjy0Z5qT4qB1KnPIHJ9EQMl2i35COfJRJo+dcioWVmZgH1Fa
         3Mkbkl8EFC3Pr1126wJMbfWcHsYJueXbHoR79hPAnyoYqSQCCRArqwH1LwEX2zVjwWZx
         rXfg==
X-Gm-Message-State: AOAM531891eH9NZwZuzYdg2DXPj28lqiCnpY3qVXbL26kjEQBlYyBiFT
        Zm6JC3NoMtvgKnU5VfB2V5Quvzpolx1CUcS/
X-Google-Smtp-Source: ABdhPJzX8pEoV6y7HDTaLESYook89iZ7Y3XovaBU4OK3j3L6NuKrsK62ykIEUzhs0sqL0MYI/4QWtQ==
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr34953919edb.130.1624976997305;
        Tue, 29 Jun 2021 07:29:57 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id hy5sm8492982ejc.72.2021.06.29.07.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 07:29:56 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.14-rc1
Message-ID: <e566b945-2fd0-bff0-b291-e7538bafc3fc@monstr.eu>
Date:   Tue, 29 Jun 2021 16:29:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these two small patches to your tree.

Thanks,
Michal

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.14

for you to fetch changes up to 14a832498c23cf480243222189066a8006182b9d:

  arch: microblaze: Fix spelling mistake "vesion" -> "version"
(2021-06-02 09:50:36 +0200)

----------------------------------------------------------------
Microblaze patches for 5.14-rc1

- Remove unused PAGE_UP/DOWN macros
- Fix trivial spelling mistake

----------------------------------------------------------------
Colin Ian King (1):
      arch: microblaze: Fix spelling mistake "vesion" -> "version"

Guo Ren (1):
      microblaze: Cleanup unused functions

 arch/microblaze/Makefile           | 2 +-
 arch/microblaze/include/asm/page.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

