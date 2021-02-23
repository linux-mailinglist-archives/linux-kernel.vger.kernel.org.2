Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E36D322E02
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhBWPvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhBWPu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:50:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E8C06174A;
        Tue, 23 Feb 2021 07:50:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r3so11423550wro.9;
        Tue, 23 Feb 2021 07:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUxd1NQzADzDyuGmI3T0uFcSxsw9DHxLT0ukNf1HOW8=;
        b=ilnMKTOYJ6LGVB12ISauevTix4asIiKaNA8jH0/BW88WRCeqLP8m/GoHbUYoNlSJz+
         nUmZIp3IKhMyzaGcksAxuMmJ3nNb+a/frTZcBc02bKPRncLawRksklcMmOwfv6z3akbG
         Aau6aCIb1Nj7LLUMK7ajzu/uyK7Wz9+wzNCcIfl63+M9IsqUcWOADHuZCMdKGqxTApGj
         4Qe3CwmHefnVgfqz2Z37Z+u9dE4C0yaqpZfYzPh5hjblCGnZntT5u+qcYfJ1h+mOEnXo
         zna3at/QL9GUz6bco1+G0V5mxFb4a/xNkQfcsRPSHNg+AHguPkdRVSTHvN3RsJfsZH9O
         v+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUxd1NQzADzDyuGmI3T0uFcSxsw9DHxLT0ukNf1HOW8=;
        b=h2ZJdZhFyRYYbNbBnp/TglOE1h7IViB+JFlyxePkdRq3QI5UfNncsTYYzqTmIGZY4K
         Fg27NXy38gaUwQ7QRTbR4KWA2ot7AvBqvZzj4yOx4OkXUUaEegtkeTdROOQ29rOxZAl+
         UkXr+TunDFGJLbSDKw5/0Jbk1pBfWhdJhZar4GljItsWRA1fqbM2srZ2pDicTWbvavbZ
         6YnVSor6zaajym7Z1Q083dsbmt18axlKejWZhu5n1V9J98A3Mf2S0OfROs7rCTDQ3r+w
         mWEH6Sa+phDSu4Ui2zLdyiiWHOnMe27oDleSi4nBjkPluqN8QxKJ5Zk0796rKBxtDnug
         oNuQ==
X-Gm-Message-State: AOAM532BmH960s0aFWDwi4/HmE15TgrQ+IqsjQeggdkiD0OyGTectJ8L
        Kl18VSgQoecj9jq0CP82j6jJSzbIm07pDdXm
X-Google-Smtp-Source: ABdhPJx1jK0dqfaAO0LhsAq2ZXpl6IGoY5j+HsPmXHEfbGVhMQby5pUCJWFBrbcwNG8geodxx1Gm7w==
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr27435720wrw.298.1614095408559;
        Tue, 23 Feb 2021 07:50:08 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id t23sm3209201wmn.13.2021.02.23.07.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:50:07 -0800 (PST)
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
Subject: [PATCH 0/2] usb: host: ehci-platform: add ignore-oc DT support
Date:   Tue, 23 Feb 2021 16:50:03 +0100
Message-Id: <20210223155005.21712-1-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
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
  usb: host: ehci-platform: add ignore-oc DT support

 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 5 +++++
 drivers/usb/host/ehci-platform.c                        | 3 +++
 2 files changed, 8 insertions(+)

-- 
2.20.1

