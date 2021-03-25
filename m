Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A145B34988E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCYRqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhCYRqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:46:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61159619DC;
        Thu, 25 Mar 2021 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616694379;
        bh=NqcaxGQNN3y04oxah4IgioEU5ngdI0w2S2E0zJ8cgNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oFk3i/J39hQr5+zrlxG9dlrr3edZxLzG4glenAyeBHcdshcLcmHYy8ujy8E52lCyX
         24X0K1OTwHZknX/dqlSoPMkXazFXEH81A/SPbOttp2xw95tP6HexYV9HWpxhKqdRr+
         +WvVrRIvuUUA7zFHBFNEsmxS8dtTWvQJISYpDc9NCAgxeoyRiod5f8XmcT/wVFerko
         tYaMgd/4bZJvUrhA57tjLrL1W/uuvdD+ARzfZClEkVFehuz2M3P6i8FayoXo6Vo7+Z
         OwZJCy0tIQNz0ffSgllOCHg+fXsYf/FGpWjDVstVtHczM/WPWEitmAkDs9GlIvzxAN
         XAHexXDLJ8dQA==
Date:   Thu, 25 Mar 2021 18:46:15 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 6/8] of: Fix kerneldoc output formatting
Message-ID: <20210325184615.08526aed@coco.lan>
In-Reply-To: <20210325164713.1296407-7-robh@kernel.org>
References: <20210325164713.1296407-1-robh@kernel.org>
        <20210325164713.1296407-7-robh@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Mar 2021 10:47:11 -0600
Rob Herring <robh@kernel.org> escreveu:

> The indentation of the kerneldoc comments affects the output formatting.
> Leading tabs in particular don't work, and sections need to be indented
> under the section header.
> 
> The example snippets for DT source in the comments still have some
> formatting issues, but there doesn't seem to be any way to do multi-line
> literal blocks in kerneldoc.
> 
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> 
> Note the dts examples still cause warnings. I couldn't find any way to 
> do a literal block and fix them. Minimally, there needs to be a way to 
> escape ':' and not create sections:
> 
> Documentation/devicetree/kernel-api:11: ../drivers/of/base.c:1466: WARNING: Definition list ends without a blank line; unexpected unindent.

You can do something like this:

/**
 * of_parse_phandle_with_args() - Find a node pointed by phandle in a list
 * @np:		pointer to a device tree node containing a list
 * @list_name:	property name that contains a list
 * @cells_name:	property name that specifies phandles' arguments count
 * @index:	index of a phandle to parse out
 * @out_args:	optional pointer to output arguments structure (will be filled)
 *
 * This function is useful to parse lists of phandles and their arguments.
 * Returns 0 on success and fills out_args, on error returns appropriate
 * errno value.
 *
 * Caller is responsible to call of_node_put() on the returned out_args->np
 * pointer.
 *
 * For example::
 *
 *	phandle1: node1 {
 *		#list-cells = <2>;
 *	};
 *
 *	phandle2: node2 {
 *		#list-cells = <1>;
 *	};
 *
 *	node3 {
 *		list = <&phandle1 1 2 &phandle2 3>;
 *	};
 *
 * To get a device_node of the ``node2`` node you may call this:
 * of_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
 */


The problem is that using just:

/**
 ...
 * Example::
 ...

Would make confusion with an existing regex at kernel-doc script that
parses a regex similar to this:

	\*\s+(\w+):

Into:
	**$1**

So, using two words fix the issue.

Granted, this is something that could be improved at kernel-doc with
something like (untested):

<snip>
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index cb92d0e1e932..cea82e004fce 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -392,7 +392,7 @@ my $doc_com_body = '\s*\* ?';
 my $doc_decl = $doc_com . '(\w+)';
 # @params and a strictly limited set of supported section names
 my $doc_sect = $doc_com .
-    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:(.*)';
+    '\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:]*)$';
 my $doc_content = $doc_com_body . '(.*)';
 my $doc_block = $doc_com . 'DOC:\s*(.*)?';
 my $doc_inline_start = '^\s*/\*\*\s*$';
</snip>

I'll run some tests if the above works and submit a separate patch
addressing it, likely tomorrow.

Thanks,
Mauro
