Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB4440CC3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 06:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhJaFCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 01:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJaFCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 01:02:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F98BC061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 22:00:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u11so29692883lfs.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lVy/fH24QPthS6HWBiNCLxZd58wLIhBCTESTMr1diy8=;
        b=GIqiP/e/0airkBt7AVVY9zwAqH+XFDnesnpw99ouddGWsttfIktj4aAfI9gEGXK9Mf
         IjUUcCwzBLka6YrTwoDQwnX+Sv4M5h86v4FbXS4pyxv7OW5d2c0MB+usBFsCg2VKoFFf
         a0IoU76Nm1UoIBaNYnjUN6hBfnNC9DAZldpovLf/WvQ1TPARBxfejVE+ogZJ8DcrCQg/
         ZDqLVhXkzk9SWmyB0eWrxcAqdDpz6iBZ61N1XUkXnDU/vGfpmtIckAaF7GuM8wjoM9US
         3pJLpff//y9JOx4cmV9NlSGe2Hhfu6m6I1h9kulySyK5GLhqixFRduT6YIGeh9+nmYGL
         BTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lVy/fH24QPthS6HWBiNCLxZd58wLIhBCTESTMr1diy8=;
        b=SoUCbXnKnYJcmGHVzi/kYPf72ElzMMZVsb/+6TRhZfNMtvMIbXUCkFGDD2X+WuUKKl
         QDxdj2O0BU8bsu4Wz7rhMy107Wsn9l6ogFXmoHNbWvxO5D5F38zafeqUvNrJJZ8G98K0
         9JJIMSPaCpGcKhhiK5S9GKtv/QRGE0rfVMmQ9wYWBsUgwDF4iKoBM0+9lvFkd/SbPAX2
         LJM2FJvrFooxrj+KIk6QoNk+eBzM29pR+ClHtUnmO1/aYArbpRtFBiYiWVaMdp9ZOE8V
         Hes8zBceh2wQk8K+lCKV93dnSpPuB9Mp1FI2MgjiNF5I3R1jq9dzX/5E09SvpefZhswg
         fnBg==
X-Gm-Message-State: AOAM53283uvUyW01AcmYsQn2pRe91bNTkl0CTiTRa0vNIC7oAHFgiXmB
        g2ZPxULEOwbeNgxqCKFz2tiBzA==
X-Google-Smtp-Source: ABdhPJyKTkZQH3l/LPlaLkLV/r+BpuZCIeqJk+kdJFxDS+cI9MUR+ouY31Lbxo7K5bbon3ujFVQhIg==
X-Received: by 2002:a05:6512:260e:: with SMTP id bt14mr20820988lfb.129.1635656407162;
        Sat, 30 Oct 2021 22:00:07 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id v26sm444766lfo.125.2021.10.30.22.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 22:00:06 -0700 (PDT)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuri.benditovich@daynix.com,
        yan@daynix.com
Subject: [RFC PATCH 0/4] Added RSS support.
Date:   Sun, 31 Oct 2021 06:59:55 +0200
Message-Id: <20211031045959.143001-1-andrew@daynix.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of RFC patches for comments and additional proposals.

Virtio-net supports "hardware" RSS with toeplitz key.
Also, it allows receiving calculated hash in vheader
that may be used with RPS.
Added ethtools callbacks to manipulate RSS.

Technically hash calculation may be set only for
SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
The completely disabling hash calculation for TCP or UDP
would disable hash calculation for IP.

RSS/RXHASH is disabled by default.

Changes since rfc:
* code refactored
* patches reformatted
* added feature validation

Andrew Melnychenko (4):
  drivers/net/virtio_net: Fixed vheader to use v1.
  drivers/net/virtio_net: Changed mergeable buffer length calculation.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report control.

 drivers/net/virtio_net.c | 405 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 390 insertions(+), 15 deletions(-)

-- 
2.33.1

