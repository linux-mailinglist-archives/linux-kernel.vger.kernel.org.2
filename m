Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3075239BE1A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFDRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:10:56 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49555 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:10:55 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2021 13:10:55 EDT
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FxTbd6RyRz1qtQJ;
        Fri,  4 Jun 2021 19:02:53 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FxTbd5P6jz1qr4Q;
        Fri,  4 Jun 2021 19:02:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id z5k1day5XkLL; Fri,  4 Jun 2021 19:02:53 +0200 (CEST)
X-Auth-Info: aPveupBFrQC4TAiwyGiMQU+yY7PQfBpu7J/bpb4noQCrgLVLfIi6p90pzAqFn3vx
Received: from igel.home (ppp-46-244-187-150.dynamic.mnet-online.de [46.244.187.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  4 Jun 2021 19:02:52 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 807A12C3629; Fri,  4 Jun 2021 19:02:52 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] powerpc/32: Avoid #ifdef nested with FTR_SECTION on
 booke syscall entry
References: <5ab3a517bc883a2fc905fb2cb5ee9344f37b2cfa.1622818435.git.christophe.leroy@csgroup.eu>
        <33db61d5f85146262dbe26648f8f87eca3cae393.1622818435.git.christophe.leroy@csgroup.eu>
X-Yow:  I want to kill everyone here with a cute colorful Hydrogen Bomb!!
Date:   Fri, 04 Jun 2021 19:02:52 +0200
In-Reply-To: <33db61d5f85146262dbe26648f8f87eca3cae393.1622818435.git.christophe.leroy@csgroup.eu>
        (Christophe Leroy's message of "Fri, 4 Jun 2021 14:54:15 +0000 (UTC)")
Message-ID: <8735tx4l6r.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 04 2021, Christophe Leroy wrote:

> On booke, SYSCALL_ENTRY macro nests an FTR_SECTION with a

That sentence lacks an

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
