Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D135322D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhBWPOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhBWPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:13:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C70C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:12:22 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lEZMJ-007QiJ-Hv; Tue, 23 Feb 2021 16:12:19 +0100
Message-ID: <21aa1d80eccede559bebf7201f03a74e67272b4f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] gdb: lx-symbols: store the abspath()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kieran Bingham <kbingham@kernel.org>
Date:   Tue, 23 Feb 2021 16:12:17 +0100
In-Reply-To: <60d43738-1d89-30b0-54bd-8303daeadc57@siemens.com>
References: <20201217091747.bf4332cf2b35.I10ebbdb7e9b80ab1a5cddebf53d073be8232d656@changeid>
         <60d43738-1d89-30b0-54bd-8303daeadc57@siemens.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-17 at 09:31 +0100, Jan Kiszka wrote:
> On 17.12.20 09:17, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > If we store the relative path, the user might later cd to a
> > different directory, and that would break the automatic symbol
> > resolving that happens when a module is loaded into the target
> > kernel. Fix this by storing the abspath() of each path given,
> > just like we already do for the cwd (os.getcwd() is absolute.)

> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

So ... I'm still carrying this patch.

Anyone want to send it to Linus? Andrew, maybe you?

Thanks,
johannes

