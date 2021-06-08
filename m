Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA53A07D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhFHXh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbhFHXh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:37:56 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC6C061574;
        Tue,  8 Jun 2021 16:36:02 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so17678201oth.9;
        Tue, 08 Jun 2021 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=11L9EZCTwrDHTYvTO9qriIZoVtGiINe/wCCaSPlNKf8=;
        b=Uoewj/YDhpVc7q/P0nuMJMSmQ50ugmYGSlxPPj4RVumXTcmH/qRC0XXzwQ8BcUx0KH
         66SATvMb+Xhb79bzPIkW4owPUpu7+v6o8u2c/22d13miCKVaxY5myb0NWNd3HhLDqL4H
         +QR5/55XerPmjVShE/LkoietJDTrV4b3LYGGZr+HMijF9vREkLVyZ6KXkvAuITg9StwJ
         wAwXWD2zudlHgldxVBeD2CtBoFfC2efEdShyyyuHKdtwv+v05b/njK8rASyxbxcD+O1y
         pcFG9b7G14yukZT3OdYUttHRslsFdCv7gVA361kTxKIdvjtTijh34oSwMIdYDKQ0bVuo
         ODVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=11L9EZCTwrDHTYvTO9qriIZoVtGiINe/wCCaSPlNKf8=;
        b=Qt/N3uCZ973K3ThUX73vLSFf1jlY68PofF7Xv7Ef6JHpW63Bg0RxDM5ourH120mo0g
         z414A3tvu8Uc/0jfSEqBHzss8rkjBIMD+anCITPlgiWzr9F6acsUF7FiEo3z+xRYelfz
         hdpgrzglrYgVN0bg0gzBvvcKLrLHIcLXyPBnT7ASkZmKIZB9UftPsEukr5kzdKKzbLvy
         FOZ1AkK9uHaVH63a71oo7teoomOv9Cqn93dag5rjJ1dE2qaKlv0v5jocg1cLBnJ9CBnD
         fXZPU7AQ56+Q6Mh5Goc2A0kqzaSNJVmSbEb/lBAnIigHyr+fcQOy/8Abi8BIApiyH+zP
         w2dg==
X-Gm-Message-State: AOAM5324W5DoOArEDY5p18EDn8ERnnwbrmUseV8Wi0CBTFQoXatayN52
        Y8zwiAt90wnxcJ+ybUhqzSat8RSpU0A=
X-Google-Smtp-Source: ABdhPJzzxO/BM32kFIondkYsXDm8R27t/zWwuayeKSE2bSbC8zdiMEWyQ56G8lfJnGD6oMUTLDpxFw==
X-Received: by 2002:a9d:684d:: with SMTP id c13mr19845118oto.201.1623195358787;
        Tue, 08 Jun 2021 16:35:58 -0700 (PDT)
Received: from linux.local (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t26sm3463360oth.14.2021.06.08.16.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 16:35:58 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Strange problem with USB device
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        ierturk@ieee.org
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
 <20210608182038.GA1812516@rowland.harvard.edu>
 <a7c7ba62-a74f-d7db-bfd9-4f6c8e25e0b8@lwfinger.net>
 <20210608185314.GB1812516@rowland.harvard.edu>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <6a6183b3-d113-179e-6939-d92bafb62398@lwfinger.net>
Date:   Tue, 8 Jun 2021 18:35:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608185314.GB1812516@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 1:53 PM, Alan Stern wrote:
> Yes.  Use the kernel boot-line parameter:
> 
> 	usbcore.dyndbg="=p"
> 

This command was tried, but no additional output occurred in dmesg.

The user has now tried a number of Linux distros, none of which worked, thus it 
seems to be a kernel problem. I have written to the BT people at Realtek to see 
if they have an suggestions. I will let you know when I learn more.

Larry

