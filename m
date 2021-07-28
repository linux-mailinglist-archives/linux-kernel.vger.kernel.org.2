Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC3B3D8828
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhG1GrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234203AbhG1GrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:47:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8CEE60EB2;
        Wed, 28 Jul 2021 06:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627454827;
        bh=AXHiGCcRMS4bzbotazDVXXM7xHLYma/PA7wkXVhUd7k=;
        h=References:From:To:Cc:Subject:In-reply-to:Date:From;
        b=e5GJTp5mNy5w3l7VAkHOcLpVvNmPfTvE+zZOzs/0zMAlqfOw3QB4MBaxbd93tMW5q
         7p/DehQIRUMN8xunEnv4XvW7D4/S09Hsfpa4CI2n9lb8++ErHDLxcWSZvXfxknryTL
         dbvsTtzXNwrObQNnnln4F6VUOAnDyuwJUMSX07tXFtU9wNLZGGnacwFZHzWUZxDHbP
         dRZUhyDoilFpSYItFggLIcTs/+dAfP94wYoYuD5oLTFInhLDDSjqe+jiphInTv5XOn
         hioTPCeXeDpUeKsAIN3E8BnsZ06o240uUPIVX7B3VALyzYm9hev++rq66kaAY5dVXh
         kPCJpzdAp0Obg==
References: <20210727185800.43796-1-mdevaev@gmail.com>
 <87mtq7t0ex.fsf@kernel.org> <YQD8MfEZxPHYhnrz@kroah.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Maxim Devaev <mdevaev@gmail.com>, sandeen@redhat.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: idle uses the highest byte for
 duration
In-reply-to: <YQD8MfEZxPHYhnrz@kroah.com>
Date:   Wed, 28 Jul 2021 09:47:04 +0300
Message-ID: <87k0lbszo7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH <gregkh@linuxfoundation.org> writes:
> On Wed, Jul 28, 2021 at 09:31:02AM +0300, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> Maxim Devaev <mdevaev@gmail.com> writes:
>> 
>> > SET_IDLE value must be shifted 8 bits to the right to get duration.
>> > This confirmed by USBCV test.
>> >
>> > Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
>> 
>> with Greg's Fixes addition:
>> 
>> Acked-by: Felipe Balbi <balbi@kernel.org>
>
> Argh, just missed me committing this.  Thanks for the review, sorry it
> missed getting added to the final commit :(

not a problem, thanks for taking care of all these patches ;-)

-- 
balbi
