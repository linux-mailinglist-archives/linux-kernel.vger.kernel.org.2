Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCD2316766
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhBJNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhBJM55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:57:57 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98264C061788
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:57:32 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DbKY44w7Yz9sVw; Wed, 10 Feb 2021 23:57:27 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <c72f014730823b413528e90ab6c4d3bcb79f8497.1612692067.git.christophe.leroy@csgroup.eu>
References: <c72f014730823b413528e90ab6c4d3bcb79f8497.1612692067.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/uaccess: Perform barrier_nospec() in KUAP allowance helpers
Message-Id: <161296172412.3178259.4318567757525360600.b4-ty@ellerman.id.au>
Date:   Wed, 10 Feb 2021 23:57:27 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Feb 2021 10:08:11 +0000 (UTC), Christophe Leroy wrote:
> barrier_nospec() in uaccess helpers is there to protect against
> speculative accesses around access_ok().
> 
> When using user_access_begin() sequences together with
> unsafe_get_user() like macros, barrier_nospec() is called for
> every single read although we know the access_ok() is done
> onece.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/uaccess: Perform barrier_nospec() in KUAP allowance helpers
      https://git.kernel.org/powerpc/c/8524e2e76441fc615a3b5c1415823e051cc79eae

cheers
