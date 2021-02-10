Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC1316AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhBJQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231596AbhBJQLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612973391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6g/UXwsgQ6n8ZDaR7ahu9IxbKKfJzpqPpGEhX7RWx1I=;
        b=ISmI3E/+Drv0v6xYkGXdLDt84b0vIzyTYjojsFd5ss9p5nb2DHPce7UBMl99Gtq56EW70F
        vE+BrGJqcV4aPZBPN4SDN9EZgh7ZFrL0lqvZpcpNpLwtoqySn4me0hEFhWiXdj6N6tWdeh
        rbc8vH1Xazs4DzntuG7Na1pK0DxKvzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-hj0Sm7ddN6Op0r5mp1kjxA-1; Wed, 10 Feb 2021 11:09:50 -0500
X-MC-Unique: hj0Sm7ddN6Op0r5mp1kjxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E9D4107ACE4;
        Wed, 10 Feb 2021 16:09:48 +0000 (UTC)
Received: from treble (ovpn-120-169.rdu2.redhat.com [10.10.120.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76D8260C0F;
        Wed, 10 Feb 2021 16:09:47 +0000 (UTC)
Date:   Wed, 10 Feb 2021 10:09:45 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        yu-cheng.yu@intel.com
Subject: Re: [RFC][PATCH] objtool: WARN about ENDBR instructions
Message-ID: <20210210160945.73n5zhlfcii5t637@treble>
References: <YCOb2byLJhLOjhrL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCOb2byLJhLOjhrL@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:39:53AM +0100, Peter Zijlstra wrote:
> 
> 
> Given all the ENDBR fun we recently had, do we want the below? Until
> someone comes and fixes up kprobes/ftrace/livepatch etc.. having them is
> a giant pain and we'd better warn about it.

Meh...

Is there a point in doing this, now that we killed it with
-fcf-protection=none?

That said, the patch is nicely small and localized.

-- 
Josh

