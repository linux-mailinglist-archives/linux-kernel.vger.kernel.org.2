Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96022407B4D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 04:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhILCYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 22:24:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:59645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhILCYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 22:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631413393;
        bh=2OrY0DwyHkIGXldAxAqQ9NaR0MZzQZBdxxhf+vKyogU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Nz+yee1xzy9EfT1EFmmkBWCCqJjhSK/aToSMwPKVB7xlYbnoKYFGgFIExanJU+h6e
         4//UwOzFZA0K208ZD5Po8MEbwoJ2HMZmJAw0ARsvjl9eTay0kHv4XJvzYU3/vdPpaw
         Ud5HB0qn+/SAxNyValb4IYQAvBGMpg0ynThnZI1I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.102]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1nC0JP3ofr-00wEYC; Sun, 12
 Sep 2021 04:23:12 +0200
Message-ID: <51815fbe3e864a0177445b9b17d018a42d603e21.camel@gmx.de>
Subject: Re: ksmbd,transport_rdma.c: Don't include rwlock.h directly
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Hyunchul Lee <hyc.lee@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>
Date:   Sun, 12 Sep 2021 04:23:12 +0200
In-Reply-To: <425df999d02a62af13da8e77dbed0f2be750cda8.camel@gmx.de>
References: <425df999d02a62af13da8e77dbed0f2be750cda8.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.41.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/YQtlIyrzTXuD9cB8JwBXAP/0Oe+pwXufQeWxdUj6b818yiT7uI
 4Al0PCYfPZZ3IVCgKyACn4AEkyVHJVJ1MWOUKrFc4pyJddZY1FIAfmb/799uKmVBHVAi///
 RgySwU+GQVdoeoJWtiKxQplJlWpCjXBf8J7MEo5cxdcD3lNdxXvg1uXzmybNAAagOTJzoc7
 uEJIZCxnJ5icCujwPzHcA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kZPgbZiA1Es=:fHzi20ed6ijxvWlozoHf8d
 ugrypxfy4xlbTAq9eQDwHZs6Ic44S4Z/7NOj/vru0LG9wWDbJAih0SzXvVvvT15ylAj2Th3xJ
 HQgGr9AQguAOOfGYdkVz148nUlnjLkwNDPscmCvwToNW7r3yElhvpap3zC9jGgHdqCqm2tCS3
 4cQrf4UpgaBEdmRdneKxTRJUKluyknoKbT8i8OGby1XWXlfOw23zEGWk3vqmfo65/2z6R6hCB
 780IFGSrrDZ1H/TbXfQgZCmMsBWbBeEkMKJuYHLOEEHe6dQIgxwp/0ejklpga7oNktX6mBtgE
 3BMmddrXFQ6Bk+xRAM2roVnSPZRzmH7AZJs9IWqoWIediwg5TdURd96YRzqfCAWx+nvxVhNpp
 c8eMmkOy70EzfXWtcMxmENCzvl6fJXuTusdOgdVApwMUcLHgz5FLIl3lS6UlPE6zqVzEoKVbe
 EwXLhXeNNgw2QhE0AJ5g6jMCJhx4JKkSQA3f7hZYayUNylusJkI2Yhx0SfdTIHiHtqOkOnyOa
 RPoLWBRcX/jF+0jbxdTv65aJaWpfdL4zPxblVlDURmwHVatqX3UdlrdA7FHqAmc9sxgmGyfD8
 Q5dJ1tsfbglBJ8ETSqx1vNzk9JZto2B1vzvtAHh939UQ6nAQKIBKKkFOIhrmWXaxJW8Ce+lbn
 IKzakNUGsgC3vr19Lc22XEK+rf7ZmscU7KACcI/nLFy1tY2qHuVgM2mUyPWsAmhM3uixd+tRh
 FRG45qeprLFmlEwaCCidLsgwnm4f418y92/NYIsNH+m8+Lf3xuS3vUOV1MmyRLDTiniWrvUpW
 wQ6MxrGQDM5IKJUM9JVnYF3qaO/997tHDflDeRh++GHcJUVLb67poWD4ILi0fsBQvilVpjchJ
 WWvgbeBv6WlmOinX0n+c79hCCj1xnCxy5bB8Rc7k9w+ywIC+yKIJhSBxow4nGmqAHWDs0FccE
 U7+CIBaNPuoy9sK7UhHdwITvpRgXDoj6cXwqNFmM8OMYfYA4q9ru7q+2592mAvgE63kXT/htD
 ETve9WK5v1Eh2n9Puz1/eW0jF25ylcA1M1fUEwta9UyaGSdQlIzuxBgvXhDWgf8Fb1PdSultS
 0QrzJjD8mL24rU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typing hard.. Thag forget type [patch]

On Sun, 2021-09-12 at 04:19 +0200, Mike Galbraith wrote:
>
> rwlock.h specifically asks to not be included directly.
>
> In fact, the proper spinlock.h include isn't needed either,
> it comes with the huge pile that kthread.h ends up pulling
> in, so just drop it entirely.
>
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> ---
> =C2=A0fs/ksmbd/transport_rdma.c |=C2=A0=C2=A0=C2=A0 1 -
> =C2=A01 file changed, 1 deletion(-)
>
> --- a/fs/ksmbd/transport_rdma.c
> +++ b/fs/ksmbd/transport_rdma.c
> @@ -20,7 +20,6 @@
> =C2=A0#define SUBMOD_NAME=C2=A0=C2=A0=C2=A0=C2=A0"smb_direct"
>
> =C2=A0#include <linux/kthread.h>
> -#include <linux/rwlock.h>
> =C2=A0#include <linux/list.h>
> =C2=A0#include <linux/mempool.h>
> =C2=A0#include <linux/highmem.h>
>

