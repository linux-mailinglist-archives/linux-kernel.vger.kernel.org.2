Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861AF3BB9DC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhGEJJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:09:58 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:34767 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGEJJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:09:57 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jul 2021 05:09:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1625476041;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gpO5L/u3UREsXqa+45yj/y5IgBmcrphWeBHKfwFoxyU=;
  b=Es70kj4GGmGn9R6aJt37KPYnfu+rQs5ThfsK494f+02NLiY8qGqE7kbz
   gvpmpuqacOi1qAJTvEzh/89zaH4UbJCwqZYV/7xEEotCRqFoSgYa3wqc1
   L+jJvZGfwSNli/U+2CjOAnKVRBdE2aX+yBjT83oAymRoZk/r7fGN2XVI+
   8=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: yAvmx3gRms4eoTLKidZquDxJgStGcrFGo3KXYKeFxjc8KgZLmpWIGNMk5ApCKEVqkS5fe6i97H
 2S4gql+jqdeG0yMEB5M9+W09Xu6R0Z1vcNifRPqIcRQFFhCOOymfE2DSVsNOlzV4l8MyCSYDcy
 SY7Nwbr1lZIVgKSvcya3OwSlr+Mq/K/ITySj/1Pp+gGBO2adfg/n7P4qsMO9CEeOzULhc3zUar
 G7w2hHcqc3Cb8+fS379AHbyXwheAcyxRb15j6lKdMPUrVPXweSd5vOqWrhc+tOIm3NgqCSL9Jg
 6hQ=
X-SBRS: 5.1
X-MesageID: 49192802
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
IronPort-HdrOrdr: A9a23:032I/qASyTEq38blHemQ55DYdb4zR+YMi2TC1yhKJiC9Afbo8f
 xG+85rrCMc6QxhP03I9urwW5VoLUm8yXcx2/h0AV7AZniChILLFuFfBOLZqlWKcREWtNQy6U
 4JSdkHNDSaNzVHZKjBjDVQX+xQouW6zA==
X-IronPort-AV: E=Sophos;i="5.83,325,1616472000"; 
   d="scan'208";a="49192802"
Subject: Re: [PATCH] xen/events: reset active flag for lateeoi events later
To:     Juergen Gross <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
References: <20210623130913.9405-1-jgross@suse.com>
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <41f6aeaa-583f-9b00-7789-d8a6f751b49d@citrix.com>
Date:   Mon, 5 Jul 2021 10:00:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210623130913.9405-1-jgross@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-23 14:09, Juergen Gross wrote:
> In order to avoid a race condition for user events when changing
> cpu affinity reset the active flag only when EOI-ing the event.
> 
> This is working fine as all user events are lateeoi events. Note that
> lateeoi_ack_mask_dynirq() is not modified as there is no explicit call
> to xen_irq_lateeoi() expected later.
> 
> Reported-by: Julien Grall <julien@xen.org>
> Fixes: b6622798bc50b62 ("xen/events: avoid handling the same event on two cpus at the same time")
> Tested-by: Julien Grall <julien@xen.org>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---

Hi Juergen,

Are you planning on backporting this fix to releases <= 5.10?

I think the fix may need some minor adjustment to make it work after
"xen/events: fix setting irq affinity" since both lateeoi_ack_dynirq()
and lateeoi_mask_ack_dynirq() were adjusted to call ack_dynirq().

Thanks,
Ross
