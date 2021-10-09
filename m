Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD4F427B77
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 17:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhJIPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 11:47:24 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41758 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234428AbhJIPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:47:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Ur98u8A_1633794323;
Received: from 192.168.0.104(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Ur98u8A_1633794323)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 Oct 2021 23:45:24 +0800
Subject: Re: [PATCH v10 2/3] tty: hvc: pass DMA capable memory to put_chars()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211009114829.1071021-1-xianting.tian@linux.alibaba.com>
 <20211009114829.1071021-3-xianting.tian@linux.alibaba.com>
 <YWGD8y9VfBIQBu2h@kroah.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
Date:   Sat, 9 Oct 2021 23:45:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YWGD8y9VfBIQBu2h@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/10/9 下午7:58, Greg KH 写道:
> Did you look at the placement using pahole as to how this structure now
> looks?

thanks for all your commnts. for this one, do you mean I need to remove 
the blank line?  thanks

