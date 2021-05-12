Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA537EB9C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381497AbhELTea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:34:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237443AbhELRnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:43:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CHYKJ3036638;
        Wed, 12 May 2021 13:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=D1yJlDEa4euXoT6cb8Ui+ulrjWTPbiStUFiXvqRQaCo=;
 b=A48cGfhXsdi+mGyJky2Fmt2NZ8iRo6OvpcQzIh2WQ47VXUw5CXcLfa4BOf9tgHGu/fcN
 w68KzLeQcxyJdjElKg85boUISLpCWG+nk8D/lOgfyVOXMZN0/3htAodryx2F6H2O94+Q
 VZepW69T0UVcdLToUTB0TrNVAHIgugPGzTRkSqca2HRC7xsSf9gM01uOMm2MI4aokh32
 KVjjtsP7r9FxeZ7bgS4Mg1FJsjdFVXJWmLl5JesIwcqB9GswmOUEalcwVf+rKsnH0N0m
 /Ho7XqMZ0fta5ImRSmYvpBGRa/9Ufmcqhpn0l3wuqGjXtFSqTb2g1OZkPmfeEkz3aItD Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ghs4uj9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 13:42:17 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14CHYYMx037385;
        Wed, 12 May 2021 13:42:16 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38ghs4uj8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 13:42:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14CHg5lr026675;
        Wed, 12 May 2021 17:42:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj98aba5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 17:42:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14CHgCg021496272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 May 2021 17:42:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C555AE051;
        Wed, 12 May 2021 17:42:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37E88AE04D;
        Wed, 12 May 2021 17:42:12 +0000 (GMT)
Received: from localhost (unknown [9.171.5.155])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 12 May 2021 17:42:12 +0000 (GMT)
Date:   Wed, 12 May 2021 19:42:10 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] objtool: Fix elf_create_undef_symbol() endianness
Message-ID: <patch-1.thread-6c9df9.git-d39264656387.your-ad-here.call-01620841104-ext-2554@work.hours>
References: <cover.thread-6c9df9.your-ad-here.call-01620841104-ext-2554@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-6c9df9.your-ad-here.call-01620841104-ext-2554@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y6r07Hd9Y_AnhLiny4hZwDA2szX9hhwT
X-Proofpoint-ORIG-GUID: q1vZ5ZOlPV_nHxioTzvXPQPKyxld_wrs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_09:2021-05-12,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105120114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently x86 cross-compilation fails on big endian system with:

x86_64-cross-ld: init/main.o: invalid string offset 488112128 >= 6229
for section `.strtab'

Mark new ELF data in elf_create_undef_symbol() as symbol, so that libelf
does endianness handling correctly.

Fixes: 2f2f7e47f052 ("objtool: Add elf_create_undef_symbol()")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 tools/objtool/elf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index a8a0ee21f71a..4d0d4d7a9aba 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -791,6 +791,7 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	data->d_buf = &sym->sym;
 	data->d_size = sizeof(sym->sym);
 	data->d_align = 1;
+	data->d_type = ELF_T_SYM;
 
 	sym->idx = symtab->len / sizeof(sym->sym);
 
-- 
2.25.4

