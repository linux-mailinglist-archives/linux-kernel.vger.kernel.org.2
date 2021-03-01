Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6063281D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbhCAPIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbhCAPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:08:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28987C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 07:07:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lGk8j-00AJOK-1u; Mon, 01 Mar 2021 16:07:17 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-um@lists.infradead.org
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] PCI support for UML
Date:   Mon,  1 Mar 2021 16:07:00 +0100
Message-Id: <20210301150708.244970-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
 - fix a memory leak in the PCI code
 - fix race in interrupt handling
 - fix checks in interrupt handling
 - use asm-generic for fb.h and vga.h
 - rediff against v5.12-rc1
 - export signals_enabled directly


Original description:

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




