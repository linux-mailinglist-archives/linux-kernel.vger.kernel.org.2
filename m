Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD71401CB9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbhIFOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhIFOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:02:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3E7C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 07:01:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y34so13671828lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z1bR3TjO8IoAaLeGm9m1Zil8bPCLxBj0FbmbvZ186NI=;
        b=hgiR81AVwLwl21VZzIKlAu33Ypr6sGpn/gf36/fbtvEZZAFyrudqSjLiaD+nGbPM3p
         pU5YK2hqA8Q2eV0nkaMIusS0UmMLZTop3Rdt11nVPUtxX/q+yqRUezS4DK784Xd+6KbK
         ACJDDh5Tqhkt8kItIPbwDR5OXM5umkEGLxZEbfetaZkaYQsurB8Qg2fKjo6nGWeBBGYh
         yDLrN0CdS2NY0TfaA+/OkUaIjjxD6AmhFNJ9rUx2oHCjHFlqLSrREwvVlM97zGT0ypKF
         6/CLZx0AGHbADWpD5TLeL1M9TOyfXxWIEcq+kZgnjdGdpY9GMLw2D3Ow/+7sD93Qk1KU
         tUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z1bR3TjO8IoAaLeGm9m1Zil8bPCLxBj0FbmbvZ186NI=;
        b=nkDXhozcIhxzYQeRlrrq/ohvmNMyvjfSpEYbrfJDiufRdNJnuzPkYCmCe4E1Y1DAI4
         9L+v/rMsusle09Bh9DA7iYt8s56EdlpqCGVexD34AHFO/M1n9z47hKgITNX8NHVdWTcv
         tbJD78NbTtfpiZ88J2IweoG6QUq3Q8FC26k9gvAjyfzjhl4tgK0olyAwE73S+EbQG6/o
         fW/ENKS8nYT5q4VuaXZbEAWYrIpoJhrZVPhjcy/Ou+MdptAv7kesrb8q5QFb0Io7Y6n5
         52bzilTGmtw/Xl6vQFCQl7AUnzgShfJ8lp6LgMh64fok2CYdbITZMHE4TlJfflcQgVEz
         LVOg==
X-Gm-Message-State: AOAM533oPzzT9TAThLFlWMFhCsUDOTJjzmSMZWxfxXECkK/MH4aGtFhg
        ny2eZbloVImlEo+c1xj6cDs1NBR3LEdkNA==
X-Google-Smtp-Source: ABdhPJzEBUQJ3iIIl0U97mjZl41dyqk/7HjBy8I2YAfDzvqhjy9siZ/53FuXKl22VWPMcP5rCN19zQ==
X-Received: by 2002:a05:6512:3742:: with SMTP id a2mr9917694lfs.604.1630936870553;
        Mon, 06 Sep 2021 07:01:10 -0700 (PDT)
Received: from localhost.localdomain ([46.61.204.60])
        by smtp.gmail.com with ESMTPSA id s9sm1064640ljp.34.2021.09.06.07.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 07:01:10 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] staging: r8188eu: remove _io_ops structure
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210904220048.12822-1-fmdefrancesco@gmail.com>
 <20210904220048.12822-2-fmdefrancesco@gmail.com> <YTYeGH+5MG5OeEbi@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <90459a0f-a32f-bf45-c790-19a03673d6fc@gmail.com>
Date:   Mon, 6 Sep 2021 17:01:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YTYeGH+5MG5OeEbi@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 4:56 PM, Greg Kroah-Hartman wrote:
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

Yep, there is no caller of this function... Idk why this was added :)

> How about removing the io ops that are not used at all first, one at a
> time, making it obvious what is happening, and then convert the ones
> that are used one at a time, and when all is done, then removing the
> structure?
> 

Ok, sounds like a good idea. Will fix in v4, thank you

> That makes it obvious what is happening and much much easier to review
> for correctness.
> 

Agree


With regards,
Pavel Skripkin
