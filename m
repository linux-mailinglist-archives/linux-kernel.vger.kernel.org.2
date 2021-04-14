Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4469735F4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351366AbhDNN0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:26:11 -0400
Received: from m12-12.163.com ([220.181.12.12]:44710 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351358AbhDNN0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ndvDO
        c1BoCwRDWmd5tQ+4Vm2u9Kle7XoAhYZDLYFx4s=; b=PQkUsL4M1dnoVQil9k1kK
        bDSCJyik6sBBrb5vRTaJh0lQWd2Nf174e+RnhotRIHORPFEk4TQuVLEOlLR9Bd6W
        qWDycJE+Nkle365iDxIlekgJ/OcpseQZxRlu5zSGS+tz1MmC2kYHkIVjiHjnryjS
        aFljjU3XUOkf2hfzAT1eBI=
Received: from localhost (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowADnfLki7XZgr24bZQ--.14388S2;
        Wed, 14 Apr 2021 21:24:50 +0800 (CST)
Date:   Wed, 14 Apr 2021 21:25:01 +0800
From:   Zuo Qi Lin <zuoqilin1@163.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] fs/debugfs: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20210414212501.00003953.zuoqilin1@163.com>
In-Reply-To: <YG09jTh5QGLLqtKP@kroah.com>
References: <20210402121141.82-1-zuoqilin1@163.com>
        <YGcMgENjMSla4BO3@kroah.com>
        <20210407102206.00005d9a.zuoqilin1@163.com>
        <YG09jTh5QGLLqtKP@kroah.com>
Organization: Coolpad
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowADnfLki7XZgr24bZQ--.14388S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWUWrW3Ww43JF13ZryUGFg_yoWDWFg_Xa
        4UAFyDGr17XF17JFnrJF45Jrnrtr4UJrs8J34UZr4DX39xJFy5Wr48Jr4xXF1UXF48Jr13
        Gw4Yv3WUJr1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbf-PUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRRZxiVPALEEzhAABsj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 07:05:17 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Apr 07, 2021 at 10:22:06AM +0800, Zuo Qi Lin wrote:
> > On Fri, 2 Apr 2021 14:22:24 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Fri, Apr 02, 2021 at 08:11:41PM +0800, zuoqilin1@163.com
> > > wrote:  
> > > > From: zuoqilin <zuoqilin@yulong.com>    
> > > 
> > > Please use your full/real name.
> > > 
> > > thanks,
> > > 
> > > greg k-h  
> > 
> > -----------------------------------------------------------
> > Hi 
> > 
> > My name is Zuo Qilin.  
> 
> Great!  Then use that above :)
> 
> Also that name does not match your "From: " name in your email, here
> either, so please just get them all the same when sending a patch.
> 
> thanks,
> 
> greg k-h

-----------------------------------------------------------
Hi 
  I understand what you mean, i also tried some methods, but when using
git send-email. I still can¡¯t change it to my name, it¡¯s still my email
account. Sorry about this, and accept your rejection of my patch.
Thanks!
BR.




