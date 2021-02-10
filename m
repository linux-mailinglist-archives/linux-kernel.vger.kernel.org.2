Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3875315FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhBJHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBJHD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:03:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F59C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 23:03:18 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z7so685050plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 23:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u7l8eLV+vm6Vl+GxoSFPLzJvVqZ42av5SQ9mpq9/dmo=;
        b=YlXpE/rPnq8FwUK4uAJN6eR9RsgqWYRn04idXKZCPjtrnB/cCOuXYw9G2ooKg6WGdR
         QKfE7vZfsi/yeegNdHyt/XCsBasO34kZixa6+CZyqkmyZYpvVRmhpmdl5DM4zDSFBkZ/
         fPnl8CVTa5yYwhwDHdrKedX0LKTtBHBl4hj3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u7l8eLV+vm6Vl+GxoSFPLzJvVqZ42av5SQ9mpq9/dmo=;
        b=JHRDkrupIlyt5ueENATtPAPwTqoQFUQzyv538PdKQemKBEaNfR9tINI8zpOGY32Fvh
         3yWC7Nl1EQbjlUOVY15JSofkZxH4oRbV/+Rx4KZk4gDoe1rrEFwitPZeN/iS8746NETL
         t6lwSFFeT0UJ6SI09yMJvZ/YhFtHs8/lgkWrbsuzRxs1eM0C7Zv8JrFi1ePtZNI9rcy8
         7r+JpXZDlAaXJFw10rwgDhakVX2skLxNT50hyIQyQa6T0VP5+aAzJiEi8Plc4ZSUVKYy
         k0Znl9ganZPZaZtuuq/RAIdjdVAleuKGq3+b1BWeA+N/EFDEQ3gE+u8jcvajSxl8yEth
         3mkw==
X-Gm-Message-State: AOAM530es/PbT8S8ciu9YfshU4oC5IeMo0SVlEfDIcV3UTnH+HC+5NRv
        dtP4IYiANtiEHJbZJYiGkhI36g==
X-Google-Smtp-Source: ABdhPJzOVRCO1fHDsK93X5AzojKdTbzXA5ZcFd9vOu8iOx67GVOyx54QEbtT6POxY23riDdSrHGVVg==
X-Received: by 2002:a17:90b:e14:: with SMTP id ge20mr1816878pjb.207.1612940597970;
        Tue, 09 Feb 2021 23:03:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 62sm1023766pfg.160.2021.02.09.23.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 23:03:17 -0800 (PST)
Date:   Tue, 9 Feb 2021 23:03:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Subject: Re: [patch V2 11/13] softirq: Move __ARCH_HAS_DO_SOFTIRQ to Kconfig
Message-ID: <202102092303.580CA57B@keescook>
References: <20210209234041.127454039@linutronix.de>
 <20210210002513.181713427@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210002513.181713427@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:40:52AM +0100, Thomas Gleixner wrote:
> To prepare for inlining do_softirq_own_stack() replace
> __ARCH_HAS_DO_SOFTIRQ with a Kconfig switch and select it in the affected
> architectures.
> 
> This allows in the next step to move the function prototype and the inline
> stub into a seperate asm-generic header file which is required to avoid
> include recursion.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
