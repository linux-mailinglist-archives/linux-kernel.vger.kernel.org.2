Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1A3AC202
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhFREZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60569 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231536AbhFREZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:02 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4D6QTPz9svs; Fri, 18 Jun 2021 14:22:52 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <827944ea12d470c2f862635f48b5ee6c1520351f.1623217909.git.christophe.leroy@csgroup.eu>
References: <827944ea12d470c2f862635f48b5ee6c1520351f.1623217909.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove proc_trap()
Message-Id: <162398829732.1363949.3536667275772125816.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 05:52:50 +0000 (UTC), Christophe Leroy wrote:
> proc_trap() has never been used, remove it.

Applied to powerpc/next.

[1/1] powerpc: Remove proc_trap()
      https://git.kernel.org/powerpc/c/77b0bed74232c480b94bae188b6c7cd0ddee92e8

cheers
