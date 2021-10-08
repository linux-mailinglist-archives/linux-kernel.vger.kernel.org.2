Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CC64270F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239831AbhJHSxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhJHSxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:53:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF3BD60F5A;
        Fri,  8 Oct 2021 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633719097;
        bh=bMjGqLqVphaBvB93a4fPkcU4DQYdJEtiwJUIy4Vw/+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4DQWw+FrVhDMOUuxv3ibEBdQLWRhLaR8MfEscHLAAnI+rWiGNZhY1zeYOfUuS0mp
         ayzJTtETnG8lXA7sVkliTmaoeogUm8wQdEwGwxb3iYzsW6Wbz/iHd1k8cv/N2orKVO
         X5u7F2sIiBifw/QI1GHwJGyPINnmkHxAQER0Gy9dkxTLyWApSAiOvrwckB0GxrxH4+
         PTCi/mTu+9ekZMi6K0e+bdoKtM8gHLtSdbHxw9vL4vAasG8CC3tbZD3EfsAFydMaTd
         NS/BBO/R1poj/6tGdop1blEVOIYUqwXfLnhJ+go7tpL68J583m4bdcGKT6gaS5PQAy
         HFR7cWpEeY55w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 601F5410A1; Fri,  8 Oct 2021 15:51:35 -0300 (-03)
Date:   Fri, 8 Oct 2021 15:51:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] libperf test: Fix build error
Message-ID: <YWCTNzVpEzxYBGE4@kernel.org>
References: <20211006095703.477826-1-nakamura.shun@fujitsu.com>
 <YWBC72+8/CaG7vB5@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWBC72+8/CaG7vB5@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 08, 2021 at 03:09:03PM +0200, Jiri Olsa escreveu:
> On Wed, Oct 06, 2021 at 06:57:03PM +0900, Shunsuke Nakamura wrote:
> > In test_stat_user_read, following build error occurs except i386 and 
> > x86_64 architectures:
> > 
> > tests/test-evsel.c:129:31: error: variable 'pc' set but not used [-Werror=unused-but-set-variable]
> >   struct perf_event_mmap_page *pc;
> > 
> > Fix build error.
> > 
> > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

