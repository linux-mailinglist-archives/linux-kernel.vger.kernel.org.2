Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA023343C46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCVJGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCVJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:06:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y88xpMhgq5zhCFUMWKJhYJpArZg4gL5FM5u/M3LEbN0=; b=NG7ypSSQhKuIShw+4yjVov+Uxw
        ISo3H4b1YKU3thK66l5MuRg0hA+qGX28eHgUkWAqXnr6H7kJkR49zQZm6gwwerdOKX3IAERKulGlE
        F4RMGCb3Yt+ntR3VgoME/FqF56PbW/3r4fMpeOWeTM2xdemPZ4a44hy2gRF6GV6xNivkWUVWIhdlB
        9zWvM1l/sSUOoFQaDmzsk03dU7qwJIYn3ciZx/k9gqv0tpuU4VicwKSkpz7vxw2OfMiLaWbkS6rE/
        BRi4quh4eQAjEnISiOtj13/H57MnU7ntDPVPE7TN/FX804oY2h6pvPI3kvRhIYjiAHWwdy4jVFEHQ
        OC/R89Rw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOGVE-008FGi-S6; Mon, 22 Mar 2021 09:05:41 +0000
Date:   Mon, 22 Mar 2021 09:05:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Antoine Tenart <atenart@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ltp@lists.linux.it
Subject: Re: [net]  5478fcd0f4:
 BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
Message-ID: <20210322090536.GK1719932@casper.infradead.org>
References: <20210322083553.GI32426@xsang-OptiPlex-9020>
 <161640335063.3537.6668586361113979688@kwain.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161640335063.3537.6668586361113979688@kwain.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:55:50AM +0100, Antoine Tenart wrote:
> I only had a quick look at this, but I think the issue should be fixed
> with:
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index e16d54aabd4c..3ae3c20eb64c 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1378,7 +1378,7 @@ static ssize_t xps_queue_show(struct net_device *dev, unsigned int index,
>         nr_ids = dev_maps ? dev_maps->nr_ids :
>                  (type == XPS_CPUS ? nr_cpu_ids : dev->num_rx_queues);
>  
> -       mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
> +       mask = bitmap_zalloc(nr_ids, GFP_ATOMIC);
>         if (!mask) {
>                 rcu_read_unlock();
>                 return -ENOMEM;

sysfs isn't a good reason to use GFP_ATOMIC.

try something like this:

-       mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
+       mask = bitmap_zalloc(nr_ids, GFP_NOWAIT);
        if (!mask) {
+               int new_nr_ids;
+
                rcu_read_unlock();
-               return -ENOMEM;
+               mask = bitmap_zalloc(nr_ids, GFP_KERNEL);
+               if (!mask)
+                       return -ENOMEM;
+               rcu_read_lock();
+               dev_maps = rcu_dereference(dev->xps_maps[type]);
+               /* if nr_ids shrank while we slept, do not overrun array.
+                * if it increased, we just won't show the new ones
+                */
+               new_nr_ids = dev_maps ? dev_maps->nr_ids :
+                       (type == XPS_CPUS ? nr_cpu_ids : dev->num_rx_queues);
+               if (new_nr_ids < nr_ids)
+                       nr_ids = new_nr_ids;

