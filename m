Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E252E40FB51
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbhIQPIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343682AbhIQPIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:08:17 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F68C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:06:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq5so34317391lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=69GiEXKdxt+heGKGrbL9Gx4hEjgC+QbxrWSsOk2igRI=;
        b=NQYj7NnZDoDKkzXPvTD+hAVBr9Dkyab+NW985IjEd6ASiEXrJCd3ZHOVOGeO1tMg7i
         Ac/gNUpxC9X3+nTaa+FIY3AYYL6kvIF3y2YtdQOMO4haPe9jd5U6pG/LWhuNuiVf2ZKd
         PQhktx8xNYT+19D4vSVO8w/OFDUb3ki5CXa7cZKvXF0EvU8HjwGu/fEMKRGUD0EbQqqd
         002PnxwosU4JZYsTgaL+xtVIgpZGYB4C353WdU73LPD0Bh1Xj2QSNm0EImELfqs/c2cu
         fnj0VMX30d3M9Y3doLAUdLHdKcgoL0Sm4KntKdGn8nmPgSU2Ch527yrXEhrB9vhqzOpe
         fABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=69GiEXKdxt+heGKGrbL9Gx4hEjgC+QbxrWSsOk2igRI=;
        b=g9gP5uxvY6czpN03UQd+PrK1MuxhZhEQSrMIFdiLhJsM0LkCNm6enOflytFd0k2S+Y
         /tF5iHkCPoBXykjAEpaN43nQnssea7Wj8dwazDcluVtk5v/FDFizweF9h6Tl2YD8hOeM
         Ev8B4JNdFxHTGx1IKNOoIMfOo2XwIpUcM+1q9R1nDEL4VAqzwgdAH4uLz2my/zO5JozG
         gK7e2O2/CXfZiRaDlEzWPwjOP/wKrh6NSPSxYIoGjEUDBsqcjsfUnMboJL/Dx6njyejV
         zCOml9GB9ptGpKsX6/ZEF49QZg7KnL5qYta7+JBHVOAbeepqdOyYzSGvNImXn+D6qRfL
         75NA==
X-Gm-Message-State: AOAM533EH9E9d772pC1M2nwpyfeJKtwmXxjsLENrdGjCMKDsCyIJJB9v
        IR+Z4ppaGAFlMdwCKdFW540=
X-Google-Smtp-Source: ABdhPJz/TwYXrI1XJ2iaymgE0fildrBim7Lw6rJyEaWfVPSUeZ0fZO5TuStQyGxVQZG24EfK5iepmw==
X-Received: by 2002:a05:6512:10c8:: with SMTP id k8mr8591405lfg.326.1631891168976;
        Fri, 17 Sep 2021 08:06:08 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.49])
        by smtp.gmail.com with ESMTPSA id e24sm548860lfs.212.2021.09.17.08.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 08:06:08 -0700 (PDT)
Message-ID: <e993abd4-1cd2-b2ef-cae3-e97c12e46ae4@gmail.com>
Date:   Fri, 17 Sep 2021 18:06:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v7 19/19] staging: r8188eu: remove shared buffer for usb
 requests
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
 <20210917071837.10926-20-fmdefrancesco@gmail.com>
 <YUSsa+3NjQVGD9gb@kroah.com> <ef2a89f5-f68c-e7e2-9338-78e70dc41701@gmail.com>
In-Reply-To: <ef2a89f5-f68c-e7e2-9338-78e70dc41701@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/21 18:03, Pavel Skripkin wrote:
> On 9/17/21 17:55, Greg Kroah-Hartman wrote:
>> On Fri, Sep 17, 2021 at 09:18:37AM +0200, Fabio M. De Francesco wrote:
>>> From: Pavel Skripkin <paskripkin@gmail.com>
>>> 
>>> This driver used shared buffer for usb requests. It led to using
>>> mutexes, i.e no usb requests can be done in parallel.
>>> 
>>> USB requests can be fired in parallel since USB Core allows it. In
>>> order to allow them, remove usb_vendor_req_buf from dvobj_priv (since
>>> USB I/O is the only user of it) and remove also usb_vendor_req_mutex
>>> (since there is nothing to protect).
>> 
>> Ah, you are removing this buffer, nice!
>> 
>> But, just because the USB core allows multiple messages to be sent to a
>> device at the same time, does NOT mean that the device itself can handle
>> that sort of a thing.
>> 
>> Keeping that lock might be a good idea, until you can prove otherwise.
>> You never know, maybe there's never any contention at all for it because
>> these accesses are all done in a serial fashion and the lock
>> grab/release is instant.  But if that is not the case, you might really
>> get a device confused here by throwing multiple control messages at it
>> in ways that it is not set up to handle at all.
>> 
>> So please do not drop the lock.
>> 
>> More comments below.
>> 
> 
> We have tested this change. I've tested it in qemu with TP-Link
> TL-WN722N v2 / v3 [Realtek RTL8188EUS], and Fabio has tested it on his
> host for like a whole evening.
> 
> I agree, that our testing does not cover all possible cases and I can't
> say it was "good stress testing", so, I think, we need some comments
> from maintainers.
> 
> @Larry, @Phillip, does this change looks reasonable for this chip?
> 
			 ^^^^^^^^^^^

I mean mutex removal, sorry for confusion :)



With regards,
Pavel Skripkin
