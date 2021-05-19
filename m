Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E3388F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353722AbhESNhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhESNhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:37:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC653610A8;
        Wed, 19 May 2021 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621431360;
        bh=zThcPhVHQLG+U7QXmHxEsymmlyuAgZgHRCartqMr0uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJITtrlLpbtccURZ7I2k7yfXSJGNddfGSGom+POnv2DFkKN9F1n9/aTOc0nIaVaK4
         FqPEY3vGvWKhZtKrxc5UZDB1koOwMTWbNblbGz0TnOA54TcIKq/ae+ln1h49bkLC3m
         DvU4B8Akf8J0m2NdpQ1O5ljcjDjTiVyEl96skrUekq7sacyz5xuf3GR132/pwfaIpx
         aknWeuwqCZZyiN99E0rk3yZWUycZ9GosX4e9BXqV59Pf4NTkwXwfFApgiAn78sGbHa
         i45Qj52fGLRqo05zUMIWC36i79wqQCvCbdukI1xr4yx9qnw4104L7aSwecLHIenmnq
         Xa+31CyMe/5kQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3700F40DC6; Wed, 19 May 2021 10:35:57 -0300 (-03)
Date:   Wed, 19 May 2021 10:35:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf intel-pt: Fixes relating to transaction abort
 handling
Message-ID: <YKUUPfAzaZ5zVp3h@kernel.org>
References: <20210519074515.9262-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519074515.9262-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 19, 2021 at 10:45:12AM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are 2 fixes for stable and a subsequent tiny tidy-up.
> 
> Adrian Hunter (3):
>       perf intel-pt: Fix transaction abort handling
>       perf intel-pt: Fix sample instruction bytes
>       perf intel-pt: Remove redundant setting of ptq->insn_len
> 
>  tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 6 +++++-
>  tools/perf/util/intel-pt.c                          | 6 ++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)

Thanks, applied.

- Arnaldo

