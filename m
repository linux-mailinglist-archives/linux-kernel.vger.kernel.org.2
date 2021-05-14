Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0343811C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhENUXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:23:42 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:46718 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229819AbhENUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:23:41 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id D18E318029127
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 20:22:28 +0000 (UTC)
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E3F25100E7B46;
        Fri, 14 May 2021 20:22:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 7E98D20A29F;
        Fri, 14 May 2021 20:22:26 +0000 (UTC)
Message-ID: <2c95dc4c4347b048abee283be90a9a2ae272ddbe.camel@perches.com>
Subject: Re: [PATCH 2/2] x86/e820: Use pr_debug to avoid spamming dmesg log
 with debug messages
From:   Joe Perches <joe@perches.com>
To:     Jason Baron <jbaron@akamai.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 14 May 2021 13:22:24 -0700
In-Reply-To: <e0116c3e-21a3-50a4-e9fd-cb227ef0b63b@akamai.com>
References: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
         <6d55670d-2f06-d768-699f-5a79cece6ce0@gmail.com>
         <d181b674-66fb-1719-e3c6-e4217cf5519c@akamai.com>
         <59985635-665b-773f-de8f-b15fe3f60196@gmail.com>
         <1789b1da-7a0f-9fc9-6ed2-ff68e2306342@akamai.com>
         <204a99e1-de7a-4434-0932-45f1b507e9ec@gmail.com>
         <5a416031-ddcd-7ef4-ec33-47134bf064bb@akamai.com>
         <7cc30a8a6644bb60e5f3358e89253d9fc783fe54.camel@perches.com>
         <e0116c3e-21a3-50a4-e9fd-cb227ef0b63b@akamai.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.90
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7E98D20A29F
X-Stat-Signature: nyuuzrfse7op545gcnddtf6dwk8zcj8p
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX198v5FY8IP2U8cGRMt7u4fROTj75Dg/gUo=
X-HE-Tag: 1621023746-893188
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-05-14 at 15:56 -0400, Jason Baron wrote:
> 
> On 5/14/21 1:38 PM, Joe Perches wrote:
> > On Tue, 2021-05-11 at 17:31 -0400, Jason Baron wrote:
> > 
> > > That said, I do see the value in not having to open code the branch stuff, and
> > > making pr_debug() consistent with printk which does return a value. So that
> > > makes sense to me.
> > 
> > IMO: printk should not return a value.
> > 
> 
> Ok, the issue we are trying to resolve is to control whether a 'pr_debug()' statement
> is enabled and thus use that to control subsequent output. The proposed patch does:
> 
> 
> +	printed = pr_debug("e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
> +	if (printed > 0) {
> +		e820_print_type(old_type);
> +		pr_cont(" ==> ");
> +		e820_print_type(new_type);
> +		pr_cont("\n");
> +	}
> 
> I do think pr_debug() here is different from printk() b/c it can be explicitly
> toggled.
> 
> I also suggested an alternative, which is possible with the current code which
> is to use DYNAMIC_DEBUG_BRANCH().
> 
> if (DYNAMIC_DEBUG_BRANCH(e820_debg)) {
>     printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
>     e820_print_type(old_type);
>     pr_cont(" ==> ");
>     e820_print_type(new_type);
>     pr_cont("\n");
> }
> 
> That however does require one to do something like this first:
> 
> DEFINE_DYNAMIC_DEBUG_METADATA(e820_dbg, "e820 verbose mode");
> 
> So I don't feel too strongly either way, but maybe others do?

Why not avoid the problem by using temporaries on the stack
and not use pr_cont altogether?
---
 arch/x86/kernel/e820.c | 71 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f0deed..a6e7ab4b522b 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -184,20 +184,38 @@ void __init e820__range_add(u64 start, u64 size, enum e820_type type)
 	__e820__range_add(e820_table, start, size, type);
 }
 
-static void __init e820_print_type(enum e820_type type)
+static char * __init e820_fmt_type(enum e820_type type, char *buf, size_t size)
 {
 	switch (type) {
-	case E820_TYPE_RAM:		/* Fall through: */
-	case E820_TYPE_RESERVED_KERN:	pr_cont("usable");			break;
-	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
-	case E820_TYPE_SOFT_RESERVED:	pr_cont("soft reserved");		break;
-	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
-	case E820_TYPE_NVS:		pr_cont("ACPI NVS");			break;
-	case E820_TYPE_UNUSABLE:	pr_cont("unusable");			break;
-	case E820_TYPE_PMEM:		/* Fall through: */
-	case E820_TYPE_PRAM:		pr_cont("persistent (type %u)", type);	break;
-	default:			pr_cont("type %u", type);		break;
+	case E820_TYPE_RAM:
+	case E820_TYPE_RESERVED_KERN:
+		strscpy(buf, "usable", size);
+		break;
+	case E820_TYPE_RESERVED:
+		strscpy(buf, "reserved", size);
+		break;
+	case E820_TYPE_SOFT_RESERVED:
+		strscpy(buf, "soft reserved", size);
+		break;
+	case E820_TYPE_ACPI:
+		strscpy(buf, "ACPI data", size);
+		break;
+	case E820_TYPE_NVS:
+		strscpy(buf, "ACPI NVS", size);
+		break;
+	case E820_TYPE_UNUSABLE:
+		strscpy(buf, "unusable", size);
+		break;
+	case E820_TYPE_PMEM:
+	case E820_TYPE_PRAM:
+		scnprintf(buf, size, "persistent (type %u)", type);
+		break;
+	default:
+		scnprintf(buf, size, "type %u", type);
+		break;
 	}
+
+	return buf;
 }
 
 void __init e820__print_table(char *who)
@@ -205,13 +223,14 @@ void __init e820__print_table(char *who)
 	int i;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
-		pr_info("%s: [mem %#018Lx-%#018Lx] ",
+		char type[32];
+
+		pr_info("%s: [mem %#018Lx-%#018Lx] %s\n",
 			who,
 			e820_table->entries[i].addr,
-			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
-
-		e820_print_type(e820_table->entries[i].type);
-		pr_cont("\n");
+			e820_table->entries[i].addr + e820_table->entries[i].size - 1,
+			e820_fmt_type(e820_table->entries[i].type,
+				      type, sizeof(type)));
 	}
 }
 
@@ -465,6 +484,8 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 	u64 end;
 	unsigned int i;
 	u64 real_updated_size = 0;
+	char type1[32];
+	char type2[32];
 
 	BUG_ON(old_type == new_type);
 
@@ -472,11 +493,10 @@ __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_ty
 		size = ULLONG_MAX - start;
 
 	end = start + size;
-	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
-	e820_print_type(old_type);
-	pr_cont(" ==> ");
-	e820_print_type(new_type);
-	pr_cont("\n");
+	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] %s ==> %s\n",
+	       start, end - 1,
+	       e820_fmt_type(old_type, type1, sizeof(type1)),
+	       e820_fmt_type(new_type, type2, sizeof(type2)));
 
 	for (i = 0; i < table->nr_entries; i++) {
 		struct e820_entry *entry = &table->entries[i];
@@ -543,15 +563,16 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool
 	int i;
 	u64 end;
 	u64 real_removed_size = 0;
+	char type[32];
 
 	if (size > (ULLONG_MAX - start))
 		size = ULLONG_MAX - start;
 
 	end = start + size;
-	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
-	if (check_type)
-		e820_print_type(old_type);
-	pr_cont("\n");
+	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx]%s%s\n",
+	       start, end - 1,
+	       check_type ? " " : "",
+	       check_type ? e820_fmt_type(old_type, type, sizeof(type)) : "");
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry = &e820_table->entries[i];


