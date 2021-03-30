Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55934EA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhC3ONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhC3ONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:13:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4FAC0613D8;
        Tue, 30 Mar 2021 07:13:21 -0700 (PDT)
Received: from ip4d14bd53.dynamic.kabel-deutschland.de ([77.20.189.83] helo=truhe.fritz.box); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1lRF7H-0000jw-Jf; Tue, 30 Mar 2021 16:13:11 +0200
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Improve reporting-issues.rst and make it official
Date:   Tue, 30 Mar 2021 16:13:03 +0200
Message-Id: <cover.1617113469.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1617113602;38c5c4bd;
X-HE-SMSGID: 1lRF7H-0000jw-Jf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset makes reporting-issues.rst fully official and thus removes
reporting-bugs.rst. It also adds an entry for the text in MAINTAINERS as
discussed earlier. Then there is the new text for the TLDR already posted as a
draft and a patch which assorted fixes and small enhancements.

Thorsten Leemhuis (4):
  docs: make reporting-issues.rst official and delete reporting-bugs.rst
  MAINTAINERS: add entry for
    Documentation/admin-guide/reporting-issues.rst
  docs: reporting-issues.rst: reshuffle and improve TLDR
  docs: reporting-issues: reduce quoting and assorted fixes

 Documentation/admin-guide/index.rst           |   1 -
 Documentation/admin-guide/reporting-bugs.rst  | 187 ---------------
 .../admin-guide/reporting-issues.rst          | 218 ++++++++----------
 MAINTAINERS                                   |   6 +
 4 files changed, 96 insertions(+), 316 deletions(-)
 delete mode 100644 Documentation/admin-guide/reporting-bugs.rst


base-commit: 8d295fbad687a61eaa0cf14958c284a3ddbf2173
-- 
2.30.2

