Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80813AC1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhFREZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFREY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:24:58 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77BCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:22:49 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m472Xzhz9sXL; Fri, 18 Jun 2021 14:22:47 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <169310e08152aa1d96c979770291d165ec6896ae.1622616032.git.christophe.leroy@csgroup.eu>
References: <169310e08152aa1d96c979770291d165ec6896ae.1622616032.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/44x: Implement Kernel Userspace Exec Protection (KUEP)
Message-Id: <162398829401.1363949.16143408531538336640.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 06:42:10 +0000 (UTC), Christophe Leroy wrote:
> Powerpc 44x has two bits for exec protection in TLBs: one
> for user (UX) and one for superviser (SX).
> 
> Clear SX on user pages in TLB miss handlers to provide KUEP.

Applied to powerpc/next.

[1/1] powerpc/44x: Implement Kernel Userspace Exec Protection (KUEP)
      https://git.kernel.org/powerpc/c/10248dcba1205042a3a0ea65eb441030702d97cd

cheers
