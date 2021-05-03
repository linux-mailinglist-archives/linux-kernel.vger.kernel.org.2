Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8E371797
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhECPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhECPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:10:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A8DB61166;
        Mon,  3 May 2021 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620054598;
        bh=s+nrm+iOJKQ6IG5kV07OgUGN7inM3sfkh/YSLaEdteI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sM/UNznpCRUz9ct8MfpJAueiYyJRHaYOPkuC6ltGGXQ9vLmvIzEMFQLWNyoJT5L/d
         1ARM8okF/37BpnpBFI+z538n2K/PALNhjT2DkyKf5ujHrA7FDy3HMKD5Kd/Hy0kGbW
         FR9Vg+zGzkw2CmXIKOpo/dSucQPWnmrz/t866aUDzvjWnu8MTggSezBrJ3ksyRpLpb
         OgkSrv341+ztO+3Vp7at7TZ22YNia/BGnQEJ+KAFmWb2VsZhOE/qaflhQs33bIo82q
         5il54TJPtkzPu9VwEcG4WIjYWHGaLNHmx/EwVmDUNNribLd6b2xudw6YzEI35EAGe/
         p63k51/pWBv2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B52541084; Mon,  3 May 2021 12:09:55 -0300 (-03)
Date:   Mon, 3 May 2021 12:09:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/12] perf intel-pt: Add more support for VMs
Message-ID: <YJASQ/2rYKUHN9bp@kernel.org>
References: <20210430070309.17624-1-adrian.hunter@intel.com>
 <3bf1d71c-25d9-c5f8-40d3-60f79d7f72cc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf1d71c-25d9-c5f8-40d3-60f79d7f72cc@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 30, 2021 at 02:29:23PM -0700, Andi Kleen escreveu:
> 
> On 4/30/2021 12:02 AM, Adrian Hunter wrote:
> > Hi
> > 
> > Here is V2, see changes list below.
> 
> 
> This will be very useful. I'll definitely be an user for future debugging.
> Thanks for working on this.
> 
> For the series
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

