Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193823EF7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 03:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhHRBuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 21:50:04 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57230 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234723AbhHRBuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 21:50:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjaFm7B_1629251367;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UjaFm7B_1629251367)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 09:49:27 +0800
Subject: Re: [PATCH v7 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210817132300.165014-1-xianting.tian@linux.alibaba.com>
 <20210817132300.165014-2-xianting.tian@linux.alibaba.com>
 <YRvaN0RwW03kkO1O@kroah.com>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <1a0587cc-97e0-62b7-026e-2ee74ed5089c@linux.alibaba.com>
Date:   Wed, 18 Aug 2021 09:49:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YRvaN0RwW03kkO1O@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/8/17 ÏÂÎç11:48, Greg KH Ð´µÀ:
> On Tue, Aug 17, 2021 at 09:22:59PM +0800, Xianting Tian wrote:
>> We tested the patch, it worked normally.
> Who is "we"?
>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> Like I said before, I need another developer from your company to review
> and sign-off on this patch (and the other one), before I am willing to
> look at it, based on the previous mistakes that have happened here.
thanks, I will add the developer in v8 and also with fix a build 
warning, which I don't meet in my build process.
>
> thanks,
>
> greg k-h
