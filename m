Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4361B3558EB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbhDFQMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhDFQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:12:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F1CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=XDFJgXxvtaM0UxLUX+LI+rLQMYimMFZh2bt7uDBXvbE=; b=j2nDF0dPDCY9lUwyW89h4s3zAr
        abxywG3qlLdz1sw8WuvmociW9cTuWWXGIWMK3vUpuIxcctx+8QAczg1fO6RnOC7EUf13FWXS2XiOo
        yVEEsl2WfbU7GyEjwggBKkvwFIyojQ147mfvLni8ZbWvvHLaPAo1UDuR53CnCyJUVoflAoUSQczGG
        cXCHTMDmH0Rf1ibDpPhRcr3Rf+DQhlv2vp1Qn78G252Qd9NM1Cx99rNqi7yOWPg0Q6Xedwzk7ylFT
        9n5T8xb6qqaRPi24S7VHUuABdzjtWUmUmN3JizMYn/AXbPIN8SdyvNSivIrJoGzFHlf8fKa76mINZ
        Bp9G9UGQ==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lToJK-00D47P-DM; Tue, 06 Apr 2021 16:12:24 +0000
Subject: Re: disk-io.c:undefined reference to `atomic64_set_386'
To:     dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        Josef Bacik <josef@toxicpanda.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <202104010035.c4LXmhAY-lkp@intel.com>
 <20210406144303.GF7604@suse.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <38f3b02c-6b0a-d986-1131-4b42d6d2eb7d@infradead.org>
Date:   Tue, 6 Apr 2021 09:12:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210406144303.GF7604@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 7:43 AM, David Sterba wrote:
> On Thu, Apr 01, 2021 at 12:34:38AM +0800, kernel test robot wrote:
>> Hi Josef,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   5e46d1b78a03d52306f21f77a4e4a144b6d31486
>> commit: 8260edba67a2e6bd5e709d32188e23aa22cb4a38 btrfs: make the init of static elements in fs_info separate
>> date:   1 year ago
>> config: um-randconfig-r023-20210330 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce (this is a W=1 build):
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8260edba67a2e6bd5e709d32188e23aa22cb4a38
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 8260edba67a2e6bd5e709d32188e23aa22cb4a38
>>         # save the attached .config to linux build tree
>>         make W=1 ARCH=um 
> 
> All the reports regarding atomic64_*_386 are from ARCH=um build, so
> it needs to be fixed there.
> 

Robot, Please try this patch:
https://marc.info/?l=linux-kernel&m=161756047331183&w=2


thanks.
-- 
~Randy

