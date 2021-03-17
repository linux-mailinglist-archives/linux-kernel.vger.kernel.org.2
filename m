Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C53B33E7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCQDeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhCQDe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615952067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5zC+oGWngh+heRjmf/k2/BhOjPXjvepEEOmjNEFsZY=;
        b=RDn7VegTa9j906TrtfCrpjtHei13ZJfxFQvksys7TjSjEZ+1JJUWUpx3cGw5fUdANs4Jhz
        ZP83rOOJ2D7t1yzuKtxpwED+SDeHqqpVHxdlqttLjPFXimwmjwfLEeq6lyxi09ogySDWCt
        wsJ2yqZL6Buykb0FawfNzzDgjbBWs2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-qi0Z7cjlPk6_BtRkoP_bQQ-1; Tue, 16 Mar 2021 23:34:23 -0400
X-MC-Unique: qi0Z7cjlPk6_BtRkoP_bQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A07BD100C619;
        Wed, 17 Mar 2021 03:34:21 +0000 (UTC)
Received: from treble (ovpn-118-162.rdu2.redhat.com [10.10.118.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41FFB19706;
        Wed, 17 Mar 2021 03:34:20 +0000 (UTC)
Date:   Tue, 16 Mar 2021 22:34:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <20210317033417.lbwemc2j2cpsdlzd@treble>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.649709484@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312171653.649709484@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:16:18PM +0100, Peter Zijlstra wrote:
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -479,6 +479,8 @@ void elf_add_reloc(struct elf *elf, stru
>  
>  	list_add_tail(&reloc->list, &sec->reloc_list);
>  	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
> +
> +	sec->rereloc = true;
>  }

Can we just reuse sec->changed for this?  Something like this on top
(untested of course):

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index addcec88ac9f..b9cb74a54681 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -480,7 +480,7 @@ void elf_add_reloc(struct elf *elf, struct reloc *reloc)
 	list_add_tail(&reloc->list, &sec->reloc_list);
 	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
 
-	sec->rereloc = true;
+	sec->changed = true;
 }
 
 static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
@@ -882,9 +882,6 @@ int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
 	struct reloc *reloc;
 	int nr;
 
-	sec->changed = true;
-	elf->changed = true;
-
 	nr = 0;
 	list_for_each_entry(reloc, &sec->reloc_list, list)
 		nr++;
@@ -894,8 +891,6 @@ int elf_rebuild_reloc_section(struct elf *elf, struct section *sec)
 	case SHT_RELA: return elf_rebuild_rela_reloc_section(sec, nr);
 	default:       return -1;
 	}
-
-	sec->rereloc = false;
 }
 
 int elf_write_insn(struct elf *elf, struct section *sec,
@@ -950,14 +945,15 @@ int elf_write(struct elf *elf)
 	struct section *sec;
 	Elf_Scn *s;
 
-	list_for_each_entry(sec, &elf->sections, list) {
-		if (sec->reloc && sec->reloc->rereloc)
-			elf_rebuild_reloc_section(elf, sec->reloc);
-	}
-
-	/* Update section headers for changed sections: */
+	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->changed) {
+			if (sec->reloc &&
+			    elf_rebuild_reloc_section(elf, sec->reloc)) {
+				WARN_ELF("elf_rebuild_reloc_section");
+				return -1;
+			}
+
 			s = elf_getscn(elf->elf, sec->idx);
 			if (!s) {
 				WARN_ELF("elf_getscn");
@@ -969,6 +965,7 @@ int elf_write(struct elf *elf)
 			}
 
 			sec->changed = false;
+			elf->changed = true;
 		}
 	}
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 9fdd4c5f9f32..e6890cc70a25 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	char *name;
 	int idx;
 	unsigned int len;
-	bool changed, text, rodata, noinstr, rereloc;
+	bool changed, text, rodata, noinstr;
 };
 
 struct symbol {

