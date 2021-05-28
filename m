Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4F3941A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhE1LKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:10:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40776 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhE1LKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:10:15 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4811B1FD2F;
        Fri, 28 May 2021 11:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622200120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+LF2PVwb9H16A2qGrmXbe0U4IHpiocrNiUK5mO4Lj0=;
        b=IG0o2uF1HpWlHTL+sOO1My7E4FRBxsbU6q0T7So4RWZTdvD0pvcMB2JMnwF6MlzLVQ/L/c
        Lsg3GwEyjIqV4kIyienHZ9YxJG/mevLBOI4hGliuncZDL9dqIYah/LfIX+2H8AmWwJjIuN
        kjbmkhU241otF0hpt037du1N8zMpz5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622200120;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+LF2PVwb9H16A2qGrmXbe0U4IHpiocrNiUK5mO4Lj0=;
        b=GLqI1FaG6tIxtN65cGlnSTIFKdjiZYcj3Vw32L3yeXF+TnAxknWmsvjrTZaS8v/6UC364t
        85jmhX/Ba4/u3SAg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 3376711A98;
        Fri, 28 May 2021 11:08:40 +0000 (UTC)
Subject: Re: [PATCH 3/6] mm/page_alloc: Adjust pcp->high after CPU hotplug
 events
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-4-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7b457a8b-877b-1644-9709-68a67cd27b60@suse.cz>
Date:   Fri, 28 May 2021 13:08:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525080119.5455-4-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 10:01 AM, Mel Gorman wrote:
> The PCP high watermark is based on the number of online CPUs so the
> watermarks must be adjusted during CPU hotplug. At the time of
> hot-remove, the number of online CPUs is already adjusted but during
> hot-add, a delta needs to be applied to update PCP to the correct
> value. After this patch is applied, the high watermarks are adjusted
> correctly.
> 
>   # grep high: /proc/zoneinfo  | tail -1
>               high:  649
>   # echo 0 > /sys/devices/system/cpu/cpu4/online
>   # grep high: /proc/zoneinfo  | tail -1
>               high:  664
>   # echo 1 > /sys/devices/system/cpu/cpu4/online
>   # grep high: /proc/zoneinfo  | tail -1
>               high:  649
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
