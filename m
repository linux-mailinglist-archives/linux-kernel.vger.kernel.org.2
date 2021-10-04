Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD3B4212C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhJDPid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:38:33 -0400
Received: from smtp1.axis.com ([195.60.68.17]:45236 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233700AbhJDPic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633361803;
  x=1664897803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L2Gat4M8MiKu4O6dro5tmxzcNp9424jTmLuiAVMgiM0=;
  b=oeakFufNcGTSGPOcZlau+NOS0XBtyt68ayqdjSq9HwQ2hGnaufmFB797
   hrR4d210C6azuj5SXiijw6TKNoiambdXokSjqO6thnAX0QoK73MLenr5t
   Xo6A8A5HdopQ5iA3dXGV5sfIifbT8Qw8EGBfNIOGEPB6foWwLDKfGoypG
   X7LlL6GxpNLe25qO1kOLrdFxFOWKSIp2eIiDJOsIvy+2UDN2ojnkJj8Yx
   gMLmDt9YA6OZYcot6TcF827Zfzqpg2+jF/qNAxF0EgLtUPAFOdukjBaaY
   9qJo1JyuQTHMUMBWO7N7NAYFtrGoDebWLnDOGK4v9UrcKVUrbhuWA1s3D
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <peda@axentia.se>, <devicetree@vger.kernel.org>
CC:     <kernel@axis.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 0/2] Add settle time support to mux-gpio
Date:   Mon, 4 Oct 2021 17:36:38 +0200
Message-ID: <20211004153640.20650-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On one of our boards we use gpio-mux with iio-mux to read voltages using an
ADC from a few different channels, and on this board the input voltage needs
some time to stabilize after a switch of the mux.

This series add devicetree and driver support for this kind of hardware which
requries a settle time after muxing.

Vincent Whitchurch (2):
  dt-bindings: mux: gpio-mux: Add property for settle time
  mux: gpio: Support settle-time-us property

 Documentation/devicetree/bindings/mux/gpio-mux.yaml | 5 +++++
 drivers/mux/gpio.c                                  | 9 +++++++++
 2 files changed, 14 insertions(+)

-- 
2.28.0

