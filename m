Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116E539740D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhFANZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233962AbhFANZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:25:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1478613B1;
        Tue,  1 Jun 2021 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622553835;
        bh=SMxMcCMF85/KcUellcsrfSDsx0nR8OQ6hkwHtCgDnK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NW8LaY8n3n+d8MXTGFwSIZKmSs0R3SLFYX74lO03vBIwhxtp6RVu5TLzgfgi/YSL2
         krDsQrSa50aspr6lEz19LtXWbMn8lvLBKkCSa3g0JM63pfnf/p2pxfCS6sPai94vHL
         0REcyczdGvj7pQV2QwXMi+u7aLWXsgjFRJ5AsV6ajq2/1XCMjdb1alnquFPQR5hUfa
         FND0NCa5wn/0+P57L46sIUhXPat5eIQwaPnnNKd/+L6siHcsGZtEO8sonpeCh7ZLdk
         Ridfdm/+OxtUfyC5oTKkZHbH+Ow1jdeN0KevitMZl5BG8CylTAXhAT5B0VMrFCmZD8
         RBvqcsnmYY5UQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E39FC4011C; Tue,  1 Jun 2021 10:23:52 -0300 (-03)
Date:   Tue, 1 Jun 2021 10:23:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     mhiramat@kernel.org, namhyung@kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        srikar@linux.vnet.ibm.com, fche@redhat.com, Jianlin.Lv@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangjihong1@huawei.com, zhangjinhao2@huawei.com
Subject: Re: [PATCH] perf probe: Fix null pointer dereference in
 convert_variable_location()
Message-ID: <YLY06O/Dk/2jpCB7@kernel.org>
References: <20210601092750.169601-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601092750.169601-1-lihuafei1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 01, 2021 at 05:27:50PM +0800, Li Huafei escreveu:
> If we just check whether the variable can be converted, 'tvar' should be
> a null pointer. However, the null pointer check is missing in the
> 'Constant value' execution path.
> 
> The following cases can trigger this problem:
> 
> 	$ cat test.c
> 	#include <stdio.h>

Thanks for providing the detailed analysis and test steps, I've
reproduced the problem before the patch and it now works with your
patch:

[acme@five tmp]$ sudo perf probe -x ./test main:6
Added new event:
  probe_test:main_L6   (on main:6 in /tmp/test)

You can now use it in all perf tools, such as:

	perf record -e probe_test:main_L6 -aR sleep 1

[acme@five tmp]$

Thanks, applied.

- Arnaldo
