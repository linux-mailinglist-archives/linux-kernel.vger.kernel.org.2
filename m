Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D6843C04C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbhJ0Cxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238940AbhJ0Cxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:53:31 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB61C061243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:51:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C33C841EA7;
        Wed, 27 Oct 2021 02:50:58 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC MAINTAINERS updates for 5.16
To:     SoC Team <soc@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <748d5e4d-9ea6-cf50-cce4-7a7e9267c76b@marcan.st>
Date:   Wed, 27 Oct 2021 11:50:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SoC folks,

Please merge these Apple SoC MAINTAINERS changes for 5.16.

I expect one merge conflict when this goes upstream, as the PCIe binding
MAINTAINERS change went in via the DT tree (a3b539fedc0 in dt/next), but
hopefully nothing else.

-Hector

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

   https://github.com/AsahiLinux/linux.git tags/asahi-soc-maintainers-5.16

for you to fetch changes up to 4c929eb8eab498de3a9a706e892da45998fa8aa2:

   MAINTAINERS: add pinctrl-apple-gpio to ARM/APPLE MACHINE (2021-10-25 18:55:47 +0900)

----------------------------------------------------------------
Apple SoC MAINTAINERS updates 5.16.

This includes entries for new drivers/bindings that have been already
merged into subsystem trees (sans these updates). It is also based on
the 5.15 fixes pull with general maintainer updates.

----------------------------------------------------------------
Alyssa Rosenzweig (1):
       MAINTAINERS: Add Alyssa Rosenzweig as M1 reviewer

Joey Gouly (1):
       MAINTAINERS: add pinctrl-apple-gpio to ARM/APPLE MACHINE

Sven Peter (2):
       MAINTAINERS: Add Sven Peter as ARM/APPLE MACHINE maintainer
       MAINTAINERS: Add pasemi i2c to ARM/APPLE MACHINE

  MAINTAINERS | 7 +++++++
  1 file changed, 7 insertions(+)

