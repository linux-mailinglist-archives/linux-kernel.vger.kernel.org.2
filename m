Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0B9400E62
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 08:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhIEFwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 01:52:10 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:41606 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231835AbhIEFwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 01:52:07 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3B95F18029120;
        Sun,  5 Sep 2021 05:51:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 4C9211124F6;
        Sun,  5 Sep 2021 05:51:02 +0000 (UTC)
Message-ID: <bef77537a67749df31fc7cb5549744ff7b76f6de.camel@perches.com>
Subject: Re: False positive EXPORT_SYMBOL warning with NS variants
From:   Joe Perches <joe@perches.com>
To:     Ian Pilcher <arequipeno@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sat, 04 Sep 2021 22:51:01 -0700
In-Reply-To: <d63da2a8-1624-21a8-f8ca-f7477c20e56b@gmail.com>
References: <d63da2a8-1624-21a8-f8ca-f7477c20e56b@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6z4p4ncebhtatfckqumese6s5hzf9wgh
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 4C9211124F6
X-Spam-Status: No, score=6.61
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+/UJs1hLVSao1Xv6OwxuW4dmpYsesQkxk=
X-HE-Tag: 1630821062-600752
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-03 at 11:01 -0500, Ian Pilcher wrote:
> $ cat foo.c
> // SPDX-License-Identifier: GPL-2.0-only
> void (*foo)(void);
> EXPORT_SYMBOL_NS(foo, FOO);
> 
> $ scripts/checkpatch.pl -f foo.c
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #3: FILE: foo.c:3:
> +EXPORT_SYMBOL_NS(foo, FOO);
> 
> The non-NS EXPORT_SYMBOL variants don't trigger this warning.
> 

Try this:
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

