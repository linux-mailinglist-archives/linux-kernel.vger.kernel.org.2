Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C41439971
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhJYO7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:59:54 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38124
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230268AbhJYO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:59:48 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 379D73FFFE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635173845;
        bh=XEEjbbf43TVhSZTAS8/8FyfDDE32FaOk0qv1/zEV4vE=;
        h=To:Cc:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=SRnq/lnLmHfRU5bTQmByhzEtRpZq/XZwkLAojaHKrI1KdGwht1dAouebmZ4Dqsq3x
         tYfweSjbRCxuKQip8UPrUtY/Ux4fV8ZmbWfakN1maYwYf90jnlCHFhNtpEzWq9obAa
         /HPKAf6cCRxbaBAsxgT+fv3zZrO0yVqsGL4fcahdu/JKXCtUdO/zG27TrEG5QznuOB
         pyxaqeFTP6yX1VKHCKquoEqyPRxRcqxIX4/UtW33zy1EqZTFkR8LQcwPeSSyem0pxW
         3GpJiqsDV3hzCuhUk60SsAVy2p09lZAEITeYoMSSRP7cczdJGRYzGWu1K+m5NkA9J8
         ENTt7v+K6RXcg==
Received: by mail-lf1-f70.google.com with SMTP id f21-20020a056512229500b003ffaa744cddso1338728lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XEEjbbf43TVhSZTAS8/8FyfDDE32FaOk0qv1/zEV4vE=;
        b=qSBZQE1F7SpkIu4r33fyjKOTPazguYcJsoVygN8ibii590LVNvKPluajxm0p1Pn0g9
         Tvpftlu+apkjcEPF80DWow2QncA2b3IUT24tClM2In6AD23vNaDtSLwi/Q8T45OLvDgc
         gXW0v9TgDOAUIj2tGKvCBhLK4NDKQRbRkgnPbvp4f/hnyEGfwnb1trGg4c4BgGmuavPu
         jG67nskVw+9rBT3m+SuBUqxQdlCFzfjZawZT5Fy31K8BGXNtSHTfRjNR/QLdqgzjpgWm
         7vuPTO/BnQyTV1+RMWnpOUsi4YCaJ5lGxQ5nClwawo056QXmvX+U8Fvg1whNusYrwTq9
         xUtA==
X-Gm-Message-State: AOAM533DwKLBONpjqj4/TTV1cj6lnk64R/klQOaGD5kXVttsImj4lt+M
        iyjwcLzd/hvXEsgRIBif3H0GtAzUVlk6f8xXfefS1kZdGvLvl5AsWL/BBoZJ11A8W6QazPXZGvW
        1BUGWmu0AYKn6Tmj84rxh5xbdCWD0mPn8MYy/esWGSQ==
X-Received: by 2002:a2e:b748:: with SMTP id k8mr19746543ljo.358.1635173844749;
        Mon, 25 Oct 2021 07:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPV1iXk6ZPy6JDSA7CspXLCnSKn2gUvovFsT/UVPNQJTEld8PZuIm3yagDI5m5bjqhQRCirQ==
X-Received: by 2002:a2e:b748:: with SMTP id k8mr19746530ljo.358.1635173844593;
        Mon, 25 Oct 2021 07:57:24 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id t21sm1671143lfe.202.2021.10.25.07.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 07:57:24 -0700 (PDT)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot <syzbot+abd2e0dafb481b621869@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Pavel Skripkin <paskripkin@gmail.com>,
        Thierry Escande <thierry.escande@collabora.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
References: <000000000000c644cd05c55ca652@google.com>
 <9e06e977-9a06-f411-ab76-7a44116e883b@canonical.com>
 <20210722144721.GA6592@rowland.harvard.edu>
 <b9695fc8-51b5-c61e-0a2f-fec9c2f0bae0@canonical.com>
 <20211020220503.GB1140001@rowland.harvard.edu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [syzbot] INFO: task hung in port100_probe
Message-ID: <7d26fa0f-3a45-cefc-fd83-e8979ba6107c@canonical.com>
Date:   Mon, 25 Oct 2021 16:57:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211020220503.GB1140001@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 00:05, Alan Stern wrote:
>>
>> The syzkaller reproducer fails if >1 of threads are running these usb
>> gadgets.  When this happens, no "in_urb" completion happens. No this
>> "ack" port100_recv_ack().
>>
>> I added some debugs and simply dummy_hcd dummy_timer() is woken up on
>> enqueuing in_urb and then is looping crazy on a previous URB (some older
>> URB, coming from before port100 driver probe started). The dummy_timer()
>> loop never reaches the second "in_urb" to process it, I think.
> 
> Is there any way you can track down what's happening in that crazy loop?  
> That is, what driver was responsible for the previous URB?
> 
> We have seen this sort of thing before, where a driver submits an URB 
> for a gadget which has disconnected.  The URB fails with -EPROTO status 
> but the URB's completion handler does an automatic resubmit.  That can 
> lead to a very tight loop with dummy-hcd, and it could easily prevent 
> some other important processing from occurring.  The simple solution is 
> to prevent the driver from resubmitting when the completion status is 
> -EPROTO.

Hi Alan,

Thanks for the reply.

The URB which causes crazy loop is the port100 driver second URB, the
one called ack or in_urb.

The flow is:
1. probe()
2. port100_get_command_type_mask()
3. port100_send_cmd_async()
4. port100_send_frame_async()
5. usb_submit_urb(dev->out_urb)
   The call succeeds, the dummy_hcd picks it up and immediately ends the
timer-loop with -EPROTO

The completion here does not resubmit another/same URB. I checked this
carefully and I hope I did not miss anything.

6. port100_submit_urb_for_ack() which sends the in_urb:
   usb_submit_urb(dev->in_urb)
... wait for completion
... dummy_hcd loops on this URB around line 2000:
if (status == -EINPROGRESS)
  continue

Best regards,
Krzysztof
