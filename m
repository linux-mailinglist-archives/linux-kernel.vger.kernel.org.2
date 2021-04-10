Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEF035AF28
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhDJQ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 12:58:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:33540 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234392AbhDJQ6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 12:58:49 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13AGkG83008877;
        Sat, 10 Apr 2021 11:46:17 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13AGkB0H008870;
        Sat, 10 Apr 2021 11:46:11 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 10 Apr 2021 11:46:11 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Xiongwei Song <sxwjean@me.com>, benh@kernel.crashing.org,
        paulus@samba.org, oleg@redhat.com, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        mikey@neuling.org, haren@linux.ibm.com, akpm@linux-foundation.org,
        rppt@kernel.org, jniethe5@gmail.com, atrajeev@linux.vnet.ibm.com,
        maddy@linux.ibm.com, peterz@infradead.org, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, aik@ozlabs.ru, alistair@popple.id.au,
        pmladek@suse.com, john.ogness@linutronix.de,
        Xiongwei Song <sxwjean@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/traps: Enhance readability for trap types
Message-ID: <20210410164611.GI26583@gate.crashing.org>
References: <20210408140750.26832-1-sxwjean@me.com> <70ece993-12bd-335c-d246-914564eb51dd@csgroup.eu> <874kgfdmxq.fsf@mpe.ellerman.id.au> <f0a6713d-756c-86f2-636d-2a478bab9be4@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0a6713d-756c-86f2-636d-2a478bab9be4@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:42:41AM +0200, Christophe Leroy wrote:
> Le 10/04/2021 à 02:04, Michael Ellerman a écrit :
> >I think these can all be avoided by defining most of the values
> >regardless of what platform we're building for. Only the values that
> >overlap need to be kept behind an ifdef.
> 
> Even if values overlap we can keep multiple definitions for the same value.

That works, but it can lead to puzzling bugs.  Of course we all *like*
working on more challenging bugs, but :-)


Segher
