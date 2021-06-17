Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61A63AB552
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFQOGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43204 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhFQOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623938662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=25IAmcYGl3crCnoWt1z2qiUGGrmE3OdaCwxpg3/NRzM=;
        b=PxN7zjACji/3P9UN2SCv/6aJovMAE680K0VPhFcEt4Yq0WnF1nFlTGwl5hZXonnftymF4l
        lTIDE4qJT90rjzgMh+icSjAoWR5ZTqE0LCai0qE3t8iqOQ7UPNBd0eJUkNPKgYpYElaH6w
        GRae34/sIqL/HW+NbqVDRerO1mGl8b0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-p5P2iMcoMDCk7RowanjUkQ-1; Thu, 17 Jun 2021 10:04:21 -0400
X-MC-Unique: p5P2iMcoMDCk7RowanjUkQ-1
Received: by mail-ej1-f72.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so2274780ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=25IAmcYGl3crCnoWt1z2qiUGGrmE3OdaCwxpg3/NRzM=;
        b=Ll5rB1XZI8OJtaENSm1fKAQnhJDt1t/D/+4EGJWetTIds7cENqOYo+DALkkpqBMSbo
         Pn8YUWi42ixxCI9fbJAFd8EZEE0qDQiuMwtgfgyyWi4IVtI/W/+XzEeMXhSbjNMQHrMQ
         hsBhTyzuBueZdQaVG0LNXO2qtlz6j2+XFs1zm4tWQTZ8lETUzIHtcVQVYdoSX1JQSLaX
         UzSUaSP1aevNCmjx2LZ+qnvLoPCGXHyuQiuqjNJdFLIyNg9lCSmK76Z1FsyT8AOJjcgj
         VqWq4pa11rencacTBE/uGKb2MGyp5N/u+/+NnOlux5UJXei2EyV/DZoGYvhQgOp/gw/x
         5Qaw==
X-Gm-Message-State: AOAM5329mkf3SO2fPiFkHc3yAl+6zJRl869MgVE26jQFchgmrYg+XnAb
        +OG9+VgYawLOh/wQXkiu/8eTDwDOOP6ea3o97yqIQAm2FNXHnwFKZ/8W2eMYVHHVKUQ48ynk2ha
        7NksJARyFyl0xL1mqfoXSx3ipgpQ0GsBUKnwnhCzKh5W8xxraWtBGWn0aGgmrolOmL7+vK5bt4V
        Ya
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr6688427edx.189.1623938660176;
        Thu, 17 Jun 2021 07:04:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfoH8LKSDwEj1+JIjkV0x3Lg5pKBFOIDurBFIj8B5tANiOs5WpxdID033TUEbyI8xeAjnM6g==
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr6688392edx.189.1623938659938;
        Thu, 17 Jun 2021 07:04:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x3sm3864697ejw.69.2021.06.17.07.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 07:04:19 -0700 (PDT)
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] Immutable branch between drivers/platform/x86 and
 drivers/extcon due for the v5.14 merge window
Message-ID: <667247a0-e40a-84d9-889b-8ecf51e5d453@redhat.com>
Date:   Thu, 17 Jun 2021 16:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

As discussed here is a pull-req from an immutable branch with the
devm-helper changes from Matti for you to merge into the extcon tree.

I have already merged this into my review-hans branch and once the
builders had a chance to play with this I will push this
branch to platform-drivers-x86/for-next.

Regards,

Hans


The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/devm-helpers-v5.14-1

for you to fetch changes up to 87ee8de23c9df3a368504f34cf3d7f9be9207717:

  extcon: extcon-max8997: Simplify driver using devm (2021-06-17 13:22:27 +0200)

----------------------------------------------------------------
Signed tag for the immutable devm-helpers branch for merging
into the extcon and pdx86 trees.

----------------------------------------------------------------
Matti Vaittinen (5):
      devm-helpers: Add resource managed version of work init
      extcon: extcon-max14577: Fix potential work-queue cancellation race
      extcon: extcon-max77693.c: Fix potential work-queue cancellation race
      extcon: extcon-max8997: Fix IRQ freeing at error path
      extcon: extcon-max8997: Simplify driver using devm

 drivers/extcon/extcon-max14577.c | 16 +++++---------
 drivers/extcon/extcon-max77693.c | 17 +++++----------
 drivers/extcon/extcon-max8997.c  | 45 ++++++++++++++--------------------------
 include/linux/devm-helpers.h     | 25 ++++++++++++++++++++++
 4 files changed, 50 insertions(+), 53 deletions(-)

