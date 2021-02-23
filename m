Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D65D322D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhBWP17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhBWP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:27:56 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F79C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:27:13 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lEZah-007R3T-G1; Tue, 23 Feb 2021 16:27:11 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 0/7] PCI support for UML
Date:   Tue, 23 Feb 2021 16:27:00 +0100
Message-Id: <20210223152707.408995-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In order to simulate some devices and write tests completely
independent of real PCI devices, we continued the development
of time-travel and related bits, and are adding PCI support
here now.

The way it works is that it communicates with the outside (of
UML) with virtio, which we previously added using vhost-user,
and then offers a PCI bus to the inside system, where normal
PCI probing etc. happens, but all config space & IO accesses
are forwarded over virtio.

To enable that, add lib/logic_iomem, similar to logic_pio but
for iomem regions, this way, ioread/iowrite can be redirected
over the virtio device.

Since currently no official virtio device ID is assigned yet
a Kconfig option for that is required to be set to the value
you want to use locally for experimentation. Once we have an
official value we can change the default (currently -1 which
makes it non-functional) or remove the option entirely.

johannes


