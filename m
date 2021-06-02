Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A91B398BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFBOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhFBOLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:11:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C5C613D8;
        Wed,  2 Jun 2021 14:10:00 +0000 (UTC)
Date:   Wed, 2 Jun 2021 10:09:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Torsten Duwe <duwe@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.de>
Subject: Re: [RFC PATCH 1/6] trace/stack: Move code to save the stack trace
 into a separate function
Message-ID: <20210602100959.185264e3@oasis.local.home>
In-Reply-To: <1622626530.3j8u9fhp7h.naveen@linux.ibm.com>
References: <cover.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
        <6a8b68f8bd64f8c16d97ef943534c639781e7f77.1621577151.git.naveen.n.rao@linux.vnet.ibm.com>
        <20210601112824.29c5f168@oasis.local.home>
        <1622626530.3j8u9fhp7h.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Jun 2021 16:05:18 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> It seems to be working fine otherwise. The one limitation though is down 
> to how ftrace works on powerpc -- the mcount call is before a function 
> sets up its own stackframe. Due to this, we won't ever be able to 
> account for the stackframe from a leaf function -- but, that's a fairly 
> minor limitation.

And this is true for x86 as well because it no longer uses mcount, but
uses fentry instead (called before stack setup), but I figured there's
not much we could do about it.

-- Steve
