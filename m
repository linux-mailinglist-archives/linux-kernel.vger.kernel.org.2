Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF73BA941
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGCPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 11:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhGCPhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 11:37:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38FEE6191A;
        Sat,  3 Jul 2021 15:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625326513;
        bh=btGSEvmjT5RSA0+cEdxiKOWCCVHgdEkOppfJ2GhWhFs=;
        h=From:To:Cc:Subject:Date:From;
        b=H6BtUlDb+2fnWllM38lznikdehqETscc3XhFUTeAqJvcWAmV32V4VXUgThi3pBrQj
         /5FOIFPCLqyKRRio7IawZLIrziGCd26tEc6tk/ANFSbwQH91e4vjJcCeuIJz/AYdIN
         +s2vTPrqNA9dRIDO2glfMwcd7CGLsJH9/kRBseOQie6EzD6PdujW1OWBk7+JrHCLtm
         J0x+SyH7JAdw3NmsK4l/hX8egH3ppirmKslfRLHQeDVZbfrYtCFMsP9zB4RxD6tx4P
         RGwKZ3prgkDJFy8JA7Vr+CRKtYynHiMBmbrt3p74uzhA7IB7QkBAZUuXLC7uzXa9oz
         IAlDM4Jk0m0Vg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf: Fix perf probe for Fedora34 glibc update
Date:   Sun,  4 Jul 2021 00:35:10 +0900
Message-Id: <162532651032.393143.4602033845482295575.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Here is a series of patches to fix the perf-probe error against the
Fedora34 glibc update, which moves most of symbols from .symtab to
.dynsym. The key is that the "most of" symbols moved, but it still
have some PLT symbols in .symtab. Thus the perf symbol-elf failes to
decode symbols.

Here is the original report from Thomas about this issue.

 https://lore.kernel.org/linux-perf-users/f6752514-eaf9-371e-f81b-0d9e41ebae0c@linux.ibm.com/

Thank you,

---

Masami Hiramatsu (3):
      perf-probe: Fix debuginfo__new() to enable build-id based debuginfo
      perf symbol-elf: Decode dynsym even if symtab exists
      perf probe: Do not show @plt function by default


 tools/perf/builtin-probe.c     |    2 -
 tools/perf/util/probe-finder.c |    5 ++
 tools/perf/util/symbol-elf.c   |   82 ++++++++++++++++++++++++++--------------
 3 files changed, 60 insertions(+), 29 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
