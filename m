Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA2F438F34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhJYGRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhJYGRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:17:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 189A260F4F;
        Mon, 25 Oct 2021 06:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635142478;
        bh=jSisEyhfeg/5wcIAb8s9R0DgLgmYgk3ggud9rZ4RHyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DOQq8Zm9N2gskgxgO2gYID4qAG3MjDWeE0VnA6QLF1Dczbt6SxuG8+8q33y7JlCr1
         CVKCHc3ycbTrnYO1IktntndVFWTqQNjHPMC6EgLc/a183q4Dk6+XOzGLMgPfpXAWR1
         RAeU+qmb+4jV29Gqbc1EcrjeWSXhC1wmRztV+hTlQ3ORo6VwKVN740kewLh4cSTC9B
         3e8vSpDeJF2sRFCERmpKxY1MeR2U7iTHPn2GDZdo+W9e3jTFq7i9MyntL1Mz2Py1R8
         mCRHC0zJyeHTiYmBpCZoL8yonEpRX/IMH9Nu3/XdVgC3waQ19pwfh2Dam+kQYyz2Fl
         u9RdAAgqdlwQw==
Date:   Mon, 25 Oct 2021 15:14:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, corbet@lwn.net, ananth@in.ibm.com,
        akpm@linux-foundation.org, randy.dunlap@oracle.com,
        mathieu.desnoyers@polymtl.ca, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Do some changes about kprobe
Message-Id: <20211025151435.cac8737a4b5ca3cd4c7a3363@kernel.org>
In-Reply-To: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
References: <1635132660-5038-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

On Mon, 25 Oct 2021 11:30:56 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> This patchset is based on kprobes kernel tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/ for-next

Sorry for confusion, that is not the kernel branch for kprobes. Currently
the kprobes is maintained under the Steve's tracing tree.

Anyway, some of your patch should be merged. Let me pick it.

Thank you,

> 
> Tiezhu Yang (4):
>   samples/kretprobes: Fix return value if register_kretprobe() failed
>   docs, kprobes: Remove invalid URL and add new reference
>   test_kprobes: Move it from kernel/ to lib/
>   MAINTAINERS: Add git tree and missing files for KPROBES
> 
>  Documentation/trace/kprobes.rst     | 2 +-
>  MAINTAINERS                         | 3 +++
>  kernel/Makefile                     | 1 -
>  lib/Makefile                        | 1 +
>  {kernel => lib}/test_kprobes.c      | 0
>  samples/kprobes/kretprobe_example.c | 2 +-
>  6 files changed, 6 insertions(+), 3 deletions(-)
>  rename {kernel => lib}/test_kprobes.c (100%)
> 
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
