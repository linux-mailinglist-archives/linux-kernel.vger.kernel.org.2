Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4613EB4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 13:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhHML72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 07:59:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239467AbhHML70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 07:59:26 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GmMXf6FRvz9t1s; Fri, 13 Aug 2021 21:58:58 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        fthain@linux-m68k.org, npiggin@gmail.com,
        Michael Ellerman <mpe@ellerman.id.au>, userm57@yahoo.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <aed174f5cbc06f2cf95233c071d8aac948e46043.1628611921.git.christophe.leroy@csgroup.eu>
References: <aed174f5cbc06f2cf95233c071d8aac948e46043.1628611921.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/interrupt: Do not call single_step_exception() from other exceptions
Message-Id: <162885586841.2317031.7293234034031355331.b4-ty@ellerman.id.au>
Date:   Fri, 13 Aug 2021 21:57:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 16:13:17 +0000 (UTC), Christophe Leroy wrote:
> single_step_exception() is called by emulate_single_step() which
> is called from (at least) alignment exception() handler and
> program_check_exception() handler.
> 
> Redefine it as a regular __single_step_exception() which is called
> by both single_step_exception() handler and emulate_single_step()
> function.

Applied to powerpc/fixes.

[1/1] powerpc/interrupt: Do not call single_step_exception() from other exceptions
      https://git.kernel.org/powerpc/c/01fcac8e4dfc112f420dcaeb70056a74e326cacf

cheers
