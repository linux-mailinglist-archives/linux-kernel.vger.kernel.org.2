Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C558D45A226
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhKWMFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhKWMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:05:48 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5191FC061574;
        Tue, 23 Nov 2021 04:02:40 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r5so18095814pgi.6;
        Tue, 23 Nov 2021 04:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PmcU1Ad5hGOKrtctKRq/pbfb3e4GptfnLdKFtOED7KE=;
        b=fNrEBBUZjfAkxJ0xIyWUWIBF7KQmPCEMe9w7/Ln0+1eh0uQDkrzCvDWFEzAGFUIr/E
         hbQQaAcruBJ43GIH2mal40NZTPUxAjf4EwXJtB5XjmrNaDxzKeBYCUJKi8LaXJvpfWtc
         BAL9U8tkK183963DSlz54U5O28mYY1kYzT/38ZjOu7qDa+bbxPtyzEY+4yVyauRXYEJY
         olBXOronmE6urUFTGxEQ8DN9QasFp9xa6RmwumJSlyPNjxXsWxze/sc6NTyPFk9mqHIT
         FP4WwsZV7eCkiSVt1iKjx8uFI2h3oq/WuNpzNgG4Wtcup7QZQxEZhM1Y4QI6IbeBiCiJ
         zX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PmcU1Ad5hGOKrtctKRq/pbfb3e4GptfnLdKFtOED7KE=;
        b=veqdzWL5k/mVLSEoCDFkwLnQtNpZvJ2ygqOAYTxcZB2Wp2K9kDxZpLHw3pZw2y1+EG
         X7HOHfOHR5NDHFGOEDekHPizpd9y79xYPzflW9cJmN8FL7ksTopsKA5TskxFAjwpKCY9
         +gKW+wQOKukXXTkrwTBLWGLlr4jOzOgC/Ddo0MkXo61mT6ZXSvgiJXUOXj1jJE4ux+bx
         JppMYYnxYj256fNenQEPV2KS1IzVrHD0cfEIy7QCWuWl3QMXMDNLnpQrNRYnddYVdLKz
         G8lrQcnkGeSVTKwZmS6kXty9wQm+pnzxDC07gd4ModHtpGtXu3SR9LE7kxrFjNRy3e2O
         67uA==
X-Gm-Message-State: AOAM5309GS18iCiGm6ieP2AAjzCrkbADnAoBw7cM7H5K/u+1WIU+tVgG
        TeybhcaqIWSDj6RZNXIx3us=
X-Google-Smtp-Source: ABdhPJxYzrUOpnn0PyqsxgguDlujgVu/Qf/YMrlsxk9WuXBd8mzK7Qz1Gfoca+w8sswV9jZwB5hCKQ==
X-Received: by 2002:aa7:93c4:0:b0:49f:a7f5:7f5a with SMTP id y4-20020aa793c4000000b0049fa7f57f5amr4743102pff.8.1637668959018;
        Tue, 23 Nov 2021 04:02:39 -0800 (PST)
Received: from [192.168.1.5] ([110.77.218.179])
        by smtp.googlemail.com with ESMTPSA id m15sm12623825pfk.186.2021.11.23.04.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 04:02:38 -0800 (PST)
Message-ID: <7c32898b-fc65-b624-ea33-c3cc02e15b63@gmail.com>
Date:   Tue, 23 Nov 2021 19:02:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] USB: serial: option: add Fibocom FM101-GL variants
Content-Language: en-US
To:     Mingjie Zhang <superzmj@fibocom.com>, johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211123082634.21498-1-superzmj@fibocom.com>
From:   Lars Melin <larsm17@gmail.com>
In-Reply-To: <20211123082634.21498-1-superzmj@fibocom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/2021 15:26, Mingjie Zhang wrote:
> Update the USB serial option driver support for the Fibocom
> FM101-GL Cat.6
> LTE modules as there are actually several different variants.
> - VID:PID 2cb7:01a4, FM101-GL for laptop debug M.2 cards(with
>    adb interfaces for /Linux/Chrome OS)
> - VID:PID 2cb7:01a2, FM101-GL are laptop M.2 cards (with
>    MBIM interfaces for /Linux/Chrome OS)
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=01a2 Rev= 5.04
> S:  Manufacturer=Fibocom Wireless Inc.
> S:  Product=Fibocom FM101-GL Module
> S:  SerialNumber=86bffe63
> C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
> 
> 0x01a2: mbim, tty, tty, diag, gnss
> 
The descriptor say 7 interfaces but you have only listed 6 in your v2, 
there was 7 in your v1.
I'm also quite sure that the interface with Prot=30 is the diag interface.

rgds
Lars




