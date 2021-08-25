Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32ED3F72C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhHYKRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhHYKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:17:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FDCC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8esBFMYRDJG8lDObO1/iroH8cfYYicO9IJLIJ+OC+X0=; b=Oa/pwfnkNC3Ogb+DhuoCWUSWRs
        I2fPqPEGGuzhjquO/8MPyU187N8gDJlC0N2cttfe6qaBOFYD6MPbvIY7LOkHmwiPN24U5xPYzIYXT
        2klKCNp80N42YuzLFsJVFPnyl59enNizn5quzwDyRyccOpOjCB3m5M2mXIMdwDMYrZn0dRN3IoRrM
        Je00SKf7+oCrmcLP3pYkrLEwj7PNeHKHyT12CJ8gCWbnzTQTLQrwUdMZCJdwiUWbweL74kAYj8koo
        UiQFUGkp4edtUkjNYvxyqCN0nFdFHD3IFqsqU9sIbS1/xH09+WEUvxLXIeWSn8O8O36SuoKndf2Qm
        rR1/YYHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIpuk-00CBYO-ET; Wed, 25 Aug 2021 10:13:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13D1030067B;
        Wed, 25 Aug 2021 12:13:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7956200E4A2F; Wed, 25 Aug 2021 12:13:43 +0200 (CEST)
Date:   Wed, 25 Aug 2021 12:13:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2 02/24] objtool: Introduce CFI hash
Message-ID: <YSYX18wjVceB2iPJ@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.756759107@infradead.org>
 <20210820222755.sqtlzframoz7k5cb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820222755.sqtlzframoz7k5cb@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 03:27:55PM -0700, Josh Poimboeuf wrote:
> > +static struct cfi_state *cfi_alloc(void)
> > +{
> > +	struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
> > +	if (!cfi) {
> > +		WARN("calloc failed");
> > +		exit(1);
> > +	}
> > +	nr_cfi++;
> > +	init_cfi_state(cfi);
> > +	return cfi;
> > +}
> 
> I'm thinking this should also add it to the hash.  i.e. I don't think
> there's a scenario where you'd alloc a cfi and not want to add it to the
> hash.  The more sharing the better.

Right, changed it like below.

> > +
> > +struct cfi_state *insn_get_cfi(struct instruction *insn)
> > +{
> > +	if (!insn->cfip)
> > +		insn->cfip = cfi_alloc();
> > +
> > +	return insn->cfip;
> > +}
> 
> Call it something like insn_get_or_alloc_cfi()?
> 
> Also, the function can be static.

It's gone now.

> > +static struct cfi_state *cfi_hash_find(struct cfi_state *cfi)
> > +{
> > +	struct hlist_head *head = &cfi_hash[hash_min(cfi_key(cfi), cfi_bits)];
> > +	struct cfi_state *obj;
> > +
> > +	hlist_for_each_entry(obj, head, hash) {
> > +		if (!cficmp(cfi, obj)) {
> > +			nr_cfi_cache++;
> > +			return obj;
> > +		}
> > +	}
> > +
> > +	obj = cfi_alloc();
> > +	*obj = *cfi;
> > +	hlist_add_head(&obj->hash, head);
> > +
> > +	return obj;
> 
> cfi_hash_find_or_alloc_cfi()?


Made that cfi_hash_find_or_add()

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -30,6 +30,7 @@ struct alternative {
 static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
 
 static struct cfi_init_state initial_func_cfi;
+static struct cfi_state init_cfi;
 static struct cfi_state func_cfi;
 
 struct instruction *find_insn(struct objtool_file *file,
@@ -278,7 +279,6 @@ static struct cfi_state *cfi_alloc(void)
 		exit(1);
 	}
 	nr_cfi++;
-	init_cfi_state(cfi);
 	return cfi;
 }
 
@@ -298,7 +298,7 @@ static inline u32 cfi_key(struct cfi_sta
 		     sizeof(*cfi) - sizeof(cfi->hash), 0);
 }
 
-static struct cfi_state *cfi_hash_find(struct cfi_state *cfi)
+static struct cfi_state *cfi_hash_find_or_add(struct cfi_state *cfi)
 {
 	struct hlist_head *head = &cfi_hash[hash_min(cfi_key(cfi), cfi_bits)];
 	struct cfi_state *obj;
@@ -1620,10 +1620,10 @@ static void set_func_state(struct cfi_st
 
 static int read_unwind_hints(struct objtool_file *file)
 {
+	struct cfi_state cfi = init_cfi;
 	struct section *sec, *relocsec;
 	struct unwind_hint *hint;
 	struct instruction *insn;
-	struct cfi_state *cfi;
 	struct reloc *reloc;
 	int i;
 
@@ -1666,9 +1666,8 @@ static int read_unwind_hints(struct objt
 			continue;
 		}
 
-		cfi = insn->cfip;
-		if (!cfi)
-			cfi = insn->cfip = cfi_alloc();
+		if (insn->cfip)
+			cfi = *(insn->cfip);
 
 		if (arch_decode_hint_reg(insn, hint->sp_reg)) {
 			WARN_FUNC("unsupported unwind_hint sp base reg %d",
@@ -1679,6 +1678,8 @@ static int read_unwind_hints(struct objt
 		cfi->cfa.offset = bswap_if_needed(hint->sp_offset);
 		cfi->type = hint->type;
 		cfi->end = hint->end;
+
+		insn->cfip = cfi_hash_find_or_add(&cfi);
 	}
 
 	return 0;
@@ -2831,7 +2832,7 @@ static int validate_branch(struct objtoo
 				insn->cfip = prev_insn->cfip;
 				nr_cfi_reused++;
 			} else {
-				insn->cfip = cfi_hash_find(&state.cfi);
+				insn->cfip = cfi_hash_find_or_add(&state.cfi);
 			}
 		}
 
@@ -3239,6 +3240,7 @@ int check(struct objtool_file *file)
 	int ret, warnings = 0;
 
 	arch_initial_func_cfi_state(&initial_func_cfi);
+	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
 	set_func_state(&func_cfi);
 
@@ -3250,6 +3252,7 @@ int check(struct objtool_file *file)
 	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
 		goto out;
 
+	cfi_hash_add(&init_cfi);
 	cfi_hash_add(&func_cfi);
 
 	if (list_empty(&file->insn_list))
