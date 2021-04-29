Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7F36EBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbhD2ODU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:20 -0400
Received: from ozlabs.org ([203.11.71.1]:33923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238846AbhD2ODQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:16 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJ36Hwsz9t1r; Fri, 30 Apr 2021 00:02:27 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Colin King <colin.king@canonical.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20201216113608.11812-1-colin.king@canonical.com>
References: <20201216113608.11812-1-colin.king@canonical.com>
Subject: Re: [PATCH] powerpc/44x: fix spelling mistake in Kconfig "varients" -> "variants"
Message-Id: <161970488570.4033873.12486603627255933756.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 11:36:08 +0000, Colin King wrote:
> There is a spelling mistake in the Kconfig help text. Fix it.

Applied to powerpc/next.

[1/1] powerpc/44x: fix spelling mistake in Kconfig "varients" -> "variants"
      https://git.kernel.org/powerpc/c/ee6b25fa7c037e42cc5f3b5c024b2a779edab6dd

cheers
