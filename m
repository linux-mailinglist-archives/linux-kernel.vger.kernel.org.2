Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7893E44AB81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 11:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245325AbhKIKdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 05:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245323AbhKIKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 05:32:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928BCC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 02:30:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t30so32087627wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 02:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=MfHxJl5a6auNvNFSJ7rg1Gf81R9mZfjH7HTWxoZ/5G0=;
        b=0/vArSvCwEu3G9LIyqv5w8ArrzCbHLtzXuKaog7D4my9z8GI1I9RVqTMwLeTPkeZWM
         mW4I5lBV7rFZTY8olzrkDgcE55U6BiaIBKdF/Vr3JqlgRy+jGxTGeuxtwCyVSaMFm6ry
         FOKxFRTjfd11wb6i75STiqoqpwhhNCRakWeIbiWt0LLhty13cRsMR1dJSRIbRlSlGpsR
         wHDf8LkYUo/cBCkx4FNFGobOUJik483qiT0AyF+5mD9sjlorkzvSSp/f/0hY9Jf6VPtF
         9Ibs57mwkqTfKmYK3vLqI+D4d2dpEsvrdy7NFFjSGaggmpJhDVW56xprcwmAcGKFXo9L
         mAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=MfHxJl5a6auNvNFSJ7rg1Gf81R9mZfjH7HTWxoZ/5G0=;
        b=uba03OP/vVjhJOrPm/l2lNVf7ksEQmp5TZL0i5qOLtY0ElRnILYybgcXnK8r7cWPMl
         AsFT9us2BGEv8sGH7yjV1/XmYJr7xdU3qrrY6Q9XBD0BjzsgQUnTfM+17Zvjdwhayhdv
         DAAseVjJBhoGDflKHFttAb4hT7w1XSzqJJb1wNTajmRYA8lMYq3wo7t4HMhCX6iteKJr
         WyLZkUo2ykfPvZp7gXCzSAzOIQkcedAfFyU+aPitj4ydRCN4UKDXHHZT9WkkKbHepxa8
         fy1tKxbyDg+gQPsGnJ/FvnOrRu8AwEAQfDcNLzkXLmD8ozZ9QUJkUN02Vyp7ZV24TbnC
         2gEQ==
X-Gm-Message-State: AOAM533vJZoJ6EVRWq2KtoNfK+DjKEf4qt4l/rOWhWgSfWC3RYj5FvUm
        V4OHCXRzLJL01P3nFyYiutp5aQ==
X-Google-Smtp-Source: ABdhPJzN8THOHqvkX+1aIcikWUkFt1UOpd4MA5jJv58ReOK0cNxpt57XaqOcBPqkiLMdgU8y+axNGA==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr8047576wrn.335.1636453808864;
        Tue, 09 Nov 2021 02:30:08 -0800 (PST)
Received: from Haruhi ([185.254.75.37])
        by smtp.gmail.com with ESMTPSA id t9sm21192654wrx.72.2021.11.09.02.30.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Nov 2021 02:30:08 -0800 (PST)
Date:   Tue, 9 Nov 2021 11:30:06 +0100
From:   Philipp Deppenwiese <philipp.deppenwiese@immu.ne>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        "=?utf-8?Q?akpm=40linux-foundation.org?=" <akpm@linux-foundation.org>,
        "=?utf-8?Q?linux-kernel=40vger.kernel.org?=" 
        <linux-kernel@vger.kernel.org>,
        "=?utf-8?Q?mauro.lima=40eclypsium.com?=" <mauro.lima@eclypsium.com>,
        "=?utf-8?Q?hughsient=40gmail.com?=" <hughsient@gmail.com>,
        "=?utf-8?Q?platform-driver-x86=40vger.kernel.org?=" 
        <platform-driver-x86@vger.kernel.org>
Message-ID: <C7D4E238-04FA-4C96-9D54-89CD649B6CBC@getmailspring.com>
In-Reply-To: <YYpMTVP/dWsyxMSt@kroah.com>
References: <YYpMTVP/dWsyxMSt@kroah.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region
 via sysfs
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

sorry for the previous html email, totally forgot kernel ml was plain
text only.

Just some feedback regarding the use case for the interface. As you may
know the firmware (BIOS/UE=46I/coreboot) is growing massively in the last=

few years. So we have now 32MB of firmware on a normal x86 system. The
interface shall be used as safe and secure method to get the first 16MB
read-only copy of the firmware. The interface from Intel is read-only so
we shouldn't introduce any security issues here.

Aside from us there is fwupd.org=C2=A0and another company which are
interested in the interface as well. We have added Richard from Redhat
to the CC. We use the interface mainly for firmware analysis and TPM PCR
pre-calculation features in our SaaS product.

I hope that resolves your questions :).=C2=A0Let me know if you want to
discuss more.

=40Hans-Gert can you deliver the documentation, otherwise I can help out.=


Greetings Philipp

On Nov. 9 2021, at 11:24 am, Greg KH <gregkh=40linuxfoundation.org> wrote=
:

> On Tue, Nov 09, 2021 at 11:06:07AM +0100, Philipp Deppenwiese wrote:
>> Hi Greg,
> =20
> <snip>
> =20
> Sorry, html email is rejected by the mailing lists.  Please fix your
> email client to send text-only email and I will be glad to respond.
> =20
> thanks,
> =20
> greg k-h
> 
