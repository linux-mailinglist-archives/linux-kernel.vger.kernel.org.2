Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B43412A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCSCK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhCSCKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616119848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WLSA2oiRltTqHjXk3IZppsXFkYoDFLNlB5L9UFw/oe0=;
        b=HRWbV7xjygpPmChwxykCdGPRvzDe/oHWgxyA7dzwwes+EU3iu48f/FgQzIEs/iXukxGSK1
        DPadze7QnlQoxHr1UkH8FD25M5/43C/z8mB/ofnnBlGH2AaD0rnagCuvkNa6KLNQ5Ux4VP
        pXrNInmyThrsIeudSlVap7JBoHtfWqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-7fZHs1J3OJWnTbwLibdBbA-1; Thu, 18 Mar 2021 22:10:44 -0400
X-MC-Unique: 7fZHs1J3OJWnTbwLibdBbA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18F57108BD15;
        Fri, 19 Mar 2021 02:10:43 +0000 (UTC)
Received: from treble (ovpn-113-46.rdu2.redhat.com [10.10.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB3625D9C6;
        Fri, 19 Mar 2021 02:10:41 +0000 (UTC)
Date:   Thu, 18 Mar 2021 21:10:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/14] objtool: Extract elf_strtab_concat()
Message-ID: <20210319021038.6mfpnbel67yhyapw@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.948282703@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318171919.948282703@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:11:12PM +0100, Peter Zijlstra wrote:
> Create a common helper to append strings to a strtab.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/elf.c |   73 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 31 deletions(-)
> 
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -676,13 +676,51 @@ struct elf *elf_open_read(const char *na
>  	return NULL;
>  }
>  
> +static int elf_strtab_concat(struct elf *elf, char *name, const char *strtab_name)
> +{
> +	struct section *strtab = NULL;
> +	Elf_Data *data;
> +	Elf_Scn *s;
> +	int len;
> +
> +	if (strtab_name)
> +		strtab = find_section_by_name(elf, strtab_name);
> +	if (!strtab)
> +		strtab = find_section_by_name(elf, ".strtab");
> +	if (!strtab) {
> +		WARN("can't find %s or .strtab section", strtab_name);
> +		return -1;
> +	}

This part's a bit mysterious (and it loses the Clang comment).  Maybe we
can leave the section finding logic in elf_create_section()?

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index b85db6efb9d3..db9ad54894d8 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -676,19 +676,17 @@ struct elf *elf_open_read(const char *name, int flags)
 	return NULL;
 }
 
-static int elf_strtab_concat(struct elf *elf, char *name, const char *strtab_name)
+static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 {
 	struct section *strtab = NULL;
 	Elf_Data *data;
 	Elf_Scn *s;
 	int len;
 
-	if (strtab_name)
-		strtab = find_section_by_name(elf, strtab_name);
 	if (!strtab)
 		strtab = find_section_by_name(elf, ".strtab");
 	if (!strtab) {
-		WARN("can't find %s or .strtab section", strtab_name);
+		WARN("can't find .strtab section");
 		return -1;
 	}
 
@@ -718,7 +716,7 @@ static int elf_strtab_concat(struct elf *elf, char *name, const char *strtab_nam
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   unsigned int sh_flags, size_t entsize, int nr)
 {
-	struct section *sec;
+	struct section *sec, *shstrtab;
 	size_t size = entsize * nr;
 	Elf_Scn *s;
 
@@ -777,7 +775,15 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	sec->sh.sh_addralign = 1;
 	sec->sh.sh_flags = SHF_ALLOC | sh_flags;
 
-	sec->sh.sh_name = elf_strtab_concat(elf, sec->name, ".shstrtab");
+	/* Add section name to .shstrtab (or .strtab for Clang) */
+	shstrtab = find_section_by_name(elf, ".shstrtab");
+	if (!shstrtab)
+		shstrtab = find_section_by_name(elf, ".strtab");
+	if (!shstrtab) {
+		WARN("can't find .shstrtab or .strtab section");
+		return NULL;
+	}
+	sec->sh.sh_name = elf_add_string(elf, sec->name, shstrtab);
 	if (sec->sh.sh_name == -1)
 		return NULL;
 

