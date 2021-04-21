Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F7366C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbhDUNPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:15:40 -0400
Received: from ozlabs.org ([203.11.71.1]:58135 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242043AbhDUNJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:45 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FQLVH4lh1z9vFP; Wed, 21 Apr 2021 23:09:11 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>, jniethe5@gmail.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <5f6f82572242a59bfee1e19a71194d8f7ef5fca4.1618405715.git.christophe.leroy@csgroup.eu>
References: <5f6f82572242a59bfee1e19a71194d8f7ef5fca4.1618405715.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/4] powerpc: Remove probe_user_read_inst()
Message-Id: <161901050534.1961279.5746860283283501781.b4-ty@ellerman.id.au>
Date:   Wed, 21 Apr 2021 23:08:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 13:08:40 +0000 (UTC), Christophe Leroy wrote:
> Its name comes from former probe_user_read() function.
> That function is now called copy_from_user_nofault().
> 
> probe_user_read_inst() uses copy_from_user_nofault() to read only
> a few bytes. It is suboptimal.
> 
> It does the same as get_user_inst() but in addition disables
> page faults.
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc: Remove probe_user_read_inst()
      https://git.kernel.org/powerpc/c/6ac7897f08e04b47df3955d7691652e9d12d4068
[2/4] powerpc: Make probe_kernel_read_inst() common to PPC32 and PPC64
      https://git.kernel.org/powerpc/c/6449078d50111c839bb7156c3b99b9def80eed42
[3/4] powerpc: Rename probe_kernel_read_inst()
      https://git.kernel.org/powerpc/c/41d6cf68b5f611934bcc6a7d4a1a2d9bfd04b420
[4/4] powerpc: Move copy_from_kernel_nofault_inst()
      https://git.kernel.org/powerpc/c/39352430aaa05fbe4ba710231c70b334513078f2

cheers
