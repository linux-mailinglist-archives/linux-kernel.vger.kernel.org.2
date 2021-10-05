Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6368F422A24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhJEOIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbhJEOIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:08:10 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E438CC08E8A9;
        Tue,  5 Oct 2021 07:03:38 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HNznh1VL3zQjbb;
        Tue,  5 Oct 2021 16:03:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robgreener.com;
        s=MBO0001; t=1633442598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc; bh=hx95swwG+ltUhhHv7A0H8iGt2RP/xSHvTG4WjbflYLk=;
        b=GHR642JpSFmpKr84x2HVhyzDkIGvROhAtoQSHgdCVSTzTsH4NsHRL/kwkv8r9MU9qwAINX
        j83UDjkolWW91oGvw3RSlMmvFR1moStVkHJNeziOA+I/5D98Qf5fnDaaSidJxcIP+MO23+
        mcsTFNPS762r7FwyduKhjSxBPEWa/+FdOZAZhAnG/3RbHfvDV8clzxCGBehr8S83P0/4yM
        k9KyXLmF1+vSvFnGNgYcZqC3RQTA4iG6m3tQVbHrq3mb9QpVCQ1aOfgmsYwaqgYF9sIEBn
        qwat36I5l+wb8fPJlTbFza4WTcJqnszIf1fRhW2OMUKKrWCawV6ajsOV6q0jEQ==
X-Mailbox-Line: From 835bbc4e27ca989674fb916f70b81038deaf47e5 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1633442131.git.rob@robgreener.com>
From:   Robert Greener <rob@robgreener.com>
Date:   Tue, 5 Oct 2021 14:55:31 +0100
Subject: [PATCH 00/13] usb: core: config: fix all checkpatch.pl warnings
X-Rspamd-Queue-Id: 2608B272
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes all checkpatch warnings in drivers/usb/core/config.c

(when combined with my earlier patch
Link: https://lore.kernel.org/r/20211001151350.ijiexr3ebwvypmdd@shortbread)

Robert Greener (13):
  usb: core: config: Use tabs rather than spaces for new lines of args
  usb: core: config: fix block comment styles
  usb: core: config: Change `unsigned` to `unsigned int`
  usb: core: config: Avoid multiple line derefrence
  usb: core: config: Fix typo in dev_warn
  usb: core: config: unsplit strings which are split across lines
  usb: core: config: remove unnecessary blank lines
  usb: core: config: add blank lines after struct def
  usb: core: config: fix inline spacign
  usb: core: config: fix checkpatch.pl braces warning
  usb: core: config: remove unnecessary parentheses
  usb: core: config: remove multiple assignments
  usb: core: config: fix parenthesis alignment

 drivers/usb/core/config.c | 393 ++++++++++++++++++++------------------
 1 file changed, 204 insertions(+), 189 deletions(-)

-- 
2.32.0

