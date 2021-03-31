Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76C934FF66
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhCaLXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbhCaLXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:23:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84284C061574;
        Wed, 31 Mar 2021 04:23:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so966931wmj.1;
        Wed, 31 Mar 2021 04:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RRmAqh4LFPikloAYlKI1ZJUSv+UwDdN6QqlklA5k02E=;
        b=klD1crcg/d6wpdPKSGJftJ6MU73ROiZhr5z+6F0v1nPdzZutjKpVslUbhVs2F39wf/
         MQ7TWXMFQlZOB2rGY/mpkaEEdTh+fo/WdFqZ/c+WDYh4QohdCgEpVBslMWQm/cdt+Jhg
         rAXzZy4lF3BDEIB33e671+kQw6rJfOaOkCF3gtkuhuzACaDXmOKb58AkGwy2dZ1EDAC+
         9T9z5uDulq8T+JfA+HtlIlHdDmvxGkm2xVYLgpN+1lFTlku+1Knw+SKMGmouQvENT78k
         0SoL9RjVqZUbSjUcH/5+QdBBAq5QxHmerW4RcfbEO7EBSR+P6vYXMewmfb8zPn5KXk/q
         wcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RRmAqh4LFPikloAYlKI1ZJUSv+UwDdN6QqlklA5k02E=;
        b=HXx0fov1BsQlktNDwU4cTuR25tsgLp7zWblYgMzLVHGEE5NXiRGJTeFdokuAJKwxGC
         GE87L+oX2am89ScWhTnhCQNudMHpFfjJiOUUpQgO543hIfuZDeEFGMVZJzutcIUT6s1I
         Nc47X6fL0z5nKPHLjaNlHAjXExvJiwR+Hl6mSVe6NiSpz/uRKH2gGi+G9T93dkR8tvVe
         xrPz+q+pB4Wzs+Z2WWgtO0LVF3DsiP6LBTd5ytNa9D9Hj3xT2eBxIBQDdJ1Al1l1jpMI
         2tV+uYZ7NN31CAqlOTmWDHfqdejAShbf3sS26MOTSUL8kC4i6VFbmHfjWI7R1KULBpvt
         Bgsw==
X-Gm-Message-State: AOAM530BvXkP0hKjXGlZn6Vb0wkg5lTjBVWNzcgIGvZSp10cxiz6brTx
        YJ4sS+2a7VWUmXXT4gB4qKY=
X-Google-Smtp-Source: ABdhPJyKBZ0CremFIugIfEnK8kCB9DNn2JSkm2NEQmqoSXiZftwrEk8j7x7Yxxv7QFU2iyxRVkESFw==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr2739630wmq.143.1617189793338;
        Wed, 31 Mar 2021 04:23:13 -0700 (PDT)
Received: from 192.168.10.5 ([39.46.7.73])
        by smtp.gmail.com with ESMTPSA id r206sm3569252wma.46.2021.03.31.04.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 04:23:12 -0700 (PDT)
Message-ID: <65e6931b2a15e4685eb0c3b7873a197ba025d50d.camel@gmail.com>
Subject: Re: [PATCH] usbip: vhci_hcd: do proper error handling
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu
Cc:     musamaanjum@gmail.com
Date:   Wed, 31 Mar 2021 16:23:07 +0500
In-Reply-To: <b2aabe03-0cd9-fe59-5354-0596e3360402@linuxfoundation.org>
References: <20210325114638.GA659438@LEGION>
         <b2aabe03-0cd9-fe59-5354-0596e3360402@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-03-26 at 14:24 -0600, Shuah Khan wrote:
> On 3/25/21 5:46 AM, Muhammad Usama Anjum wrote:
> > The driver was assuming that all the parameters would be valid. But it
> > is possible that parameters are sent from userspace. For those cases,
> > appropriate error checks have been added.
> > 
> 
> Are you sure this change is necessary for vhci_hcd? Is there a
> scenario where vhci_hcd will receive these values from userspace?
I'm not sure if these changes are necessary for vhci_hcd. I'd sent
this patch following the motivation of a patch (c318840fb2) from
dummy_hcd to handle some cases. Yeah, there is scenario where vhci_hcd
will receive these values from userspace. For example, typReq =
SetPortFeature and wValue = USB_PORT_FEAT_C_CONNECTION can be received
from userspace. As USB_PORT_FEAT_C_CONNECTION case isn't being
handled, default case will is executed for it. So I'm assuming
USB_PORT_FEAT_C_CONNECTION isn't supported and default case shouldn't
be executed.

> Is there a way to reproduce the problem?
I'm not able to reproduce any problem. But typReq = SetPortFeature and
wValue = USB_PORT_FEAT_C_CONNECTION may trigger some behavior which
isn't intended as USB_PORT_FEAT_C_CONNECTION may not be supported for
vhci_hcd.

> thanks,
> -- Shuah

There is one line wrong in this patch. If we decide to proceed, I'll
send a v2. Please let me know your thoughts.

Thanks,
Usama

