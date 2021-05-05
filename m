Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0359F373CAC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhEENuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232671AbhEENuY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:50:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32F1C610FB;
        Wed,  5 May 2021 13:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620222567;
        bh=Tm+F5vmFGdQSaSHmk68Jf6ftLuqZ2EEpYYwH4nIBnXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YozxFOeSEy50DTkosgSr4QcepmTZ0o1EytnZ2n+Z1xg2U5IvLAPg5wuz3UKHduIJ5
         qq4hVCEL7CyWUVmGprGS/DtEPewPsV8UfX7ttgBMWscoMXCtp8iICpOQloxCI/a8xY
         i4THL5v8VJs+QdLJYsTrqyhx5fM8vtvtj/9l7MWhX7ZwI1DeBBmX6OWWTOjCKsJLLN
         YPEkeaS/0UeQ8PfCrc5O9t96dTW1M1gKtbV3cF5uPCXkDImcAOVCZZukeAGZakUlOz
         y4eMZxOhQbsLkziFWxb+3jTKnnpb0v9XQqQNNcXo6FWa8HZp4iaxdGKzdGdtXeAXNe
         qVyVkUXWlGhhQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BF5EF4034C; Wed,  5 May 2021 10:49:23 -0300 (-03)
Date:   Wed, 5 May 2021 10:49:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
Message-ID: <YJKiYziYlLgUmMwq@kernel.org>
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
 <YJFgrKB9ZavgbA1P@krava>
 <YJGgYSXcJbZ2n3H3@kernel.org>
 <YJGifgASdDD7T8Xc@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJGifgASdDD7T8Xc@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 04, 2021 at 09:37:34PM +0200, Jiri Olsa escreveu:
> On Tue, May 04, 2021 at 04:28:33PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, May 04, 2021 at 04:56:44PM +0200, Jiri Olsa escreveu:
> > > On Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao wrote:
> > > > It would be useful to let user know the hybrid topology.
> > > > Adding HYBRID_TOPOLOGY feature in header to indicate the
> > > > core cpus and the atom cpus.
> > 
> > > > With this patch,
> > 
> > > > For the perf.data generated on hybrid platform,
> > > > reports the hybrid cpu list.
> > 
> > > >   root@otcpl-adl-s-2:~# perf report --header-only -I
> > > >   ...
> > > >   # cpu_core cpu list : 0-15
> > > >   # cpu_atom cpu list : 16-23
> > 
> > > hum, should we print 'hybrid:' or something to make
> > > sure its not confused with something else? like
> >  
> > >   # hybrid cpu_core cpu list : 0-15
> > >   # hybrid cpu_atom cpu list : 16-23
> > 
> > But this _core/_atom already got to be enough? I disagreed with that
> > naming, but neverthless having one or the other present in an output is
> > a clear mark of this hybrid topology.
> > 
> > I.e having that extra hybrid string that wouldn't add information to the
> > output.
> 
> sure when you know that cpu_core/cpu_atom are hybrid pmus ;-)
> and I guess other arch will come with other names 

Yeah, its too Intel centric, I thought they would come up with
cpu_big/cpu_little and map it to core/atom on Intel and whatever other
BIG/little arches come up with.

Perhaps:

root@otcpl-adl-s-2:~# perf report --header-only -I
...
# hybrid cpu system:
# cpu_core cpu list : 0-15
# cpu_atom cpu list : 16-23

?

- Arnaldo
