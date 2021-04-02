Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E0352B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhDBNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234448AbhDBNpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:45:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AC07610D2;
        Fri,  2 Apr 2021 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617371118;
        bh=WXzh49l06FBlZcpOVnOoIk01IGPv5urpCaqqXoHLB38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOhQ0DMHKVLj4I8M53dWcplehITqme0vSwXkhNgIernLRQuTyC+sK+nsFBtbDtuXY
         rzR/YeyUvEZZIOG0Vfwj2MuHLbSkh598hBY6whU/l3D4618XAfiwro6ruwy1qHCCB1
         BKrw65xhcxNiQqGTrV7kRCcFPffsheNQ3TH9aMfyRWchbdypf6wbHnJTrJlbXIZWKi
         uDtdVl8AJuLooxhmoAV5PVBn0g9/eBxEs/ykQ9qA9EMr5hSlQctj/OzhI41kiN3drl
         Ln69zWNtaIUrSFBdOMZPkWAXgzyLGgWQdV2uo6Yvv47Vsh94Cb8QM1AIRa+lXgLYMj
         W0RpvpVSXa0sw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6247F40647; Fri,  2 Apr 2021 10:45:15 -0300 (-03)
Date:   Fri, 2 Apr 2021 10:45:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Subject: Re: [PATCH] tools: perf: util: Remove duplicate struct declaration
Message-ID: <YGcf65apSLYuOhyi@kernel.org>
References: <20210401062424.991737-1-wanjiabing@vivo.com>
 <CAM9d7ciHzUDJc0KutAKoBqB2RA7pheB44=xv7dZ97=UqdNtv_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciHzUDJc0KutAKoBqB2RA7pheB44=xv7dZ97=UqdNtv_g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 01, 2021 at 04:19:38PM +0900, Namhyung Kim escreveu:
> Hello,
> 
> On Thu, Apr 1, 2021 at 3:25 PM Wan Jiabing <wanjiabing@vivo.com> wrote:
> >
> > struct target is declared twice. One has been declared
> > at 21st line. Remove the duplicate.
> >
> > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> I think we can move all the forward declarations to the top
> (and sort them) as well.

Thanks, applied.

- Arnaldo

