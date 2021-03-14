Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1C33A412
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 11:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhCNKCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 06:01:22 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E951EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 03:01:21 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Dyw721Qwgz9sW5; Sun, 14 Mar 2021 21:01:18 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Plattner <christoph.plattner@thalesgroup.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <4a0c6e3bb8f0c162457bf54d9bc6fd8d7b55129f.1612160907.git.christophe.leroy@csgroup.eu>
References: <4a0c6e3bb8f0c162457bf54d9bc6fd8d7b55129f.1612160907.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/603: Fix protection of user pages mapped with PROT_NONE
Message-Id: <161571587047.138988.3119931595106306211.b4-ty@ellerman.id.au>
Date:   Sun, 14 Mar 2021 21:01:18 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 06:29:50 +0000 (UTC), Christophe Leroy wrote:
> On book3s/32, page protection is defined by the PP bits in the PTE
> which provide the following protection depending on the access
> keys defined in the matching segment register:
> - PP 00 means RW with key 0 and N/A with key 1.
> - PP 01 means RW with key 0 and RO with key 1.
> - PP 10 means RW with both key 0 and key 1.
> - PP 11 means RO with both key 0 and key 1.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/603: Fix protection of user pages mapped with PROT_NONE
      https://git.kernel.org/powerpc/c/c119565a15a628efdfa51352f9f6c5186e506a1c

cheers
