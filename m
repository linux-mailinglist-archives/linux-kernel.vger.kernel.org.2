Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64246318B99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhBKNIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:08:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:34850 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBKMqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:46:12 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 11BCd8nj001681;
        Thu, 11 Feb 2021 06:39:08 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 11BCd7qd001680;
        Thu, 11 Feb 2021 06:39:07 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 11 Feb 2021 06:39:07 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/bug: Remove specific powerpc BUG_ON()
Message-ID: <20210211123907.GD28121@gate.crashing.org>
References: <694c7195c81d1bcc781b3c14f452886683d6c524.1613029237.git.christophe.leroy@csgroup.eu> <20210211114910.GA28121@gate.crashing.org> <3b7f3a1e-0355-b6d4-14cd-300bf4d3629a@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b7f3a1e-0355-b6d4-14cd-300bf4d3629a@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 01:26:12PM +0100, Christophe Leroy wrote:
> >What PowerPC cpus implement branch folding?  I know none.
> 
> Extract from powerpc mpc8323 reference manual:

> — Zero-cycle branch capability (branch folding)

Yeah, this is not what is traditionally called branch folding (which
stores the instruction being branched to in some cache, originally the
instruction cache itself; somewhat similar (but different) to the BTIC
on 750).  Overloaded terminology :-)

6xx/7xx CPUs had the branch execution unit in the frontend, and it would
not issue a branch at all if it could be resolved then already.  Power4
and later predict all branches, and most are not issued at all (those
that do need to be executed, like bdnz, are).  At completion time it is
checked if the prediction was correct (and corrective action is taken if
not).


Segher
