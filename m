Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9076A3F3F7D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhHVNcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVNcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:32:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F26C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:31:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s3so26174042ljp.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JsMbuvBD0CchbCI3lgM2niPcU+m6IwFJ9H/VVzweq2Y=;
        b=qqC9mwg+6tew+qt42fhQ14SEJoobc+VZ/le58VUqaa7Qw1gMu+oeD54wymply9L2rm
         H25a8c1/F54keEf2e15xL42wXTinMoH/teuVA/0MUblGhJjuQIqsG3HHp4jYdJk7IONJ
         7/c9yNiy4fFH1X2gjMIGSrYBZMHyiwZbru1r1vyWkDb7C9DjG5Vo3hayUkD4vWuxaCSU
         WsGWTcr+815ZIc4mB4R+TjchnrBuUvI/plsPw5a6rEp7oEDpLSsbZUr6hTq4eCww3tT5
         WGe9on24hMKiGK2fpx6MOx6JODNvDfU622IYJ8uFq8SmB94VToYXxmAgDZV4b5An0jb2
         YVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JsMbuvBD0CchbCI3lgM2niPcU+m6IwFJ9H/VVzweq2Y=;
        b=NAd6viKbZeaZkxldNGfCd9608CpUVyxRxHJP4w+39Raujzu+CZ4wx3b1jlA9LxP3N3
         y3HRHjpuRS0Fm1Kd9snPd4mBefSIoOgTwns3ie/gFLn2obKXb2W5jDqKyb+KeWhBIvoS
         /ohQ8wP7JfeZoRhWvmSZRO5yC60zH269IIz9Vqpb2v8etsw3CTUTVeDAyMwU5LNys1xr
         TTN+QgFzCvZvivQ+JQI7GjOxnUTpNf9Ia5u2V88ZJL5j1O3r9Sd9U047oqeFmol8fAeH
         Jh7O/0Tut4nvNHKA+/BFEYV/TPofLDFJ7WQeqVBpRXEhDoMP38+1S6OXfsLqzTSRFvZ8
         7Zxw==
X-Gm-Message-State: AOAM533cJAvBRriCea5unl5hbZ+PcT6Ogs/9AmX5okdV5DA3201AGhrp
        phOJqQciztj2vwNiF+x06icUV1KIDHqc9lHS
X-Google-Smtp-Source: ABdhPJykU0SLLk67B2neMVBqAhpddgV0Wea55aoiAjZl1Yff4haybs3qGnQUCwCLFnFC87DuXDXiIA==
X-Received: by 2002:a2e:a261:: with SMTP id k1mr22481980ljm.509.1629639093250;
        Sun, 22 Aug 2021 06:31:33 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id bn3sm1180121ljb.18.2021.08.22.06.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 06:31:32 -0700 (PDT)
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
References: <cover.1629479152.git.paskripkin@gmail.com>
 <435eea22-da31-1ebc-840c-ee9e42b27265@gmail.com> <YSJFhmTs74PUyo8b@kroah.com>
 <2244219.zNr1yEsLHP@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com>
Date:   Sun, 22 Aug 2021 16:31:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2244219.zNr1yEsLHP@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 4:21 PM, Fabio M. De Francesco wrote:
> On Sunday, August 22, 2021 2:39:34 PM CEST Greg KH wrote:
>> On Sun, Aug 22, 2021 at 03:10:56PM +0300, Pavel Skripkin wrote:
>> > On 8/22/21 1:59 PM, Fabio M. De Francesco wrote:
>> > > On Sunday, August 22, 2021 12:09:29 PM CEST Pavel Skripkin wrote:
> [...]
>> > > So, it's up to the callers to test if (!_rtw_read*()) and then act
>> > > accordingly. If they get 0 they should know how to handle the errors.
>> > 
>> > Yes, but _rtw_read*() == 0 indicates 2 states:
>> > 	1. Error on transfer side
>> > 	2. Actual register value is 0
>> 
>> That's not a good design, it should be fixed.  Note there is the new
>> usb_control_msg_recv() function which should probably be used instead
>> here, to prevent this problem from happening.
> 
> I think that no functions should return 0 for signaling FAILURE. If I'm not
> wrong, the kernel quite always prefers to return 0 on SUCCESS and <0 on
> FAILURE. Why don't you just fix this?
> 

That's what I've done in v2. All rtw_read* family will have following 
prototype in v2:

int __must_check _rtw_read8(struct adapter *adapter, u32 addr, u8 *data);


Was it your idea, or you were talking about different approach?


With regards,
Pavel Skripkin
