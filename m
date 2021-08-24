Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786163F559F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 04:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhHXCHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 22:07:34 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:41532 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHXCHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 22:07:33 -0400
Received: by mail-qk1-f179.google.com with SMTP id bk29so15761989qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAUUnTgkoa3k12aTtTd1I7GW9Zir2hN+aG0xsiNu28Q=;
        b=jGL8TInuP3uTcBji/+1DgfXQWgVn/fOZr8vts4g1a2TbUN4D951kYk/P7dRJC5IeBL
         rDXd/xrKvcpq1P7pknZ9/MRd/SgBTQ5Yp8RVCQyFyYDhyhQmMHWmXt2ftlDO4gah8FDH
         y3YJX4h/2yYL+FHz99YHm43Iam8p/J5YNEo/Le+yfrnPIYWXfOvZB09FONCPO5oKSCyB
         q1JdKM76Zd2aIWwvCWQl0Y5Zm8FyLcdxg/dyGdlXLVfeYma2+OID1joglFmEjL9hwY9g
         X/JTbO/ziEbWPldtV5D2/ifU+lkbLBPSm1fA+UkekCCBplPezJdl3FDfhDjw36tucLrg
         ZBFA==
X-Gm-Message-State: AOAM531IlTDtnAg6HhSlYByoVrrWwStD2PciLOKGbCbeToE1sSpmdoAT
        9HXVZz4Qh8eSmFcMVinZoD2k5FaYGxCDKg==
X-Google-Smtp-Source: ABdhPJxWSN1E85hQycCFZ4I7YEf3eAqWxQmhtdWFxoWw9Vgl7IjjL9h4/Erx3OVVYmABtuSgvilAZw==
X-Received: by 2002:a37:8044:: with SMTP id b65mr23838872qkd.295.1629770809337;
        Mon, 23 Aug 2021 19:06:49 -0700 (PDT)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id q14sm9636827qkl.44.2021.08.23.19.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 19:06:48 -0700 (PDT)
Date:   Mon, 23 Aug 2021 22:06:47 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCHv2 1/2] kernel/workqueue: Make schedule_on_each_cpu as
 EXPORT_SYMBOL_GPL
Message-ID: <YSRUNzVEig80IBtq@fedora>
References: <5afc2a0c4da65e71ccf24fe65396710d34fc662e.1629751104.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5afc2a0c4da65e71ccf24fe65396710d34fc662e.1629751104.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 24, 2021 at 02:12:29AM +0530, Ritesh Harjani wrote:
> Make schedule_on_each_cpu as EXPORT_SYMBOL_GPL
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> [v1 -> v2]: Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
> 
>  kernel/workqueue.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index f148eacda55a..993f8983186d 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3309,6 +3309,7 @@ int schedule_on_each_cpu(work_func_t func)
>  	free_percpu(works);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(schedule_on_each_cpu);
> 
>  /**
>   * execute_in_process_context - reliably execute the routine with user context
> --
> 2.31.1
> 

I think you missed the point of Christoph's comment. I agree with him
and don't think a test justifies exporting of this particular function.

Thanks,
Dennis
