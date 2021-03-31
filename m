Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5834F5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhCaBLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43167 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233288AbhCaBKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:40 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xt31GHz9t17; Wed, 31 Mar 2021 12:10:33 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     naveen.n.rao@linux.ibm.com, oleg@redhat.com,
        linuxppc-dev@lists.ozlabs.org, sandipan@linux.ibm.com,
        jniethe5@gmail.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, paulus@samba.org
In-Reply-To: <20210311091538.368590-1-ravi.bangoria@linux.ibm.com>
References: <20210311091538.368590-1-ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v5] powerpc/uprobes: Validation for prefixed instruction
Message-Id: <161715297002.226945.13446780395285368488.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:30 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 14:45:38 +0530, Ravi Bangoria wrote:
> As per ISA 3.1, prefixed instruction should not cross 64-byte
> boundary. So don't allow Uprobe on such prefixed instruction.
> 
> There are two ways probed instruction is changed in mapped pages.
> First, when Uprobe is activated, it searches for all the relevant
> pages and replace instruction in them. In this case, if that probe
> is on the 64-byte unaligned prefixed instruction, error out
> directly. Second, when Uprobe is already active and user maps a
> relevant page via mmap(), instruction is replaced via mmap() code
> path. But because Uprobe is invalid, entire mmap() operation can
> not be stopped. In this case just print an error and continue.

Applied to powerpc/next.

[1/1] powerpc/uprobes: Validation for prefixed instruction
      https://git.kernel.org/powerpc/c/d943bc742a6aabc578b6b62a713ceedf8bf16623

cheers
