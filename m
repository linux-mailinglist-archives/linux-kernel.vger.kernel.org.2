Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8AF32AA47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835549AbhCBTRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346422AbhCBQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:40:43 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638EC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:39:29 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id l132so19616516qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=FTYS/gGQXuQUykvugtvVUaArYSWZk1KmkM7/lBX9KnI=;
        b=XcPA4UgV3FSkVD7HnWyiJs1UjNSVvbnIZZEiLazXuKrAca6Udxs7/FCapU+v+UHRzo
         iR+IFg1ZefZz7iH34wUECqBF1kDi9jT5eBf3AV7TrYMMSoxVOUHbc1TYZHVmaeRMefbP
         eyJmo4QL58JebQYzT3tAfTseXYKdx0XmElgsN4ZWbgOplW/UYyfw7YFKYWH5u4eiP7nH
         UYbbSVnTuCRgvS1XnpYzgJvX1lGJ5DH6sk9W9EwIJk0OzCUfPq5ioiD10W1xuL+pDLwx
         m3s2SpBAPV19ZUDhXQqWNAAN4C9eoyJfXjM5q0N0UwsNIlgIhYDh1UAYb/7bgMG2JsE5
         4SXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=FTYS/gGQXuQUykvugtvVUaArYSWZk1KmkM7/lBX9KnI=;
        b=jk6IJlcJzQ6CjoVwkapYc0Dj+DgkVyVxqHiPP+2N56z9t8Xh7zQIJOPzjc9tTGZKqF
         gc/SASO6sJ5o6/ogQCjOevq2MY15bldGnWscm+qfXr2EsthhIiE/kZQSZoOMUO0tSFKZ
         eVAILso02zSaqkCYlaYD1/AnJ6817Vaz3JyvzN3oqJsGmnVjqDXqkgel6L2de4vADMIM
         nLE+J6BaF0C+Am/YMv2RraMX0bqv0yE3GFcNoUQgcHb+yU1pZD5MeQP7SHopMjYaaZ8Z
         J0pm63c9aF/0qSMKC5yT0zO6M4PCbP/9xkULfk0DJV8StCRkuu4+tWIkGEEqSPqpB8jU
         hrIA==
X-Gm-Message-State: AOAM531qRpaTiq+2Kce3xatxp9qP0qQJIw8cA/F0s/OMLCFWv6w5+moV
        SwbAV5/j0pZ6OHFhwZJ9B9s=
X-Google-Smtp-Source: ABdhPJzfd1h0pWXTYy5ZX3mPU67nNIUp16pHxletvY/YfIogRibciMc0YpESRkTqJ9P/9aqV289yUQ==
X-Received: by 2002:a37:7985:: with SMTP id u127mr539754qkc.333.1614703168575;
        Tue, 02 Mar 2021 08:39:28 -0800 (PST)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id 61sm14879qtb.53.2021.03.02.08.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 08:39:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 02 Mar 2021 11:39:26 -0500
Message-Id: <C9N0I288RXB0.KYS5CPR3BBCP@shaak>
Cc:     <geert@linux-m68k.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Vinod Koul" <vkoul@kernel.org>
References: <20201211191241.21306-1-liambeguin@gmail.com>
 <20210113114941.GD2771@vkoul-mobl> <C9BWPQC23WXC.2TUP0Q9J7VAX5@shaak>
 <20210219075837.GX2774@vkoul-mobl.Dlink> <YD5ps6h3rR/O915w@vkoul-mobl>
In-Reply-To: <YD5ps6h3rR/O915w@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Mar 2, 2021 at 11:37 AM EST, Vinod Koul wrote:
> On 19-02-21, 13:28, Vinod Koul wrote:
> > On 17-02-21, 10:22, Liam Beguin wrote:
> > > Hi Vinod,
> > >=20
> > > On Wed Jan 13, 2021 at 6:49 AM EST, Vinod Koul wrote:
> > > > Applied, thanks
> > > >
> > >=20
> > > I can't seem to find where this was applied, could you point me to th=
e
> > > right repository?
> >=20
> > Yeah I cant find the commit in phy-next. I will apply this after merge
> > window opens.. sorry for the miss
>
> Done now, it should be in linux-next for tomorrow

Perfect! Thanks again for your time,

>
> --
> ~Vinod

Liam
