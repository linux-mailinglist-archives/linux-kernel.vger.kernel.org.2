Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B5D3F99EC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbhH0NXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbhH0NXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:42 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3623C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:22:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0ky5K7Sz9tk1;
        Fri, 27 Aug 2021 23:22:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20210815222334.9575-1-rdunlap@infradead.org>
References: <20210815222334.9575-1-rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc/head_check: use stdout for error messages
Message-Id: <163007013465.52768.731707221270776567.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:15:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Aug 2021 15:23:34 -0700, Randy Dunlap wrote:
> Prefer stderr instead of stdout for error messages.
> This is a good practice and can help CI error detecting and
> reporting (0day in this case).
> 
> 
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/head_check: use stdout for error messages
      https://git.kernel.org/powerpc/c/47c258d71ebfc832a760a1dc6540cf3c33968023

cheers
