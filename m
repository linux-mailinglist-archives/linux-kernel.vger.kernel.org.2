Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04562332D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhCIRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:25:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:44454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhCIRZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:25:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1219AEC4;
        Tue,  9 Mar 2021 17:25:03 +0000 (UTC)
Date:   Tue, 9 Mar 2021 18:25:02 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Philipp Rudo <prudo@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Michal Kubecek <mkubecek@suse.cz>
Subject: dummy-tools regression on Linux 5.12
Message-ID: <20210309172502.GA6564@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on 5.11 I can update the config with dummy-tools but in 5.12 it no longer
works:

make ARCH=powerpc CROSS_COMPILE=scripts/dummy-tools/ oldconfig
scripts/dummy-tools/gcc: unknown compiler
scripts/Kconfig.include:44: Sorry, this compiler is not supported.
make[1]: *** [scripts/kconfig/Makefile:63: oldconfig] Error 1
make: *** [Makefile:605: oldconfig] Error 2

I think the new copiler version checks in 5.12-rc1 don't work with dummy
tools.

Any idea which side should be adjusted?

Thanks

Michal
