Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C303F7098
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhHYHow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:44:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235922AbhHYHou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:44:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 146596127B;
        Wed, 25 Aug 2021 07:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629877444;
        bh=wVU9GLKhq2p6ukezJvevgnRgWmpzPM5Lh6hx13awvCo=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=NGpKUNQ6oSgrgb1v2TMRw9Ddobcwpjz7nUAx0YJwoBAdEZQqgINe8XsKIN6JPXeVB
         ZdYqzG0qoTTpuBWB30J6+YfgPOwhhLXamWWF6HY96Oujq0UBhyBcNyRj2RyzAUOrnw
         VlYL7CarRbFVY/spLXsR3e1LY7fHHGA7rwicDIPcelou1HQmj1zIz0dLtJ42pnEGu9
         ua36zxbo3e6Npz4ggYU6LZ7Uikp5oI5mZxCzgd2v05X4eR+ZJw8OlNW+X5W02hT47W
         1WKOJTPfSr0C+WIxGTA5bXjVJoX0r6Wms2rFbHXhljFKW3viStjbdgNUQBrv5o8zCx
         cbafdrsD/jojA==
References: <20210824192337.3100288-1-Nehal-Bakulchandra.shah@amd.com>
 <87ilzu5ap0.fsf@kernel.org> <YSXqsXmuom2fFiKN@kuha.fi.intel.com>
User-agent: mu4e 1.6.4; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kun.liu2@amd.com,
        alexander.deucher@amd.com
Subject: Re: [RESEND PATCH 2/2] usb: dwc3: pci add property to allow user
 space role switch
Date:   Wed, 25 Aug 2021 10:43:38 +0300
In-reply-to: <YSXqsXmuom2fFiKN@kuha.fi.intel.com>
Message-ID: <87zgt69dfj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Heikki Krogerus <heikki.krogerus@linux.intel.com> writes:

> On Wed, Aug 25, 2021 at 08:55:41AM +0300, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com> writes:
>> 
>> > For AMD platform there is a requirement to enable user space role
>> > switch from host to device and device to host as customer platform is not
>> > completely capable of OTG i.e. with type C controller it does not have PD
>> > to support role switching. Hence, based ACPI/EC interrupt role switch is
>> > triggered by the usemode script running in background.
>>                    usermode ?
>
> Couldn't you capture that ACPI/EC interrupt in kernel?
>
>> > Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
>> 
>> I'm okay with this, just wondering if we need to Document the property
>> somewhere.
>> 
>> @Heikki, is there a place to document these private properties that's
>> not on DT binding document?
>
> The build-in properties are not documented separately. I've always
> tried to supply DT bindings for all new properties I've proposed.
>
> In this case though, do we need the new property at all? Why not just
> register a normal USB role switch on this platform? It can be either a
> dummy role switch that only passes the user space input to dwc3, or,
> perhaps ideally, it would also be a driver that captures that ACPI/EC
> event/notification and then passes the information from it to dwc3.

I like the actual driver responding to EC IRQ idea.

-- 
balbi
