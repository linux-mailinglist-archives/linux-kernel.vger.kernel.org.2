Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1941C4466AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhKEQIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhKEQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:08:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B715EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:05:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r4so33932443edi.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/9XSUmVfeL2F65GKqEnqUxKeQ+K6LZxcfhr/8BVOcI=;
        b=ho2vIDOcj5SGwiCkHetNF1PyFjrRp62kIicNG8nQ/fxyewVpuPImxslpC3dKDDVUSw
         mqVRZ+qLK0uqhwVdhUXWN9Uov5SnXubnJMQf/bwe3tVRLayfGOGjOe5iXcIwEPMZinxr
         jflmiTRtVngpe8khXT0BMn/hZErrLgbGkZfVra700F8lCIUERlqLo/MsyJ5QcmjGZwpJ
         3coozNaiuzE86PnjuyGjKfP2VVjOFgSm9+aEDP+5F4G+YSjWVPmDdCKYOlTlQylho5Oj
         VysuTPFMfojPebhnJ37YhWZKhx28VaQchXXk1W4jQId8eE2NR2Z6uY1d5B8Wz7Ez5ltq
         LrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/9XSUmVfeL2F65GKqEnqUxKeQ+K6LZxcfhr/8BVOcI=;
        b=zwExfRM/VhkM4pFjGNnfV9amRDqz7rcMRLx4IOB2kTN0gMFerVIlbTlEhtu0bLTytr
         86Oc4njl1OttgXf54Oc6taKavIXzVDba96zr366+Mk8OWrXxB+O5+zIIr8o25LktQvQ3
         d3+ERTCSgsND/r6rn4fGqcOm4Js5SgB6PF24ItokkU4Jnn9su7wBoEg3+2RuFF7a3etH
         UwlKIYAsuWRwFszHhsVLUeGQPiXHFXipQNsvcaMGduvYw/gIgpxLLs71xmCCrvsx69ka
         hd0RlX34idigayGd1SFDvCTheLF/O9COhFI47d5nlbohr+F22tY0Ah1iUtSEsjrjp1jB
         WYKw==
X-Gm-Message-State: AOAM531T8x2D9MeGYQfeKsrkGvRT6y9cwvEgEK4ViHohHb5aJw5eesgy
        5Aj4X6wUMe/QRCaUOK/jqCE=
X-Google-Smtp-Source: ABdhPJzLwAReC40Xz1FLehEy0qNjdUqom7UHdvUzVfRuQ1HvGDdWoEefz7LJmZ7QpIuQ0uWvpkQLJQ==
X-Received: by 2002:a17:907:c0e:: with SMTP id ga14mr12653619ejc.26.1636128327296;
        Fri, 05 Nov 2021 09:05:27 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-54-101.retail.telecomitalia.it. [79.56.54.101])
        by smtp.gmail.com with ESMTPSA id gv34sm4301932ejc.104.2021.11.05.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:05:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Fri, 05 Nov 2021 17:05:25 +0100
Message-ID: <2849185.MRNcFvI4iY@localhost.localdomain>
In-Reply-To: <20211105153633.GD2026@kadam>
References: <20211101191847.6749-1-fmdefrancesco@gmail.com> <3198013.HnMX8GfXRX@localhost.localdomain> <20211105153633.GD2026@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, November 5, 2021 4:36:33 PM CET Dan Carpenter wrote:
> Oh yeah, you're right.  It never *just* does spinlocks (as stated in the
> commit message btw), it does spin_lock_bh() which bumps the soft IRQ
> count.

Thank you very much for checking and confirming.
 
> > To summarize, I think that using in_interrupt() in the old wrappers was 
the 
> > wiser choice.
> 
> "Wiser" is not the right word.  The wrappers were always stupid, but I
> guess they did work in this case so the fixes tag is correct.

Ah, sorry. I was not able to express my thought properly :(

I agree with you that the wrappers were a not a good idea and Larry did well 
in removing them. Furthermore, I think that delegating the choice to use 
GFP_KERNEL vs. GFP_ATOMIC depending on the return from in_interrupt() is very 
bad design and it adds sensible overhead. 

I used "wiser" is a stricter sense. I meant that, if wrappers were needed 
(but they were not), in_interrupt() is "wiser" than "in_atomic()".

Regards,

Fabio M. De Francesco   



