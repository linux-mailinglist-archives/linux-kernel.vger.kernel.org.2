Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644113F051F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhHRNqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbhHRNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:46:34 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4990FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:45:59 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GqTgl6rZsz9sX4; Wed, 18 Aug 2021 23:45:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <2a3a5b6f8cc0ef4e854d7b764f66aa8d2ee270d2.1624813698.git.christophe.leroy@csgroup.eu>
References: <2a3a5b6f8cc0ef4e854d7b764f66aa8d2ee270d2.1624813698.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove in_kernel_text()
Message-Id: <162929391793.3619265.4608132514228433472.b4-ty@ellerman.id.au>
Date:   Wed, 18 Aug 2021 23:38:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2021 17:09:18 +0000 (UTC), Christophe Leroy wrote:
> Last user of in_kernel_text() stopped using in with
> commit 549e8152de80 ("powerpc: Make the 64-bit kernel as a
> position-independent executable").
> 
> Generic function is_kernel_text() does the same.
> 
> So remote it.

Applied to powerpc/next.

[1/1] powerpc: Remove in_kernel_text()
      https://git.kernel.org/powerpc/c/09ca497528dac12cbbceab8197011c875a96d053

cheers
