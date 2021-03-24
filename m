Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E943480FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbhCXSxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhCXSwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:52:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 991F361A10;
        Wed, 24 Mar 2021 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616611954;
        bh=iQxcF34kQXuVG06/sMrNAooIMn5TbsvrImcAfLkq7S4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXeC6qlo0csUpYGbSMOkaWVPHqkgxSlHv+uy4GkIpTON9i6mnvP359JbY8QDa26ed
         icSx719wbkcZmpS5CE+D5JZgguFIxwZK7w2X5ha3bMeiD8+KpnbKxDlavfeMWdihNZ
         6O1gqAmfuUkhIgchsovsqV/Orz8uUV6Sr0F9Fls2h7yPYBfiH76EuDsw/cZ1LRxNZw
         wej+9fl2qGw92MqxzcXpoim7UaINxgv4zh6wRLhiQXasAmDMx+k9JnYsF/Tk8Wobkw
         SM3vkKt/61X7Ol72mXpFVubKH3++Sjvo2hu5PMilGlzVzb6eBZbXf1khItuGlY0Y+8
         FRFmK6agj3LZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 546D940647; Wed, 24 Mar 2021 15:52:32 -0300 (-03)
Date:   Wed, 24 Mar 2021 15:52:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, X86 ML <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 04/21] x86/insn: Add an insn_decode() API
Message-ID: <YFuKcA1F6vaI/qGf@kernel.org>
References: <20210304174237.31945-1-bp@alien8.de>
 <20210304174237.31945-5-bp@alien8.de>
 <CAP-5=fU2D_kmdaLFL7Azm31Czdfdze6EpKg7=uZ+ohbNnb7ssQ@mail.gmail.com>
 <YFtB+Dir1lWjL2gi@kernel.org>
 <20210324135406.GD5010@zn.tnic>
 <CAP-5=fWwZ8WVKHT=+rWdYODx1MTOMR8318mSiheSMx_q4r41hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWwZ8WVKHT=+rWdYODx1MTOMR8318mSiheSMx_q4r41hA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 24, 2021 at 11:21:19AM -0700, Ian Rogers escreveu:
> On Wed, Mar 24, 2021 at 6:54 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Mar 24, 2021 at 10:43:20AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Borislav, was this addressed? Ian?
> >
> > Yap:
> >
> > https://git.kernel.org/tip/0705ef64d1ff52b817e278ca6e28095585ff31e1
> 
> Tested on PPC and ARM64 fwiw. Thanks,

Thank you guys for clearing this up,

- Arnaldo
