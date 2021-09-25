Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C141805A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 10:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhIYIiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 04:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhIYIiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 04:38:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8DA061250;
        Sat, 25 Sep 2021 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632556831;
        bh=fSMLfh4sE3MbngNjB1rH5VRYWGcbVzhEEu26DYx8/Jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjJFH0quNUfFVqKW6lor1QqRwahM0azOc+kqyFzrMw9BpEL5EZq7y1278zZ6sRBb6
         mYZNlADKjqbbiBCEIfu2r5u9n7WL10ruYYZ5baWw2ayyDT0pwskbcSgXUvnwuh97jB
         JYkfeX5DU+PKkloj6tG6tlOMQLAV3O1EiX4TbrKI=
Date:   Sat, 25 Sep 2021 10:00:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] staging: vt6655: replace camel case
 b_short_slot_time instead of bShortSlotTime.
Message-ID: <YU7XBPzQAq2s7d4L@kroah.com>
References: <20210925074531.10446-1-tomm.merciai@gmail.com>
 <20210925074531.10446-2-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925074531.10446-2-tomm.merciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 09:45:22AM +0200, Tommaso Merciai wrote:
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>

I can not take patches without any changelog text at all, sorry.

My bot pointed you at the instructions for how to write a good
changelog, please read that before resubmitting.

thanks,

greg k-h
