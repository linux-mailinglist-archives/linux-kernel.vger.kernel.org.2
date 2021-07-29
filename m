Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1B3D9A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 02:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhG2Ayg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 20:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhG2Ayf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:54:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE15C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 17:54:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so186001wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 17:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XSg1KClhpY6agnGkYpv/G7LfJe7Hmjfoc58jUe7Kj58=;
        b=TsvSZ7v9WmHKhOgAONXj0WaM3Jej78yWnLkYYP4G16tw9RhDBmHz6PAIFry9fGA9xQ
         03WjBF/e9/FL2uXqw5pQq5CRf188ycNhQcopmPHkJYvy8WjMHSYjBt6EucGrKmjR5YF6
         aWr7DEG/VmCy6c1Nom9cGlSzJtTVNfuTHXwnWUlrareFC17tMh0w1+YiHudxYK6p7fOP
         +Do8Cq7UB4J7wmCvXpE8UvcxeQdNMINakgsOzAps9y74JAafxAep4htIwJEfoB1g0RK5
         QBTxLhHOxXXQ+MBeNZiyHili1gHK1vma2xzNRpWisBnDPoeHlByVtaNjr3ECAaqoYcde
         +Sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSg1KClhpY6agnGkYpv/G7LfJe7Hmjfoc58jUe7Kj58=;
        b=Y9qb5NDfRCrct2WbBfYKwC9y57t7eAISn1ACgtF2Ip9U/oSYgcz8d4VXOvI4z7PvET
         XqZhQM6Nf68tkUqkBCTYyOQuKzASj1tM2/lzmy5fG8MhUEj0XEaho0QOL+1CYtL4zP2s
         8KEf3mXIiBf/ng6548trihRNNEK9p3ri/J6AywEqnbVXaw/M2+cvRjFRxP6xWR9Y9r7m
         HT1L+gKZFSWVSL02TBXPmbrilFSyLM/E4oGsYHA5Qsul9EQjwjb3kHTmmodBj/ok1GdY
         2apspsfDzdksesx1Ol9jfoCJcMGFmxNpys7VPWUnq3wlMopG/Ey+Xdfq8hRgo8SNI4U3
         SonQ==
X-Gm-Message-State: AOAM530244mTQM1Wu2PUeR+HZqUgwQBoWYEiJibxmp9k00h//0yaeBpI
        +uQeY7NgX981gCqAlNCFjio=
X-Google-Smtp-Source: ABdhPJzE4/hNCW5Y57W4WcRPxWQmXg7g/IPEA5r3KiXjfej0nyvqskFFYS8Ax0lwSX5krTBdVjFl5Q==
X-Received: by 2002:a1c:9d91:: with SMTP id g139mr11650562wme.76.1627520071083;
        Wed, 28 Jul 2021 17:54:31 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id t1sm1459628wma.28.2021.07.28.17.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 17:54:30 -0700 (PDT)
Date:   Thu, 29 Jul 2021 01:54:27 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Brother Matthew De Angelis <matthew.v.deangelis@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tablet: acecad: update the reference count of the usb
 interface structure
Message-ID: <20210729005427.GA784014@pc>
References: <20210724205542.GA549014@pc>
 <20210727123756.GL1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727123756.GL1931@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 03:37:56PM +0300, Dan Carpenter wrote:
> This commit message doesn't say what the user visible effects are.  If
> you encountered this bug at runtime then please put the stack trace in
> the commit mesage.
> 

I made this patch based on the following documentation of
usb_get_intf():

[quote]
Each live reference to a interface must be refcounted.

Drivers for USB interfaces should normally record such references 
in their probe methods, when they bind to an interface, and release them 
by calling usb_put_intf, in their disconnect methods.

[/quote]

Thanx
