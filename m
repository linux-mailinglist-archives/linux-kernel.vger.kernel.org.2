Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870A53730CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhEDT3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbhEDT3b (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:29:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12311613C6;
        Tue,  4 May 2021 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620156516;
        bh=6s9YcySBfv0oXhxhDIdEO/gHOGuHr2jjIuejtBR9k+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZWFlmh2mbl+EO5zpkEwZsGuPZUuxg/QFWvmj5b3vEXMm1JKzNR1XPgT7VspsglsZ
         ViUDeXTjRLTOjftFbiMlSjwBc1SgPKZ1ZXdQwz0u3IMTp2L66JuMWk05IErZGxdX/Q
         vOu2oMEL9bk3emdCZtvfwPZfV3hZZgt+OTbCRvSPL1yGVqOln6J7TDI/RZZ1XxoIi9
         m7cPvyaaVZBtn3KJMvB/nbS3qeywdidF/z3dGMf3IpNyDts3oMWyehOSug+nknMBzF
         BXIFucDs/v1iE8+TRRrbprozvnZ4j41zWoPYbJ4nJrAzDQGX7pnssyFQxtoGQAvwsK
         ddLE8u6mwtTGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 900174034C; Tue,  4 May 2021 16:28:33 -0300 (-03)
Date:   Tue, 4 May 2021 16:28:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
Message-ID: <YJGgYSXcJbZ2n3H3@kernel.org>
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <YJFgrKB9ZavgbA1P@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJFgrKB9ZavgbA1P@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 04, 2021 at 04:56:44PM +0200, Jiri Olsa escreveu:
> On Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao wrote:
> > It would be useful to let user know the hybrid topology.
> > Adding HYBRID_TOPOLOGY feature in header to indicate the
> > core cpus and the atom cpus.

> > With this patch,

> > For the perf.data generated on hybrid platform,
> > reports the hybrid cpu list.

> >   root@otcpl-adl-s-2:~# perf report --header-only -I
> >   ...
> >   # cpu_core cpu list : 0-15
> >   # cpu_atom cpu list : 16-23

> hum, should we print 'hybrid:' or something to make
> sure its not confused with something else? like
 
>   # hybrid cpu_core cpu list : 0-15
>   # hybrid cpu_atom cpu list : 16-23

But this _core/_atom already got to be enough? I disagreed with that
naming, but neverthless having one or the other present in an output is
a clear mark of this hybrid topology.

I.e having that extra hybrid string that wouldn't add information to the
output.

IMHO.

- Arnaldo
