Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228073DB8DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhG3MsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 08:48:01 -0400
Received: from m12-17.163.com ([220.181.12.17]:34259 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhG3MsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 08:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=z80Oe
        AxuVEQDT+rfaaxVU7rSSe184xqcY2x6cJebVsw=; b=FHAi9lruClHkngaxnb+IG
        pTnSk16pofJMZ7pmywMjKThe6F14nEPqkbKKtKYSjaTmzsFv7Q2L52HAHr9V/B1M
        vjtFdFmMu14/huMF9avzSsX2krCjktso+7XDPM4FwGubNXdH/PHY9PR0l9LS+W38
        v8ua+Wpd40VjBmQjbwCwGI=
Received: from localhost (unknown [183.195.9.44])
        by smtp13 (Coremail) with SMTP id EcCowAAnu7Xg9ANh0twfDg--.50891S2;
        Fri, 30 Jul 2021 20:47:28 +0800 (CST)
Date:   Fri, 30 Jul 2021 20:47:28 +0800
From:   "qiaoyanbo_310@163.com" <qiaoyanbo_310@163.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] kobject: kobject_add_internal cleanup
Message-ID: <YQP04FoSecPhI+38@ybqiao-virtual-machine>
References: <20210727143212.39142-1-qiaoyanbo_310@163.com>
 <YQEtJkPFDWMSAd/C@kroah.com>
 <3be7ce57.62f6.17af280a47f.Coremail.qiaoyanbo_310@163.com>
 <YQK0JuI1w1zsEHeC@kroah.com>
 <54cc7e43.808a.17af32725d9.Coremail.qiaoyanbo_310@163.com>
 <YQOEl0SQY/WpE1dK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQOEl0SQY/WpE1dK@kroah.com>
X-CM-TRANSID: EcCowAAnu7Xg9ANh0twfDg--.50891S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry8Kry7ur1kuF4xJFy7Wrg_yoWxKrX_ua
        4Fva42kwn8XrnIqw4DZrs8KrZ8WrWDWF1qqr98ZwsIqa47WanrGrZIvFn5tFyUG3y0yrnx
        Kan8W342gryxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn1xR3UUUUU==
X-Originating-IP: [183.195.9.44]
X-CM-SenderInfo: 5tld055dqe0sqtrqqiywtou0bp/1tbiDRbfT1QHXFBj-AACsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 06:48:23AM +0200, Greg KH wrote:
> On Fri, Jul 30, 2021 at 12:44:26AM +0800, qiaoyanbo_310 wrote:
> > Hi Greg KH,
> 
> Sorry, but html email is rejected by the mailing lists.  Please try
> again after fixing up your email client, and I will be glad to respond.
> 
> thanks,
> 
> greg k-h

(Sorry, this is the first time I use the mutt environment to send mail,
	shamed on me I know~)

>Why is this a problem?  What bug is this solving?  Is the code somehow
>now faster or smaller that can be measured? 

I don't think the logic of the original code is self consistent.
This is not a bug,  but it causes  some unnecessary assignment operations.
This patch is to clean unnecessary assignment operations.

Thanks,
Qiao Yanbo

