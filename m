Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21163F57AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 07:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhHXFp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 01:45:29 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:19924 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhHXFp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 01:45:27 -0400
Received: from [192.168.1.18] ([90.126.253.178])
        by mwinf5d65 with ME
        id lHkg250073riaq203Hkg08; Tue, 24 Aug 2021 07:44:42 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Aug 2021 07:44:42 +0200
X-ME-IP: 90.126.253.178
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in
 usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
References: <20210823223751.25104-1-fmdefrancesco@gmail.com>
 <15825589.4VbMHeJK9p@localhost.localdomain>
 <1815496.OexNakQ7IY@localhost.localdomain>
 <4118209.ZeClQeRtK1@localhost.localdomain>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <50d40020-5b0e-4bb9-357b-3640a0f9e8c6@wanadoo.fr>
Date:   Tue, 24 Aug 2021 07:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4118209.ZeClQeRtK1@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/08/2021 à 04:01, Fabio M. De Francesco a écrit :
> On Tuesday, August 24, 2021 3:38:03 AM CEST Fabio M. De Francesco wrote:
>> I think that I've inadvertently switched the order by which usb_control_msg_send()
>> and memcpy() are called. I'm very sorry for not doing my tests, but (as I had said
>> before) at the moment I don't have my device with me.
> 
> No, I did not switch them. There must be something else...
> Sorry for the noise.
> 
> Fabio
> 

Hi,

'usb_control_msg_recv()' looks like:

int usb_control_msg_recv(struct usb_device *dev, __u8 endpoint, ...)
{
	unsigned int pipe = usb_rcvctrlpipe(dev, endpoint);
	...
	ret = usb_control_msg(dev, pipe, ...);


'usb_control_msg()' looks like:
int usb_control_msg(struct usb_device *dev, unsigned int pipe, ...)
{


The difference is that one expect an 'endpoint' (and compute the pipe 
from it), and the other expect a 'pipe'.

Also, in your code, 'pipe' looks un-initialized.


So, my guess is that you should rename 'pipe' into 'endpoint' (to keep 
the semantic), have "endpoint = 0;" somewhere and pass it to 
usb_control_msg_{recv|send}.
Or just remove 'pipe' and pass an explicit 0 directly.

Not sure it is enough, but it looks like a difference between before and 
after your patch.


just my 2c,
CJ
