Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D266634F5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhCaBLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:11:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233316AbhCaBKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:45 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xy6VhCz9sXh; Wed, 31 Mar 2021 12:10:39 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, aneesh.kumar@linux.ibm.com,
        linux-kernel@vger.kernel.org, paulus@samba.org
Cc:     rdunlap@infradead.org
In-Reply-To: <20210312112537.4585-1-unixbhaskar@gmail.com>
References: <20210312112537.4585-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] powerpc: mm: book3s64: Fix a typo in the file mmu_context.c
Message-Id: <161715297733.226945.14751652600143342873.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 16:55:37 +0530, Bhaskar Chowdhury wrote:
> s/detalis/details/

Applied to powerpc/next.

[1/1] powerpc: mm: book3s64: Fix a typo in the file mmu_context.c
      https://git.kernel.org/powerpc/c/7a7d744ffe87ae10ab98004d1a6ca1f691af58e1

cheers
