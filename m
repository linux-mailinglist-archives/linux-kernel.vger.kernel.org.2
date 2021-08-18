Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72F23F0524
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbhHRNq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhHRNqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:46:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071F0C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:46:04 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GqTgs1XN2z9t23; Wed, 18 Aug 2021 23:46:00 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        nathanl@linux.ibm.com
In-Reply-To: <20210511073136.17795-1-ldufour@linux.ibm.com>
References: <20210511073136.17795-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v2] ppc64/numa: consider the max numa node for migratable LPAR
Message-Id: <162929388912.3619265.15749940956800275665.b4-ty@ellerman.id.au>
Date:   Wed, 18 Aug 2021 23:38:09 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 09:31:36 +0200, Laurent Dufour wrote:
> When a LPAR is migratable, we should consider the maximum possible NUMA
> node instead the number of NUMA node from the actual system.
> 
> The DT property 'ibm,current-associativity-domains' is defining the maximum
> number of nodes the LPAR can see when running on that box. But if the LPAR
> is being migrated on another box, it may seen up to the nodes defined by
> 'ibm,max-associativity-domains'. So if a LPAR is migratable, that value
> should be used.
> 
> [...]

Applied to powerpc/next.

[1/1] ppc64/numa: consider the max numa node for migratable LPAR
      https://git.kernel.org/powerpc/c/9c7248bb8de31f51c693bfa6a6ea53b1c07e0fa8

cheers
