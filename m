Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E524E37F876
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhEMNRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233333AbhEMNRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620911743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsfYYVuA4z4/qDu23wSBRsngQvHS7+tVBTsrP7EpQa4=;
        b=cbNmWUDmPJI8AsNCR7j6MFnyXHyl8iG5qMOULumNH/9P93AvMH41b8ezjbz3TRKBV2xX6X
        DqBx83xDtm9RysUm0bOScvqPk33xKGxILTBPK9kIbjWPIvvzBU1ip8EWLBRIvaXykBMrR+
        GKEHmHnJSm/madsRpbqjsTvKzMr0qv8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-5Ih0h98oNAupRIE5OqkbOw-1; Thu, 13 May 2021 09:15:42 -0400
X-MC-Unique: 5Ih0h98oNAupRIE5OqkbOw-1
Received: by mail-qk1-f199.google.com with SMTP id a24-20020a05620a1038b02902fa6ba180ffso7733813qkk.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 06:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qsfYYVuA4z4/qDu23wSBRsngQvHS7+tVBTsrP7EpQa4=;
        b=UVBY4ntGsBqp0jXK3y1N2pLprJg2nJI5i3+jnQJHyxN8HX6UoQ12XeS8kXkwTiispc
         pkld050KZ0HIlbSLKV0/nufhE5i/gf39D3ssAE5wpsc5f4gvXSauDEQSj89Iy9Kz8O6M
         0YRMM/6QgKph/TDAVnFnsB7N4ZWGgwdFHg90YZLOIKIlVRBW3wYfTUzI7pEQzVhC+eZg
         bI8KGXkVFZADqoK/pNKxFj3PI5LVmFr4QDhCjd7rhA0pZNUzv8/9RRY11p/tcn2Mi0rY
         /P7ZmlJphiPovwOOVPeM2NHCbu+pPPhDMKjZAw5iFWjx6nLXU889n/EiYykm+aFb1Z/r
         1iuQ==
X-Gm-Message-State: AOAM531NJF6glz/WDB/hBvEE7UneRP6wxQG4NDzR5/IwUNqMshOyh1uJ
        sycgkMClPZl8ITNQ1MMi6uTEBJSCUYgqWphDOIBM5NGTG2h3J2MK0bPjU1K/0qq/7ThBVoBYrol
        7OGCWCChYhI7DsciTejKpma0gdtrDHaBbfGKydElVzUgASLR+nM1uIqMCPCxYBodnDGS7WlE=
X-Received: by 2002:a05:622a:341:: with SMTP id r1mr9994084qtw.307.1620911741436;
        Thu, 13 May 2021 06:15:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwEjyY3u1J/G6+Cm8z9/t8ewZ6vW2TOaD0qCa1us8rfNgrCbblKdYRP+6ulsrYSiTB+uVbAA==
X-Received: by 2002:a05:622a:341:: with SMTP id r1mr9994062qtw.307.1620911741198;
        Thu, 13 May 2021 06:15:41 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l10sm2519572qtn.28.2021.05.13.06.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 06:15:40 -0700 (PDT)
Subject: Re: [PATCH v4] HID: ft260: improve error handling of
 ft260_hid_feature_report_get()
To:     Jiri Kosina <jikos@kernel.org>,
        Michael Zaidman <michael.zaidman@gmail.com>
Cc:     benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210511101208.16401-1-michael.zaidman@gmail.com>
 <nycvar.YFH.7.76.2105131308260.28378@cbobk.fhfr.pm>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8c48cdcc-ee47-3352-4023-db24b7a94759@redhat.com>
Date:   Thu, 13 May 2021 06:15:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2105131308260.28378@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/13/21 4:09 AM, Jiri Kosina wrote:
> On Tue, 11 May 2021, Michael Zaidman wrote:
>
>> Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
>>
>> The ft260_hid_feature_report_get() checks if the return size matches
>> the requested size. But the function can also fail with at least -ENOMEM.
>> Add the < 0 checks.
>>
>> In ft260_hid_feature_report_get(), do not do the memcpy to the caller's
>> buffer if there is an error.
>>
>> ---
>> v4   Fixed commit message
>> ---
>> v3   Simplify and optimize the changes
>> ---
>> v2:  add unlikely()'s for error conditions
>> ---
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
> Who should be the author of the git commit?

Go with the latest patch's author, Micheal.

Tom

>
> Thanks,
>

