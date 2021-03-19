Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB1334215B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhCSP46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhCSP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:56:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B54C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VKPo1fLcPx3giwMwYsg8eU9wtHSfn1ayAI0GpBBxSiQ=; b=mlhvcZeNeF4fbDmatYukWf48gr
        dA5eDxZIZXmdG8S2wLU5dbWjvuDIB7Te8+iAJjCTKshJryRPAx5q4l19BciPI6IOVc2mdT5aXSsZV
        jaY7kRNJfbM28LsP4WkZRV7Hakea7d2UEGyJzGXjPYnfhW8Sy3TcwR/t7jqeUnN9we6tD1putmVrd
        48RtOY4AJPtJ6QpHAuzdIzWWuZ61sDg/3eDPZbrRoQS7jfu1xbEqGCm3zH5T6kO+IF6RAG/yJAc3I
        3s7NUbPCaykMRfgjT6B/L+Gglf1BS/j/G8DlEBKuH78QVhR4nOhXq6OGhvwiCQG1iCqjIbe/MLLHg
        t8KXKHDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNHUE-007exK-S9; Fri, 19 Mar 2021 15:56:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48E3C3006E0;
        Fri, 19 Mar 2021 16:56:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 300132B7D6280; Fri, 19 Mar 2021 16:56:30 +0100 (CET)
Date:   Fri, 19 Mar 2021 16:56:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <YFTJro42GX6m7O5Q@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.253147364@infradead.org>
 <20210319032955.zdx6ihhprem5owbc@treble>
 <YFRblERAnQu2KtZG@hirez.programming.kicks-ass.net>
 <20210319153026.cfqwyy36feqyunyd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319153026.cfqwyy36feqyunyd@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:30:26AM -0500, Josh Poimboeuf wrote:
> On Fri, Mar 19, 2021 at 09:06:44AM +0100, Peter Zijlstra wrote:
> > > Also doesn't the alternative code already insert nops?
> > 
> > Problem is that the {call,jmp} *%\reg thing is not fixed length. They're
> > 2 or 3 bytes depending on which register is picked.
> 
> Why do they need to be fixed length?  Objtool can use sym->len as the
> alternative replacement length.  Then alternatives can add nops as
> needed.

UNDEF has size 0. That is, unless these symbols exist in the translation
unit (they do not) we have no clue.

Arguably I could parse the symbol name again and then we know the
register number and thus if we need REX etc.. but I figured we wanted to
avoid all that.
