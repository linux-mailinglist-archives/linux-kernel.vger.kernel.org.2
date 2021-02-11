Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792BF3191D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBKSGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhBKRlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:41:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6FC061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=O1hKRFl7JRzVg3X3vgAmupRW1p0EOzrDmdBZS6uhk+U=; b=vniGDmQq/twvAY63rvj7BhiWNR
        vaSh28N2HeJknC+CPz0GEkMDPYvQlWt/cn8L62bULzCYlUnjdYN6ELUikHmw0QN/uOxYiBQ0HLcgF
        KhmoIsyLRLoAybCp4okt9rVE78sg0j1BL2H8XKrSyJrbswfk2nZ0W9j4/nhzc2BREu7sgjSYcjNdH
        ogyA4C5hpxbWnHDlnFikaaVNgkuXrbH/S+QpCR+HiMVXVHkx3SmvJh3L+IN7hg0xah/NQR7595pH6
        WuVHGICT+xFRWdTT89qBIuu0jQiWv4Gd+MK71yGweT8E0b7INTAK89lw8bH05cSOyyRUp2SExOHRa
        7jAzWKHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lAFxO-0005bv-6f; Thu, 11 Feb 2021 17:40:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 048E83019CE;
        Thu, 11 Feb 2021 18:40:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E704E2BC34261; Thu, 11 Feb 2021 18:40:44 +0100 (CET)
Message-ID: <20210211173044.141215027@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 11 Feb 2021 18:30:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH v2 0/7] objtool x86 decoder fixes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since I had to look at instruction decoding for the stack swizzle thing, I
ended up with a few more changes to the objtool x86 decoder.

These patches are lightly tested (they build defconfig and allmodconfig using
GCC10), but older versions have seen some robot exposure and other compilers.

v2:
 - actually Cc'ed LKML :/

