Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A98359DC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhDILro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDILrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:47:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E533AC061761;
        Fri,  9 Apr 2021 04:47:28 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lUpbg-0005de-PL; Fri, 09 Apr 2021 13:47:24 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Mention regression mailing list in reporting-bugs and MAINTAINERS
Date:   Fri,  9 Apr 2021 13:47:22 +0200
Message-Id: <cover.1617967127.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617968849;7011f6d2;
X-HE-SMSGID: 1lUpbg-0005de-PL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! A mailing list for regressions was finally created as
regressions@lists.linux.dev (we dropped the linux- prefix as the term is already
in the domain name). Hence, add it to MAINTAINERS, as that where people will
look it up. I was a bit unsure how to actually do that, see the note in the
first patch of the series for details.

The second patch makes reporting-issues.rst mention the new list, so people CC
it.

@Jonathan: this hopefully is the last round of patches for reporting-issues.rst
for this cycle. Please let me known if you think the addition to the MAINTAINERS
file should better go through a different maintainer.

Ciao, Thorsten

Thorsten Leemhuis (2):
  MAINTAINERS: add regressions mailing list
  docs: reporting-issues: make everyone CC the regressions list

 .../admin-guide/reporting-issues.rst          | 55 ++++++++++++-------
 MAINTAINERS                                   |  5 ++
 2 files changed, 40 insertions(+), 20 deletions(-)


base-commit: dfc7927d4ee008c69c5b60f9076e2ad8980589bc
-- 
2.30.2

