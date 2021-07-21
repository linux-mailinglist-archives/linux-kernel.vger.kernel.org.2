Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F93D16FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbhGUSiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbhGUSiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:38:02 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ECFC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 12:18:37 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 31-20020a9d0ea20000b02904d360fbc71bso335224otj.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zI7SkFaWWbDBEZ1zEkQYT42jKObz7/x/yVA7oosczwA=;
        b=PsPsGJa3ehm9Dgn0eAs9JRl+SgFtERWuNG8WPSDzZWXyZvo1FVY7DmpmiveBOW+PjD
         10nTwvEazJSAJB9d6UI9qYLwkM0/NcXt6AU21I1e9OAhVOfa2tDjTQNvcXeFZvgp3i2R
         Gesn28zAqB1r6wwNzIK7AIfATS7frAjnpEZJdrb1MfmqPxsM5RZbha6WzgKPFWDByjFq
         WengrKo8Td7/vnbKYVxX/pw7aGPdy7J8B+DEvVKAcsJaQ9Kh6qGD5btms8W9N9HmmfHt
         ONPYbWGX8/3BC0tU1rVFmDid83j1BlA3cxZhbSH7O4YqyirsiKvi1fesPlQkIdMBZCr/
         cCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zI7SkFaWWbDBEZ1zEkQYT42jKObz7/x/yVA7oosczwA=;
        b=sNLflSumvnU5RpjH+WujTQHKArHPvBPQtruuxK2o/y2b8i16USjxKOVv2Yhn0mq41G
         9GeFAj4BsRIajP2hShQOws72W5BUQ9xX9QzDa/906RabzA26Qwjmx3ZdSYCJfEU6qlj1
         DtpvLN100NBwsCF6U15xqPa7nj3peGQOckSsGkv7Q+3kZWlBqgFWQTL77qEhO+JObLQo
         jxHpceqaR6PrKuTEwmE0AkzDl/wvXBjt0pFjIoWjLhfze6BBouC6WDUD2Dhuep7WDSEn
         jicyinxzPNGQ9sdty3MAUhEQE+Bze3Gd9CAVGsJU9v2vSn0EohNeTRzTVCX4CvLgSTDR
         m58A==
X-Gm-Message-State: AOAM5328LcDJZ3tBbZYCoYL6BNsPYho4jTDZITRCbcnDmV7JprTp3T7e
        BQyMVdMbi9UA8FLVZklxWyE=
X-Google-Smtp-Source: ABdhPJw5RIg9qxIl36oJODkJ8bmdEYrdw0fQyjMeH4c5RMlQpUr+T0v2RhGlHP0sFWJ9AobPf/S0Ug==
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr27290043oti.274.1626895116637;
        Wed, 21 Jul 2021 12:18:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id x3sm1849590otr.69.2021.07.21.12.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 12:18:35 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH resend] staging: rtl8188eu: move all source files from
 core subdirectory
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
References: <20210719224601.255364-1-phil@philpotter.co.uk>
 <7bc43fb0-2dab-190b-c480-9e77cff863d4@lwfinger.net>
 <20210720090035.GB1406@agape.jhs>
 <08a8b372-8ec2-afcc-cc54-305d1dd74a59@lwfinger.net>
 <YPfRf8dgFd+u5hzm@equinox>
 <0c2d97fa-e1e1-3564-98b8-37d5b9a1a9cb@lwfinger.net>
 <20210721182836.GX1931@kadam>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <ed7b7d93-f754-dce9-ca4f-425e49c972ba@lwfinger.net>
Date:   Wed, 21 Jul 2021 14:18:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210721182836.GX1931@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 1:28 PM, Dan Carpenter wrote:
> You're obviously not a Realtek employee, but what are they doing for
> wireless drivers these days?

You are correct in that I am not a Realtek employee, nor do I have any knowledge 
of the internals of any of their chips. I do have a close working arrangement 
with the head of their PCI driver development, and I have gotten free samples of 
some of their chips. I am a volunteer that is interested in providing drivers 
for the devices in new laptops with wireless chips that do not yet have a Linux 
driver in the kernel. I also provide relatively modern drivers for older USB 
devices through GitHub repos.

 From what I know, the PCI group at Realtek is mainly working on new 802.11ac 
devices, but are leaving some hooks for the USB and SDIO equivalents of those 
chips (RTL8822BE, RTL8822CE, RTL8821CE, RTL8723DE, and RTL8852AE). These drivers 
are either in the drivers/net/wireless tree of the kernel, or are under review 
for such inclusion.

I have no current contact with the USB part of their driver development.

Larry


