Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160154469AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhKEUbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhKEUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:31:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253DC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SBUlw2ZrXdlIU2jyUk3frE2xH8Y80m9s1WmI2QsIwFw=; b=lTa0FqqaWIUOZLnpwuCgqhYLz+
        hmHusQoAY2iuIDdcOTwfJS928274AnfjYs4kecPm6q6WP+5gCuBeYqnFWr4hdiuFKvhuCVxcLn9IG
        6WdFROFoPVimiqRxLXsnW+ReSVJFHVs6/+8HAClUdBRhySkibG6a9Ppqmdg6foDBoIkwFzgoBMzWL
        sVTmzSLvfu6DCH3l++bios2fwSiP2OARz9LHz8ZwTCgTd5SM7+oynrVTqSy0osE6PETmIngUmaY46
        fGgpJe+1IoeIVCf6OODKm3aSCDuwmdEI07yTd/GlUo34hRnmtLQw784FVIu750iJRBu/JAHDJZpxy
        2FJjltdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj5mr-006o2p-H7; Fri, 05 Nov 2021 20:26:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C3FE9862D2; Fri,  5 Nov 2021 21:26:08 +0100 (CET)
Date:   Fri, 5 Nov 2021 21:26:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <20211105202608.GI174730@worktop.programming.kicks-ass.net>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
 <YYVqnr+gql9RpL4C@google.com>
 <20211105184556.GN174703@worktop.programming.kicks-ass.net>
 <YYWDQO3ugarMcKmH@google.com>
 <20211105193229.GP174703@worktop.programming.kicks-ass.net>
 <YYWKSmHkgdMA2euh@google.com>
 <20211105201557.GQ174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105201557.GQ174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 09:15:57PM +0100, Peter Zijlstra wrote:

> That's really unfortunate that is... 6.4.4.1 item 5 of the C99 spec
> covers this gem :-( I suppose I'll go stick that (int) cast in the
> EX_IMM_MASK definition or something.

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -2,10 +2,15 @@
 #ifndef _ASM_X86_EXTABLE_FIXUP_TYPES_H
 #define _ASM_X86_EXTABLE_FIXUP_TYPES_H
 
+/*
+ * Our IMM is signed, as such it must live at the top end of the word. Also,
+ * since C99 hex constants are of ambigious type, force cast the mask to 'int'
+ * so that FIELD_GET() will DTRT and sign extend the value when it extracts it.
+ */
 #define EX_DATA_TYPE_MASK		0x000000FF
 #define EX_DATA_REG_MASK		0x00000F00
 #define EX_DATA_FLAG_MASK		0x0000F000
-#define EX_DATA_IMM_MASK		0xFFFF0000
+#define EX_DATA_IMM_MASK		((int)0xFFFF0000)
 
 #define EX_DATA_REG_SHIFT		8
 #define EX_DATA_FLAG_SHIFT		12

