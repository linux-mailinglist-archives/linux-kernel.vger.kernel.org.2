Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAB33E985
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCQGKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:10:21 -0400
Received: from m12-14.163.com ([220.181.12.14]:59900 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCQGKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=4uTr2
        NHU0DRrt8kmD1K1YVcf8+DMINggkKvcHPoX/9M=; b=hUJeWqc1TVaxW9uD7TLHn
        6NULUctL13kMg35Amua8vXVosi2IWHRfDK/VohKO46Q7Ep3jKejnVPm8IEIIqN8M
        VKrcYxjq6hZyo9yVH3dokSM8pTL/tKHRZ9H29FbTY6rP5I4bgq1oBOxkIttqqQ1u
        5woEgkb6CLlNpHh5/oGaO0=
Received: from localhost (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowAA31rQYnVFgPTFMpw--.57114S2;
        Wed, 17 Mar 2021 14:09:28 +0800 (CST)
Date:   Wed, 17 Mar 2021 14:09:27 +0800
From:   Guoqing Chi <chi962464zy@163.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     jic23@kernel.org, linux-kernel@vger.kernel.org,
        chiguoqing@yulong.com
Subject: Re: [PATCH] iio:imu:mpu6050: Modify matricies to matrices
Message-ID: <20210317140927.00002761@163.com>
In-Reply-To: <23d4b482-212f-dde5-dc83-7401b14f3638@infradead.org>
References: <20210317024102.419-1-chi962464zy@163.com>
        <23d4b482-212f-dde5-dc83-7401b14f3638@infradead.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAA31rQYnVFgPTFMpw--.57114S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryfXFW7GF1fCr1fAFWkJFb_yoW8Xr1rpF
        1kGay0ka18G3WUK34a93Zavr1ktwsIgr17KasrJr4ku3s0vFn2qFs7K3W8GFn7ArWUWw4U
        ZrZFgr4ruFn8ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjOJ5UUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: pfklmlasuwk6r16rljoofrz/xtbB9xBYRF2MYOCsfwAAs5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 22:04:33 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/16/21 7:41 PM, Guoqing chi wrote:
> > From: Guoqing Chi <chiguoqing@yulong.com>
> > 
> > The complex number of "matrix" is "matrices".  
> 
> (I would say that the plural of matrix is matrices.)

Yes£¬your suggest is better.
I will resent patch V2 for this.

Thanks.

> 
> > 
> > Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>  
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
> > ---
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


