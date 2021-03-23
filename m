Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8E346468
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhCWQGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhCWQGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:06:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B41C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=fZcfVXMNH8Rqgz7ZPFakLkIDfdVeLG7nLhI59YHj9co=; b=lMOrluIoN3Bs2Mo8BG6bBVPe3G
        6z9cq/EAfMqG93d41MeY+xmTDqUwotXIIi/M2eRKeVcqR+oTfP2YquPaatw+SwMSQt2nigMZdLklC
        KzqM/F5FS8nYrXu2nYk+/Uc8QqCtpNZiQn8s7XbC0iIYxW/9fL+9LoWL9zhyLym0F234FdPzuMAL3
        jYLHJVtlwD0GJCkMC4iLM+Mu38Va46jh46z7Wzr57t7Y+KmJSLDTQIcsoEdlM2+pl/CqMDbF4Lg5y
        gY/Eoq4WBbgXzPKXd99D4ZsHXyzovowyE6lLs1UBMrJrubQvPX46G5xm5O6K0u5TeY4Ozsfq4AhnQ
        YQOeHemA==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOjXj-00FHuv-5b; Tue, 23 Mar 2021 16:06:07 +0000
Subject: Re: [PATCH, -v2] tracing: Fix various typos in comments
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
References: <20210322224546.GA1981273@gmail.com>
 <5e563a58-2ed6-3a1a-d92d-231fb6eecfa9@infradead.org>
 <20210323111150.GA3939639@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <50de05ac-9206-5555-4448-1c1d8da87753@infradead.org>
Date:   Tue, 23 Mar 2021 09:06:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323111150.GA3939639@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 4:11 AM, Ingo Molnar wrote:
> Fixed.
> 
> -v2 attached - I preemptively added your Reviewed-by as well, if 
> that's fine. :-)

Sure.
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy

