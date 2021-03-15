Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176D033C030
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhCOPl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:41:58 -0400
Received: from one.firstfloor.org ([193.170.194.197]:47228 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhCOPlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:41:37 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 11:41:37 EDT
Received: by one.firstfloor.org (Postfix, from userid 503)
        id B71F886851; Mon, 15 Mar 2021 16:34:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1615822440;
        bh=qKEiqWkd+vTdel60Nz7+dVA4piWiwZUw/vCyOIgCeHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfsH11obdNy10LOj3fB6pafP/TA4hYBZJv+R5mmS7OYos8gIuXYJ1qMEizR77fsiQ
         HBmEj6CMTLTGibVpji1PexWK/aa2iFrfcoIq+yHlYowIT9Ash+/soCb6GS/nZBhE3l
         OSjeQkRaaSze7nC67mThThjZo4VHsPrpL9uEuvg8=
Date:   Mon, 15 Mar 2021 08:34:00 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Andi Kleen <andi@firstfloor.org>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@ghostprotocols.net" 
        <linux-perf-users@ghostprotocols.net>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Message-ID: <20210315153359.s47atiznpxkrc7oq@two.firstfloor.org>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YEt5o7pSTleymwy1@kernel.org>
 <F55800AC-73A5-46A4-9E08-1DD00691267C@fb.com>
 <YE9ctk/sO/bokBjw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE9ctk/sO/bokBjw@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I still think that there is value in taking those measurements after we
> enable the counters, as, for instance, for interval mode we want
> measurements with the counters enabled, whatever happens before the
> counters are enabled is just startup time, etc. Jiri, Andi?

Yes I agree. Only the time with counters enabled matters.


-Andi
