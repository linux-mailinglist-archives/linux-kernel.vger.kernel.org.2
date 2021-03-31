Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3339E34F5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhCaBKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:10:53 -0400
Received: from ozlabs.org ([203.11.71.1]:51867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233125AbhCaBKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:10:25 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4F97Xc2QZdz9sXb; Wed, 31 Mar 2021 12:10:24 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, nathanl@linux.ibm.com,
        cheloha@linux.ibm.com
In-Reply-To: <20210305125554.5165-1-ldufour@linux.ibm.com>
References: <20210305125554.5165-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/pseries: export LPAR security flavor in lparcfg
Message-Id: <161715296647.226945.115384263678902468.b4-ty@ellerman.id.au>
Date:   Wed, 31 Mar 2021 12:09:26 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 13:55:54 +0100, Laurent Dufour wrote:
> This is helpful to read the security flavor from inside the LPAR.
> 
> In /sys/kernel/debug/powerpc/security_features it can be seen if
> mitigations are on or off but the level set through the ASMI menu.
> Furthermore, reporting it through /proc/powerpc/lparcfg allows an easy
> processing by the lparstat command [1].
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries: export LPAR security flavor in lparcfg
      https://git.kernel.org/powerpc/c/6ce56e1ac380eaa088d3f4c01446e15e195bd541

cheers
