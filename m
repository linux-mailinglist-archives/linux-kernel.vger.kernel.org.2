Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D085398AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFBNlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:41:05 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:34634 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhFBNlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:41:04 -0400
Received: by mail-qt1-f181.google.com with SMTP id v4so1825378qtp.1;
        Wed, 02 Jun 2021 06:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fXSd1bu/MjA4kYOL8Ihcm6lOkbPZHxwAQyd0h39bQys=;
        b=Bdqr8pApaGq+LY69gs/wUXsUFNGo62mZ23+zVlJ6VG8qNtM5rlPLXLdHvvdcZCyBlD
         +qIIYSnBy7lRIzGa1UIQuzvEcfBx1M1zEURyVDq2rw2Qz8jqrUqSJgP4cmU6R1/9CqV3
         MdPcUx2ag6vPfItYyFnCcOQSuT3QqV94I3VIwrqYCceJCv9X2spkjEhigVi5priclWVr
         TMbNyRoXyRD14myyUfrMayFW1QaUQvSrBQM9yySxmDdmYg/fw6yeFUr3eRNRdMxMg/eZ
         SSyD/sObfKWFr7+qFsWG03Rwkibjto7JZ4SrbLOVSgkAB23tmCoaelWuZipnUZ9mHMUh
         ZLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fXSd1bu/MjA4kYOL8Ihcm6lOkbPZHxwAQyd0h39bQys=;
        b=tPBXjJJZd53lTgPLjNLjw/YIV4PAUND0dOJwi6dYIYOg5DFr+gbAjAdQgW3GIo/9Ob
         6Mcvbxdix1T1jA0BVwj1uBGZKs3QzihKa5bi2GmPxHorUMa3urHiT/sehF/TFXCb7GaD
         2Ea3sXoY2H7APASBaCspTar7QUQhuSt5wEu+WwVY9MfUTUFLD7hSIql5DM/VGCrXs+j5
         GRzSkiaJtK/FCRc/RUNpbtotCEE5Wj9JlgTAj1+cb4KuRMC8Aew7anrzC66B1RzKQ8pO
         1A013iTzJANbryB0UCcc0CiISYI4HN2J64uXkKlCU1cqOZ1NaDtwX5/9AtzxYaxbKhMy
         /lAw==
X-Gm-Message-State: AOAM531YsVlHJ35tJBTBGQ3nQO9VEbRB9/4Uvvc550M6bq44DcJYLZdC
        /SZratjlJDqtbMlJpWGgDKDTha9QVLs=
X-Google-Smtp-Source: ABdhPJzylTigPMjfmZV1kPFltHQiGPtbkVJpOB7lOLTl9m/ke4a2fLAZt5LObqaccGLqcYzGFKUs8A==
X-Received: by 2002:ac8:5392:: with SMTP id x18mr24523589qtp.381.1622641085619;
        Wed, 02 Jun 2021 06:38:05 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id h8sm11997188qtp.46.2021.06.02.06.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 06:38:05 -0700 (PDT)
Subject: Re: docs: Convert the Speakup guide to rst
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <20210531220754.h4ep2dj65wl6hejf@begin>
 <b8769ad4-9188-a735-3ac4-4a79b9b06487@gmail.com>
 <20210601215536.5rhnbwwt66uyqhze@begin>
 <85969150-6e00-12b8-b56d-5f161436777d@gmail.com> <87pmx4pi29.fsf@intel.com>
From:   Igor Torrente <igormtorrente@gmail.com>
Message-ID: <2044b3a6-45e1-5fe9-cabb-88a2758cde24@gmail.com>
Date:   Wed, 2 Jun 2021 10:38:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87pmx4pi29.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

On 6/2/21 9:27 AM, Jani Nikula wrote:
> On Tue, 01 Jun 2021, Igor Torrente <igormtorrente@gmail.com> wrote:
>> Hi Samuel,
>>
>> On 6/1/21 6:55 PM, Samuel Thibault wrote:
>>> Hello,
>>>
>>> Igor Torrente, le mar. 01 juin 2021 12:39:01 -0300, a ecrit:
>>>> I was reading all the emails sent in this thread, but I'm not sure how I
>>>> should proceed. Do think should I continue to improve the patch with the
>>>> Jani Nikula suggestions? Or abandon it? Or keep both versions?
>>>
>>> It seems that people are fine with the switch to the .rst format, and
>>> it'll indeed allow much better distribution of its content, so please
>>> continue improving the patch with the suggestions from Jani, you have an
>>>
>>> Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>>>
>>> and the review will probably come from Jani, who seems to actually know
>>> a bit about the rst syntax :)
>>
>> OK, I will keep improving it.
> 
> Heh, I just made suggestions on things that I thought could be done
> better, but please see for yourself how it renders and how it actually
> works with Braille displays. That should have priority over anything I
> suggest.

I understand and agree. But I don't have a braille display to test the 
change, so I will need the help of the community anyway.

And if anything gets worse I can revert the changes in the next patch 
version based on the feedback.

> 
> BR,
> Jani.
> 
> 

Thanks,
---
Igor M. A. Torrente
