Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75F63F3212
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhHTRN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhHTRN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:13:56 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D10FC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:13:18 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so15398271oti.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FXSqbQkGwpmuS098nxMAvtEnVwMvIhc8mYNL176c7Gc=;
        b=LhTpqsGUoUHR22mwvjEuKWTyIgpnlo0fudH8JszfBfl8vw/u7iDHObOKAlj5JCWo+r
         QfhXJVCPgtqftDEL4YbzXxc8zt+qPkORkpdzn7yXHvaBt0+yijNwLv1F/gHBx64AwmNA
         u4Ho1lWEZOyDFTApDW/XxNkr74fCgwT3oCOmHagk+CkeFakWC3AOrlrY04kBgovbkomz
         terQGzTTPjYGtRGesP//tqfvP6NfC4YZVKMrxkMHim2FeioiyXZQR8EuGTUc547J61Es
         3IF2Ye8kLKDatrOpJnOCPyOgr3nDS5mQQ5lCIrdJ44Ge6o5ylltd+I+MyUk162HqNtkS
         YuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FXSqbQkGwpmuS098nxMAvtEnVwMvIhc8mYNL176c7Gc=;
        b=BngomULyskqVKuyhmrcjq+6dAmxkbLXj7HAde2yFgbcsYnfwclhwsCX+htLjZGZoHS
         Pr3XyafZCtwzdlE0lMQzbkAWpPoX+2g7RNKOqpWxY+Bi1j65hjR7bi+4z5QhHILv/oae
         U08ETsfX58gAXKxhHZmQmoSVask8fT9VXuc+TKF3qHY/tnxF5GaLyk8k8fevVLmi0L+1
         sYVXy+w7Q5uwdkm/ZiKSI9NOOnclvWfSmlqQUiDMCjHvL5ajXlmT0DewmnCFkIL3hNhB
         LGHDUIbLBPN1nKq8h9AWDFakttJEDg4BGyJBumEo4qGmMr5uvVwlQ1+uaZvCmIFhmaid
         24bQ==
X-Gm-Message-State: AOAM530Nocu+xW1UdIGbqzE9h4ZDH90OlaeRN9QmifG15ya68KKYY1XS
        hg+0mCTwZ/fd91loz+JOWG0=
X-Google-Smtp-Source: ABdhPJwoXP+Q96yW0pS89vi2le0AyX3sajJwfU8BRmrxi9PhyXb7BshkwPYpy2+TrWz/FqIf826Zew==
X-Received: by 2002:aca:2206:: with SMTP id b6mr3687793oic.88.1629479597791;
        Fri, 20 Aug 2021 10:13:17 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id 32sm1590953otr.2.2021.08.20.10.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 10:13:17 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH] staging: r8188eu: clean up endianness issues
To:     David Laight <David.Laight@ACULAB.COM>,
        'Aakash Hemadri' <aakashhemadri123@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <8a3fca82d9ec5dde9e42d40f0268a324cc87ebc6.1629301854.git.aakashhemadri123@gmail.com>
 <3dfde3cd06094e52b71b48a3a2524226@AcuMS.aculab.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <8bd7047c-49d1-b93d-3ccb-96d9773f3f66@lwfinger.net>
Date:   Fri, 20 Aug 2021 12:13:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3dfde3cd06094e52b71b48a3a2524226@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/21 5:26 AM, David Laight wrote:
> From: Aakash Hemadri
>> Sent: 18 August 2021 16:53
>>
>> Fix these sparse warnings:
> 
> Did you test this code before and after the changes?
> 
> I think you've changed the behaviour on LE systems which
> are probably the ones it was actually tested on.
> 
> Don't blindly change code to fix sparse warnings.

I'm late getting into this conversation. Gmail thought the original patches were 
spam.

First of all, we need to change the behavior as the original code is wrong; 
however, the code involves PPPoE, which I have never used, and never tested. I 
still need to check the correct endian values for one of the packet types. I 
hate reading IEEE official documents!!!!

I should have a review of the patches later today.

Larry

