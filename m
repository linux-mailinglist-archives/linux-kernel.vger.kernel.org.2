Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C837351B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhDASFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:05:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236575AbhDARpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A1E1AE5C;
        Thu,  1 Apr 2021 12:39:46 +0000 (UTC)
Date:   Thu, 1 Apr 2021 14:39:44 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Philipp Rudo <prudo@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: allmodconfig not working with dummy-tools
Message-ID: <20210401123944.GJ15381@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

running allmodconfig with dumy-tools I get:

which: no elfedit in (./scripts/dummy-tools)
scripts/dummy-tools/gcc: unknown assembler invoked
scripts/Kconfig.include:50: Sorry, this assembler is not supported.
scripts/kconfig/Makefile:77: recipe for target 'allmodconfig' failed
make[1]: *** [allmodconfig] Error 1
Makefile:648: recipe for target 'allmodconfig' failed
make: *** [allmodconfig] Error 2

I use allmodconfig to enable any unknown options on new kernel version
automaticallly so it can be build-tested.

Can this be fixed or is there some other way of automatically udating
the config after new options are added?

Thanks

Michal
