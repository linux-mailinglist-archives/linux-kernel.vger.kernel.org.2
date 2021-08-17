Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA173EF1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhHQSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28245 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhHQSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629224514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blC9in8MvMGEjFJlf0hTtxqygbjsNJ5D7/lqFZYI9+s=;
        b=WBB0qMLxfMB8sJBzFh4OWDCMCh8vaS6RHw8kGfWEypnkNYu+Ji1bueifJIOjZmGc8gwfSa
        be9ueP71odOLUx+vo5HBBSh2CqW/v7nOqUjF13ieUsVPhcM0b8gpecl1WTfD9tbEArN32h
        ZgrUU+T8uCJ2Koe/A58ZCbAn3d//XQA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-EJYb7HHJNKa8u4MUqxUhfg-1; Tue, 17 Aug 2021 14:21:53 -0400
X-MC-Unique: EJYb7HHJNKa8u4MUqxUhfg-1
Received: by mail-ed1-f72.google.com with SMTP id a23-20020a50ff170000b02903b85a16b672so10990883edu.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=blC9in8MvMGEjFJlf0hTtxqygbjsNJ5D7/lqFZYI9+s=;
        b=dKWk94GaxhxxbsF9n0QgpsrfQNetfxbij6sniKYt49xdIYyI/mLBwecR2WahNICxdi
         I+uh4+TibhIZGuKgB7Dh/OFhS+6p4triW+uCZxxsLWzV/kVjAuum+amMK2R5053J/JmR
         k6Xxy6lIfVbXGUXdurydkkCq1Yt9eE0qOXBlv3XlAxeIf0CIHUZhLTASoYPWINSW2poY
         zxpNXd3LP34XQk9PAVljUWfABGOZMAoAd/gS/4VCmzzCBvyURVMC9ItxJ3PaAnBW79So
         H5UwicoKEH6lT156IlQnKqITFvpY9b+gLM7K0ol8aI4kG2Cmn2hYfHQQMwLg0rjlwLIj
         Cjxg==
X-Gm-Message-State: AOAM532HF+IMldayaUFaRrS784/ubJR6fsSXGMITETMhZDWQqpG9TU11
        p5q621Jd+mMuNx2f0cpCuhlEkxN2bK6Ih0ItrVHIvZMpWSsYznOvP7FUJum7ilJgezLBIKJyn+v
        lvjx6mxvbGZALmB5CGJHRYy6F
X-Received: by 2002:aa7:cc83:: with SMTP id p3mr5595369edt.365.1629224512652;
        Tue, 17 Aug 2021 11:21:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGc5AQHYAO7Aclyic7sZOUCBYScblNEgE0hQX9VJ4nIY9m246Q/nIq5Crkhc5VFMFl08ZE5Q==
X-Received: by 2002:aa7:cc83:: with SMTP id p3mr5595360edt.365.1629224512536;
        Tue, 17 Aug 2021 11:21:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b5sm1076647ejq.56.2021.08.17.11.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 11:21:51 -0700 (PDT)
Subject: Re: [PATCH 5.10 12/19] vboxsf: Make vboxsf_dir_create() return the
 handle for the created file
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
References: <20210813150522.623322501@linuxfoundation.org>
 <20210813150523.032839314@linuxfoundation.org>
 <20210813193158.GA21328@duo.ucw.cz>
 <26feedff-0fb4-01db-c809-81c932336b47@redhat.com>
 <CADVatmNm83ZdwJzMzZSEF-SPjSV4OmjByLpnYAubZSkY7f9uMw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <758b95b1-382a-4831-d562-e46837b61534@redhat.com>
Date:   Tue, 17 Aug 2021 20:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CADVatmNm83ZdwJzMzZSEF-SPjSV4OmjByLpnYAubZSkY7f9uMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/17/21 5:52 PM, Sudip Mukherjee wrote:
> On Sun, Aug 15, 2021 at 2:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 8/13/21 9:31 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>> commit ab0c29687bc7a890d1a86ac376b0b0fd78b2d9b6 upstream
>>>>
>>>> Make vboxsf_dir_create() optionally return the vboxsf-handle for
>>>> the created file. This is a preparation patch for adding atomic_open
>>>> support.
>>>
>>> Follow up commits using this functionality are in 5.13 but not in
>>> 5.10, so I believe we don't need this in 5.10, either?
>>>
>>> (Plus someone familiar with the code should check if we need "vboxsf:
>>> Honor excl flag to the dir-inode create op" in 5.10; it may have same
>>> problem).
>>
>> Actually those follow up commits fix an actual bug, so I was expecting
>> the person who did the backport to also submit the rest of the set.
> 
> I only track Greg's failed messages when I find time for stable and
> this one was one of those. So, no idea who has originally requested
> this and why were the other two not requested.

I understand, thank you for backporting the 2 failing commits.

Regards,

Hans

