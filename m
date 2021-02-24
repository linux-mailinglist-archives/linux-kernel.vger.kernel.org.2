Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F28323BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 13:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhBXMDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 07:03:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:37682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232564AbhBXMDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 07:03:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC942ADDD;
        Wed, 24 Feb 2021 12:02:56 +0000 (UTC)
Date:   Wed, 24 Feb 2021 13:02:56 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] x86/unwind/orc: Handle missing ORC data better
In-Reply-To: <cover.1612534649.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2102241259510.10904@pobox.suse.cz>
References: <cover.1612534649.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021, Josh Poimboeuf wrote:

> A couple of patches for improving the ORC unwinder's handling of missing
> ORC data.
> 
> Josh Poimboeuf (2):
>   x86/unwind/orc: Disable KASAN checking in the ORC unwinder, part 2
>   x86/unwind/orc: Silence warnings caused by missing ORC data
> 
>  arch/x86/kernel/unwind_orc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

I apologize for a really late reply. It seems it has not been merged yet, 
so

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
