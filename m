Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7F03F5CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbhHXLIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbhHXLIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:08:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2644C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:07:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j12so22501597ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FpTK3hvE23pECqh9p0EL04iD+tphMlpsn6IwOnys+Yw=;
        b=MKAHNRe1lcS55l+C6nT7NY2946DeihoetzLsrM65H8RTbpH8YccKELXIddw5tqFebr
         RyxTc0FViBBli8GOFiht696B2DcQ7ieWqJPLL2UQRmJcMp181SlELCgypd4uLRj7MtSa
         gHbC3gcOYtCh1F1Jnm6wAt8nk7/ZCs7bmbpCjjKgVXQEdPExjj6uZLK2XFWKxOqaLq1F
         PRnLKkMgK2AxD6xJ+ecjNOGVhiHIsL2AIDhLj44gOqrfAe5opggNwHachKaFAnMpT3HX
         2HzBCNmW7iNWQANzQvfkpkrZ51chZCwgWyg+JipNhDZ9S/B/44ZgEdYDTn4SmRwX2pTv
         0zeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FpTK3hvE23pECqh9p0EL04iD+tphMlpsn6IwOnys+Yw=;
        b=XqGSEEz8r8TAxTwWIuL6TcTbbj4rATfNTqGlPwdUq+WYOrQJTtMaQHNwQAEkHLT1q/
         NynPbEcF9+zMc+sE5+uFcpfWlTui0h1vXlEiZ+N0AO5hUfjX3uZwV446+guOoGJ7LzSz
         s/kIxzQAid6S6+jKuhmlA5GEwoi/Ek46pryv/rAXzigedj4nq5uOE6ha3RLv0958Xr6e
         DLaYB+j290j5PTMyWJfG4TVBvpCw9boD5qb8yzQFCVjzZMYWjmdbL/EIVLY+q2qPMIjq
         iygnnMtZAWTpOf3BaTMdMnJFQc7RGVQLhWOHfGFX2S1T9iQbuiBOTuFHHm+YdDAmIBUb
         urQg==
X-Gm-Message-State: AOAM531Tr/0pIvhNvJD9Ecky7Cs+FCqAgU1hH0qHIK+DhViJXNXVCl1C
        Eh4dwcOJzuJHqAHye944H9xQwzTWPX6plQ==
X-Google-Smtp-Source: ABdhPJzdeNtzFvmqVLRRORGLdHk7PoStaT2GgTR2xPoO/JFcfaiD+G7i7CNDEvBfQVJCY4nbmowEjQ==
X-Received: by 2002:a2e:8e8f:: with SMTP id z15mr24744472ljk.121.1629803268016;
        Tue, 24 Aug 2021 04:07:48 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id p1sm763760lfs.10.2021.08.24.04.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 04:07:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in
 usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210823223751.25104-1-fmdefrancesco@gmail.com>
 <20210823223751.25104-2-fmdefrancesco@gmail.com>
 <68eebfaf-50a3-a7ec-12ba-cde33c74c9ce@gmail.com>
 <3198276.4iybWabFxt@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <d5ac7cd8-dc81-732d-b583-628cd2a273cb@gmail.com>
Date:   Tue, 24 Aug 2021 14:07:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3198276.4iybWabFxt@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 11:53 AM, Fabio M. De Francesco wrote:
> On Tuesday, August 24, 2021 10:13:46 AM CEST Pavel Skripkin wrote:
>> On 8/24/21 1:37 AM, Fabio M. De Francesco wrote:
>> > Replace usb_control_msg() with the new usb_control_msg_recv() and
>> > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
>> > 
>> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> > ---
>> > 
>> > Thanks to Pavel Skripkin <paskripkin@gmail.com> for his review of the
>> > RFC patch.
>> >   
>> > drivers/staging/r8188eu/hal/usb_ops_linux.c | 25 ++++++++++-----------
>> > 1 file changed, 12 insertions(+), 13 deletions(-)
>> > 
>> > [...]
>> >
>> Hi, Fabio!
>> 
>> Christophe is right about semantic part. 
> 
> Hi Pavel,
> 
> I haven't yet read Christophe's message (but I'm going to do it ASAP).
> I hope he found out what is wrong with the code, what made Phil's tests
> fail.
> 
>> Also,
>> 
>> if (!status) {
>> 
>> } else {
>> 	if (status < 0) {		<-
>> 					  |
>> 	} else {			  |
>> 					  |
>> 	}				<-
>> }					
>> 
>> Extra if-else is not needed, since status can be 0 and < 0, there is no 
>> 3rd state, like it was before.
> 
> Correct, thanks!
> 
> Now I read the following from the documentation of the new API...
> 
> "Return: If successful, 0 is returned, Otherwise, a negative error number."
> 
> I'll remove that status < 0 check and whatever else is no more necessary.
> Thanks, again :)
> 
> Regards,
> 

Btw, not related to your patch, but I start think, that this check:


	if (!pIo_buf) {
		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
		status = -ENOMEM;
		goto release_mutex;
	}

Should be wrapped as

	if (WARN_ON(unlikely(!pIo_buf)) {
		...
	}

Since usb_vendor_req_buf is initialized in ->probe() and I can't see 
possible calltrace, which can cause zeroing this pointer.

Something _completely_ wrong is going on if usb_vendor_req_buf is NULL, 
and we should complain loud about it. What do you think?


With regards,
Pavel Skripkin
