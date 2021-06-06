Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A6539CEC3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFFMNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:13:54 -0400
Received: from ozlabs.org ([203.11.71.1]:54739 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhFFMNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:13:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb353sKCz9sRN; Sun,  6 Jun 2021 22:12:01 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        gustavoars@kernel.org, ojeda@kernel.org, ndesaulniers@google.com,
        Zhang Jianhua <chris.zjh@huawei.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210510075134.252978-1-chris.zjh@huawei.com>
References: <20210510075134.252978-1-chris.zjh@huawei.com>
Subject: Re: [PATCH -next] ppc: boot: Fix a typo in the file decompress.c
Message-Id: <162298131565.2353459.16060565445905530615.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:35 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 15:51:34 +0800, Zhang Jianhua wrote:
> s/input buffer/output buffer/
> s/length of the input buffer/length of the input buffer/
> 
> --------

Applied to powerpc/next.

[1/1] ppc: boot: Fix a typo in the file decompress.c
      https://git.kernel.org/powerpc/c/930a77c3ad79c30ce9ba8cbad9eded5bc5805343

cheers
