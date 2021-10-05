Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E639F422C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 17:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhJEPTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 11:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhJEPTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 11:19:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE606115A;
        Tue,  5 Oct 2021 15:17:16 +0000 (UTC)
Date:   Tue, 5 Oct 2021 11:17:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211005111714.18ebea2b@gandalf.local.home>
In-Reply-To: <20211005053922.GA702049@embeddedor>
References: <20211005053922.GA702049@embeddedor>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 00:39:22 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> In order to make sure new function cast mismatches are not introduced
> in the kernel (to avoid tripping CFI checking), the kernel should be
> globally built with -Wcast-function-type.
> 
> So, fix the following -Wcast-function-type warnings on powerpc64
> (ppc64_defconfig):

I think I'll go back and add my linker magic.

  https://lore.kernel.org/all/20200617165616.52241bde@oasis.local.home/

I'll clean it up a bit too. I'll have a patch in a bit.

-- Steve
