Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC5633FC9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 02:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhCRBVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 21:21:13 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:57546 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCRBVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=I23IJ
        tqkog6tF5WToYLuQP6LKo1y3wD29cfUp1lWilg=; b=JniNf8y7rnkwr29OCvXgN
        ZinJygUNYTd6OzE9Ks4sEZqhexZsMh31wBh3mIdzERMHLKuDJVuhhYM0QhnJQuFR
        8Wb2XRRB4yfy+n10xEW4mV5byjj3TZXZrVlWL8xKK2QR+BqkOb3yBW0keosMDs18
        +OnNaY0v8z8ETYa8a9hSGM=
Received: from localhost (unknown [218.94.48.178])
        by smtp4 (Coremail) with SMTP id HNxpCgDX1zzzqlJgEQpfEw--.2926S2;
        Thu, 18 Mar 2021 09:20:52 +0800 (CST)
Date:   Thu, 18 Mar 2021 09:20:51 +0800
From:   Guoqing Chi <chi962464zy@163.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org,
        chiguoqing@yulong.com
Subject: Re: [PATCH V2] iio:imu:mpu6050: Modify matricies to matrices
Message-ID: <20210318092051.00005153@163.com>
In-Reply-To: <ccaa6038-0b52-9b3b-f50c-f63ddf3a8747@infradead.org>
References: <20210317061930.478-1-chi962464zy@163.com>
        <ccaa6038-0b52-9b3b-f50c-f63ddf3a8747@infradead.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: HNxpCgDX1zzzqlJgEQpfEw--.2926S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw15JFW8Kw18Xw43Zr18Zrb_yoW8Gw1UpF
        4kGay0ka18G3WUK34ak3Zayrn5twsIgr17KasrAr4ku3sIvFn2qFs7K3W8KFn7ZrWUGw4U
        ZrZFgr4ruan8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbnYwUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbB9wRZRF2MYOiUZgAAsF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 08:24:33 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/16/21 11:19 PM, Guoqing chi wrote:
> > From: Guoqing Chi <chiguoqing@yulong.com>
> > 
> > The plural of "matrix" is "matrices".
> > 
> > Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>  
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

Sorry to my mistake.
I will add this for patch V3.
Thanks.

> 
> > ---
> > V2:fix "complex number of" to "plural of".
> > 
> >  include/linux/platform_data/invensense_mpu6050.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/platform_data/invensense_mpu6050.h
> > b/include/linux/platform_data/invensense_mpu6050.h index
> > 93974f4cfba1..f05b37521f67 100644 ---
> > a/include/linux/platform_data/invensense_mpu6050.h +++
> > b/include/linux/platform_data/invensense_mpu6050.h @@ -12,7 +12,7 @@
> >   *			mounting matrix retrieved from
> > device-tree) *
> >   * Contains platform specific information on how to configure the
> > MPU6050 to
> > - * work on this platform.  The orientation matricies are 3x3
> > rotation matricies
> > + * work on this platform.  The orientation matrices are 3x3
> > rotation matrices
> >   * that are applied to the data to rotate from the mounting
> > orientation to the
> >   * platform orientation.  The values must be one of 0, 1, or -1
> > and each row and
> >   * column should have exactly 1 non-zero value.
> >   
> 
> 

