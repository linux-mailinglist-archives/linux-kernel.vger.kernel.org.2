Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB6383911
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbhEQQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344698AbhEQPp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:45:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21401C043155
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:36:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so2990244pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ONXfhlq9u8TCp8JigDIr+wVNy5cCGrQCG+BT7AvIJxE=;
        b=NG6zpf8Agchb/GE3uLH4/OkaK/fDpjPoR1ZYI9MnLdG2ykPuhDUOJC5dHCza71or43
         WHEf2w+KTD5znmmeZPCp81+cK8XkLsyaoC2QKZ7YxjcPLW6wLU3OFRCOsJBA1sj22swd
         kjry1KuBFQU2tI1d8gDnnCDbzUZNEkmvoZfWySmY/CrLX5Bg6z2dA4rJq5bxfYON7QsO
         PMtABQbUYXSg4PQfxNMZY+Aar6P80+YtmwCJVSf9KJk5irW3repYyG6aTg0AxY70HSIE
         RukEM9zjtWTEMs1+lzmU6QUWiRNbOdRx0QF1AW6dVF3tPT5IIahVQqotGeKOYmYzfg3M
         rsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ONXfhlq9u8TCp8JigDIr+wVNy5cCGrQCG+BT7AvIJxE=;
        b=h8oMuslZtVvEtGjYWikI/al9IhX/iFgQ0WL9CDDCRF4Gf/CePptxE1h907Ny2TpmC0
         Vr5yROz7lFTWksPOM4BPW6RsAmK090pv7qSgs+HxwYRoXqsE4mkVE2hgRgYmkEmClyJQ
         OOwekvD2XOJ/1zAZ46GFmuO+OZ33iLJjWFAZJkLmRc/g3zBVWjOJzHXAZey9vLhunPzn
         gAAD3bF+beMCLm11IneS276gxpLDgy9b5o9d8dX7p4t67ifShaGqvmbWIUhXVV+IuWS3
         z6RaCAyjbCHpCGi/a0b1rrrjy0/KcvAZxmhD1BojnFYE4qkiq3WEA+9eGtbM72LdTRXV
         1XYw==
X-Gm-Message-State: AOAM532y937fXmaEL3txxlVn+gHqr8mhLab++3yD2F1e1VI9a8DLUvOL
        jclLcKMn7Li47n+Idm4yS8Q=
X-Google-Smtp-Source: ABdhPJz113CiVERVUbFTTWOWQhAbwAjFPbjqTpA0ufNlMsFNmnVNpR7PD6hLd+H7eD4T6JRVU2+TUA==
X-Received: by 2002:a17:903:3046:b029:ee:f24a:7517 with SMTP id u6-20020a1709033046b02900eef24a7517mr304521pla.17.1621262212725;
        Mon, 17 May 2021 07:36:52 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id y14sm15319102pjr.51.2021.05.17.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 07:36:52 -0700 (PDT)
Date:   Mon, 17 May 2021 23:36:47 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernel/locking: make __down_common use flags previously
 saved
Message-ID: <20210517143647.GA53990@hyeyoo>
References: <20210424142823.3896-1-42.hyeyoo@gmail.com>
 <YJwn7qb3/ekFBWDF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJwn7qb3/ekFBWDF@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 09:09:34PM +0200, Ingo Molnar wrote:
> Yes, this is intentional, because if we get into __down_common() we have to 
> schedule, so we have to enable interrupts.

when I sent this patch I thought we have to match XXXX_irqsave with
XXXX_irqrestore, but that was my misunderstanding. I'm sorry for sending
patch saying that it's wrong without explicit evidence.

now I know it's wrong so I won't do that again.

thanks,
Hyeonggon
