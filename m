Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C68322E97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhBWQRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhBWQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:17:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F48C061574;
        Tue, 23 Feb 2021 08:16:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o10so1874341wmc.1;
        Tue, 23 Feb 2021 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+edkdqgi3SYev5Q8UoeHmGWS9QJymZfx3Dq69r0Ygso=;
        b=QfklkAOZocwgThYIGee/c+xLDLK5Yy+D4PUmgxD9ohITpIhMy+osOx1MMDR1VSqif5
         VYS/qhvgDEYSJip7bLtE8Xb6c2Vto7KihCdVVwwLEyas45Oa5iV0Z+qeBZB3gEMk5VNb
         blfLQv3E4Hr0+sdg8JlXiWvS0qoTEP8+ehTiNe2ajMG/loATBugJo7Qu/1Ns2iS9t9iv
         4vn6d4dYNWNwhUWdCQyXdqe4E22/cU/q+C5jbTaDj6xgU4OGfw1r7JEzjrFv7EwrcgqW
         ydr00vUEc1g++dJLmhiOE7uWWaldAtcVe2DkHCJZ1ZGN+pW7YhbyqCzOh6ubjAIzXAf4
         tTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+edkdqgi3SYev5Q8UoeHmGWS9QJymZfx3Dq69r0Ygso=;
        b=nwsdD1OYV8jPFzCRMChRhjEXqZVELEyUkfHiywHmjBup2L8kH8Jw7+MkuHyftdA2oX
         h9loRj5C7XLq6ehGeWVk7jCA0CLBRTD7Z1fP7qHzm1Py2atEFmEcMTv7JY9v+JOJ+iW0
         AM+CC3fAUOxT5JRnDBtJVCI5kHEhYiUlRiPoju/ICUVGFTgMCldS1HH5UscLZS/ezISI
         oe7AqbeIQisz7C9qWwlIUL5GRS7kkUMHmHwEZI36o31EBG10MOMAkpkRm7zRevKt7jFn
         CQ6YYgjdZZJuzBKiBnuvBegpY0Y/XoTt8N3p7VDPqHGhydqt3uCbmxh97XbX285n5qGd
         IORw==
X-Gm-Message-State: AOAM533I8BpXABZFvMwhKGToOS6kkLtJjeMzgQElz609cQ9DjDlek4so
        BBM0TkuArRW/hKOA51yk86Q=
X-Google-Smtp-Source: ABdhPJxIKUbIkdzh5aSKqP4BK8xaXviO0WDFC7xjICkxsoBmOBeCkSL2xrKojcLx0aLrKx4aPuQX3A==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr13849906wmc.95.1614097006584;
        Tue, 23 Feb 2021 08:16:46 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id h13sm32699925wrv.20.2021.02.23.08.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 08:16:46 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, jonas.gorski@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 0/2] usb: host: ehci-platform: add ignore-oc DT support
Date:   Tue, 23 Feb 2021 17:16:42 +0100
Message-Id: <20210223161644.6095-1-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223155005.21712-1-noltari@gmail.com>
References: <20210223155005.21712-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Over-current reporting isn't supported on some platforms such as bcm63xx.
These devices will incorrectly report over-current if this flag isn't properly
activated.

Álvaro Fernández Rojas (2):
  dt-bindings: usb: generic-ehci: document ignore-oc flag
  usb: host: ehci-platform: add ignore_oc DT support

 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 6 ++++++
 drivers/usb/host/ehci-platform.c                        | 3 +++
 2 files changed, 9 insertions(+)

-- 
2.20.1

