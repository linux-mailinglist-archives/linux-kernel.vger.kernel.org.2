Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC3443C9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 14:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbhJ0Mcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 08:32:47 -0400
Received: from marcansoft.com ([212.63.210.85]:36800 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232724AbhJ0Mcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 08:32:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8EEF3419BC;
        Wed, 27 Oct 2021 12:30:18 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     SoC Team <soc@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Apple SoC MAINTAINERS updates for 5.16 (v2)
Message-ID: <f62bfa4a-3cc8-c568-be78-c5fd6919bc74@marcan.st>
Date:   Wed, 27 Oct 2021 21:30:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SoC folks,

Second try at the Apple SoC MAINTAINERS changes for 5.16. Sorry for the
s-o-b snafu...

-Hector

The following changes since commit 56dd05023675a35541e9baeba868bd0472eb97f9:

   MAINTAINERS: Add Sven Peter as ARM/APPLE MACHINE maintainer (2021-10-08 01:16:48 +0900)

are available in the Git repository at:

   https://github.com/AsahiLinux/linux.git tags/asahi-soc-maintainers-5.16-v2

for you to fetch changes up to e081c53a5ba10041d3512f51d0e3975ac514c532:

   MAINTAINERS: add pinctrl-apple-gpio to ARM/APPLE MACHINE (2021-10-27 21:23:56 +0900)

----------------------------------------------------------------
Apple SoC MAINTAINERS updates 5.16.

This includes entries for new drivers/bindings that have been already
merged into subsystem trees (sans these updates). It is also based on
the 5.15 fixes pull with general maintainer updates.

----------------------------------------------------------------
Joey Gouly (1):
       MAINTAINERS: add pinctrl-apple-gpio to ARM/APPLE MACHINE

Sven Peter (1):
       MAINTAINERS: Add pasemi i2c to ARM/APPLE MACHINE

  MAINTAINERS | 4 ++++
  1 file changed, 4 insertions(+)

