Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D08031A984
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhBMBkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBMBkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:40:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BF0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:39:27 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e9so632144pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q6F+stSDKS2SRVHcBD8mIOmM+rg8IVu1AmLn1cRJQZY=;
        b=HwmHc3FV7o3GDVhsYCxqXmXQCX4R2Yd6+UxeTpB3h2H4tWk8I1YZBvkoqUHcWMGsas
         aXKw8g+yG/biIkqPlzKuJT/+EqpVRk2EvLcpoJlVeJ3vwmIhwTusI4BmqBwoZhYfCc2v
         qOABFfEyRpPHxWZx221r21HHvAab3zTe1yj/h3aFwZUz8WdRRThbspn/x8X0SC7sWVnR
         RuJAldlCd9dMXcLbLNMtLi7xcYGbNaO5ls5QDcj94ftAea6Hwj0laZqfv9pWlkyJeViL
         tStPD1NmZNWsjsfLpLJ5QzfvmFBnJQgsSiaJ9N6SzAYM4UvZ9AouGKh85Dc8BSs4cB4/
         V7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q6F+stSDKS2SRVHcBD8mIOmM+rg8IVu1AmLn1cRJQZY=;
        b=Hq3AAxZnKwUN4nrkowPSjzLUYeDJ1gnhLyFPFBGg4BF1bqDScxOcrtIt307mJtB/E9
         0E0twdsn0jVAysK2+ZdQkfItRGA75Q/o/OrsygarQyPhYCGN6Ujl9uBVrz/AjnBLXD/0
         h4+KndKU97aRAuEvjuUbn7lHupdqDJZtc04YWAWcNUVQQHhvou+fSOd7tEBwTZ+CiYpt
         mZyA0zddGZiG/UaBH7DDSWVEhZSKZ/gBz2xaAuOXnMDAIz9pgIku5BTjEzY0uoelpLjN
         yOYsuWPC50swEq6biu9ZoyzLa2RxIWcX1g7q91lTLkgW+A6kLs8N1a0wPbhzLEjamGGV
         lhuA==
X-Gm-Message-State: AOAM531CoPdR+lWcu9sBq9MnrlzAzZw5LDXUDT1nEoNad11REFZXaeBp
        CXPlf+HUPgfBYWcl2cimVEE=
X-Google-Smtp-Source: ABdhPJwwCyuJqhiyuY2YWS1Ntk0Q3WvURf1Hk+hrQa8ErJP/CypVTGPWttdQ9O/QjIihAJJ/0VtTag==
X-Received: by 2002:a17:902:b189:b029:dc:4102:4edf with SMTP id s9-20020a170902b189b02900dc41024edfmr5203490plr.80.1613180367359;
        Fri, 12 Feb 2021 17:39:27 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id u127sm10284552pfb.180.2021.02.12.17.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 17:39:26 -0800 (PST)
Date:   Sat, 13 Feb 2021 10:39:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "J. Avila" <elavila@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: avoid prb_first_valid_seq() where possible
Message-ID: <YCctzHxcxfvUmmtf@jagdpanzerIV.localdomain>
References: <20210211173152.1629-1-john.ogness@linutronix.de>
 <YCZOmajTizYrDSm5@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCZOmajTizYrDSm5@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/12 10:47), Petr Mladek wrote:
> > Fixes: 896fbe20b4e2333fb55 ("printk: use the lockless ringbuffer")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Reported-by: J. Avila <elavila@google.com>
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> I am going to push the patch later today. I would prefer to do it
> later and give a chance others to react. But the merge window
> will likely start the following week and Sergey was fine
> with this approach.

Yup, ACK.

	-ss
