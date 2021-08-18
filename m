Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E243F0526
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbhHRNq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:46:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237528AbhHRNqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:46:39 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GqTgv17vGz9sVw; Wed, 18 Aug 2021 23:46:02 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nathanl@linux.ibm.com
In-Reply-To: <20210429174908.16613-1-ldufour@linux.ibm.com>
References: <20210429174908.16613-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v5] pseries: prevent free CPU ids to be reused on another node
Message-Id: <162929391998.3619265.3392197710789152359.b4-ty@ellerman.id.au>
Date:   Wed, 18 Aug 2021 23:38:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 19:49:08 +0200, Laurent Dufour wrote:
> When a CPU is hot added, the CPU ids are taken from the available mask from
> the lower possible set. If that set of values was previously used for CPU
> attached to a different node, this seems to application like if these CPUs
> have migrated from a node to another one which is not expected in real
> life.
> 
> To prevent this, it is needed to record the CPU ids used for each node and
> to not reuse them on another node. However, to prevent CPU hot plug to
> fail, in the case the CPU ids is starved on a node, the capability to reuse
> other nodes’ free CPU ids is kept. A warning is displayed in such a case
> to warn the user.
> 
> [...]

Applied to powerpc/next.

[1/1] pseries: prevent free CPU ids to be reused on another node
      https://git.kernel.org/powerpc/c/bd1dd4c5f5286df0148b5b316f37c583b8f55fa1

cheers
