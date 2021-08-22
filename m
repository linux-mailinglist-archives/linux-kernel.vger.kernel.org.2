Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806973F3F60
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 14:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhHVMvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 08:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVMvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:51:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DB8C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:50:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s12so901516ljg.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rxmlNdlUfU1P9x2yEO9RufRY6ZMTXEHbwKbvIeBfIWg=;
        b=QOXny0/osgqA6UzlB1dRo/nj4oBlLuQxkEwHkmznxMXNCBaWVuAjtiWRGbn5epQ3q+
         vjNZ2vV9Ml3MFux+avJmWxIR8aiVl7+jL8K8Xq+YrbVlP40bmydtjikMhemhLa9LmrLm
         Q+HRmjfJyALVIYzDjEWx4dbB6rT0UT2r9X65jM7gzdN4b74lhmbpPH3WJGhw+VR3aveO
         C7U63WMcXmzLDIbzIq9UPS85fCd91X3YV3Tarq+nQDuQlPOKoqhHcrb7jOmnQUXjKOli
         ymMnOWUi4Y5Je/gnpZV3Awb7/29Qbcad71QN3YKuNx4l9J25ANCr7ktOynDWZ7KVU58g
         SSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rxmlNdlUfU1P9x2yEO9RufRY6ZMTXEHbwKbvIeBfIWg=;
        b=jDTlQPYa+znscRybL/VHB2sBYYT2l7UL6xf8jwlCd/MhgErigtLsaHMUPuCU7Ew0zc
         yTMOhr1rmuO9mMd/LJFVEQ4CgIzkvVHNHIsdLblNThVW9N4WrojH4brleY5sdYLOBPrp
         4ridn9rwHhNozMHUe9ufPqr3ZTqza7M+8l9xqfFBuYn0IYpR2Gmc1CCoIsqNrM4w/4GW
         NNaxIhsHOm3mtVJjM8dEgp91GR8e+PJwXPLpnpJMgT9BNOhLX6DI2A/j/Uqzpyiyma+/
         IJ5rzdPeGiLHQTw1p0Jny4fkYKSIVFa1FOd+Wg4XHnEDGDZ6ZB87sldVGmcuiS7865FO
         RGJg==
X-Gm-Message-State: AOAM5308LepxW2Z8ELA8usAv5BZiRhR3N1uU8sk/rvvdYyBUoZriKxaR
        Bq+ovRaoFCP6zrR86jtvV20=
X-Google-Smtp-Source: ABdhPJwEMmgrzP4gk9QRJw9/Lxj83pvzB66lS/NYtqpAsAqHbk/OwI0irZYb1eiVs9S4hgqnORV6cQ==
X-Received: by 2002:a2e:a5c6:: with SMTP id n6mr23634756ljp.204.1629636637250;
        Sun, 22 Aug 2021 05:50:37 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id l2sm1192534lfk.84.2021.08.22.05.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 05:50:36 -0700 (PDT)
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
References: <cover.1629479152.git.paskripkin@gmail.com>
 <10584649.zhyk0TxWeL@localhost.localdomain>
 <ae27d6a0-dc00-459f-7b36-acf7f4c08d72@gmail.com>
 <2327383.5TodInGmHT@localhost.localdomain>
 <435eea22-da31-1ebc-840c-ee9e42b27265@gmail.com> <YSJFhmTs74PUyo8b@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <e5d189b7-15b2-8cc3-1e84-021dc5ab51af@gmail.com>
Date:   Sun, 22 Aug 2021 15:50:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSJFhmTs74PUyo8b@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 3:39 PM, Greg KH wrote:
>> 
>> Yes, but _rtw_read*() == 0 indicates 2 states:
>> 
>> 	1. Error on transfer side
>> 	2. Actual register value is 0
> 
> That's not a good design, it should be fixed.  Note there is the new
> usb_control_msg_recv() function which should probably be used instead
> here, to prevent this problem from happening.
> 

Thank you, Greg, for confirmation. That's was the point why I started to 
write this series :)

I think, usb_control_msg_recv() won't help us with this problem, since 
all rtw_read*() functions return an unsigned value now. In future, when 
driver code will be fixed (ex: a lot of void function, which can fail 
and leave passed pointer uninitialized) we can move to new usb API and 
then move driver out of staging :)


With regards,
Pavel Skripkin
