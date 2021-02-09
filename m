Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9A1315115
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhBIN7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:59:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:41868 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhBIN6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:58:18 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 119Dot0b023626;
        Tue, 9 Feb 2021 07:50:55 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 119DorgE023625;
        Tue, 9 Feb 2021 07:50:53 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 9 Feb 2021 07:50:53 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 20/22] powerpc/syscall: Avoid storing 'current' in another pointer
Message-ID: <20210209135053.GD27854@gate.crashing.org>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu> <24804747098369ebcdac38970b8f7a1260bdd248.1612796617.git.christophe.leroy@csgroup.eu> <1612838134.rvncv9kzls.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612838134.rvncv9kzls.astroid@bobo.none>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:36:20PM +1000, Nicholas Piggin wrote:
> What if you did this?

> +static inline struct task_struct *get_current(void)
> +{
> +	register struct task_struct *task asm ("r2");
> +
> +	return task;
> +}

Local register asm variables are *only* guaranteed to live in that
register as operands to an asm.  See
  https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html#Local-Register-Variables
("The only supported use" etc.)

You can do something like

static inline struct task_struct *get_current(void)
{
	register struct task_struct *task asm ("r2");

	asm("" : "+r"(task));

	return task;
}

which makes sure that "task" actually is in r2 at the point of that asm.


Segher
