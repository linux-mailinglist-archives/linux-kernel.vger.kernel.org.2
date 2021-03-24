Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69D3479FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhCXNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhCXNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:54:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9946DC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:54:09 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a080019d3082655b1d2f4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:800:19d3:826:55b1:d2f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26A6D1EC03A0;
        Wed, 24 Mar 2021 14:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616594043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9ALF8TSH6pFp1Tk5GDTedC+ypic48uRcRUcUIVI+qqQ=;
        b=Oj8dEYug8hxvKd+yrgj+qK5A+gffHMpErKXk38TZWb+b6iS0NwdgouUhsykFhQq3Rq2eOn
        huF9pRIBpp780tA1ONFGpPUOWYHAAGxXeQrGBQcqN1djUFeHCTM1ETYdkQf1e2n+weLsA8
        jcpV+ns9fmAH70yPdVV8A3pqfxlEXx0=
Date:   Wed, 24 Mar 2021 14:54:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
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
Message-ID: <20210324135406.GD5010@zn.tnic>
References: <20210304174237.31945-1-bp@alien8.de>
 <20210304174237.31945-5-bp@alien8.de>
 <CAP-5=fU2D_kmdaLFL7Azm31Czdfdze6EpKg7=uZ+ohbNnb7ssQ@mail.gmail.com>
 <YFtB+Dir1lWjL2gi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFtB+Dir1lWjL2gi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:43:20AM -0300, Arnaldo Carvalho de Melo wrote:
> Borislav, was this addressed? Ian?

Yap:

https://git.kernel.org/tip/0705ef64d1ff52b817e278ca6e28095585ff31e1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
