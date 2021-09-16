Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE040EB43
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhIPUEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhIPUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:04:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3466FC061574;
        Thu, 16 Sep 2021 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=KqxRy0WLPGBV4wdZfMfm1u6INYHRT5mHQEbiujkzzfA=; b=4YJ/7yjUlMNVy5sm7r8fyAy9d8
        R3A/56UyXqQ8+keVYtEFbZI2VxlPyKHmMsNibGllk58CSqOTvItHL9Y0CNUaKg3scjkgyZ2iIcl9Z
        AYfE4OcGYDqlqxh3ojXK/ZXeBTUB/n7Gw47qAqtbCqybR9KhkjKnSi2TIyxFP/z1ijqF1ezgrm1dA
        lHVsl3lhEgaE2YGFPs8ui+seqfxNK0sRI7KuchTEVNBcPokksjMY42B2njlPnHQndCDCKoQY4yJbi
        oU+tcXPP4CH0hK8oqJBDGGxIz+SUqoio6IXfAEiDP50ZdXDlN/fj+d/b2tDlpBTDg3iuXjzbNmsSD
        CzsWGf6g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQxbT-00CJJl-Ao; Thu, 16 Sep 2021 20:03:27 +0000
Subject: Re: [GIT PULL] parisc architecture warning fix for kernel v5.15-rc2
To:     Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
References: <YUNi6hTcS8nUrrpF@ls3530>
 <b3d13e4f-c9cd-495b-5df2-1080ca4d3aa3@roeck-us.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f3713fe6-2806-9d65-618b-a9d210193e60@infradead.org>
Date:   Thu, 16 Sep 2021 13:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b3d13e4f-c9cd-495b-5df2-1080ca4d3aa3@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/21 12:45 PM, Guenter Roeck wrote:
> On 9/16/21 8:29 AM, Helge Deller wrote:
>> Hi Linus,
>>
>> please pull one parisc architecture warning fix for kernel 5.15-rc2 from:
>>
>>    http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-4
>>
>> One patch which fixes a build warning when using the PAGE0 pointer.
>>
> 
> Grumble:
> 
> Building parisc:allmodconfig ... failed
> --------------
> Error log:
> In file included from drivers/net/phy/dp83640.c:23:
> drivers/net/phy/dp83640_reg.h:8: error: "PAGE0" redefined [-Werror]
>      8 | #define PAGE0                     0x0000
> 
> No, I didn't see that coming either. It _was_ there before, I just didn't notice.
> 
> Looks like that define isn't even used anywhere.
> I'll send a patch to remove it.

Already merged in the net tree.


-- 
~Randy

