Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F62345D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCWLgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhCWLfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:35:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AD13619B1;
        Tue, 23 Mar 2021 11:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616499347;
        bh=0tB7JB1Ym0+rZ4dU0rvwfin8XCc0CyQvjYTK3UKsTWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDkSw/Kyj7u1ThCWIxWdjKUuOkd5gDb1b7si710tO6GUJ+TnzhO0TMOr/EGUTbnVj
         KXivBAl9avqai0DQw3MCJU4XVGons8E5lurDk+wDFLUinXx3LPnMdF1eDq+svH0l84
         vr4sY+JXcJO/7rl/fuUuUAoMTK8BcXLfMNGNlLuE=
Date:   Tue, 23 Mar 2021 12:35:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     balbi@kernel.org, weiyongjun1@huawei.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] usb: gadget: legacy: fix error return code of
 msg_bind()
Message-ID: <YFnSkcqXGFSyzD73@kroah.com>
References: <20210307085219.22147-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307085219.22147-1-baijiaju1990@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 12:52:19AM -0800, Jia-Ju Bai wrote:
> When usb_otg_descriptor_alloc() returns NULL to usb_desc, no error
> return code of msg_bind() is assigned.
> To fix this bug, status is assigned with -ENOMEM in this case.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>>

You have 2 '>' on the end of this line :(

