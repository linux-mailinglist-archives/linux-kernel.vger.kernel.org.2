Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80CC3A312A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhFJQpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhFJQpN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:45:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 907A7613DD;
        Thu, 10 Jun 2021 16:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623343396;
        bh=1TI3P5xNylhJ3HbRoJRSII56aRhipspy+WKJIxECdwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSaFfwPTJOSrCY1T42ZcEQtzQ6qNaCkky1S+zXNqqxnK0RAyW1Up5B/FhQ2pLzUr1
         AIxSnRdq18+P6x2e+n20yNLMm9lw3G+RbuV20b7CurfvR9N06XJHi/VcP8WO7c36gO
         MpnIX9ldga89MKJxRugdXDVHKliLteMoTBtGbVU8ZpooJBzQoemlyB+S7lwdzVKmud
         YHWtFnrU/OviKMc9qiZeUhBKPdDLhFKqYQuHVCpo5Qo39Iz+lBTvjOGuSUTUcWqF+X
         GRs0TRGiTq1mOZtwHig6blSWEr1vOvIYU4EApSW91iqhBCpUxidFNfVFNvkDwyF58Q
         h5OMGdUm986vg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A2A4F40B1A; Thu, 10 Jun 2021 13:43:11 -0300 (-03)
Date:   Thu, 10 Jun 2021 13:43:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf evsel: Adjust hybrid event and global event
 mixed group
Message-ID: <YMJBH6Os6IgE9NYh@kernel.org>
References: <20210609044555.27180-1-yao.jin@linux.intel.com>
 <YMEhYYwQaT5i9/UE@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMEhYYwQaT5i9/UE@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 09, 2021 at 10:15:29PM +0200, Jiri Olsa escreveu:
> On Wed, Jun 09, 2021 at 12:45:55PM +0800, Jin Yao wrote:
> > A group mixed with hybrid event and global event is allowed. For example,
> > group leader is 'intel_pt//' and the group member is 'cpu_atom/cycles/'.
> > 
> > e.g.
> > perf record --aux-sample -e '{intel_pt//,cpu_atom/cycles/}:u'
> > 
> > The challenge is their available cpus are not fully matched. For example,
> > 'intel_pt//' is available on CPU0-CPU23, but 'cpu_atom/cycles/' is
> > available on CPU16-CPU23.
> > 
> > When getting the group id for group member, we must be very careful.
> > Because the cpu for 'intel_pt//' is not equal to the cpu for
> > 'cpu_atom/cycles/'. Actually the cpu here is the index of evsel->core.cpus,
> > not the real CPU ID.

<SNIP>

> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
 
> looks good to me
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

