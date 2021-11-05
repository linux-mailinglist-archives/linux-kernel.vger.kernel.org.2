Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58030445EF3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 05:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhKEEDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 00:03:45 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:49970 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKEEDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 00:03:35 -0400
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 1A5403LP022540;
        Fri, 5 Nov 2021 13:00:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1A5403LP022540
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636084804;
        bh=eq5hBBdaM7UNcAEEa7Bvx0DF2SRlULhuC7+Am1EA3c4=;
        h=From:To:Cc:Subject:Date:From;
        b=1XcU1+5pwNp2I87j6BAv9s2UMKXbESMyveAhZS2eRXpzb9vlNttGDEJTcnyPhwleN
         uTSWJOa4sBglTifhC76f/1WBgs6hV/wsnujMhJ/dOWbmjLhplQUqlU8eVVUvPQLjI0
         WBDtj5bPXZz1jQAR9hZv4iTIwVOEyN+RxA0uPZzd48ZIkd5LUpsilgE02ojHBTbmAT
         kUkR1NuAcVtMz95VNKzIAIQ5uCnHbugy4aTkC2lgqkxVEFBWchq8Dj4wGiSLYinAYw
         yHVuacH8RE7GzjAl+2C41wB/eQbDeE21BqSLFZVPy9i01HwgG67D3rgJaDzwT8UqX2
         qmwJZDvE7phEQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] certs: various cleanups of certs/Makefile
Date:   Fri,  5 Nov 2021 12:59:53 +0900
Message-Id: <20211105035959.93748-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Masahiro Yamada (5):
  certs: remove meaningless $(error ...) in certs/Makefile
  certs: check-in the default x509 config file
  certs: remove noisy messages while generating the signing key
  certs: use 'cmd' to hide openssl output in silent builds more simply
  certs: use if_changed to re-generate the key when the key type is
    changed

 certs/Makefile            | 74 ++++++++-------------------------------
 certs/default_x509.genkey | 17 +++++++++
 2 files changed, 32 insertions(+), 59 deletions(-)
 create mode 100644 certs/default_x509.genkey

-- 
2.30.2

