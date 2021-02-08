Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41F5314160
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhBHVMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:12:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236633AbhBHUKb (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E4EB64E6C;
        Mon,  8 Feb 2021 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612814982;
        bh=gVJAtbx29cJxJNKpnEs/PoWRKoOnpq4fML2WVxj+MF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efHwM3iuWZPaGh75XYZkTBINL5LDBTYkauCcvZZ7iRQ63vc+dPOh8Hryrvzz+eOPf
         EjlqiZdwYsep6UosNjfktc3tyP7LfXzOMdh91n+JIfBwMALPirpE0TpjzgOAr8MTJL
         bxbHBIWcE6aQAK0hSrDLcuCbIUCv5yvAHgxHFauPP/ry/ORV2on+ZyLY0EFsjKzzEV
         4+zXTftfh62FO79NjqGBjhM/Nmz0HZt0f/plPIDo4s8U3ZmAgllEHOkxDEEBc+S1QX
         Ujk0B69Qq00z5RthctABzCaTa5RHu0UZfDyJ9hqBqbVvU8U/E8kUHl3DNQ18e1W6Jv
         sKGDsJZkWYLWA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 749DA40513; Mon,  8 Feb 2021 17:09:40 -0300 (-03)
Date:   Mon, 8 Feb 2021 17:09:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/2] perf script: Support filtering by hex address
Message-ID: <20210208200940.GT920417@kernel.org>
References: <20210207080935.31784-1-yao.jin@linux.intel.com>
 <20210207080935.31784-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207080935.31784-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 07, 2021 at 04:09:35PM +0800, Jin Yao escreveu:
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  v3:
>    Update setup_addrlist:
>    1. Add more checks for strtoul (errno, space and etc). 
>    2. Don't break when detect an invalid address, just save the
>       valid address to addr_list. 

Thanks, tested and applied.

- Arnaldo
