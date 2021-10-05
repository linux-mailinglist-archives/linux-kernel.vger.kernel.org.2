Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AB54225F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhJEMJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234631AbhJEMJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:09:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9F6661502;
        Tue,  5 Oct 2021 12:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633435663;
        bh=oIgsQ77j5OZfDAx/jRH/jJIfGDauyIlgA9UGM0LBZUY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=GplYYVg2fP8Z6NLLI9qrRLRfPT3JhNIbxDBkmb+JdFeMgQM/VfHVAvuL0rvb2wV9K
         E0B/ncmPqh1PyuVpd5e7EH/DzKCr2a4mB1qz30ndRNzQpJjLfyYV7/FI8EmrOVM3Zi
         7Llq0v6QX4JgVvKFLDXF30qm1tRA0bhHl78wxSuSg4a+lgMz1W6XQncbqBc7IhXMbB
         FubYkVZqHVn7hCUU4BYh4NyRbnwkw8yxinpLVceU3MYq7q9eOvy2aX4lOc9kDIQBtR
         WBMuot5tM+uyQNLqqHfz8LeYZkXIF4fDgGt5pUDG/CLRsrDqo97349LcPYn6rekqPH
         wWUAB8692AzpA==
References: <YUnsSxUERYj/oXTO@kroah.com>
 <20210921145901.11952-1-nikita.yoush@cogentembedded.com>
 <YVwyDsuIT9lZWi2v@kroah.com>
User-agent: mu4e 1.6.6; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Nechaev <petr.nechaev@cogentembedded.com>
Subject: Re: [PATCH v3] usb: gadget: storage: add support for media larger
 than 2T
Date:   Tue, 05 Oct 2021 15:07:11 +0300
In-reply-to: <YVwyDsuIT9lZWi2v@kroah.com>
Message-ID: <875yubznck.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Sep 21, 2021 at 05:59:02PM +0300, Nikita Yushchenko wrote:
>> This adds support for READ_CAPACITY(16), READ(16) and WRITE(16)
>> commands, and fixes READ_CAPACITY command to return 0xffffffff if
>> media size does not fit in 32 bits.
>> 
>> This makes f_mass_storage to export a 16T disk array correctly.
>> 
>> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>> ---
>> v3:
>> - added this changelog
>> 
>> v2:
>> - fixed call to check_command() for READ_CAPACITY(16)
>> - fixed alphabetical order of commands in switch statement
>> - renamed variable, added comments, and fixed formatting, per advices by
>>   Alan Stern <stern@rowland.harvard.edu>
>
> Felipe and Alan, any objections to this change?

none from me, but I'd definitely wait for Alan's comments as he's the
one who understands the storage gadget inside out :-)

cheers

-- 
balbi
