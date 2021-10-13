Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2596442CC66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhJMU7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJMU7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:59:14 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4EC061570;
        Wed, 13 Oct 2021 13:57:09 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id u5-20020a4ab5c5000000b002b6a2a05065so1228174ooo.0;
        Wed, 13 Oct 2021 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qlyS/cvj8WUS5oNYSnjL6ZoAUF8yWfmcdbUL5rAb7pU=;
        b=h8RaLrAx3MYqU050Dfmajj2hUL896Qqs957Y0NVDT+ofYVFEiDgpME3xH2CBUpp7jh
         yIy61gUJ3SiZENyeoNHRiUbLDVSkPckoymLQQ/04Ns7RCu0OW+vHTOfmbyUEdvDdOnN4
         ysR67yiaadIc09PSjDjHEB8YKyuUzaoUOYsOPjCdIWtbGirl48uXRx2pQys9Ux1KE9W2
         ltfIR98kxcakpUe6Q6rKx9mpSET5rNvfkrttJOXmPRxH8Y6yB1dCvYqszPFKkdy5ECIn
         FbJbr2aBvKCl3oUOh9ZYXSxoxjbQFSyFdWQfpqdv0F9Y2it4TUZdXWsvat8kMRUBjVFh
         ERdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlyS/cvj8WUS5oNYSnjL6ZoAUF8yWfmcdbUL5rAb7pU=;
        b=dS3Pdnge/SClJPIBCcFA6kHHt7p5ciorLE5Oc0+aegLbxIIIko82oKzZv7HxJ5ton+
         HH+IdkKY9NbHznmlO7ah3eG7Yb27faGUgbWnjb18OTYp7ckt7VVCsHemyoZjb9fljr04
         4gdo+/0ZnHa+JF+ap2beXtqAf48+9JDzdyBn2uZ41YCApr82uudal48jLTtW4/OcQzYx
         SaXN8bs/q5czSRv7kDsV8tsCGwbEV5OWNNj0pJElp5dtYdRSrOCsg2Owa976faKcr+wE
         qXeZZtF5rZqo8dqjFsL6Ki5gMPqbcno2jEMYi1J4WKB+Oij2AmNxG8XDtvkxuD1MBopR
         9hRQ==
X-Gm-Message-State: AOAM533rwLc5S+X0XEDc3XUjq4zBS/HeBJ5X69H2tzXAR8t5aK6QVnwB
        J6ZQw791NJBV0RUfavpbYeYTlZQnowU=
X-Google-Smtp-Source: ABdhPJw7RpzwuAtqd2CW7HXZew58+3Eo/FPoGUPvSNAcMxgXEoqy7n69du8xFq/jZxaZYOJwY5X8IA==
X-Received: by 2002:a4a:de10:: with SMTP id y16mr1127123oot.4.1634158628340;
        Wed, 13 Oct 2021 13:57:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w93sm139765otb.78.2021.10.13.13.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 13:57:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v6 2/4] usb: Link the ports to the connectors they are
 attached to
To:     Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210407065555.88110-1-heikki.krogerus@linux.intel.com>
 <20210407065555.88110-3-heikki.krogerus@linux.intel.com>
 <YWdBZY7vSWO7DN54@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d82e9972-0d30-f9f4-9333-de57146d5543@roeck-us.net>
Date:   Wed, 13 Oct 2021 13:57:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWdBZY7vSWO7DN54@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/21 1:28 PM, Prashant Malani wrote:
> Hi,
> 
> On Wed, Apr 07, 2021 at 09:55:53AM +0300, Heikki Krogerus wrote:
>> Creating link to the USB Type-C connector for every new port
>> that is added when possible.
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Did this patch eventually get merged?
> I somehow don't see it in the "master" kernel branch [1], although I do
> see the commit in that repo [2].
> 

It was applied but later reverted with commit 5bdb080f9603 because
it created a module dependency cycle.

Guenter
