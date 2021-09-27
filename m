Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D60419563
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhI0Nvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234585AbhI0Nvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90A0360F41;
        Mon, 27 Sep 2021 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750595;
        bh=8xhgJ1VxubUEF7re8obYZLRRe6xW79b6UPbCJOr+N1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKg2Mvhj9NnmZarL2zGE5MA1ZOlXsHiNjUH272XMBQVCvWYLzwELRuI0VUqmFZ9lL
         HHWHz43SkGgz9LtVQKjYsQ/MgRBglqjzUBEX5QYnSl/hwHmS0YhLcILh5SH2YTPY6p
         QngucrUwQskbHIRALJanBUjlOH9Q/v/kuwmpMliYOpTlxid42oj99c/gWsmgcChWog
         QYZw+0iZ1yf2L3WAesvTm7IXa/PqHBA3JMRQo0fp5jdQJM9efl/L7VbD45yUmnR3/G
         g4D5+AoUyKKyGq0SyyUpfkZIGD1pppAc5ELIkRsXWHrd+SvjqRfnsW+eVvMP0HNap3
         YKYbCjqSnK0eg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUr0z-000Ajc-M8; Mon, 27 Sep 2021 15:49:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] scripts: get_abi.pl: update its documentation
Date:   Mon, 27 Sep 2021 15:49:51 +0200
Message-Id: <89fcd301e065ed86dfd8670725144b196266b6a4.1632750315.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750315.git.mchehab+huawei@kernel.org>
References: <cover.1632750315.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current highlight schema is not working properly. So, use,
instead, Pod::Text.

While here, also update the copyright in order to reflect the latest
changes and the e-mail I'm currently using.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1632750315.git.mchehab+huawei@kernel.org/

 scripts/get_abi.pl | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index d14f5cfc3138..4978163f5b16 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -1,10 +1,12 @@
 #!/usr/bin/env perl
 # SPDX-License-Identifier: GPL-2.0
 
+BEGIN { $Pod::Usage::Formatter = 'Pod::Text::Termcap'; }
+
 use strict;
 use warnings;
 use utf8;
-use Pod::Usage;
+use Pod::Usage qw(pod2usage);
 use Getopt::Long;
 use File::Find;
 use Fcntl ':mode';
@@ -47,7 +49,7 @@ GetOptions(
 ) or pod2usage(2);
 
 pod2usage(1) if $help;
-pod2usage(-exitstatus => 0, -verbose => 2) if $man;
+pod2usage(-exitstatus => 0, -noperldoc, -verbose => 2) if $man;
 
 pod2usage(2) if (scalar @ARGV < 1 || @ARGV > 2);
 
@@ -923,18 +925,18 @@ B<abi_book.pl> [--debug <level>] [--enable-lineno] [--man] [--help]
 	       [--search-string <regex>]
 	       <COMAND> [<ARGUMENT>]
 
-Where <COMMAND> can be:
+Where B<COMMAND> can be:
 
 =over 8
 
-B<search> [SEARCH_REGEX] - search for [SEARCH_REGEX] inside ABI
+B<search> I<SEARCH_REGEX> - search for I<SEARCH_REGEX> inside ABI
 
-B<rest>                  - output the ABI in ReST markup language
+B<rest>                   - output the ABI in ReST markup language
 
-B<validate>              - validate the ABI contents
+B<validate>               - validate the ABI contents
 
-B<undefined>             - existing symbols at the system that aren't
-                           defined at Documentation/ABI
+B<undefined>              - existing symbols at the system that aren't
+                            defined at Documentation/ABI
 
 =back
 
@@ -950,9 +952,9 @@ the Documentation/ABI directory.
 =item B<--rst-source> and B<--no-rst-source>
 
 The input file may be using ReST syntax or not. Those two options allow
-selecting between a rst-compliant source ABI (--rst-source), or a
+selecting between a rst-compliant source ABI (B<--rst-source>), or a
 plain text that may be violating ReST spec, so it requres some escaping
-logic (--no-rst-source).
+logic (B<--no-rst-source>).
 
 =item B<--enable-lineno>
 
@@ -972,7 +974,7 @@ following bitmask:
 Show hints about possible definitions for the missing ABI symbols.
 Used only when B<undefined>.
 
-=item B<--search-string> [regex string]
+=item B<--search-string> I<regex string>
 
 Show only occurences that match a search string.
 Used only when B<undefined>.
@@ -1021,11 +1023,11 @@ $ scripts/get_abi.pl rest --dir Documentation/ABI/obsolete
 
 =head1 BUGS
 
-Report bugs to Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
+Report bugs to Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 
 =head1 COPYRIGHT
 
-Copyright (c) 2016-2019 by Mauro Carvalho Chehab <mchehab+samsung@kernel.org>.
+Copyright (c) 2016-2021 by Mauro Carvalho Chehab <mchehab+huawei@kernel.org>.
 
 License GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
 
-- 
2.31.1

