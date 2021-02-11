Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3425A31894B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 12:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhBKLUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 06:20:32 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35017 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhBKKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:51:25 -0500
Received: by mail-ed1-f54.google.com with SMTP id g10so6489209eds.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0m6ZYdNg9bPuLZo7iX6eWN4cNFxLWh6FNh/M1D/UdU=;
        b=Y1j/VzVMKV7EIIVGjMcQ48JcwVsMERxwYdoodjSmjmdUuFKUTLpyEWIB8SGiqOCznn
         beUTubBPgZX1G/V1LrfBhobtfWUWkEmQ/9MqDOlMwB51MeuM2YRJ+BkDEVcXEyF7qeLm
         L05p4eo1ALAn55V+5kreeSdio7gfrlbtnrDVlRAOWQbnKfHO2y70wK3NJ+Ts3xcguulJ
         wXDUag+teG916SjQmO4EGGWzHZIxLo2MvUOM0Aup6cztax3u4qx2fPG144p8UQwZ8mYn
         SljzMuAo6lWrJojFM26MaevctqN4TIUQ0cVx2b3ZZFoo8Ru9nkYcTaQeNkZvZOJVOAtC
         U0ow==
X-Gm-Message-State: AOAM531hHCgCDdDDDH1jJZ0GDL9GaFP5+JBdZMVYqcpgHeiVyfIH7p+G
        ktqmNsbAj/63qM1crwcE/n/fjPhD7XEq2A==
X-Google-Smtp-Source: ABdhPJxEaXFcU1SCOaEvQtj4XhQNd66yFyZ5EaDEwCxzg9vvwCqZ+8s8w5nFP6++Fv0wwBx1mq/PWg==
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr7700455edd.92.1613040643283;
        Thu, 11 Feb 2021 02:50:43 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id c16sm3866120ejm.86.2021.02.11.02.50.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 02:50:42 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id w1so9296792ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 02:50:42 -0800 (PST)
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr8020838ejb.355.1613040642341;
 Thu, 11 Feb 2021 02:50:42 -0800 (PST)
MIME-Version: 1.0
References: <YCQvsdlnbnQN4Ruf@karthik-strix-linux.karthek.com>
 <20210211075715.GD2696@kadam> <CAJ5zXr3ONFFHL7g8Xt=BjM9SJK16HEwiqhkBPTbrBTwa=DDqog@mail.gmail.com>
 <YCUK6Bi9lFziF6qG@kroah.com>
In-Reply-To: <YCUK6Bi9lFziF6qG@kroah.com>
From:   karthek <mail@karthek.com>
Date:   Thu, 11 Feb 2021 16:20:30 +0530
X-Gmail-Original-Message-ID: <CAJ5zXr26co5c5kCFqGN2Rt3Kbk+i5GKAsvzgF-4Zz3jg0xZ+bw@mail.gmail.com>
Message-ID: <CAJ5zXr26co5c5kCFqGN2Rt3Kbk+i5GKAsvzgF-4Zz3jg0xZ+bw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: remove obsolete commented out code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 4:16 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Thu, Feb 11, 2021 at 04:00:04PM +0530, karthek wrote:
> > Should i send them as patch series?
>
> Please do.
>
> thanks,
>
> greg k-h

Yeah, it is clearly mentioned in lfd103 which i do remember
but i want you to know that it's purely accidental
