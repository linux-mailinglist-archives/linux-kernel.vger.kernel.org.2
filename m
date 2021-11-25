Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E4345E136
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 20:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356710AbhKYT72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 14:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhKYT51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:57:27 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8BBC06173E;
        Thu, 25 Nov 2021 11:54:15 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso2375579ood.13;
        Thu, 25 Nov 2021 11:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3PNODSeJUKSzpmtT5055Fa1wEv5yYWyy+5/m09p+AeA=;
        b=CJbw4Jm+zQe1XFivkZRUmGif9lxaxPHpk++ZyOHrbOq68cgGs3RMcCTBBUUopTP0lL
         h4Bv060+/KUTm8z6qxP4E4OnYDAFQke/ekjYTXsTDeqm3uOqXGI7Al2ZUjZzO/oNKoLT
         P8OTwXpUheF7i05BkCiocW/EjaSGUWvT8ES+RuwptqpIJKLSJwUo5udftfMTX+1Fzlpq
         7nib55zW4TyOk3ZOyBGwTIQQmZFcG3NHCkAfDL6SlpQAWGjLXI5ErqdAFW5IwOgs+JHy
         WAXW9u9axuhiFZwqFM6IjtC25Vn0flc0H66ugiTAZGNzs623IfHjm50+rTbjHZovjeo6
         zNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3PNODSeJUKSzpmtT5055Fa1wEv5yYWyy+5/m09p+AeA=;
        b=lK59vhA7ovVGlDadHgF4CCDkAaSNaXzVHe7Jr+8zhXbo/MBz6PVHUQRy5xYLGr/j7+
         2oIDnVduxS6MQ8s4gBHRRMyNKJvVkVPQ8gYIB1NrI/tBMVNy7lrLBuAo6pFEQLPJk8nw
         dd8IAwDaJe1dUS7hu16a+uJ88Gn85FwlioQf2BtRttlLgvRGBH0u9R934a0hnrzQDzBg
         zi2oR7hUMT3iykpXb95Olh7Wm4TL5vDswFndDTf2tNzsIT/7yXdUZtyoOIDin7AeL9T9
         xa/XggdniaphwXB18nYjb4fY3wVHUf7kyLKbf3XZ9qDR+Bj3oeRI3MwOJi1yGwv4/fRy
         bcOw==
X-Gm-Message-State: AOAM532qacDd5fLu/F2Udy5dzHY+kjaJZAo74uoPkTzjekKjvkeogh73
        dU/sBJCt78SJ481Kzrp1SvVGFU82Tdo=
X-Google-Smtp-Source: ABdhPJx7P+v+iwY3NcbdX5futs8CugPGAXHBFXD0FmRBAeTr/ZRkF8sr+O8Sv2WuGGV3xHCV6hVH4A==
X-Received: by 2002:a4a:dc1a:: with SMTP id p26mr16327693oov.6.1637870054823;
        Thu, 25 Nov 2021 11:54:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12sm657896ots.59.2021.11.25.11.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 11:54:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211122212850.321542-1-pauk.denis@gmail.com>
 <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
 <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com>
 <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
 <CAB95QAT_b8Wef+4wN-H8dKZXxgnznqOk5J0fMuL2XJLhob7d9Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b7616187-87d8-c87f-8f66-d5936a33395f@roeck-us.net>
Date:   Thu, 25 Nov 2021 11:54:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAB95QAT_b8Wef+4wN-H8dKZXxgnznqOk5J0fMuL2XJLhob7d9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 6:00 AM, Eugene Shalygin wrote:
>> Please, do not top post in the mailing lists!
> 
> Well, it was almost a new topic...
> 
>> I'm not sure I have got the above correctly, do you mean that the just
>> submitted asus_wmi_sensors HWMON driver will be replaced by your
>> changes? If so, you guys, need a lot to improve communication between
>> each other before submitting anything upstream.
> 
> Yes, you get it right. Sorry for that, it was a long story and I
> worked on the subject
> only occasionally, so that when Denis took the code and submitted it
> to the mainline
> I was not sure which approach is better, and so I did not stop him.
> 

We won't be heving two drivers with the same functionality. Give me one
reason why I should not drop the wmi driver (or both of them; I am not
sure which one we are talking about here).

On top of all that, this submission isn't about any of the wmi drivers,
but for the nct6775 driver, which just adds to the confusion.

Guenter
