Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0BF3A8E61
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhFPBcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhFPBco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:32:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:30:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k6so833842pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=98QtFZL4VdtHTypPhf4rfoA0vIbhXerE7IjIdxfFqRU=;
        b=WDc6UGP9Xk8pCcAw0qAvz+SN/Q4oXI1+yPexmHl8R77PYRUiHxlGBKuZSUVER0JP8D
         3aHqOmJsT24Kb4MD/mIwi1eqHGpd9oDMvpAPzto/0kVUBncMUaYtnVqCVwOhi9uHn4OB
         JpC7mcSp/+enuQ3/IbV7kCxfXacavVbLrMHhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=98QtFZL4VdtHTypPhf4rfoA0vIbhXerE7IjIdxfFqRU=;
        b=a5iuY/3NpOrqcJtdrATq5caq7NvbOi2lt7W0dKdvgt8UmC/j2jNpU2IOmX7yS9oMf7
         2Yp1Hbq5Ql3/0/d80l/mOMxt+Je4s5A0Ber6eB4OF42fBcH4TqMSeRzITQni9iVV8wCf
         z+f469T3jmXTa8FuzD+kWRaY40cvCSSeJfvYJH4ip4XtsChkEz3WziUBoGNpI5wuEQui
         rRuTK7rKnjy9D0arkQb1oN3jITyoVu7i+nm02QWq6m4/eCyF6J16RtUd6nBoJfykh706
         yd2NSE0y2w/xkGMiH0wkWmF2cO6omY8t6mbtRChSxB5axjQiSgFhFwmRUp3Tw1bEO2A9
         r5rg==
X-Gm-Message-State: AOAM533ZlU4q0X2efe+iLs3cQtiDrCNUc1fhnFPMlwIsGwmjvs9WyBEG
        q/fqC4jnFj4jmx+RLF+PzTqtLw==
X-Google-Smtp-Source: ABdhPJxrHJVKhgq5ZsFbpCyhrDXZmY+WlAfnxHbE9Y24jvxFC87nN2HDAIOpr2LxxUXKNUJMLuYXYA==
X-Received: by 2002:aa7:860a:0:b029:2e9:f8cb:489c with SMTP id p10-20020aa7860a0000b02902e9f8cb489cmr6960401pfn.50.1623807038413;
        Tue, 15 Jun 2021 18:30:38 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:da79:71b5:dd21:f72])
        by smtp.gmail.com with ESMTPSA id ms5sm3619169pjb.19.2021.06.15.18.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 18:30:37 -0700 (PDT)
Date:   Wed, 16 Jun 2021 10:30:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Move EXPORT_SYMBOL() closer to vprintk definition
Message-ID: <YMlUOdpMEnTd2RSs@google.com>
References: <20210614235635.887365-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614235635.887365-1-punitagrawal@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/15 08:56), Punit Agrawal wrote:
> Commit 28e1745b9fa2 ("printk: rename vprintk_func to vprintk") while
> improving readability by removing vprintk indirection, inadvertently
> placed the EXPORT_SYMBOL() for the newly renamed function at the end
> of the file.
> 
> For reader sanity, and as is convention move the EXPORT_SYMBOL()
> declaration just after the end of the function.
> 
> Fixes: 28e1745b9fa2 ("printk: rename vprintk_func to vprintk")
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>

Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
