Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F0E35615F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348083AbhDGCWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:22:25 -0400
Received: from m12-16.163.com ([220.181.12.16]:39606 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234067AbhDGCWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=kbbog
        kyK2CQTgnmGMMs8DlIYwJDUIJA5pIoF90bBHe8=; b=LYbyvfHB5Ray5ibnEGwcP
        MxWrXbP6O4jM/PdZ+9+96rgqqp/39S9/b6/RWYk1b5VzV38/CH/9DgodSaeRgZe1
        sKq1MKQuLD6MDm0FFywIjrAro3Rn3vAKfs6l0owyjE8a0vNgiXHyNVIji/K/LCpz
        I2WgWWRDF3oxO8scHOxpnw=
Received: from localhost (unknown [218.94.48.178])
        by smtp12 (Coremail) with SMTP id EMCowACnKDNPF21g4YmKkQ--.21772S2;
        Wed, 07 Apr 2021 10:22:07 +0800 (CST)
Date:   Wed, 7 Apr 2021 10:22:06 +0800
From:   Zuo Qi Lin <zuoqilin1@163.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: Re: [PATCH] fs/debugfs: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20210407102206.00005d9a.zuoqilin1@163.com>
In-Reply-To: <YGcMgENjMSla4BO3@kroah.com>
References: <20210402121141.82-1-zuoqilin1@163.com>
        <YGcMgENjMSla4BO3@kroah.com>
Organization: Coolpad
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EMCowACnKDNPF21g4YmKkQ--.21772S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU1ZXrUUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRQ9tiVPAK9dRrQAAs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2021 14:22:24 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Apr 02, 2021 at 08:11:41PM +0800, zuoqilin1@163.com wrote:
> > From: zuoqilin <zuoqilin@yulong.com>  
> 
> Please use your full/real name.
> 
> thanks,
> 
> greg k-h

-----------------------------------------------------------
Hi 

My name is Zuo Qilin. I think if the number after my name is causing
you doubts, i am sorry for that, because my name has been registered by
others, so i can only distinguish by adding numbers after my name.

Thanks.
BR.

