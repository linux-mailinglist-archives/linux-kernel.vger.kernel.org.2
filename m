Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B339D31F02F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhBRTmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233749AbhBRTGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:06:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDCEE64EB8;
        Thu, 18 Feb 2021 19:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613675152;
        bh=0kVaXeLYH6acQ+pBzW3nw03A0aCbRYsMMbgXTgirLJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m40QTEzWC7biDgQER7o6T5VhRmNhCIf2MXkVAWlZHbvPSZeyjrimjyeQopm5piFCr
         x4KHMHpP7qVbBI4Lf0/xPA8Sryrx73RicaB+KY65oOjnXvmk0/VweDrbHmWBo2Ltxc
         12Zs5+/cipA6wI9fYUAJ8NcxmppNyXwCmaQSsT2Ol6lKcDGmjq71KATMO47xiTAj4f
         UjQMib+sk6T7q7dGzCwNfSMtKBqyxMwc10epsZC84ScbsNA3pJkE5gjJFr0MtHLpCd
         YoqkLn+cxmFaMUWXV34t6c6moaU+903oBgrFmCUSrXeLTtYdUvZQkqLSSmrxos4Y+Z
         J8YLtFhfeHGDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32FE640CD9; Thu, 18 Feb 2021 16:05:48 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:05:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/0] perf intel-pt: Add PSB events
Message-ID: <YC66jF0/vXLJ/c80@kernel.org>
References: <20210205175350.23817-1-adrian.hunter@intel.com>
 <20210205205449.GG27611@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205205449.GG27611@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 05, 2021 at 12:54:49PM -0800, Andi Kleen escreveu:
> On Fri, Feb 05, 2021 at 07:53:46PM +0200, Adrian Hunter wrote:
> > Hi
> > 
> > Here are 3 fixes and 1 minor new feature, for Intel PT.
> 
> For the series:
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.

- Arnaldo

