Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4CE30D8F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhBCLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:41:38 -0500
Received: from ozlabs.org ([203.11.71.1]:57335 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234368AbhBCLlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:41:20 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW09f1S2Sz9vDt; Wed,  3 Feb 2021 22:40:37 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Allison Randal <allison@lohutok.net>,
        Markus Elfring <Markus.Elfring@web.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Gen Zhang <blackgod016574@gmail.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
In-Reply-To: <db28c84d-ac07-6d9a-a371-c97ab72bf763@web.de>
References: <db28c84d-ac07-6d9a-a371-c97ab72bf763@web.de>
Subject: Re: [PATCH 0/2] PowerPC-pSeries: Adjustments for dlpar_store()
Message-Id: <161235200944.1516112.5674406874820012967.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:37 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 14:40:42 +0200, Markus Elfring wrote:
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Delete an unnecessary kfree() call
>   Delete an error message for a failed string duplication
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/pseries: Delete an unnecessary kfree() call in dlpar_store()
      https://git.kernel.org/powerpc/c/de060ac83e5c1fe5fb8c505a4e99c1fe4f70ff94
[2/2] powerpc/pseries: Delete an error message for a failed string duplication in dlpar_store()
      https://git.kernel.org/powerpc/c/6e7a4da754f3087fa1f0839c1128aac233c21442

cheers
