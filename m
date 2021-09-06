Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9146D401F1B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbhIFRUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbhIFRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:20:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49080C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:19:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x27so14568340lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=46jNlcoB/PrxGhtTxusVMKNCYWvu8Kvd/CNEibPL+uM=;
        b=dyUu6fbSe1tzusga0oWuJrt7JdAN8uHLHnfw59S2CsCMD3feYmwzAqGsv4FP9ATKcj
         Jh3znVJtaEih5ppYXQX2sV9bMU+PoZdS35EMj0Tgr6/PX+qeddCsotBy8BnFPk3LMGl5
         e+b2XEWFx+41j97Xf4tNNyrRQaetJT29KNvm7ne/9W/X6e5l4S9Ff/1TNKqp1lEqbpMC
         syAwFa7mJtZhuXb6py2+CIqyfwoqM3PtUm4rdgEbyDawRcqMEJkKC1PzlQajYeXFsLqd
         yz6ZhvBb7o8lELnt0W+qBsrGkrOZQQ7CW/O0YVpNY4P/m0c/M4HLNk1KwlVwcYsdK0jI
         ikAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=46jNlcoB/PrxGhtTxusVMKNCYWvu8Kvd/CNEibPL+uM=;
        b=EiJEfvm4ZUOy24nu3x7tzJaFvNdY/EMx22KTvtejiENziyLh/KR6VzHHja8WkizwnK
         AJuerBtNonGwYNO+SjcXhiRM+carUAtmJuurrVhPcnIvQ9OeM5lCoCedCDo7PLntwVDD
         snca6V40kceBKe/CnegsGJmxUtfqD7vQNs9LCYuGUgkzbloyXwEAzFQhC99KibAF00Fx
         lmeaXSi21Hi3EIt57t735yaiUPdwso8bFxqE5w/XnlezTxjXa9v7hSiHRAhQCEpYDpmK
         iJOIF6ey/e1TMq6jkM2WbQWo5wgSYz1mOZHmaQz6KX0WDY7Xv7OW+XJQzNKQV04wcCCK
         1Gqg==
X-Gm-Message-State: AOAM53045XrxwaoIkHlyJqGC7LaIFhdVoU7CpKYum/kHU5IIBZiZiQfy
        BnEH1e1Wby/lZpXL/15bvls=
X-Google-Smtp-Source: ABdhPJz26M0KlC2YuT0GyES2YNGDTJ1Yz8VWNUVEyJ/fmmRHXW7hTtcr8TRfxICg9gmMipsgcpoUnw==
X-Received: by 2002:ac2:495e:: with SMTP id o30mr10168105lfi.674.1630948748513;
        Mon, 06 Sep 2021 10:19:08 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.70])
        by smtp.gmail.com with UTF8SMTPSA id p14sm1142680lji.56.2021.09.06.10.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 10:19:08 -0700 (PDT)
Message-ID: <d9e536d6-1b66-52d5-50a8-0c011b23e018@gmail.com>
Date:   Mon, 6 Sep 2021 20:19:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH v3 1/3] staging: r8188eu: remove _io_ops structure
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
 <20210904220048.12822-2-fmdefrancesco@gmail.com> <YTYeGH+5MG5OeEbi@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YTYeGH+5MG5OeEbi@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 16:56, Greg Kroah-Hartman wrote:
> On Sun, Sep 05, 2021 at 12:00:46AM +0200, Fabio M. De Francesco wrote:
>> -void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem)
>> -{
>> -	void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
>> -	struct io_priv *pio_priv = &adapter->iopriv;
>> -	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
>> -
>> -
>> -	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
>> -	     return;
>> -	_read_mem = pintfhdl->io_ops._read_mem;
>> -	_read_mem(pintfhdl, addr, cnt, pmem);
>> -
>> -}
> 
> This is odd, in that it resolves down to usb_read_mem which does
> nothing at all.
> 
> And then no one calls this at all either?
> 
> How about removing the io ops that are not used at all first, one at a
> time, making it obvious what is happening, and then convert the ones
> that are used one at a time, and when all is done, then removing the
> structure?
> 

Just have started to cut one big patch to smaller ones and does it make 
sense to group changes like: one for usb_read*, one for usb_write* and 
one for usb_port*? I think, it would be cleaner and series won't be too big.


What do you think?




With regards,
Pavel Skripkin
