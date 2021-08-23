Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F683F4C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhHWOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhHWOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:20:26 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51840C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:19:44 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso5012627otv.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0n0w4PDIyms1itbpc01zsz9eZtSGypxZCXnsam1uhvo=;
        b=inkq1zZOzw077vCxOERqLDQsrUjy6Y3U12ZdSTf4H9iEsl96d0zdYecyLH6uCnK6t1
         UFD5i0P8DgtKxcF/t2m/DOrttb/idq+BPUpoI44bqYx3nQ4CWKZ7F2AWooQ9CS0IeRX0
         7CfrHKLmQnrPf2LS0opObELhoa5cmXKakytSYecljN/4SS+ET2OjvjEFfxha9TKHg9ZM
         8LqKbHYQFJlao3HD0y9gQnNn+ay38sKTZkZIffeZXsqNFCZ48T80h6aSzttE5VJ8tRYP
         LOUFe5/gpNK9qn5hdedGjhqZrXL66WmXksYUcrO3gT3Mr5rUcsRUYcXHoTK+qqxCCPc8
         R2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0n0w4PDIyms1itbpc01zsz9eZtSGypxZCXnsam1uhvo=;
        b=UHcogKdBD38AN/bVp2M68G8OyhdTnMTuFWuLd/YiL7jjowGn6owoKFqv95V9AnMzWB
         bqsNS3CcQa9hXbtoneD1CXimOIMwxXFUaDI1kb0ASOih/ccYHv2B37FCFQXuJ4QgOS+X
         v1BU/99domcJPuKwzuVwZLUIvJS4iy4dmLO9GaKHXD7Qu2cUGblbquwmgVOai+C1jzbZ
         ZbYZxluPhfDo2N2MS7l0I7vM1E7e+HVTfPlwZI/6IOMehqFauCckTUhUpTzwrY/gM6pF
         lCmX0HY6c1QSHud1pp67RhQPttjQN+01aooihugSrxomFtuV7cqXpHdB1q/jWnDzLm4l
         rujA==
X-Gm-Message-State: AOAM533+ZQn26Un6I+OWo7LfLsbgeQxGNX+TUE4wEYJeLwzzofCgh1rU
        pz6Auy59m32jalygjVlqTO0ruYq+ihc=
X-Google-Smtp-Source: ABdhPJzlLNbbwzemGWWilAuX2b8NTLLUCZqRzR1NUr2n0d1FcV0tdq0e8Y7g1wkOe1nlST9Jj9/ueQ==
X-Received: by 2002:a05:6830:1657:: with SMTP id h23mr18929046otr.315.1629728383412;
        Mon, 23 Aug 2021 07:19:43 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id m206sm3642468oif.23.2021.08.23.07.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 07:19:42 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v2 2/5] staging: r8188eu: cast to restricted __be32
To:     David Laight <David.Laight@ACULAB.COM>,
        Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <602aefc30b0d979dc6e402d52da2f096ea5c67cf.1629360917.git.aakashhemadri123@gmail.com>
 <4be5c5fa-c3fd-8c86-e904-8e2e60173380@lwfinger.net>
 <05aafb94be1b4e609250313709cd668d@AcuMS.aculab.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <c79cfd22-0809-7a7b-2b43-7801a17605d0@lwfinger.net>
Date:   Mon, 23 Aug 2021 09:19:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <05aafb94be1b4e609250313709cd668d@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/21 4:30 PM, David Laight wrote:
> From: Larry Finger
>> Sent: 20 August 2021 22:45
>> 					u32 cookie = be32_to_cpu(dhcph->cookie);
> 
> Modulo anything that really means it should get_unaligned_be32().

True, but cookie is 32-bit aligned, thus the code is correct.

Larry

