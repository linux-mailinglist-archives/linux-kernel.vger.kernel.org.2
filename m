Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27DF39CEEB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFFMOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhFFMOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:14:07 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8008FC061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:17 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3L5NPtz9ssP; Sun,  6 Jun 2021 22:12:14 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Nathan Lynch <nathanl@linux.ibm.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210514214422.3019105-1-nathanl@linux.ibm.com>
References: <20210514214422.3019105-1-nathanl@linux.ibm.com>
Subject: Re: [PATCH] powerpc/udbg_hvc: retry putc on -EAGAIN
Message-Id: <162298131809.2353459.1796595260393131161.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 16:44:22 -0500, Nathan Lynch wrote:
> hvterm_raw_put_chars() calls hvc_put_chars(), which may return -EAGAIN
> when the underlying hcall returns a "busy" status, but udbg_hvc_putc()
> doesn't handle this. When using xmon on a PowerVM guest, this can
> result in incomplete or garbled output when printing relatively large
> amounts of data quickly, such as when dumping the kernel log buffer.
> 
> Call again on -EAGAIN.

Applied to powerpc/next.

[1/1] powerpc/udbg_hvc: retry putc on -EAGAIN
      https://git.kernel.org/powerpc/c/027f55e87c3094270a3223f7331d033fe15a2b3f

cheers
