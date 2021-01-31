Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A17309C99
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhAaONW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 31 Jan 2021 09:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbhAaN3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:29:08 -0500
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:8d8e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BFC061788
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 05:23:51 -0800 (PST)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id B8CD315360;
        Sun, 31 Jan 2021 13:18:47 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 83327219FCF; Sun, 31 Jan 2021 13:18:47 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: add option to disable registration of
 legacy ISA ports
References: <20210128172244.22859-1-mans@mansr.com>
        <YBam2m2VMowH5Yth@kroah.com>
Date:   Sun, 31 Jan 2021 13:18:47 +0000
In-Reply-To: <YBam2m2VMowH5Yth@kroah.com> (Greg Kroah-Hartman's message of
        "Sun, 31 Jan 2021 13:47:22 +0100")
Message-ID: <yw1xwnvtcki0.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Jan 28, 2021 at 05:22:44PM +0000, Mans Rullgard wrote:
>> On systems that do not have the traditional PC ISA serial ports, the
>> 8250 driver still creates non-functional device nodes.  This change
>> makes only ports that actually exist (PCI, DT, ...) get device nodes.
>> 
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>>  drivers/tty/serial/8250/8250_core.c | 26 ++++++++++++++++++++------
>>  drivers/tty/serial/8250/Kconfig     |  5 +++++
>>  2 files changed, 25 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index cae61d1ebec5..49695dd3677c 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -555,6 +555,7 @@ static void __init serial8250_isa_init_ports(void)
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_SERIAL_8250_ISA
>
> This is just making a mess of the code. 

It was already a mess.

> To do this right, pull the isa code out into a separate file and put
> the #ifdef in a .h file, so we can properly maintain and support this
> code over time.  This change as-is is not going to make that any
> easier :(

I might put in that effort if there's a reasonable chance this change
will be accepted.  If it's going to be rejected regardless, I'd rather
not waste my time.

>> +config SERIAL_8250_ISA
>> +	bool "8250/16550 ISA device support" if EXPERT
>
> So, no one will set this?

I followed the pattern of the existing SERIAL_8250_PNP option.  Was that
a mistake?  How would you prefer it?

> What userspace visable change will be caused by this? 

There won't be /dev/ttyS devices for ports that don't exist.

> Will ports get renumbered?

Not if they had predictable numbers to begin with.

> What harm is this causing systems today without this change?

It means I have to somehow maintain a separate list of which ports are
real and which should be ignored, or else try to distinguish real errors
from those caused by trying to access the bogus ports.

-- 
Måns Rullgård
