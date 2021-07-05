Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABD73BC26A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGER6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 13:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhGER6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 13:58:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F37E61960;
        Mon,  5 Jul 2021 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625507767;
        bh=bv2embn+MbMbkbhPOy30PDymp7h/saItL/lDCYweFOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCoJqSK9GDWmjlan3Ns9JeJKF14oy/dCQTRZ309CxXtjnJezbneUXqpOeaDGi5TKB
         EdgzNTRX7CRnwiYPs4c8fThr9mb2mitZzUMAkUKYvfJ8/nlgfiyaNDf41yW3wes6Si
         Fi/rMhTiwduaK/EKfBAirLMDWA2ExxoeO4mX9HaX8wR+dC41lZq56FcCG1DpD2HLDC
         tNq+LqFFVCvz2zzSO1vLrVuHWoGXjY0qOSMWw9CVEFWkJCUrAP3werzIt01g+mwdFv
         qTHlWmf6RLOLyg2Mhkx5N+rTN30Nu6Y9gu9jYnkA2jbhUh5Qxh+SkU2aWVBNVjVgcK
         LBNQvfIHr50zA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB5DD40B1A; Mon,  5 Jul 2021 14:56:03 -0300 (-03)
Date:   Mon, 5 Jul 2021 14:56:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Fabian Hemmer <copy@copy.sh>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf top: fix overflow in elf_sec__is_text
Message-ID: <YONHs5z8ODjePxo2@kernel.org>
References: <20210621222108.196219-1-rickyman7@gmail.com>
 <CAM9d7ch7eg6_tX76FeXz3zPJdUGnHRPKkkBF6ZwjAGcJz7wQCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch7eg6_tX76FeXz3zPJdUGnHRPKkkBF6ZwjAGcJz7wQCg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 22, 2021 at 12:46:38PM -0700, Namhyung Kim escreveu:
> Hi Riccardo,
> 
> On Mon, Jun 21, 2021 at 3:22 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> >
> > ASan reports a heap-buffer-overflow in elf_sec__is_text when using perf-top.
> > The bug is caused by the fact that secstrs is built from runtime_ss, while
> > shdr is built from syms_ss if shdr.sh_type != SHT_NOBITS. Therefore, they
> > point to two different ELF files.
> >
> > This patch renames secstrs to secstrs_run and adds secstrs_sym, so that
> > the correct secstrs is chosen depending on shdr.sh_type.

Thanks, applied.

- Arnaldo

