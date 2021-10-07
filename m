Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3616342581E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbhJGQkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:40:23 -0400
Received: from marcansoft.com ([212.63.210.85]:37102 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241523AbhJGQkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:40:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A848E419BC;
        Thu,  7 Oct 2021 16:38:24 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC fixes for 5.15
To:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <a50a9015-0e62-c451-4d0d-668233b35b85@marcan.st>
Date:   Fri, 8 Oct 2021 01:38:21 +0900
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

Please merge these Apple SoC fixes for 5.15.

-Hector

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

   https://github.com/AsahiLinux/linux.git tags/asahi-soc-fixes-5.15

for you to fetch changes up to 56dd05023675a35541e9baeba868bd0472eb97f9:

   MAINTAINERS: Add Sven Peter as ARM/APPLE MACHINE maintainer (2021-10-08 01:16:48 +0900)

----------------------------------------------------------------
Apple SoC fixes for 5.15; just two MAINTAINERS updates.

- MAINTAINERS: Add Sven Peter as ARM/APPLE MACHINE maintainer
- MAINTAINERS: Add Alyssa Rosenzweig as M1 reviewer

----------------------------------------------------------------
Alyssa Rosenzweig (1):
       MAINTAINERS: Add Alyssa Rosenzweig as M1 reviewer

Sven Peter (1):
       MAINTAINERS: Add Sven Peter as ARM/APPLE MACHINE maintainer

  MAINTAINERS | 3 +++
  1 file changed, 3 insertions(+)

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
