Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7132A407A2C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhIKTCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 15:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhIKTCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 15:02:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D42F611AD;
        Sat, 11 Sep 2021 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631386890;
        bh=OY5IdttbyAJVyEHgy/4n/euNi4I2ZckosFt7luFG/oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPyTRO3/EBgmyoO25iVOYeMs1brUHHKamAFuHKrmVn1mJ0Zvi9eE9faFj5VIGuzEs
         riWdmOAXQ21jOBDnQt69bz4zeQF9sYEuQs1lW8VyvTj5DfSCHVl0iY7ykXGarVS+yr
         TFXFtZUU0ALqo8fJbJfN9AH6IJzj0ex1T1M78U16BYq9RxSdT2/F14w1K9ppDfgJxj
         uz4KivzW5aoamDVwiMv+rL+v3DYXCUOXNuUWCP34JAv63C+7MtmFSLMzXuGrmAif1P
         wegZqQ1yEs4uI1khy+BmaWcQy/zg98PcKduPftmA9vDCOfez3jwZnwyj4Bz1lU1HEa
         vF32R+1neY0wA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A1AF4038F; Sat, 11 Sep 2021 16:01:27 -0300 (-03)
Date:   Sat, 11 Sep 2021 16:01:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf tools: Fix hybrid config terms list corruption
Message-ID: <YTz9B28btyOjLUIQ@kernel.org>
References: <20210909125508.28693-1-adrian.hunter@intel.com>
 <YTyLipYOF8cSB/YC@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTyLipYOF8cSB/YC@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 11, 2021 at 12:57:14PM +0200, Jiri Olsa escreveu:
> On Thu, Sep 09, 2021 at 03:55:06PM +0300, Adrian Hunter wrote:
> > Hi
> > 
> > Here is a fix for an issue using perf on ADL.
> > 
> > 
> > Adrian Hunter (2):
> >       perf tools: Factor out copy_config_terms() and free_config_terms()
> >       perf tools: Fix hybrid config terms list corruption
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

