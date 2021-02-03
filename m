Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1CF30D8F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhBCLla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:41:30 -0500
Received: from ozlabs.org ([203.11.71.1]:33183 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234297AbhBCLlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:41:18 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW09c0GBmz9vG0; Wed,  3 Feb 2021 22:40:35 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Markus Elfring <Markus.Elfring@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Enrico Weigelt <lkml@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
In-Reply-To: <6dc7d70e-8a40-46ab-897b-d2eaf9a87d77@web.de>
References: <6dc7d70e-8a40-46ab-897b-d2eaf9a87d77@web.de>
Subject: Re: [PATCH 0/2] powerpc/82xx: Adjustments for pq2ads_pci_init_irq()
Message-Id: <161235200985.1516112.15383644631445109361.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:35 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 10:23:29 +0200, Markus Elfring wrote:
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Delete an unnecessary of_node_put() call
>   Use common error handling code
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/82xx: Delete an unnecessary of_node_put() call in pq2ads_pci_init_irq()
      https://git.kernel.org/powerpc/c/60aece416483fdf7e51728a3518438e0458bdabb
[2/2] powerpc/82xx: Use common error handling code in pq2ads_pci_init_irq()
      https://git.kernel.org/powerpc/c/c0cff7a17781f8b02b4837a9fc434a7eed322a14

cheers
