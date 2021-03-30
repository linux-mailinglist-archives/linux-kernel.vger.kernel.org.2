Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A579234F13A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhC3Ssq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:48:46 -0400
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:39256 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232901AbhC3Ssi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:48:38 -0400
Received: from omf18.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1A328181D337B;
        Tue, 30 Mar 2021 18:48:37 +0000 (UTC)
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA id 0B1202EBFA0;
        Tue, 30 Mar 2021 18:48:35 +0000 (UTC)
Message-ID: <aa1819fa5faf786573df298e5e2e7d357ba7d4ad.camel@perches.com>
Subject: [PATCH] checkpatch: Warn when missing newline in return
 sysfs_emit() formats
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Mar 2021 11:48:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.10
X-Stat-Signature: gtk9ypfu7oa15o3ox1on1zkwumj79y3y
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0B1202EBFA0
X-HE-Tag: 1617130115-666885
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return sysfs_emit() uses should include a newline.

Suggest adding a newline when one is missing.
Add one using --fix too.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d67146d0b33c..4dbda85fd7e5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7198,6 +7198,17 @@ sub process {
 			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
 		}
 
+# return sysfs_emit(foo, fmt, ...) fmt without newline
+		if ($line =~ /\breturn\s+sysfs_emit\s*\(\s*$FuncArg\s*,\s*($String)/ &&
+		    substr($rawline, $-[6], $+[6] - $-[6]) !~ /\\n"$/) {
+			my $offset = $+[6] - 1;
+			if (WARN("SYSFS_EMIT",
+				 "return sysfs_emit(...) formats should include a terminating newline\n" . $herecurr) &&
+			    $fix) {
+				substr($fixed[$fixlinenr], $offset, 0) = '\\n';
+			}
+		}
+
 # nested likely/unlikely calls
 		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 			WARN("LIKELY_MISUSE",

