Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3443DA290
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhG2L4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhG2L4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:56:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F6EC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:56:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d1so6717486pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=reWzh3OdEOGw7F78jU2h0BOb61+Bau+uTHia8Q/89V8=;
        b=IaL3rGM1C0+p5EI4dwAtMi7JS2l80ZljyAWOK2arkXrKp3nTXS49OP6MfH3eVQW9kD
         pu5JqNu4HNx5plFv3VYgwzFZLfBBMWq84kURUBKQ5jEe0sqIPEWln+eSnF9MrVUw0exg
         3CkRUhPvAydBUlUmx18mWAeMCrRGtbIA93B7Qd1h1EUXaPcnWE9VBfY3dY2oT8KjGlBP
         lKokRCRDeOKHFfCX/dA89sIO8QqdO7o8mZ07wal1pZEe3b5UXOKOWf3Uv0zSiih+6G0j
         tbE7I0jtp4aVsYUDMWtgRp0CL77BCGx8nKOKl7TQmw2YcUnmFlK6mES5XWRH3Voo3IZb
         oFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=reWzh3OdEOGw7F78jU2h0BOb61+Bau+uTHia8Q/89V8=;
        b=kyCfycm4R0mq8NcY7MbcHnVw/HYsiCMmnNlCXE1e79/IcEvZzGvMJi+jJr7WR3ieE6
         TmMGNPn2DSvFlr9S+xInxAsWIe74DmQvaCjlKzbdU7+c0ZSPSmIPbRi68ERObGx4uWdD
         X9Tvb4V8Xcvmc8p1am0l/u6NKe7R8005qbLyNQg92Y0k5+TYfKA3jn0aukd4hMoru/8w
         vXhiIUrcV2rFLwW0L57gG7ouPI8Q5lc+vJxse37BHIMfgN8fnDZ0HuIwptgicvb4kpt0
         TGavLk8mz3vMyx7vO1ZPNdDVMRgMTOdcbjqh0Io6yP2Eh1XyLfLse9iy73SmzU0z4gHP
         vy/A==
X-Gm-Message-State: AOAM532q8QDn0+Uqp2BUVs/QffEmy54MzjvOk7h+wu9aPSphc+dRIk3h
        jIA8+wHnF8vetuWIrRzMZVY=
X-Google-Smtp-Source: ABdhPJzj0RzK7IZOH+o/pO07TTLehY7nwqiCMVKOOGmOCGDv3SpV5AZLs1+BD7rJnIH0eNdeWFVTmw==
X-Received: by 2002:a17:902:b218:b029:11a:bf7b:1a80 with SMTP id t24-20020a170902b218b029011abf7b1a80mr4437298plr.82.1627559773713;
        Thu, 29 Jul 2021 04:56:13 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id e23sm9671103pjt.8.2021.07.29.04.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 04:56:12 -0700 (PDT)
Subject: Re: [PATCH] ntfs: Fix validity check for file name attribute
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     anton@tuxera.com, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        skhan@linuxfoundation.org,
        syzbot+213ac8bb98f7f4420840@syzkaller.appspotmail.com,
        rkovhaev@gmail.com
References: <2424055.QlFIqzKPrH@devpool47>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <e24a9b8c-12c9-eb05-7133-148d16da034b@gmail.com>
Date:   Thu, 29 Jul 2021 19:56:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2424055.QlFIqzKPrH@devpool47>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/7/21 4:31 pm, Rolf Eike Beer wrote:
> Hi,
> 
> I was just scanning through some older vulnerabilities and came across
> CVE-2018-12929, CVE-2018-12930, and CVE-2018-12931, which are all still open
> according to linuxkernelcves.com (originally reported against 4.15 [1]). I
> looked into the commits in fs/ntfs/ from 4.15 onwards to see if they were just
> missed, but I can't spot anything there. RedHat claims to have them fixed in
> one of their kernels [2].
> 
> Which makes me wonder if the issue fixed here is a duplicate of the any of the
> above. Is there a reason I can't find any patches for the original issue in
> tree, like the issue only introduced in a custom patchset that Ubuntu/RedHat
> were using? Is this thing worth it's own CVE if it's no duplicate?
> 
> Greetings,
> 
> Eike
> 
> 1) https://marc.info/?t=152407734400002&r=1&w=2
> 2) https://access.redhat.com/errata/RHSA-2019:0641
> 

Hi Eike,

Thanks for digging into this. From a first glance, this bug seems most 
similar to CVE-2018-12929.

However, from the logs, the root causes are probably different. The 
cause of this bug is specifically in the call to 
ntfs_is_extended_system_file [1], but from what I can see this is not 
the case for CVE-2018-12929. I don't know enough to comment whether it 
needs a CVE, but it has been patched on Linux stable (up to 4.4).

It's worth noting that there's another similar bug that was fixed by 
Rustam Kovhaev (+cc) in ntfs_read_locked_inode [2]. This may or may not 
have been the issue in CVE-2018-12929.

Link: 
https://syzkaller.appspot.com/bug?id=a1a1e379b225812688566745c3e2f7242bffc246 
[1]

Link: 
https://syzkaller.appspot.com/bug?id=933dab9c03ac47a3d09dd4b0563a0a8fcb35f282 
[2]

Best wishes,
Desmond
