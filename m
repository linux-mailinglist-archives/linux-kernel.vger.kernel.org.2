Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8313A0DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbhFIHff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236025AbhFIHfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:35:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5A676135D;
        Wed,  9 Jun 2021 07:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623224019;
        bh=sf3DQW0Ey1By/Rw/Aftj1JCbuq4U/NXXCk4qj9KBwFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pii0NALyIX/OXj3uLaQryrhuQira8IEfrwJFugOMugkyETtbj7AZDXOZwoDRMg7M3
         OQ7E/ULz5oz/2a1a7Sh+CmrfErGzQQ+CePv++j5Pxu5bcQ4j4W6otRvgDwZftLHhOJ
         cF2fI5Tp37hfxb0Rlg6JoL5/CExGysJk9iB6bZyn1pSqyeyBn5BQtz3RMct3kZgsi0
         EKZqLK63ZYxFZZXECdPr5eh7sRvTZiP/IJDBGy9VuoA252XG8QNtDn4kZcQyArWfDt
         BSEfHYIFSE4+qXaK/qIZSVi76My62exB6g/42RG6Cmr7XYNZQEmrV8+SS0R5/KYlay
         4M4xkvyCJeLhw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lqsiS-0004r2-Br; Wed, 09 Jun 2021 09:33:32 +0200
Date:   Wed, 9 Jun 2021 09:33:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tung Pham <Tung.Pham@silabs.com>
Cc:     Pho Tran <photranvan0712@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Pho Tran <Pho.Tran@silabs.com>
Subject: Re: [PATCH v12] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YMBuzDqpcr+WLE5H@hovoldconsulting.com>
References: <CO1PR11MB488255D1B04D3B90886A59BE812C9@CO1PR11MB4882.namprd11.prod.outlook.com>
 <YKNnBckiw4fLIuQL@hovoldconsulting.com>
 <CO1PR11MB4882BE3951A2CDFC8F060B58812A9@CO1PR11MB4882.namprd11.prod.outlook.com>
 <YKdqKDj/Qbw4k5IA@hovoldconsulting.com>
 <CO1PR11MB488295663735895484C264CF81369@CO1PR11MB4882.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB488295663735895484C264CF81369@CO1PR11MB4882.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 03:06:16AM +0000, Tung Pham wrote:

> Thanks for your effort to reviewing our code.
> What about status of this patch?.

It's still on my list. I'm a bit short on time at the moment and had to
prioritise the CP2102N regression. I'm still hoping to get to this patch
this week.

Johan
