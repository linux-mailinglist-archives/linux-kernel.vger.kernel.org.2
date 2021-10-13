Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC442C13E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhJMNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhJMNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:22:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E41C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:20:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r18so8345280wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNlPB75M4XSOjxI3wOhKbU7nFj5ZW12aJOqcg2JsS4E=;
        b=GGsU8yG1YnpioZClYoEgT5tK+YG6/PVqb45wEc6+RpzLdKx3gnFghuTwHu/wmSyF6X
         R4335nDbbO/tf9WPJuyvI/GLpZ6YVUBYiJRf7vRrCrw+6Vl5QRv3e640luWgwSJShFiH
         ILAy2aZzM7JdgYt92YquoHYuCbrEEMLDqRBHO9DmjEoyJIFRlAFDZ9ToNpRDD+mUW9Er
         JQzXGTPcJLDy1uYhBkD99sibDzYq+5je0s96J3+MA9s0yP7GoZmSAISlfq/RKOtk2jjh
         8FjmBxxH9edpGqriCXXCxq3uYzRJ6IdxmY2BgQvLHtQgtx51zo4hBTKk+t7ELE6vJo18
         GxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bNlPB75M4XSOjxI3wOhKbU7nFj5ZW12aJOqcg2JsS4E=;
        b=5wVwtXztRDqnNqN1aLPQ+y8+9dKOgpDp0k5wwZ+CrTBCWLYuk1+GnlY2MT5e57swdW
         bj/Mf2oYyDmRR3YghyqC8LDC5R6DWIrewpv27H00yOLXF2XzGAtguaF/NDw7ad3go0Ci
         Q9WNtPs3kTPuaAI14nZqNmgrdJqZJ7toK9bvM0zAWg0go+wA0EsloMqKJgU6Yewa+u+A
         qVxoNKpF2xfJ1HqSAn/iU54OiGJjhT8it43aDIbVduEe+AkeQoA6ReRDNlGeXFUDiCM9
         DDT4pfKzLa49KXOGAM8P6UKx8Uluty94Lh9EoloF0eXLKHlBzztOz+tmczLXeAUlicgO
         JYkg==
X-Gm-Message-State: AOAM530a1niSZscDpU+Qo8O9xoWp1AjRIekfD+LxHaQuv50Nge9ebx//
        sM/Dw/dwas9TJkv0up7Cumm6utL2sZQ=
X-Google-Smtp-Source: ABdhPJyxQsmUqJniLZKhY2c3MZecZND9D3IR/GaFt7BiiAnimqvmsDph7NUndMk6iDAGUEmQh+tUKA==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr12445623wml.175.1634131226609;
        Wed, 13 Oct 2021 06:20:26 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r4sm2281367wrz.58.2021.10.13.06.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:20:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] nvmem: patches (set 1) for 5.16
Date:   Wed, 13 Oct 2021 14:19:54 +0100
Message-Id: <20211013131957.30271-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.16 mainly to add support for nvmem
cell data post processing in the provider drivers.
This is to help post process data like mac-address which are stored
in a vendor specific format that is not directly understood by the
nvmem consumer drivers.

Can you please queue them up for 5.16.

thanks for you help,
srini

Srinivas Kandagatla (3):
  nvmem: core: rework nvmem cell instance creation
  nvmem: core: add nvmem cell post processing callback
  nvmem: imx-ocotp: add support for post processing

 drivers/nvmem/core.c           | 174 +++++++++++++++++++++------------
 drivers/nvmem/imx-ocotp.c      |  25 +++++
 include/linux/nvmem-provider.h |   5 +
 3 files changed, 144 insertions(+), 60 deletions(-)

-- 
2.21.0

