Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF744131FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhIUKyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:54:12 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:45683 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhIUKyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:54:11 -0400
Received: by mail-ed1-f53.google.com with SMTP id c22so72460849edn.12;
        Tue, 21 Sep 2021 03:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=STQ1SYPDR3l1tp+29Ksawhjtp3/4UkFtTcVlzO20jxw=;
        b=eYEEEHY7Yc5Jp+UniIVV9z6z0e7nWxGRT0U7OQim/zRmuUsh7D4BqRX7ikyQICrazc
         hCgFsxRgVaaDRdWkSfeprfD+ODGF7IPT7NZghF1uKKt+BnVWdolACy3IBXZUTFj1v+kF
         suUs2NFKCyqyWbRT0jhsab11arF5/ZYKO/MiqG06h3UArFSuaLZkqxKFoNfTGj8AseNd
         OmeZxHd7aWdQeKyo4ov0r9yUglCQjdocsQO4PLG/Rpw6iiJ8+6wQNz3l2lEphRvmbXaz
         +SlJkOLXsC1/WvuHu4l8bBif9lfGBSyexLkzS0jhex8xEfYI2ZvH6Bla0NsySlRBTcT/
         9ZGA==
X-Gm-Message-State: AOAM530uyk+RTt6eEnhaWogKESv00CJMGi776YHKKZQ0Hp4/O/ziIieU
        3zcvHsTwy3o70HHKIEQkGj9JPgAoAAQ=
X-Google-Smtp-Source: ABdhPJzV8kO9F47YfqiJ4yR/67N6EPeYnE5Lb57mIqp/kxCSXyTqietIepnIBS8SxLdoCnSBkVZnxw==
X-Received: by 2002:a50:bf02:: with SMTP id f2mr21867212edk.98.1632221562314;
        Tue, 21 Sep 2021 03:52:42 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id 10sm5689589ejo.111.2021.09.21.03.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 03:52:41 -0700 (PDT)
Message-ID: <9049e956-2865-7309-2eaf-aa4516ab28d6@kernel.org>
Date:   Tue, 21 Sep 2021 12:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 07/16] tty: remove file from tty_ldisc_ops::ioctl and
 compat_ioctl
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091134.17426-7-jslaby@suse.cz> <YUlY5pQQWf2P2fKn@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YUlY5pQQWf2P2fKn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 09. 21, 6:00, Dmitry Torokhov wrote:
> Hi Jiri,
> 
> On Tue, Sep 14, 2021 at 11:11:25AM +0200, Jiri Slaby wrote:
>> diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
>> index 17eb8f2aa48d..55e91d0e70ec 100644
>> --- a/drivers/input/serio/serport.c
>> +++ b/drivers/input/serio/serport.c
>> @@ -207,8 +207,8 @@ static void serport_set_type(struct tty_struct *tty, unsigned long type)
>>    * serport_ldisc_ioctl() allows to set the port protocol, and device ID
>>    */
>>   
>> -static int serport_ldisc_ioctl(struct tty_struct *tty, struct file *file,
>> -			       unsigned int cmd, unsigned long arg)
>> +static int serport_ldisc_ioctl(struct tty_struct *tty, unsigned int cmd,
>> +		unsigned long arg)
> 
> Can we please keep arguments aligned as they were? Otherwise

Fixed, thanks. Likely, I will send a follow-up -- depending if Greg 
drops or keeps these in the tree.

-- 
js
suse labs
