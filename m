Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87573B3CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhFYG07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 02:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhFYG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 02:26:58 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC62C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 23:24:38 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GB6RR5r7hz9sX5; Fri, 25 Jun 2021 16:24:35 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20210616134303.58185-1-andriy.shevchenko@linux.intel.com>
References: <20210616134303.58185-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] powerpc/papr_scm: Properly handle UUID types and API
Message-Id: <162460208882.3247425.8141718563854989207.b4-ty@ellerman.id.au>
Date:   Fri, 25 Jun 2021 16:21:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 16:43:03 +0300, Andy Shevchenko wrote:
> Parse to and export from UUID own type, before dereferencing.
> This also fixes wrong comment (Little Endian UUID is something else)
> and should eliminate the direct strict types assignments.

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Properly handle UUID types and API
      https://git.kernel.org/powerpc/c/0e8554b5d7801b0aebc6c348a0a9f7706aa17b3b

cheers
