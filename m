Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB36038FBD3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhEYHfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhEYHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:35:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6948C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4zoxU5b1QV6QiUvFvnDKve3Vz+8+npvl/t6DvzE8QCs=; b=WshCUQJztw84n+ha/CGhoWt8hT
        6zs3f9EFu2enwzRMsPNPQNqxatXjROMLLxhN1YcXqlkQd63gPDtN6aby77/amstjza6qEVoIWo8db
        EoUuPwHo30xy2LP1Lh2nD/XouwZ7Mn3/dfyM2dfjLOOkD6ypqvXITMXoav3miwAb0cQtTorEe88+y
        Ze/9IfrMqxFWHnbJe6MnuqivvwVGSxicPfsxYj1SPzX17OYfvBaMNSFOuhjPlS9j56pMi1BuT+alA
        6hsSsdC0D1QX84tt2j5BfLxhF1oVtr8tf3rgaXGMD0q2RHQq3Kq+Lwv+ARv7iaeIo4oYXkJiSoHQK
        AS85E/9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llRYg-003Eis-Hz; Tue, 25 May 2021 07:33:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E6F93001E4;
        Tue, 25 May 2021 09:32:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D15AB30A65B78; Tue, 25 May 2021 09:32:57 +0200 (CEST)
Message-ID: <20210525072518.791889911@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 25 May 2021 09:25:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, rostedt@goodmis.org,
        naveen.n.rao@linux.vnet.ibm.com, ananth@linux.ibm.com,
        x86@kernel.org
Subject: [PATCH 0/2] kprobes: Remove kprobe::fault_handler
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason for kprobe::fault_handler(), as given by their comment:

* We come here because instructions in the pre/post
* handler caused the page_fault, this could happen
* if handler tries to access user space by
* copy_from_user(), get_user() etc. Let the
* user-specified handler try to fix it first.

Is just plain bad. Those other handlers are ran from non-preemptible
context and had better use _nofault() functions. Also, there is no
upstream usage of this.

The corollary of this change is that no tracing/probing/whatever can consume
faults.

