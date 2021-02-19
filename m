Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9531F6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBSJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:42:42 -0500
Received: from smtp88.iad3b.emailsrvr.com ([146.20.161.88]:33740 "EHLO
        smtp88.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhBSJmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:42:38 -0500
X-Greylist: delayed 630 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2021 04:42:37 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1613727077;
        bh=S+dJPTKN+EhVQm/f0xJ8YQU7u1kFlh0tuWCSQHpuENE=;
        h=Subject:To:From:Date:From;
        b=lEfK3pruzk2zZpa4BZXgeGnwnjIM7Y/46Fl/vxL+TLPnKWBCJplQoVHKiTtWQeybW
         4cdUA7KZbSMlzS/7VV+gRm24rydkj/Ozh1CGV2e3oDzbq851iIWViFUOQYrXLqugN3
         4GWW5tyQLyBg+08f1WPnAmxZyE/pTXHvNC/2cLKE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1613727077;
        bh=S+dJPTKN+EhVQm/f0xJ8YQU7u1kFlh0tuWCSQHpuENE=;
        h=Subject:To:From:Date:From;
        b=C8o0taraGqg6XxLTopMmXgB8CtZj3WjK+ewkvHM4PLSa+tRxcgLJwHBIyM+Igvfav
         /I7l6zqfcTBb72oN4jGy8wJhS/GToGjp2Sf0ZcsJuhmzU/QncZsXbKMBFoMfxHhKjh
         Gc2OiY1KtOCxb/8tR6cv4gWIMgZ+IESvgC9yLf80=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp4.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1ADB52071B;
        Fri, 19 Feb 2021 04:31:16 -0500 (EST)
Subject: Re: [PATCH] staging: comedi: cast to (unsigned int *)
To:     David Laight <David.Laight@ACULAB.COM>,
        Greg KH <gregkh@linuxfoundation.org>,
        Atul Gopinathan <atulgopinathan@gmail.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210217165907.9777-1-atulgopinathan@gmail.com>
 <YC1T06VCh0K2BBW5@kroah.com> <20210217181000.GB10124@atulu-ubuntu>
 <YC1fzjVOwiqzO1nb@kroah.com> <3cfef23d-8d4a-205c-61e8-cbe8c9a0c0f4@mev.co.uk>
 <21a953261eb44e7ba302cfe74d8efa2d@AcuMS.aculab.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <94917044-ba8f-7044-42f6-7e8d5ef1e10b@mev.co.uk>
Date:   Fri, 19 Feb 2021 09:31:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <21a953261eb44e7ba302cfe74d8efa2d@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 859589ae-0f4d-437d-8685-e5f2ac50e4f5-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2021 09:03, David Laight wrote:
>> It's kind of moot anyway because the patch is outdated.  But the reason
>> for the ___force is that the same `struct comedi_cmd` is used in both
>> user and kernel contexts.  In user contexts, the `chanlist` member
>> points to user memory and in kernel contexts it points to kernel memory
>> (copied from userspace).
> 
> Can't you use a union of the user and kernel pointers?
> (Possibly even anonymous?)
> Although, ideally, keeping them in separate fields is better.
> 8 bytes for a pointer isn't going make a fat lot of difference.

This is for a UAPI header (eventually), so cannot add a new field.  For
an anonymous union, one tagged with __user and one not, the __user tag
would be removed during conversion from UAPI headers to
/usr/include/linux headers, leaving a union of two identically typed
members, which would look a bit odd.  The union also kind of hides the
problem.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
