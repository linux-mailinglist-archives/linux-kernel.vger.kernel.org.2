Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8183AC198
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 05:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFRDw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 23:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFRDw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:52:57 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F221C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 20:50:49 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5lMB30ZWz9sCD; Fri, 18 Jun 2021 13:50:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <3e5b63bb3daab54a1eb9c20221c2e9528c4db9b3.1622883330.git.christophe.leroy@csgroup.eu>
References: <3e5b63bb3daab54a1eb9c20221c2e9528c4db9b3.1622883330.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mem: Add back missing header to fix 'no previous prototype' error
Message-Id: <162398820924.1362017.13365422518831928702.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:50:09 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2021 08:56:09 +0000 (UTC), Christophe Leroy wrote:
> Commit b26e8f27253a ("powerpc/mem: Move cache flushing functions into
> mm/cacheflush.c") removed asm/sparsemem.h which is required when
> CONFIG_MEMORY_HOTPLUG is selected to get the declaration of
> create_section_mapping().
> 
> Add it back.

Applied to powerpc/fixes.

[1/1] powerpc/mem: Add back missing header to fix 'no previous prototype' error
      https://git.kernel.org/powerpc/c/8e11d62e2e8769fe29d1ae98b44b23c7233eb8a2

cheers
