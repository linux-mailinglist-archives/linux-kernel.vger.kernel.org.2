Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E843F805F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 04:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhHZCUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 22:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235677AbhHZCUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 22:20:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84E92601FE;
        Thu, 26 Aug 2021 02:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629944364;
        bh=xOADAxsafKh08ynoLGlWX9hW7/cYaZagi+PU2WUNpMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=AnU9MqhXn+EduAnPMTLBgQw423RRaECkjSHvKa8OS62oDlZj0icc8+zK52Bpu3qcJ
         51N34aqYHwJ8l5ElN7VAmmRsmdIFKo8BV5RED7GfFoFBXHVPRXawBhlCwjItOjaCVe
         dYsBaoX1n7jrzi7WfggISaE5ckbuFfYADKDGEziP943Wgm8ito2VuU5IQ8K/41nt2V
         wFuLfkJ52Cryp7XppHO4w5qDA+yTVHuSUb65hQj/5x9F5sPPoI1mHbdZwVV//EV+Nk
         MU5bnxn86OWt29uQlcw4K/q+6ZH0GxIJk85Q5O3Wq+E25tGWsi5l/0d6dp8PqnOQvB
         LtluMpHJXeV/w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: [PATCH] checkpatch: Do not warn __initconst for const char *.
Date:   Thu, 26 Aug 2021 11:19:21 +0900
Message-Id: <162994436171.204899.977391959489238226.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl warns if an '__initdata' variable has 'const'
attribute to use __initconst, but it doesn't check that attribute
affects the type of a pointer or the variable. Thus it reports an
false error if 'const char *' variable is '__initdata'. e.g.

ERROR: Use of const init definition must use __initconst
#32: FILE: lib/bootconfig.c:32:
+static const char *xbc_err_msg __initdata;

To fix this issue, this ensures that the 'const' does not
follows any type string and a pointer ('*') too.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 scripts/checkpatch.pl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 461d4221e4a4..c04213a7b633 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6330,7 +6330,7 @@ sub process {
 		}
 
 # check for $InitAttributeData (ie: __initdata) with const
-		if ($line =~ /\bconst\b/ && $line =~ /($InitAttributeData)/) {
+		if ($line =~ /\bconst\b/ && $line !~ /\bconst\b[^\*\(]+\*/ && $line =~ /($InitAttributeData)/) {
 			my $attr = $1;
 			$attr =~ /($InitAttributePrefix)(.*)/;
 			my $attr_prefix = $1;

