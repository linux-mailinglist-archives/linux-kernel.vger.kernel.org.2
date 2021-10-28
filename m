Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0473343F1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJ1Vds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhJ1Vdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:33:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA49C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=H5IO9MGvtmKmJRUsf7JcVSqcKtbZa9XWblmqEvfM/Os=; b=IsCfHon50xMjPlzGLogaxr1g4K
        SuONHbiHUbCS+xooa2pqrt/ffnflT1wxxy3e7N1OogWeMblGl/50ptECXirU/ueAT99Wbju6V1fs6
        +n4rMQeWKQyq/WNSfw1tDl30pP+dEMlbitKhfpo/xLcwczoVnAGwNNob9cDWpVtCgGdEXpDiHLQ1O
        s17mCs5WyObbukJSjrGIdcQewHNRaVT+EkYmXkF1Yek/hjjI6qMBRVhsOngpvrQI8JtEZBV7x3kYY
        QWPXhyUpNwjzKYn4DeRyMIVc5ky6o2Zc8qWP/xMidgI4z1rhNXZchN0nkbLdzCaDCVMaLtRc9Se6M
        fNq5gpvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgCzD-00CtkN-PP; Thu, 28 Oct 2021 21:31:00 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 749CC981FD5; Thu, 28 Oct 2021 23:30:58 +0200 (CEST)
Date:   Thu, 28 Oct 2021 23:30:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, hjl.tools@gmail.com
Subject: Re: [RFC][PATCH] x86: Add straight-line-speculation mitigation
Message-ID: <20211028213058.GQ174703@worktop.programming.kicks-ass.net>
References: <YXqNAJI3NJz3SQue@hirez.programming.kicks-ass.net>
 <8ad13850-10fc-f8a2-c35b-4afe847b7f4e@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ad13850-10fc-f8a2-c35b-4afe847b7f4e@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 09:06:30PM +0100, Andrew Cooper wrote:
> It would be remiss of me not to say...  In Xen, I've currently gone with:
> 
> #ifdef CONFIG_SPECULATIVE_HARDEN_STRAIGHT_LINE
> # define ret  ret;  int3
> # define retq retq; int3

#define retq ret

Surely :-)

> #endif
> 
> 
> which avoids needing to patch any asm files, and therefore is a far less
> invasive patch.

All the asm stuff was more or less:

find arch/x86/ -name \*.s | while read file;
do
	sed -i $file -e 's/\<retq?\>/RET/'
done

or thereabout. The pesky bits were the inline asm and realizing that
RETPOLINE_SAFE also means we really don't care about SLS.

> I know those defines probably deserve a WTF, and will confuse anyone who
> doesn't understand the phrase "painting blue", but they have the
> advantage that casual contributions don't need to remember to avoid
> naked `ret` instructions to maintain safety, making it a rather more
> robust option.

objtool while whinge if someone forgets
