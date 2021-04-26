Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA76E36B7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhDZRUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236184AbhDZRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619457587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/jsF2lxKTl/lUe6Kjxs6QcmJ4QNt4VTFtwwHU6p+vE=;
        b=GbTX9gQ7DomP//8tlvW+qMzOLlmZbp9vcOixlvcZekvZz2ogjkFMi358jjwTjZadZdbssR
        POUHftBBTiHmCdrconUNHICFyWx4Vfo2SFYILhPiAlqAmZsWzH2/VfH2tS7hpGAsxU1TI9
        V7ySkNQMs9qUIXwHxs+MmLTtBFp1c1o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-IsNZwtnQPq6bLlleXOV-AQ-1; Mon, 26 Apr 2021 13:19:45 -0400
X-MC-Unique: IsNZwtnQPq6bLlleXOV-AQ-1
Received: by mail-ej1-f71.google.com with SMTP id t9-20020a1709069489b02903807ab24426so7921365ejx.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z/jsF2lxKTl/lUe6Kjxs6QcmJ4QNt4VTFtwwHU6p+vE=;
        b=DtR9gICnb3yVvaJXwe7p/kw3IeZNb2yob3EZ6ux9DqXvu2msmMxih37g+xDaUU08vU
         n/Zw7JDwXDNwLWK9r8FvBZSzWhToQrfe3BKfgwSSXqGrPdf1ajeJ5DNe43WaIO38Uubl
         iFBS+i/lPc6Hibbeq7cwewYSvnd4v2ybMPUo9Ncd2fbUI+3GUoRKkDvjn1BHjjG12YhT
         SGGtIJPlfghXbfgL16pl/QwedzPGxdRdW/v3VAmC38xnAP7Q1aHtm9YzHt1igu0R/T3P
         bGCOXw980VBCoAfZwjBr4AG3hjQL/D93glxazzvIl4Mrd621SeuWu556knjfc7GUBpGj
         5oGw==
X-Gm-Message-State: AOAM530fqoU4eKxQ1yTCqL/8MauGmdE8GzvyCmjf7KBGDUVN4r4FspTu
        QiNe4UM49fQNHIy99PV3UH3sBMVSLFgeEa66KbP3Jzgwc4an/+UabTO57++1cST+84jncVVr2v0
        ukD7rVsjNZCC8BQqRLDeZLBh8
X-Received: by 2002:a17:906:4e51:: with SMTP id g17mr19805645ejw.18.1619457584326;
        Mon, 26 Apr 2021 10:19:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6VQAzC4ozqxFIxRQ8nLBSgYynBvabkbW60Yy6bs9LoxYV5FXPtMXJ9E544b9ZjDCj6kDasQ==
X-Received: by 2002:a17:906:4e51:: with SMTP id g17mr19805636ejw.18.1619457584202;
        Mon, 26 Apr 2021 10:19:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k5sm378981edk.46.2021.04.26.10.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 10:19:43 -0700 (PDT)
Subject: Re: [PATCH 186/190] Revert "virt: vbox: Only copy_from_user the
 request-header once"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-187-gregkh@linuxfoundation.org>
 <68067532-56e5-c135-7a7e-0743c8e7b2a0@redhat.com>
 <YIBaDvrNVHlNRuXM@kroah.com> <YIbzdac1uM63QPMB@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <938d95f7-953a-0caf-5984-adb1f1085ebd@redhat.com>
Date:   Mon, 26 Apr 2021 19:19:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YIbzdac1uM63QPMB@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/26/21 7:08 PM, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 06:59:58PM +0200, Greg Kroah-Hartman wrote:
>> On Wed, Apr 21, 2021 at 06:51:24PM +0200, Hans de Goede wrote:
>>> Hi Greg,
>>>
>>> On 4/21/21 3:01 PM, Greg Kroah-Hartman wrote:
>>>> This reverts commit bd23a7269834dc7c1f93e83535d16ebc44b75eba.
>>>>
>>>> Commits from @umn.edu addresses have been found to be submitted in "bad
>>>> faith" to try to test the kernel community's ability to review "known
>>>> malicious" changes.  The result of these submissions can be found in a
>>>> paper published at the 42nd IEEE Symposium on Security and Privacy
>>>> entitled, "Open Source Insecurity: Stealthily Introducing
>>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
>>>> of Minnesota) and Kangjie Lu (University of Minnesota).
>>>>
>>>> Because of this, all submissions from this group must be reverted from
>>>> the kernel tree and will need to be re-reviewed again to determine if
>>>> they actually are a valid fix.  Until that work is complete, remove this
>>>> change to ensure that no problems are being introduced into the
>>>> codebase.
>>>>
>>>> Cc: Wenwen Wang <wang6495@umn.edu>
>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> Ugh what a mess (the whole umn.edu thing).
>>>
>>> I still remember reviewing this patch during its original submission
>>> and I've reviewed it again this morning when you just send it out.
>>>
>>> And now after letting it sit for a bit I've reviewed it a third time
>>> and it seems to do what it says on the label / in the original commit
>>> msg; and if fixes a real, potentially security, issue.
>>>
>>> I'm not sure what the process is for "good" patches in the set
>>> which you are reverting. I would prefer for this patch to be dropped
>>> from the set of reveert. But I can also submit a revert of the revert(?)
>>> once this set of reverts has been merged.
>>
>> If you have reviewed it, and think it should stay, I will drop the
>> revert from my patch series.  Other maintainers/reviewers have asked the
>> same thing for their patches, which is fine.
>>
>> Anything that I do end up reverting, that was not reviewed, will be
>> again reviewed by me and others to determine if it is "safe" to come
>> back in at a later point in time.
>>
>> So thanks for the review, I'll drop this one.
> 
> Now dropped, thanks for the review.

Great, thank you.

Regards,

Hans

