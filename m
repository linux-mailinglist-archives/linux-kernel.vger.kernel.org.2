Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF63342F0B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCTSms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhCTSmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:42:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D456192E;
        Sat, 20 Mar 2021 18:42:17 +0000 (UTC)
Date:   Sat, 20 Mar 2021 18:42:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guoqing Chi <chi962464zy@163.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        chiguoqing@yulong.com
Subject: Re: [PATCH V2] iio:imu:mpu6050: Modify matricies to matrices
Message-ID: <20210320184214.519a9e20@jic23-huawei>
In-Reply-To: <20210318092051.00005153@163.com>
References: <20210317061930.478-1-chi962464zy@163.com>
        <ccaa6038-0b52-9b3b-f50c-f63ddf3a8747@infradead.org>
        <20210318092051.00005153@163.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 09:20:51 +0800
Guoqing Chi <chi962464zy@163.com> wrote:

> On Wed, 17 Mar 2021 08:24:33 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 3/16/21 11:19 PM, Guoqing chi wrote:  
> > > From: Guoqing Chi <chiguoqing@yulong.com>
> > > 
> > > The plural of "matrix" is "matrices".
> > > 
> > > Signed-off-by: Guoqing Chi <chiguoqing@yulong.com>    
> > 
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Thanks.  
> 
> Sorry to my mistake.
> I will add this for patch V3.
> Thanks.
Please make sure to cc linux-iio@vger.kernel.org

Thanks,

Jonathan

> 
> >   
> > > ---
> > > V2:fix "complex number of" to "plural of".
> > > 
> > >  include/linux/platform_data/invensense_mpu6050.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/platform_data/invensense_mpu6050.h
> > > b/include/linux/platform_data/invensense_mpu6050.h index
> > > 93974f4cfba1..f05b37521f67 100644 ---
> > > a/include/linux/platform_data/invensense_mpu6050.h +++
> > > b/include/linux/platform_data/invensense_mpu6050.h @@ -12,7 +12,7 @@
> > >   *			mounting matrix retrieved from
> > > device-tree) *
> > >   * Contains platform specific information on how to configure the
> > > MPU6050 to
> > > - * work on this platform.  The orientation matricies are 3x3
> > > rotation matricies
> > > + * work on this platform.  The orientation matrices are 3x3
> > > rotation matrices
> > >   * that are applied to the data to rotate from the mounting
> > > orientation to the
> > >   * platform orientation.  The values must be one of 0, 1, or -1
> > > and each row and
> > >   * column should have exactly 1 non-zero value.
> > >     
> > 
> >   
> 

