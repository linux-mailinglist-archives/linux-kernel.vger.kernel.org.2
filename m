Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7CE311C6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 10:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBFJwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 04:52:46 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:39731 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhBFJwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 04:52:40 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id 1169pdDX029775;
        Sat, 6 Feb 2021 12:51:44 +0300
Received: from oak.local (unknown [83.167.113.121])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id ACA2013A94;
        Sat,  6 Feb 2021 12:51:40 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v4 0/4] hwmon: lm75: Handle broken device nodes gracefully
Date:   Sat,  6 Feb 2021 12:51:17 +0300
Message-Id: <20210206095121.20625-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2588ea5c-630e-6509-689d-4c8fea358e9b@roeck-us.net>
References: <2588ea5c-630e-6509-689d-4c8fea358e9b@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to fix a logical issue in lm75 driver.
The actual fix is in the last patch. 
Other patches are present in order not to break existing users.

Matwey V. Kornilov (4):
  hwmon: lm75: Add lm75 to of_match list
  hwmon: lm75: Add nxp,lm75a to of_match list
  hwmon: lm75: Add ti,lm75 to of_match list
  hwmon: lm75: Handle broken device nodes gracefully

 .../devicetree/bindings/hwmon/lm75.yaml       |  3 ++
 drivers/hwmon/lm75.c                          | 32 +++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.26.2

