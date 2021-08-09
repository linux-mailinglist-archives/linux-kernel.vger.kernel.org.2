Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661723E4F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbhHIWeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhHIWeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:34:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2662DC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 15:34:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j3so18272548plx.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HUJ+Q2vVe0MOY3L56exkGoUBcaH3WA29WucKvhtJedQ=;
        b=PpQyaZo+EV9AjmAa12PsAq+kne/u/Wps3FHqqmYD6DhvpGd7a0JkX9Tu6mB35sLhB/
         6FyYf9SxzdaIDpLmbd61gVuINiWgk9TLtZLPEn1Es1ZAcrNmVOn4dbRww4uUROXJfFzK
         Dp1NKglWSuazrC6rzkzXB/CiUkQLcmfu3UrHuVPKWzHPiU6MTrIa0Non6OM47KksL0iV
         8nbpog3p0sZg5A58ImQlK0q5S8Qduv6Sdf4HYNhzKeCQxowjGofbhkT2OI+8sPEYJ/Dn
         IcZdmJ2aoUeU/nO37ebZ52bpPwO7vE9xUtsWpxTboynTqqM34fJJVIvDuaOZlKMDioKq
         jq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HUJ+Q2vVe0MOY3L56exkGoUBcaH3WA29WucKvhtJedQ=;
        b=Pxkvq4cWLDxcpJsmFSxBiYWFGsskmmUSoH1vJyGh1UCGzd6g/jcMm4t8jwVVSY8X7y
         9kYvkyVYUGu3ymnkoMO7yn0DitseNNxMQDM1En4vq9ELJ3EyVEWeUobfJ/HNKI6ODrzC
         rjIj1GHVHTuDHi9T1m9B5Ua8N8IETmaqi2vFgscGHzKPBI4aAyz3hlwwo6vdfpr6vwOP
         cyrPJXVukz9KbigUyqkmPL1HCY4owFsxm5/pfougHmK5klXZ3pzpW/Dz+BR3eJsbTqih
         UAUozj+Vy10oLU3vD1cVaw0EQaRL3qnJ+HLQHec/zMggBJ1Wl71+9cUcUrUL0FmMYGfw
         iCUw==
X-Gm-Message-State: AOAM533SHnLbBKz5lXwOJcb5BeuyxMNx3kzieqi9jG+dAFCasxsXt2RN
        XqRnsi6rrW00rTduiPRqSNA=
X-Google-Smtp-Source: ABdhPJz3yM6YYkWNYBHFcZnjFoeGgleCpjmtwKzCAvZmYeBR45UFF07NfwQHz//5AMi/R69dKpwoVQ==
X-Received: by 2002:a63:4e4a:: with SMTP id o10mr262212pgl.350.1628548442630;
        Mon, 09 Aug 2021 15:34:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df1c])
        by smtp.gmail.com with ESMTPSA id j4sm1789780pgi.6.2021.08.09.15.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:34:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Aug 2021 12:33:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 37/38] workqueue: Replace deprecated CPU-hotplug
 functions.
Message-ID: <YRGtVVz2MPitFmSr@mtj.duckdns.org>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-38-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803141621.780504-38-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:16:20PM +0200, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to cgroup/for-5.15.

Thanks.

-- 
tejun
