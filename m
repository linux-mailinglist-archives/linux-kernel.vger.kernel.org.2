Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB53F5DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhHXMKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhHXMJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:09:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99A8C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:09:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r9so45094798lfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7PcdMnGwD/TVBDMI0hdvsoYsiNHwhw3N+WJOyBZilh4=;
        b=NFwLL1O0h2SMOf5CPHyCc52ibh3534uLa/004eAEb3oAeOBTqQ9cKa4gDk9qYGlXxg
         Z72YxwrEp7gCvXky5oxDBrH2dUgqbAf5MLk/vBPER9p/fPpqXgZV1+2OFCOLd7s4m7Cd
         ZOxFJ0pbVpEmrdurSG3xLVtd4km5YrBWyYQEvOsO0jHFGAMGvkEWHFpkuPVSjkrloQvH
         tizxFyE9Ftttk2lycn/N2/ozS2fKrt0nQZKf+quc33jYO2hbeQYqAQ++h9rdOV+ieqda
         7Quj3KWlSlNhOYl6frhzvLlV45YMnLrAG316i4cIFwzsPOXH8fu9c99PiSF4ITm5WqHu
         Nkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7PcdMnGwD/TVBDMI0hdvsoYsiNHwhw3N+WJOyBZilh4=;
        b=iJ+k1S53VkTdI+bJ6FZQMy+wuVVTcpEGQBazHPTp4ZLU3kD48OXmyk5Xm2binrZfma
         kmFUvJTcEMpYx0jLSzI7AR5CWMk6tc9QS17Cbxrm2cidv3gcXnqfCaCjbmF5QuJ/DpyL
         Hz8kYeNiOyODhJFRgvN7RafBsY/Pn8E3EgTD2k65s5zwal7m/odRJLPPDYdHmVDaj5nw
         rTvYp3Mr8l2KsKYR+q9lDC3mxjkl7XUpjMF0zNk0dPdfFofiFcQXmSHoJsSWz4sHgnBF
         UiIqxN8Ji64BlOvsaBi0h//AAOSv1k14nNzsl+2VSouIGz2/yVcnvpqofaMjY91VNeiA
         5PCQ==
X-Gm-Message-State: AOAM53369VbJzUkw1VY1sV9GSC0rJaFkkgVKDsLMRD42p+lqeQ89zLf1
        Is9bRjgTesdKmUjRX7Q1bqb2mmm9EPjMog==
X-Google-Smtp-Source: ABdhPJyY345P53Z28nzO2jWCu6n4NOM7PhVobj4nHXVuC8nw9Jbxxqd1zL4sDPM2n6G0NB8Avquzeg==
X-Received: by 2002:a19:740d:: with SMTP id v13mr12925642lfe.655.1629806953845;
        Tue, 24 Aug 2021 05:09:13 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id e8sm1780825ljj.132.2021.08.24.05.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 05:09:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] staging: r8188eu: Use usb_control_msg_recv/send() in
 usbctrl_vendorreq()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210823223751.25104-1-fmdefrancesco@gmail.com>
 <3198276.4iybWabFxt@localhost.localdomain>
 <d5ac7cd8-dc81-732d-b583-628cd2a273cb@gmail.com>
 <6601006.JhxPbakEoc@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <99d69811-deff-d346-634e-20e9fdead7c8@gmail.com>
Date:   Tue, 24 Aug 2021 15:09:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6601006.JhxPbakEoc@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/21 3:01 PM, Fabio M. De Francesco wrote:
> On Tuesday, August 24, 2021 1:07:46 PM CEST Pavel Skripkin wrote:
>> 
>> Btw, not related to your patch, but I start think, that this check:
>> 
>> 
>> 	if (!pIo_buf) {
>> 		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
>> 		status = -ENOMEM;
>> 		goto release_mutex;
>> 	}
>> 
>> Should be wrapped as
>> 
>> 	if (WARN_ON(unlikely(!pIo_buf)) {
>> 		...
>> 	}
>> 
>> Since usb_vendor_req_buf is initialized in ->probe() and I can't see 
>> possible calltrace, which can cause zeroing this pointer.
> 
> I see that usb_vendor_req_buf is initialized in rtw_init_intf_priv(). It depends on a
> kzalloc() success on allocating memory. Obviously it could fail to allocate. If it fails,
> rtw_init_intf_priv() returns _FAIL to its caller(s) (whichever they are - I didn't go too
> deep in understanding the possible calls chains).
> 

Call chain is the most interesting part here :)

     rtw_drv_init()		<-- probe()
       usb_dvobj_init()
	rtw_init_intf_priv()

If kzalloc fails, then whole ->probe() routine fails, i.e device will be 
disconnected. There is no read() calls before rtw_init_intf_priv(), so 
if kzalloc() call was successful, there is no way how usb_vendor_req_buf 
can be NULL, since read() can happen only in case of successfully 
connected device.


Anyway, it can be NULL in case of out-of-bound write or smth else, but 
there is no explicit usb_alloc_vendor_req_buf = NULL in this driver.
We should complain about completely wrong driver behavior, IMO :)


Does it make sense?



With regards,
Pavel Skripkin
