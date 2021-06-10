Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2713A2B24
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFJMLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:11:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F18FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 05:09:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h12so1448703pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b8nZP+Gapaq0m2CiyXSp+UoYpv4V40nbqCx5vZWy2So=;
        b=qNpHGLbzx8OhyV03T1XQBAEOd4lRjyRCU0fJwWQZM9z8cmhPoAFi+GDxkHRMRhazLH
         R0nsMAtnYe96LshwmR/TMRPVGoU8ytMBoxbmB53R8tZYrcmwEFY8HlHAn44TpYb0pzTh
         qmB77sFVrdZyAyBI4G19njPnorLQYKYdmRF092cSd0Ei7zqUxCPk/1jsa5KnX0YhIvk1
         SzFP1/gawTAr5K0/RmkjYDxzJD37wlU3JNFPy+LzxoihOhSyx3ZJ+C93QrVboF34Xv0n
         Li/GbaMZV6qI7CbrdPL5RJ9aq7yt+bgyv+rUCOxswMYCURW7p2jiiOGrkgPqjecyRGWA
         0TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b8nZP+Gapaq0m2CiyXSp+UoYpv4V40nbqCx5vZWy2So=;
        b=f6c6SB9xA9gnrRQj7GSVL/sM16K2HjstGNsdG0gKg4cs8EgOeWYyIlSoO3u1uW97Xj
         TXfNf0TNbVf7jP1DxrVe3//fEgSwfl0CIo3AD/RDIxbbOJD1mLpPCzYzqtHfvvfw7bz+
         tirLdmeppMLxRPVFau5nHyFvyOxv24pPBxc9uQygchan1ja6Tmw6dtY5CI5bG7O6s2tp
         YwHz+2zmg5GlQpyjRdVirpN1tWKdqYqjKl1SiyhLjsObc5vYaIgDQK/Ak10MQKXqM5Bm
         /tzxJyP/BEm4tmWw08ATAPJ0Ln9rcz/Mun2KsD3D5Gyjrzk5efUg94ltZLqsR7h34jYW
         QJiQ==
X-Gm-Message-State: AOAM532hoxwrKQiKiEAuqGlG6b6EsuPJsGkuv1Wxz1Yacz55dIyBUGFA
        CK+K6x8WX5IR1JtZWJGj3X+CSQ==
X-Google-Smtp-Source: ABdhPJwSp9xuwNSizzHp3uvbFX+DHZygMqXvOaYSXbJZdQ1gOs84CgFHQge7IuxwbzYsh3V0+5Vtug==
X-Received: by 2002:a62:ab16:0:b029:2ed:8599:7df8 with SMTP id p22-20020a62ab160000b02902ed85997df8mr2772433pff.31.1623326957801;
        Thu, 10 Jun 2021 05:09:17 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id v67sm2423802pfb.193.2021.06.10.05.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:09:17 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org
Subject: [PATCH V3 0/3] gpio: Add virtio based driver
Date:   Thu, 10 Jun 2021 17:39:05 +0530
Message-Id: <cover.1623326176.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This adds a virtio based GPIO driver based on the proposed specification [1].

The first two versions [2] were sent by Enrico earlier and here is a newer version.
I have retained the authorship of the work done by Enrico (1st patch) to make
sure we don't loose his credits.

I have tested all basic operations of the patchset (with Qemu guest) with the
libgpiod utility. I have also tested the handling of interrupts on the guest
side. All works as expected.

I will now be working towards a Rust based hypervisor agnostic backend to
provide a generic solution for that.

This should be merged only after the specifications are merged, I will keep
everyone posted for the same.

I am not adding a version history here as a lot of changes have been made, from
protocol to code and this really needs a full review from scratch.

--
Viresh

[1] https://lists.oasis-open.org/archives/virtio-comment/202106/msg00022.html
[2] https://lore.kernel.org/linux-gpio/20201203191135.21576-2-info@metux.net/

Enrico Weigelt, metux IT consult (1):
  gpio: Add virtio-gpio driver

Viresh Kumar (2):
  gpio: virtio: Add IRQ support
  MAINTAINERS: Add entry for Virtio-gpio

 MAINTAINERS                      |   7 +
 drivers/gpio/Kconfig             |   9 +
 drivers/gpio/Makefile            |   1 +
 drivers/gpio/gpio-virtio.c       | 566 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_gpio.h |  56 +++
 include/uapi/linux/virtio_ids.h  |   1 +
 6 files changed, 640 insertions(+)
 create mode 100644 drivers/gpio/gpio-virtio.c
 create mode 100644 include/uapi/linux/virtio_gpio.h

-- 
2.31.1.272.g89b43f80a514

