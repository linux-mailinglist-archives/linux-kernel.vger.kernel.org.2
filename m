Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB29345D07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCWLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhCWLf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:35:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F0A9619B1;
        Tue, 23 Mar 2021 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616499325;
        bh=bd1lHeohaarMedvzn/T2ZYAwtCAyIqbm8WGP2u4zTt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alCNHGS9wr4/obiUew2KdTNGQ0P9Z84PzmMzZqBJjpVTV+bcskuVzaWp0dMhCKdaT
         jCE4qnHPfMKobMQ8h48qgV//u/ZIMhFLA0WY4kWof+6VebCW1+kmB7ScN+TaPM6qT3
         aW9b4YrvuyoXg2JNLpf1ItBfsscMTtSm8AZTbS40=
Date:   Tue, 23 Mar 2021 12:35:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     balbi@kernel.org, weiyongjun1@huawei.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: legacy: fix error return code of msg_bind()
Message-ID: <YFnSe716okrldCHJ@kroah.com>
References: <20210307084915.22022-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307084915.22022-1-baijiaju1990@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 12:49:15AM -0800, Jia-Ju Bai wrote:
> When usb_otg_descriptor_alloc() returns NULL to usb_desc, no error
> return code of msg_bind() is assigned.
> To fix this bug, status is assigned with -ENOMEM in this case.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>>

These lines are not written correctly :(

Please fix up and resend.

thanks,

greg k-h
