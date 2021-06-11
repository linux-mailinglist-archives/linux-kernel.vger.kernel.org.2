Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8833A3B41
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 07:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFKFPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 01:15:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhFKFPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 01:15:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F7D061278;
        Fri, 11 Jun 2021 05:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623388418;
        bh=D7kbfOKjdwzuKWAz5+BSU+ECXesDYujCITFPLtqleKE=;
        h=From:To:Cc:Subject:Date:From;
        b=Uxo6Qsok9ufnYuo4Go1LtJ0NK/i8mrifH4UVA+AEcjQCc5ypFHe9eWcXzKwTarHbv
         KqVXQb3LIMvne51GEXjjnRGYHoxtexgMX3VHAyvzdYYHwh3ssppUIcGptt72AAbvZz
         +m8OfIx6wwkB/A++dtA2JEPy0grBZZJKZG5JBCA2EXe18l54tp9A6cuNH2yMIw5OUX
         FKcpaRrBAdpXiitCbMYCMpRPK8kreO1GdPJIKDnhvcM8zamPvItz2obRmo/lEuXuAE
         ucC5lmgztYR8yC48ZBiJWRN86VgbYJvCsCijB66igcFGvv8IMpXL4PXdpcuQEoMKUL
         4w1vP/d0QCZGw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/2] x86/fpu: Clean up "dynamic" APIs
Date:   Thu, 10 Jun 2021 22:13:35 -0700
Message-Id: <cover.1623388344.git.luto@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Dynamic" XSTATEs are not dynamic.  They are just managed separately from
the normal struct fpu states.  Rename the functions and make their interfaces
sane.

Andy Lutomirski (2):
  x86/fpu: Rename "dynamic" XSTATEs to "independent"
  x86/fpu: Improve FPU APIs for independent features

 arch/x86/events/intel/lbr.c       |  6 +--
 arch/x86/include/asm/fpu/xstate.h | 19 +++++----
 arch/x86/kernel/fpu/core.c        |  3 ++
 arch/x86/kernel/fpu/xstate.c      | 67 +++++++++++++------------------
 4 files changed, 46 insertions(+), 49 deletions(-)

-- 
2.31.1

