Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3813B4E1F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 12:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFZKl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 06:41:29 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhFZKlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 06:41:19 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GBr2S1NPpz9t2G; Sat, 26 Jun 2021 20:38:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Kajol Jain <kjain@linux.ibm.com>, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        trivial@kernel.org, linux-kernel@vger.kernel.org,
        vaibhav@linux.ibm.com
In-Reply-To: <20210418074003.6651-1-kjain@linux.ibm.com>
References: <20210418074003.6651-1-kjain@linux.ibm.com>
Subject: Re: [PATCH] powerpc/papr_scm: trivial: fix typo in a comment
Message-Id: <162470384564.3589875.1244984138894329682.b4-ty@ellerman.id.au>
Date:   Sat, 26 Jun 2021 20:37:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2021 13:10:03 +0530, Kajol Jain wrote:
> There is a spelling mistake "byes" -> "bytes" in a comment of
> function drc_pmem_query_stats(). Fix that typo.

Applied to powerpc/next.

[1/1] powerpc/papr_scm: trivial: fix typo in a comment
      https://git.kernel.org/powerpc/c/d2827e5e2e0f0941a651f4b1ca5e9b778c4b5293

cheers
