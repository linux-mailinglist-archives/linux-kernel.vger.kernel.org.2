Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8DB3AC1FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhFREZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhFREZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:00 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA90C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:22:52 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4B2zG3z9sjB; Fri, 18 Jun 2021 14:22:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <37f41d74faa0c66f90b373e243e8b1ee37a1f6fa.1623219019.git.christophe.leroy@csgroup.eu>
References: <37f41d74faa0c66f90b373e243e8b1ee37a1f6fa.1623219019.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Move update_power8_hid0() into its only user
Message-Id: <162398829750.1363949.3980800168826008828.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 06:10:29 +0000 (UTC), Christophe Leroy wrote:
> update_power8_hid0() is used only by powernv platform subcore.c
> 
> Move it there.

Applied to powerpc/next.

[1/1] powerpc: Move update_power8_hid0() into its only user
      https://git.kernel.org/powerpc/c/ab3aab292cb2f417f63b8f4887c1dd01c2a831cd

cheers
