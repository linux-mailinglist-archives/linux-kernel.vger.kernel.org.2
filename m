Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D6F3CC91D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 14:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhGRMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 08:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233365AbhGRMfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 08:35:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF9A16113D;
        Sun, 18 Jul 2021 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626611565;
        bh=wrj/dtsR6Wp7k94gq+IVpey1DneyoS8rRjtrbzVtNDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nT1pfRX+gIpPZ+oT0jzYyL5m3FSKCDbwv0xYMVAZ/z/IrzM7xOM0DRcx2faJyJ3yC
         phSdreUcRoO5g7waspOcM91nJSNADE8Tuiv7cHBeY6qjXWeABz+JW9ykb5H+ZhzQsz
         hcek9cwfTdEcTBLAeSkMbdu8mt0WucTH8T51JDNLoqbNEotQr1LrgOXDInwiv5Ejw9
         muTs95lkOUY+HRrP7nLA/AJHMh6gIlDAY07X2V+POCfwZngIWN/4uweA4J9DHiiLPN
         KXlsT9/NmEn3V+SraUBVU1fgRAEKR+2+XNgJrJ0dPXhJ79u/mUwF+jyrj3muXyByRy
         aOUe8VejNkSNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42B6C403F2; Sun, 18 Jul 2021 09:32:42 -0300 (-03)
Date:   Sun, 18 Jul 2021 09:32:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, fche@redhat.com,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        srikar@linux.vnet.ibm.com, Jianlin.Lv@arm.com,
        lihuafei1@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf probe: Fix add event failed when 32-bit perf
 running in 64-bit kernel
Message-ID: <YPQfapAY5ONTknoM@kernel.org>
References: <20210715063723.11926-1-yangjihong1@huawei.com>
 <20210715180505.11d1209c91d37c239abe65d7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715180505.11d1209c91d37c239abe65d7@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:05:05PM +0900, Masami Hiramatsu escreveu:
> On Thu, 15 Jul 2021 14:37:23 +0800 Yang Jihong <yangjihong1@huawei.com> wrote:
> OK, this looks good to me :)
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks, applied.

- Arnaldo

