Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE04348A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCYHsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhCYHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:48:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340BFC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=duaBMLbyWpWakK+L0rw3VWpqillSBc+LSq9CrnLyyZ0=; b=hJ590nr8fcO505oxO+EhXDiDhM
        U3OanJgwH08mZYvmLtOv4FDs7JXm3oiATYaDkfaGHjjC5lx6acLRyJQZRd6M9acWVn+a8eHe/RI5h
        2bLfSb+TI4KQDZGprJc4JNNjDpb93dU8OqJrzrm8cnNAVa06fS90HeKwiA6OwAd6yWS7G35X3/gAZ
        HcdfRho5u+qnXAMyw3KFRsT4RR8jFfNjpipIasWACZ8ihJw29zZz8N8Fv6Uk6qi35ZnBvKSbNJSKm
        ulpOWTYdDplF12igFJR+K8YpNISPuSwbpq4HZ5hu4uTay0KSq7COWm0cvdSm9Ko1nA8/yMo6Lt/wS
        I/i9U/SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPKir-000oiH-Op; Thu, 25 Mar 2021 07:48:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1A2BE301A7A;
        Thu, 25 Mar 2021 08:48:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 014432C67B295; Thu, 25 Mar 2021 08:48:04 +0100 (CET)
Date:   Thu, 25 Mar 2021 08:48:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched: stop using magic values in sched_dynamic_mode
Message-ID: <YFxANIu5GYwaahcN@hirez.programming.kicks-ass.net>
References: <20210325004515.531631-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325004515.531631-1-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 01:45:14AM +0100, Rasmus Villemoes wrote:
> Use the enum names which are also what is used in the switch() in
> sched_dynamic_update().
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Thanks for both!
