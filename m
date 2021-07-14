Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D393C863C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhGNOjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:39:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37834 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhGNOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:39:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B8904202BE;
        Wed, 14 Jul 2021 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626273410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Af9zMHeqi8aU1b8R7HQ3pE9s7xYasPzAL+lA7Sq+Erc=;
        b=goSPEgkj/LMYVuyHS3HzjsISnwz96IAR9tufnsb6HbMQD4IukAXW45LnQfJU5SEByPsz0b
        SVF2k8Dkmr3MmWc4yz7rgiUuNf3V2FYEiPQKzLjwhlllRtD2FzRS4eL131Ev4yu1ZtZ/Ta
        EigEqE8nsyXZ21oETXTW/Wlzajd7mnA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F491A3BBA;
        Wed, 14 Jul 2021 14:36:47 +0000 (UTC)
Date:   Wed, 14 Jul 2021 16:36:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     yong w <yongw.pur@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, nico@fluxnic.net,
        wang.yong12@zte.com.cn
Subject: Re: Re: [BUG] ramfs system panic when using dd to create files
Message-ID: <YO72fy49hqaqDtME@dhcp22.suse.cz>
References: <CAOH5QeChR8s6vENfRdGtUeeqKsSSbeFkY9TArmOyDcUvgAgU7Q@mail.gmail.com>
 <CAOH5QeC0PhnZY6Cpe4zZ8o07XHA4-5B3xGEontkezrYu=Jt0VQ@mail.gmail.com>
 <7074179d.c3fd.17aa3f148cc.Coremail.wuzhouhui14@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7074179d.c3fd.17aa3f148cc.Coremail.wuzhouhui14@mails.ucas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-07-21 15:35:36, wuzhouhui wrote:
> &gt; -----Original Messages-----
> &gt; From: "yong w" <yongw.pur@gmail.com>
> &gt; Sent Time: 2021-07-14 08:24:23 (Wednesday)
> &gt; To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, nico@fluxnic.net, wang.yong12@zte.com.cn
> &gt; Cc: 
> &gt; Subject: Re: [BUG] ramfs system panic when using dd to create files
> &gt; 
> &gt; Hello, is there any solution, or how to avoid this problem when using ramfs?
> 
> Limit max size of ramfs.
> 
> &gt; 
> &gt; yong w <yongw.pur@gmail.com> 于2021年7月7日周三 下午5:58写道：
> &gt; &gt;
> &gt; &gt; When I  use dd to create files multiple times under the ramfs file
> &gt; &gt; system，Panic appears, indicating that there is no process to kill.
> &gt; &gt; I learn that ramfs will automatically grow space due to data writing,
> &gt; &gt; causing all the system memory to run out,  but i think it shouldn't
> &gt; &gt; cause the system to panic.
> 
> The comments already explains why kernel should panic on this situation:
>             /*
>              * If we got here due to an actual allocation at the
>              * system level, we cannot survive this and will enter
>              * an endless loop in the allocator. Bail out now.
>              */

That is the oom side of the things. And that is way too late to do
anything more reasonable. It is suspicious that the ramfs can consume
arbitrary amount of memory. I would be looking there.

-- 
Michal Hocko
SUSE Labs
