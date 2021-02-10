Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D247631676D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBJNEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhBJM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:58:40 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BE7C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:57:58 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DbKYY6lXsz9sWg; Wed, 10 Feb 2021 23:57:53 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
        rppt@kernel.org, paulus@samba.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org
Cc:     rdunlap@infradead.org
In-Reply-To: <20210202093746.5198-1-unixbhaskar@gmail.com>
References: <20210202093746.5198-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] arch: powerpc: kernel: Fix the spelling mismach to mismatch in head.44x.S
Message-Id: <161296171992.3178259.17393013457574476712.b4-ty@ellerman.id.au>
Date:   Wed, 10 Feb 2021 23:57:53 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 15:07:46 +0530, Bhaskar Chowdhury wrote:
> s/mismach/mismatch/

Applied to powerpc/next.

[1/1] powerpc/44x: Fix a spelling mismach to mismatch in head_44x.S
      https://git.kernel.org/powerpc/c/ea7826583f5ed7abca97e6e56441caadcbbd957a

cheers
