Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7708D3F4172
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 22:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhHVUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhHVUUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 16:20:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCA2C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 13:19:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c12so27573630ljr.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FDptVy7iAjl9M+A0+p4e8e9LtNhAWaLr/wK/1r7PIo4=;
        b=PoCsmbb2j1zVj8uHyL7/lFUn7CiRXyxgbxSHH1Jw8YUHhF5A0l4v1EONMfTWz9tpyl
         0YJYn6U5cCkDVTcrG5n9y0m8wUE6DvHvrKZjUxcgckawCYjagxPxXY6rt3ZC3bSJ0gO9
         /GqspqVhQPWcbaOR6rXCu0yQMQvZu7ZxQxt41yhaO7U2OK68fIU1ihWWialR84neUDDX
         D7SEMo0ZAWt9BBjEQ+kyl9ZNy+iLkHutKPuMM1cu0dtR+wTGUFPd2a9010IGw9k/fWW3
         kZgwV7utAwyt7TQND0aq/2KdBQPit7d82q8v58ejX+nVuwhUCOfP/1N0Lc0jDFe0M3Ol
         5V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FDptVy7iAjl9M+A0+p4e8e9LtNhAWaLr/wK/1r7PIo4=;
        b=Zh8aIHR0GEGJgD6CDM9NQ2zEhzn4Wway2g8f8SvpI3PTNH2IbPS2y2LRDyNlxSgzGV
         1HHmIdgohxjnCV/784A56oXXEZEgR7x4zgGDUdVMBWpyh4Wx3/HPv6SaR0dUQ46N0JzK
         asv2el6Qa8kgJwPeec1hMFvYSYchPX3v4Cwhea7OdfraIBTjI1M/qWObKKmY/h2Ec3JO
         WULxfzdYVD4N9v71C9T8LXG/OhsKhTs8fQEin5rqLr84dXGn+/qOk/qYr5KrRmPyXaVc
         SnhEnnHNt6M3ARYiQlEkrwSu8JKWyHSJFPYzVrs26asZZOGjGjZHPyerr4kRLPmCq5gy
         fZHQ==
X-Gm-Message-State: AOAM532ZwvJl63PAG5NHSBTkIKksBlmsOJTO7DUNJKUWPwroHdRbK90T
        WhkccLgv0JAYIsqbXm8fFo7kvV2wy5g6pG09
X-Google-Smtp-Source: ABdhPJwEfAGC68KbmMAKbP58crb7BvAEFlwceuEHzm3H+SMyc3tSx7awvERj+GP/k2aolYSWgd3rXQ==
X-Received: by 2002:a05:651c:3dd:: with SMTP id f29mr24931735ljp.69.1629663567364;
        Sun, 22 Aug 2021 13:19:27 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id u24sm1266627lfc.162.2021.08.22.13.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 13:19:27 -0700 (PDT)
Subject: Re: [PATCH RFC v2 0/6] staging: r8188eu: avoid uninit value bugs
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com>
 <15979623.JslXr83I74@localhost.localdomain>
 <9ef4cd9f-4f0c-bc6a-76d2-b9e30f6744a4@gmail.com>
 <3600115.G8iuhHfNpT@localhost.localdomain>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <e9ad740e-d970-1a1e-fee9-b26d8c371506@gmail.com>
Date:   Sun, 22 Aug 2021 23:19:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3600115.G8iuhHfNpT@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 11:06 PM, Fabio M. De Francesco wrote:
> On Sunday, August 22, 2021 7:38:11 PM CEST Pavel Skripkin wrote:
>> On 8/22/21 8:36 PM, Fabio M. De Francesco wrote:
>> > On Sunday, August 22, 2021 4:35:05 PM CEST Pavel Skripkin wrote:
>> >> Hi, Greg, Larry and Phillip!
>> >> 
>> >> I noticed, that new staging driver was added like 3 weeks ago and I decided
>> >> to look at the code, because drivers in staging directory are always buggy.
>> >> 
>> >> The first thing I noticed is *no one* was checking read operations result, but
>> >> it can fail and driver may start writing random stack values into registers. It
>> >> can cause driver misbehavior or device misbehavior.
>> >> 
>> >> To avoid this type of bugs, I've changed rtw_read* API. Now all rtw_read
>> >> funtions return an error, when something went wrong with usb transfer.
>> >> 
>> >> It helps callers to break/return earlier and don't write random values to
>> >> registers or to rely on random values.
>> >> 
>> >> Why is this pacth series RFC?
>> >>   1. I don't have this device and I cannot test these changes.
>> >>   2. I don't know how to handle errors in each particular case. For now, function
>> >>      just returns or returns an error. That's all. I hope, driver maintainers will
>> >>      help with these bits.
>> >>   3. I guess, I handled not all uninit value bugs here. I hope, I fixed
>> >>      at least half of them
>> >> 
>> >> v1 -> v2:
>> >>   1. Make rtw_read*() return an error instead of initializing pointer to error
>> >>   2. Split one huge patch to smaller ones for each rtw_read{8,16,32} function
>> >>      changes
>> >>   3. Add new macro for printing register values (It helps to not copy-paste error
>> >>      handling)
>> >>   4. Removed {read,write}_macreg (Suggested by Phillip)
>> >>   5. Rebased on top of staging-next
>> >>   6. Cleaned checkpatch errors and warnings
>> >> 
>> >> Only build-tested, since I don't have device with r8118eu chip
>> >> 
>> >> Pavel Skripkin (6):
>> >>   staging: r8188eu: remove {read,write}_macreg
>> >>   staging: r8188eu: add helper macro for printing registers
>> >>   staging: r8188eu: add error handling of rtw_read8
>> >>   staging: r8188eu: add error handling of rtw_read16
>> >>   staging: r8188eu: add error handling of rtw_read32
>> >>   staging: r8188eu: make ReadEFuse return an int
>> > 
>> > Hi Pavel,
>> > 
>> > I've just read your v2 of the series. I had no time to read each and every line,
>> > however, I suppose that I saw enough to say that I think they are a huge
>> > improvement over v1. I really like your patches and if I were you, I'd drop
>> > that RFC tag.
>> > 
>> 
>> Thank you, Fabio! I appreciate it :)
>> 
>> 
>> With regards,
>> Pavel Skripkin
> 
> Hi Pavel,
> 
> I've read more code of your series and I'm ready to give a formal ack. However,
> I'm not sure about the rules: can it be also given to RFC or only to "real" patches?
> 
> As I've already said, they look good and I like them. So, the entire series is...
> 

AFAIK, RFC patches can be treated as normal patches, if 
reviewers/maintainers don't have objections to code. I am not sure about 
it, since it's my first experience with RFCs :)

Anyway, thank you for ACKing. Let's see what Larry thinks about it. I 
believe, he can find some bugs in my code since it's not tested at all 
:) I hope, my r8118eu device will come soon and I will be able to test 
this series...

> Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> If the rules don't allow to formally ack RFC, I will be happy to ack again the final product.
> 
> I also want to say that I enjoyed discussing this work with you on this long thread. :-)
> 

Me too, thank you. Technical discussions are the best part of linux 
kernel development process, IMO :)



With regards,
Pavel Skripkin
