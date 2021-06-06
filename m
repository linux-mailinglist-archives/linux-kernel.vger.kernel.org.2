Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0626339CEC7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFFMOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFFMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:13:55 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A60C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:06 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3757PQz9sWD; Sun,  6 Jun 2021 22:12:03 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <848f18d213b8341939add7302dc4ef80cc7a12e3.1620307636.git.christophe.leroy@csgroup.eu>
References: <848f18d213b8341939add7302dc4ef80cc7a12e3.1620307636.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Speed up likely path of kuap_update_sr()
Message-Id: <162298131688.2353459.37331133206133649.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 13:27:31 +0000 (UTC), Christophe Leroy wrote:
> In most cases, kuap_update_sr() will update a single segment
> register.
> 
> We know that first update will always be done, if there is no
> segment register to update at all, kuap_update_sr() is not
> called.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Speed up likely path of kuap_update_sr()
      https://git.kernel.org/powerpc/c/8af8d72dc58e90dc945ca627b24968400e0f21b6

cheers
