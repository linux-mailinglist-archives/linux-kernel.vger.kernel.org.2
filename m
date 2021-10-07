Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785AB42575C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 18:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhJGQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 12:06:37 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:47690 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233060AbhJGQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 12:06:36 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BBBD818062A0E;
        Thu,  7 Oct 2021 16:04:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id BE3DC268E31;
        Thu,  7 Oct 2021 16:04:40 +0000 (UTC)
Message-ID: <9e8f251b42e405f460f26a23ba9b33ef45a94adc.camel@perches.com>
Subject: [PATCH] checkpatch: Improve EXPORT_SYMBOL test for EXPORT_SYMBOL_NS
 uses
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ian Pilcher <arequipeno@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Oct 2021 09:04:39 -0700
In-Reply-To: <d63da2a8-1624-21a8-f8ca-f7477c20e56b@gmail.com>
References: <d63da2a8-1624-21a8-f8ca-f7477c20e56b@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=4.33
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BE3DC268E31
X-Stat-Signature: m6hnjryndt4utiswzr8ygdmeagir194f
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19zynEo4NQerF8enbp3XV6Pr8L4gJ4c+pY=
X-HE-Tag: 1633622680-946455
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EXPORT_SYMBOL test expects a single argument but definitions of
EXPORT_SYMBOL_NS have multiple arguments.

Update the test to extract only the first argument from any
EXPORT_SYMBOL related definition.

Reported-by: Ian Pilcher <arequipeno@gmail.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88cb294dc4472..91798b07c6cb5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4449,6 +4449,7 @@ sub process {
 			#   XXX(foo);
 			#   EXPORT_SYMBOL(something_foo);
 			my $name = $1;
+			$name =~ s/^\s*($Ident).*/$1/;
 			if ($stat =~ /^(?:.\s*}\s*\n)?.([A-Z_]+)\s*\(\s*($Ident)/ &&
 			    $name =~ /^${Ident}_$2/) {
 #print "FOO C name<$name>\n";


