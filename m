Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FBE44B47D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 22:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244946AbhKIVNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:13:30 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:42233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244936AbhKIVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:13:29 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MqJuN-1mO7bl04NH-00nULT for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021
 22:10:42 +0100
Received: by mail-wr1-f42.google.com with SMTP id s13so265358wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 13:10:41 -0800 (PST)
X-Gm-Message-State: AOAM533cDyY8aG/itofyma7Vo03K9gA0+0QLzH4g6Md8oERinM9e94ta
        utS5rbPypAocfkxtUKJsLcVArXQTtSqWOmnvIV8=
X-Google-Smtp-Source: ABdhPJwz5ivXzVe+sj4hFq2BV5qorjnjOJBJuVHaJtIigROYaCMrlzF4ZqrmVNOhpSjEmGQjAl4UCw4Pc5CRHcWs1TQ=
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr13303414wrq.411.1636492241674;
 Tue, 09 Nov 2021 13:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20210706163033.795805-1-benjamin.gaignard@collabora.com>
 <a1df40c2-f414-56e9-2e42-83e28ad54cee@foss.st.com> <8a1ecd56-5690-7f0b-9c7f-92ff4ca46120@foss.st.com>
In-Reply-To: <8a1ecd56-5690-7f0b-9c7f-92ff4ca46120@foss.st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Nov 2021 22:10:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a34h_k_y4Xniw=+7DubMgNS52aXpXFjo-kN4JUg1rb=KQ@mail.gmail.com>
Message-ID: <CAK8P3a34h_k_y4Xniw=+7DubMgNS52aXpXFjo-kN4JUg1rb=KQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Benjamin Gaignard maintainer status
To:     Philippe CORNU <philippe.cornu@foss.st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philippe CORNU <philippe.cornu@st.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Hwg8Ug6Tj2eqlC4ySXYu2VRRH9x7IjHyy7HvJUTcWZMDfAgWmSm
 tmJCGAF2bBWtaxj4l6WOqUmz/cdsbms4I6v9zgg55lzsHI4f8ilDGjahNyUj46GwVmz4DE7
 gwxh5/CfijOQSfrI5mD1AsLwWc59TBE3xaRN+St6YJBV9TuxBs7/2FoeuVHHbcjji/Ukquw
 mSNb9JnjQi4vNstB1l26w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zZYy8y0sO0s=:JOfWyVRZ0Kvo0S7BSqxD6S
 af/eou3CVPzIwNpbNv2k5KEElz+ufeo+G8KoEjEjK1w5/vt+ayApx5Pq/s8f5LXtFjfLVgvq5
 Hu39YspcJ+qTDPfWVy9DKqrx6dg4iTDBegZGzo5yzvCZzf8Sq/2ceiztjv/e5L9uURYZwQKZU
 hG+ARiJ061dIkLPBqjpfgIHQxYhDwwzHvg7gQh7Xx5Y97pBykXP5V/KwDu55sv3jp8IAFfUuL
 GeKNDcJpDDnsCkicLUsy7inQuz9twqWp5WIMDu0lb7NuXL32Orar1UiiZV0Z7k6PK54+zocyz
 DPswLuYrNFppK21eMIeUAvVo/KEfXbesWD+jR4OaB2KOluk2gxVCpSIXhZK38lMdCer5tU/5R
 CIp48uDhg/LFL1jnZ0bXj1UsH3P7KOrv0VO5oKvK0Vr0aiSzlKeWDuDGLoFpeCLjMZWhDPD/N
 NZ107h9y8l/HdbQrTKLwY2deziGv5jNNnRwhiGv7hyvHLqeq2HB1zSqQHQ4CmB1bgB9hmeZEJ
 Vcod/idJTTv49HkeUXcUPi7XLISoBs+NoxR4zW1FdMA5bsyWe0Jpj1/i+atReh1+I5yEsXOd/
 Xf24WLg3p4XH70Z4xRSSmtNbUMa52VwEXx5TwczR5abgCyyhG6NR5xMFfYJe9oD5ZWI3XfrPL
 UnWymJNoaT7KnypsEVojwfI2l4xbM8TJA6JyDBClK37FWfMSMOhoMOwfGEKVfXyS8kDs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 6:15 PM Philippe CORNU
<philippe.cornu@foss.st.com> wrote:
> On 7/23/21 5:48 PM, Alexandre TORGUE wrote:
> > On 7/6/21 6:30 PM, Benjamin Gaignard wrote:
> >> Update Benjamin Gaignard address and remove it from no more maintained
> >> drivers.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >
> > How to handle this kind of patch ? Do I take it or do you take it
> > directly through arm-soc tree ?
>
> This is a kind reminder email ;-)

Sorry for  missing this earlier.  I'm happy to take updates to the MAINTAINER
file as bugfixes, please either send these to soc@kernel.org so they make it
into patchwork and I don't miss them, or put them into the normal soc updates
for the platform specific pull requests.

          Arnd
