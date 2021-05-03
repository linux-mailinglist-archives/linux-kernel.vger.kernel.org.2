Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F67371E91
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhECR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231329AbhECR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620062899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRmPKljHOMCwd0tyaLod6YKOuTWkIHWORuPcdrXcO88=;
        b=PEyigUY+BBo7ntcs54YcHRCD75rutMDMaiNkMqxSsylmBO1023VT3/dNB6XdH0jvLQzc0/
        r31FogcEfjGZIEU6gCJ6Eu1Gc4YzXg9Mz7BQgMeFKq6m9sVM4RzFBhTBxA6hdQWmbJJGOM
        hohfUfOnCyBC//5nTREA9XpcJCJjFok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-OAr0HUYBOQ-xPqQO8qWd-A-1; Mon, 03 May 2021 13:28:17 -0400
X-MC-Unique: OAr0HUYBOQ-xPqQO8qWd-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F274D107ACF2;
        Mon,  3 May 2021 17:28:15 +0000 (UTC)
Received: from treble (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4868C5C1D0;
        Mon,  3 May 2021 17:28:15 +0000 (UTC)
Date:   Mon, 3 May 2021 12:28:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vanessa Hack <vanessa.hack@fau.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Jonas Rabenstein <rabenstein@cs.fau.de>
Subject: Re: [PATCH] objtool: include symbol value in check for contiguous
 objects
Message-ID: <20210503172814.suquyqr737ogn4ef@treble>
References: <20210428210408.4546-1-vanessa.hack@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210428210408.4546-1-vanessa.hack@fau.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:04:08PM +0200, Vanessa Hack wrote:
> While trying to adopt objtool's ability to generate ORC data for the use
> in our research project, we came across a problem with the detection of
> function pointers of contiguous objects introduced by commit fd35c88b7417
> ("objtool: Support GCC 8 switch tables"). Only the section and the
> addend/offset of the relocation/function are compared without the actual
> value of the involved symbols - false positives might be reported if the
> referenced symbols are different, but are in the same section. By adding
> (the value of) the referenced symbol as part of the comparison, those
> false positives are no longer reported.
> 
> Co-developed-by: Jonas Rabenstein <rabenstein@cs.fau.de>
> Signed-off-by: Jonas Rabenstein <rabenstein@cs.fau.de>
> Signed-off-by: Vanessa Hack <vanessa.hack@fau.de>
> ---
>  tools/objtool/check.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 1f4154f9b04b..4456f3278bb8 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1320,6 +1320,8 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  	 * instruction.
>  	 */
>  	list_for_each_entry_from(reloc, &table->sec->reloc_list, list) {
> +		unsigned int pfunc_offset;
> +		unsigned int reloc_offset;
>  
>  		/* Check for the end of the table: */
>  		if (reloc != table && reloc->jump_table_start)
> @@ -1330,8 +1332,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
>  			break;
>  
>  		/* Detect function pointers from contiguous objects: */
> +		pfunc_offset = pfunc->sym.st_value + pfunc->offset;
> +		reloc_offset = reloc->sym->sym.st_value + reloc->addend;
>  		if (reloc->sym->sec == pfunc->sec &&
> -		    reloc->addend == pfunc->offset)
> +		    pfunc_offset == reloc_offset)
>  			break;

Hi Vanessa & Jonas,

Thanks for the patch!

I'm a little confused about the issue -- do you have an example listing
of .rodata relocations (e.g. from 'readelf -aW') which confused objtool?

I believe add_jump_table() -- in addition to all the other jump table
code -- assumes that reloc->sym is a section symbol (STT_SECTION),
rather than a function symbol (STT_FUNC).  Was it an STT_FUNC symbol
which caused the problem?

Also I'm not quite convinced this patch is the right fix.  For the
'pfunc_offset' calculation, I believe 'pfunc->sym.st_value' is the same
value as 'pfunc->offset' -- they both represent the function's section
offset.  So it's basically adding pfunc->offset to itself, right?  Is
that intentional?

Any chance this patch fixes your issue?  If not, the above readelf would
help me understand it more.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5e5388a38e2a..4f30a763a4e3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1344,6 +1344,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (prev_offset && reloc->offset != prev_offset + 8)
 			break;
 
+		/* Jump table relocs are always STT_SECTION: */
+		if (reloc->sym->type != STT_SECTION)
+			break;
+
 		/* Detect function pointers from contiguous objects: */
 		if (reloc->sym->sec == pfunc->sec &&
 		    reloc->addend == pfunc->offset)

