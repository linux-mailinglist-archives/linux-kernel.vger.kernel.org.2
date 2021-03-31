Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E02734F5D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhCaBKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:37 -0400
Received: from ozlabs.org ([203.11.71.1]:41039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233069AbhCaBKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XQ0j7hz9shx; Wed, 31 Mar 2021 12:10:14 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <955248c6423cb068c5965923121ba31d4dd2fdde.1615881400.git.christophe.leroy@csgroup.eu>
References: <955248c6423cb068c5965923121ba31d4dd2fdde.1615881400.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/4] powerpc: Activate HAVE_RELIABLE_STACKTRACE for all
Message-Id: <161715297988.226945.14373125287629011053.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 07:57:13 +0000 (UTC), Christophe Leroy wrote:
> CONFIG_HAVE_RELIABLE_STACKTRACE is applicable to all, no
> reason to limit it to book3s/64le

Applied to powerpc/next.

[1/4] powerpc: Activate HAVE_RELIABLE_STACKTRACE for all
      https://git.kernel.org/powerpc/c/accdd093f260bc8c8a8f580ee48e49ad5c5f91b2
[2/4] powerpc: Rename 'tsk' parameter into 'task'
      https://git.kernel.org/powerpc/c/826a307b0a11e605b4be0b2727550b510c4a88cd
[3/4] powerpc: Convert stacktrace to generic ARCH_STACKWALK
      https://git.kernel.org/powerpc/c/a1cdef04f22dd5ad9e1ccf5d05a549c697b7f52d
[4/4] powerpc: Fix arch_stack_walk() to have running function as first entry
      https://git.kernel.org/powerpc/c/a2308836880bf1501ff9373c611dc2970247d42b

cheers
