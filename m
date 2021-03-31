Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66234F5D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhCaBKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:38 -0400
Received: from ozlabs.org ([203.11.71.1]:41039 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhCaBKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:16 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97XR20Q6z9sj1; Wed, 31 Mar 2021 12:10:15 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com
In-Reply-To: <8dfe1bd2abde26337c1d8c1ad0acfcc82185e0d5.1614868445.git.christophe.leroy@csgroup.eu>
References: <8dfe1bd2abde26337c1d8c1ad0acfcc82185e0d5.1614868445.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/4] powerpc: Enable KFENCE for PPC32
Message-Id: <161715296631.226945.8593352881430375558.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:26 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 14:35:09 +0000 (UTC), Christophe Leroy wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the ppc32 architecture. In particular, this implements the
> required interface in <asm/kfence.h>.
> 
> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the Read/Write linear map to be
> mapped at page granularity.

Patch 1 applied to powerpc/next.

[1/4] powerpc: Enable KFENCE for PPC32
      https://git.kernel.org/powerpc/c/90cbac0e995dd92f7bcf82f74aa50250bf194a4a

cheers
