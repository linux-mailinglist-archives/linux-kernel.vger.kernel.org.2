Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B45372C9A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhEDO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230246AbhEDO5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620140217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NTrOieyGEeM0dvjH3dLlvJfIDcimE9C1Cz6dzalW5c=;
        b=LKGLaI+oWpvgYNWdTfPYDEtHiFr7FsGhXx2ZNyqPtWmVP3xcLr003HoZmooCcHW3iV0QBk
        maC/ltWpL2ibPK5sXCfe3FDgMc9zGr/hqSgrX00WnDT4qspcaDzZ4CLV9C3ByriUqgpzIg
        YqIiGLjy4fs35qX2swdEmigzvBp4Bqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-6HdF8ehWOk2ZMfLXXL3ykg-1; Tue, 04 May 2021 10:56:48 -0400
X-MC-Unique: 6HdF8ehWOk2ZMfLXXL3ykg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 259391006C80;
        Tue,  4 May 2021 14:56:47 +0000 (UTC)
Received: from krava (unknown [10.40.192.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 214DC5C1B4;
        Tue,  4 May 2021 14:56:44 +0000 (UTC)
Date:   Tue, 4 May 2021 16:56:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 1/2] perf header: Support HYBRID_TOPOLOGY feature
Message-ID: <YJFgrKB9ZavgbA1P@krava>
References: <20210430074602.3028-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430074602.3028-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:46:01PM +0800, Jin Yao wrote:
> It would be useful to let user know the hybrid topology.
> Adding HYBRID_TOPOLOGY feature in header to indicate the
> core cpus and the atom cpus.
> 
> With this patch,
> 
> For the perf.data generated on hybrid platform,
> reports the hybrid cpu list.
> 
>   root@otcpl-adl-s-2:~# perf report --header-only -I
>   ...
>   # cpu_core cpu list : 0-15
>   # cpu_atom cpu list : 16-23

hum, should we print 'hybrid:' or something to make
sure its not confused with something else? like

  # hybrid cpu_core cpu list : 0-15
  # hybrid cpu_atom cpu list : 16-23

jirka

