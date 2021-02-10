Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9187A315E90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 06:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBJFGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 00:06:42 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6533 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhBJFGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 00:06:35 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602369b20000>; Tue, 09 Feb 2021 21:05:54 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 05:05:50 +0000
Received: from ubuntu.vdiclient.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Feb 2021 05:05:48 +0000
From:   Timur Tabi <ttabi@nvidia.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        <akpm@linux-foundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        <roman.fietze@magna.com>, "Kees Cook" <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        <akinobu.mita@gmail.com>, <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [PATCH 0/3] add support for never printing hashed addresses
Date:   Tue, 9 Feb 2021 23:05:26 -0600
Message-ID: <20210210050529.843005-1-ttabi@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612933554; bh=k1iewYdm5iqO8SkKejAIunDnl9bWSYGT0UoXEWqFvkU=;
        h=From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=IS0WMBy/DkdVeUznUsjqkWpjpe2dr7Jtppf0GS2Mgw995/CPK/Kr4xhzTVmRn2p7w
         HmPDabG9ML21XbEhGzR/vHIzlPhMg8aCh6B55OFh5heWOneqnyvAowwo0IvlnGGPu9
         ++udcBAOqBvsiKKusrw66FHdK+z5UuokqxxxBhxPA2SnXZU0j+1/48zqDBmDcmxRw1
         URq6H+JaJrCk1uZEasxmflRIyxocJtU0r+d/DgxR0Zle+JIpGa8lmMB/6qsmvcZ9eC
         2Ieizh7LOBN0sHv5NNwOGYj2NlXWGnJK92C+1mgGRGLAn2lj3Xfnbbl6s85vWWuICd
         HcvbG3/sLAo8Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[The list of email addresses on CC: is getting quite lengthy,
so I hope I've included everyone.]

Although hashing addresses printed via printk does make the
kernel more secure, it interferes with debugging, especially
with some functions like print_hex_dump() which always uses
hashed addresses.

To avoid having to choose between %p and %px, it's easier to
add a kernel command line that treats all %p as %px.  This
encourages developers to use %p more without making debugging
more difficult.

Patches #1 and #2 upgrade the kselftest framework so that
it can report on tests that were skipped outright.  This
is needed for the test_printf module which will now skip
%p hashing tests if hashing is disabled.

Patch #2 upgrades the printf library to check the command
line.  It also updates test_printf().

Timur Tabi (3):
  lib/test_printf: use KSTM_MODULE_GLOBALS macro
  kselftest: add support for skipped tests
  [v2] lib/vsprintf: make-printk-non-secret printks all addresses as
    unhashed

 .../admin-guide/kernel-parameters.txt         | 15 +++++++
 lib/test_printf.c                             | 12 +++++-
 lib/vsprintf.c                                | 40 ++++++++++++++++++-
 tools/testing/selftests/kselftest_module.h    | 18 ++++++---
 4 files changed, 75 insertions(+), 10 deletions(-)

--=20
2.25.1

