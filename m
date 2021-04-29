Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C036E64C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbhD2HxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhD2HxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:53:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D004C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:52:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gx5so6377931ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=og6rPNeD+rOEL+ogAHa0BnXhYJoaU+SruXIlKeqLuSE=;
        b=ov81kQHa2DfG54BfyqX1OGbPfjOhCf6QjaIdz6ZFs1CvlCOYxA0IEnC90Iw9p5J+j/
         nUPJNlTTBY1Qjofh1Vz+K/WB8Z2l+XlZCtMA74/E/bUL2gmWBEborpFHD6JHMEZnRZ92
         G9ZUkqi90eby4wYcvdFnT41XTZ3vQWgDDeH8RBS5UUveOA1WhbxcX3mGGAt0wsPfCpJa
         3feTNYsGylB8znoBgKBVRIyf39it2yIyy7pe0wc4LNDVFFgmtuez6cMHEszvoLgEgvmM
         GnQDqiq9hKtOZ5Y6BqeLwbmWIPBwuhJWmxwpPwQ6rIlPFO0aUU5mz3X8zopOY/AR5hCo
         35bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=og6rPNeD+rOEL+ogAHa0BnXhYJoaU+SruXIlKeqLuSE=;
        b=FBNc67Q5GtQZvmtWMLzgKMAw7iAJ0trxb8pcn+CEwsunqZT9awUVBPjPd26EhmP3Ll
         JeUgBB436VL8XgrXvDCeMVAVDsoYEhO+x+sv6QVNhOpcH8RcC0IQ6Ce52v3TlxZHcFTI
         4CmBnrnONJlYVHHp1mVvmGnwH1z2S6HAcFAvz4y7vyb6DVO5CKe9I8VlVZLh1CieqtOA
         LYtkPjpC/3xdP4HVavLnP/CDKh09qUkxPVPRC9NbCqYSJW1BrJmF9VQx/BkSo5h0Xnj3
         DnKn3QEXk2NzmKzfSZi4GJFREOgdqletlDBrl1kBVs4DBso3MKzYIBFmY343VzhwU7pe
         QnOA==
X-Gm-Message-State: AOAM531PIYYJMOXSGJEUhyU4K1JgeXlkRI0OJWWFRmEgVmdUCtvZik1B
        E7JMC4ccvdOv7vRZ5130HRZW78OS3uxjhuUL
X-Google-Smtp-Source: ABdhPJwZN3vd/iusAiVbceVs2eux0dmOopQD1Xg4vUqb1eT40tIOUspmmWr98vb0zy1ZssWIGbWS7Q==
X-Received: by 2002:a17:906:1fd1:: with SMTP id e17mr1225600ejt.419.1619682749712;
        Thu, 29 Apr 2021 00:52:29 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id a22sm1714162edu.14.2021.04.29.00.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 00:52:29 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.13-rc1
Message-ID: <ffad0699-7966-f601-3d88-8ad1157bf2b8@monstr.eu>
Date:   Thu, 29 Apr 2021 09:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull these patches to your tree. There is no new feature added
but it just about cleaning up some code and moving to generic syscall
solution used by other architectures.

Thanks,
Michal


The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.13

for you to fetch changes up to 47de4477a8e6bfd202640567ce4bf17cc1de60be:

  microblaze: add 'fallthrough' to memcpy/memset/memmove (2021-04-22
09:34:05 +0200)

----------------------------------------------------------------
Microblaze patches for 5.13-rc1

- Switch to generic syscall scripts
- Some small fixes

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      microblaze: Fix a typo

David Hildenbrand (1):
      microblaze: tag highmem_setup() with __meminit

Masahiro Yamada (2):
      microblaze: syscalls: switch to generic syscalltbl.sh
      microblaze: syscalls: switch to generic syscallhdr.sh

Randy Dunlap (1):
      microblaze: add 'fallthrough' to memcpy/memset/memmove

 arch/microblaze/kernel/syscall_table.S        |  3 +--
 arch/microblaze/kernel/syscalls/Makefile      | 14 ++++----------
 arch/microblaze/kernel/syscalls/syscallhdr.sh | 36
------------------------------------
 arch/microblaze/kernel/syscalls/syscalltbl.sh | 32
--------------------------------
 arch/microblaze/lib/memcpy.c                  |  4 ++++
 arch/microblaze/lib/memmove.c                 |  5 +++++
 arch/microblaze/lib/memset.c                  |  2 ++
 arch/microblaze/lib/uaccess_old.S             |  2 +-
 arch/microblaze/mm/init.c                     |  2 +-
 9 files changed, 18 insertions(+), 82 deletions(-)
 delete mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

