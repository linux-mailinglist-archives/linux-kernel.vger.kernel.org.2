Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7528339741
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhCLTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:15:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234105AbhCLTPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615576534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l81isJ/JzaYrzKWato7Fh4pS+w4Lv/n2lhw8isgH4q4=;
        b=I5f2sfr+iOXaObRiFfGY4Q+tPZT2IGkinsaU69KrOh5w9OrBymOJ5eVV116qubvX6ZJVPf
        1qT0rmiQFTFv22WPVuASicuKAUBH9IkzfvC0dnJYDVZPDvyfsMkIkCDeAFgrU9bygiGxC0
        9O0O01HTilIZgI6w+fkFjOZGbq/9OL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-xz-Sqy0qMeKacDd8ozTofA-1; Fri, 12 Mar 2021 14:15:30 -0500
X-MC-Unique: xz-Sqy0qMeKacDd8ozTofA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E153B800D55;
        Fri, 12 Mar 2021 19:15:28 +0000 (UTC)
Received: from krava (unknown [10.40.192.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id DA01660636;
        Fri, 12 Mar 2021 19:15:26 +0000 (UTC)
Date:   Fri, 12 Mar 2021 20:15:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 09/27] perf parse-events: Create two hybrid hardware
 events
Message-ID: <YEu9zbr75p+OLY2o@krava>
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-10-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311070742.9318-10-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 03:07:24PM +0800, Jin Yao wrote:

SNIP

>   cycles: 4: 800933425 1002536659 1002536659
>   cycles: 5: 800928573 1002528386 1002528386
>   cycles: 6: 800924347 1002520527 1002520527
>   cycles: 7: 800922009 1002513176 1002513176
>   cycles: 8: 800919624 1002507326 1002507326
>   cycles: 9: 800917204 1002500663 1002500663
>   cycles: 10: 802096579 1002494280 1002494280
>   cycles: 11: 802093770 1002486404 1002486404
>   cycles: 12: 803284338 1002479491 1002479491
>   cycles: 13: 803277609 1002469777 1002469777
>   cycles: 14: 800875902 1002458861 1002458861
>   cycles: 15: 800873241 1002451350 1002451350
>   cycles: 0: 800837379 1002444645 1002444645
>   cycles: 1: 800833400 1002438505 1002438505
>   cycles: 2: 800829291 1002433698 1002433698
>   cycles: 3: 800824390 1002427584 1002427584
>   cycles: 4: 800819360 1002422099 1002422099
>   cycles: 5: 800814787 1002415845 1002415845
>   cycles: 6: 800810125 1002410301 1002410301
>   cycles: 7: 800791893 1002386845 1002386845
>   cycles: 12855737722 16040169029 16040169029
>   cycles: 6406560625 8019379522 8019379522
> 
>    Performance counter stats for 'system wide':
> 
>       12,855,737,722      cpu_core/cycles/
>        6,406,560,625      cpu_atom/cycles/

so we do that no_merge stuff for uncore pmus, why can't we do
that in here? that'd seems like generic way

jirka

