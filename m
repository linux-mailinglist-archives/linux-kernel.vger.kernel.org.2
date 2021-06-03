Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AA739A914
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhFCRYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 13:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232270AbhFCRY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622740960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aHpBelIcGziVZRjX50HNqyKbhuaMC/JWW1ZKekLkz48=;
        b=cFQgGKqeMq5N8yDh95Z9R0xHcpDQrIZMf5z/A8JagCX8RPGLqWwxgnZ8HBsmzstPS7EhLo
        PIdlQMDsDb/8cvjy05XAGk3j45K/0jyVjUtaMppW3wWB0ijGOjHfOjhhVVfvNEcqVMbn7x
        bN3iXvsCOrbn47PBj5PXIJ8qf4D3osQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-4o3YLKuAOaicr8Dfq4mL6A-1; Thu, 03 Jun 2021 13:22:39 -0400
X-MC-Unique: 4o3YLKuAOaicr8Dfq4mL6A-1
Received: by mail-oi1-f200.google.com with SMTP id j12-20020a056808034cb02901f18cf8f4c5so3345497oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 10:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=aHpBelIcGziVZRjX50HNqyKbhuaMC/JWW1ZKekLkz48=;
        b=A0nxsJ41miVf2mHLLB1EsNE0hiVbeOppW5W15dnJc+SKo7myVMb9apaoRRqU2So69g
         /tZnyQ2JBlmzEhjFzHjwShjUh5fUtQuz0FNCYuaPcuWFAXCTZbFPcTj+W5249CVkFpfb
         b/axEjEB68gG7ueL0w8X5qQ4UUwk/dkY8P0Wr7G4qhy6eDDv7W3Eb3QSxWYOLHM75dy8
         GnblvnfLwYlB6EHHz0UzZN2eXp19NCAX5iAzzPZF9panQTJzfi5jNbL6aSWsVOXO3a+Q
         jcX7t7MHHPlZXQEzRg4MPslpEXAOWM0uhspR3h/3SWet2emhB0RvD7fr3InJ8oAw8hvT
         9p0w==
X-Gm-Message-State: AOAM531XYrWOhsi19NODTJwdPDJCZdQr25wte8mJFWEMc2njN5nRwbjk
        5U/oHs4SEsIwIkJhv3Dyo0EmSu24hVAM01Vy3UOxfKPWN3v8RoExOzzvmMEYBLJGAhGqkTK6fGK
        b9a4Qsji639gvVJvu6trsGH/j
X-Received: by 2002:a4a:55c1:: with SMTP id e184mr286054oob.74.1622740958678;
        Thu, 03 Jun 2021 10:22:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWIJ6FthiCRVzxgagPFmBEKINqHxxlflAKjGADOX+m7iPOMGXQLstOybZQVabNpnfI65ro3w==
X-Received: by 2002:a4a:55c1:: with SMTP id e184mr286039oob.74.1622740958468;
        Thu, 03 Jun 2021 10:22:38 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id p1sm847639otk.58.2021.06.03.10.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 10:22:38 -0700 (PDT)
Date:   Thu, 3 Jun 2021 11:22:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO fixes for v5.13-rc5
Message-ID: <20210603112237.42b620c1.alex.williamson@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v5.13-rc5

for you to fetch changes up to dc51ff91cf2d1e9a2d941da483602f71d4a51472:

  vfio/platform: fix module_put call in error flow (2021-05-24 13:40:13 -0600)

----------------------------------------------------------------
VFIO fixes for v5.13-rc5

 - Fix error path return value (Zhen Lei)

 - Add vfio-pci CONFIG_MMU dependency (Randy Dunlap)

 - Replace open coding with struct_size() (Gustavo A. R. Silva)

 - Fix sample driver error path (Wei Yongjun)

 - Fix vfio-platform error path module_put() (Max Gurtovoy)

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      vfio/iommu_type1: Use struct_size() for kzalloc()

Max Gurtovoy (1):
      vfio/platform: fix module_put call in error flow

Randy Dunlap (1):
      vfio/pci: zap_vma_ptes() needs MMU

Wei Yongjun (1):
      samples: vfio-mdev: fix error handing in mdpy_fb_probe()

Zhen Lei (1):
      vfio/pci: Fix error return code in vfio_ecap_init()

 drivers/vfio/pci/Kconfig                     |  1 +
 drivers/vfio/pci/vfio_pci_config.c           |  2 +-
 drivers/vfio/platform/vfio_platform_common.c |  2 +-
 drivers/vfio/vfio_iommu_type1.c              |  2 +-
 samples/vfio-mdev/mdpy-fb.c                  | 13 +++++++++----
 5 files changed, 13 insertions(+), 7 deletions(-)

