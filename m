Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9F44CE67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhKKAkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhKKAkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:40:17 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D384C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:37:29 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id k21so4963797ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j0pMJ7o7XPzdibktwTlScC6L1CXIa+CAYp/SlIFhGOI=;
        b=78zSnH8cFrvj/bHc74+cMlzKlQUzezEhEIA28Dfck+g9B7shhoKDFvKNn2sBzCBuOh
         0zDPpETV22Wx6H8HoN1FoyTXgz285t1F+h8t2bl02d6SgpIU0zMCK6aQlDUZFLuecMgC
         RBHmBzOXWE8ZIlP1T4XwDF0sCJMQiZP1/1/8p2bpQp+IrtUpXAU9czqvpeT0SgYu9fCS
         mwcTBMRRD9GRbqXxWBjaGd+T+BoU+Zwikgtea7JHZ2tO0MvHo0a+ZgjmJVxIFTi2AA10
         qn8GxX0XfBATGX6y++q7sXgFfctJ9LwA1g3dWI5b4MPzZaoOUBBtFm6gQPIXiMgaNysW
         6vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j0pMJ7o7XPzdibktwTlScC6L1CXIa+CAYp/SlIFhGOI=;
        b=Vrdkb7UudtaRyiM5ug6mYRkjoFlMmUchk1e8V1laqYCREsO6T6noTi2GbnOk3+GS2s
         YDNOIRNy8lBM7iwWr5V7yMXRqOaxUH0RQxTJAxEdx7plg+jeY+a002gS0mL9LdAoQYVZ
         6bJQX7tSXoobgGKQzJzXmH6lAkc4mgFRxY3sKKOjr99s4uFbfEprdqcQKQvOeQ0v+iE+
         JnpQkKnulRjB6Q07LRdZlRG+yeynFj0iK4507WopvPx4ED3dZZ49vMJRulJvftZ8AvpE
         kxH+LEbWOLmdU6Ex7JmZ86OF1EDG3pPTigrxRhOpLVr1MpWGmDeJR11ToZsyxY+QE9bO
         SPQA==
X-Gm-Message-State: AOAM531GJZ1wIdugR6gIkIkIpmeknBORx1x+7oPJAiUCNEvQ7/p33seA
        7Q/XNgVlwoJcLlMlShuisj82hg==
X-Google-Smtp-Source: ABdhPJzBEYDXVnrGNXwwm5FTRdKeIUl/B3kSfC2ATwsHD0zlKsXsU2EJizGqx6+zEdFLGhT1rxESOg==
X-Received: by 2002:a02:712c:: with SMTP id n44mr2381517jac.92.1636591049013;
        Wed, 10 Nov 2021 16:37:29 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i1sm875397iov.10.2021.11.10.16.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 16:37:28 -0800 (PST)
Subject: Re: block/blk-ia-ranges.c:119: warning: expecting prototype for
 disk_register_ia_ranges(). Prototype was for
 disk_register_independent_access_ranges() instead
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
References: <202111110829.XuUWn4Km-lkp@intel.com>
 <f5ec9cf3-8d7a-4142-dee6-cfbf5bd81129@kernel.dk>
 <CH2PR04MB7078397EB865AB49A5643D8CE7949@CH2PR04MB7078.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <40a7dcba-f202-16d9-92d1-2507b2b67515@kernel.dk>
Date:   Wed, 10 Nov 2021 17:37:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CH2PR04MB7078397EB865AB49A5643D8CE7949@CH2PR04MB7078.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 5:36 PM, Damien Le Moal wrote:
> On 2021/11/11 9:35, Jens Axboe wrote:
>> On 11/10/21 5:26 PM, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   881007522c8fcc3785c75432dbb149ca1b78e106
>>> commit: a2247f19ee1c5ad75ef095cdfb909a3244b88aa8 block: Add independent access ranges support
>>> date:   2 weeks ago
>>> config: m68k-randconfig-r036-20211027 (attached as .config)
>>> compiler: m68k-linux-gcc (GCC) 11.2.0
>>> reproduce (this is a W=1 build):
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2247f19ee1c5ad75ef095cdfb909a3244b88aa8
>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>         git fetch --no-tags linus master
>>>         git checkout a2247f19ee1c5ad75ef095cdfb909a3244b88aa8
>>>         # save the attached .config to linux build tree
>>>         mkdir build_dir
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> block/blk-ia-ranges.c:119: warning: expecting prototype for disk_register_ia_ranges(). Prototype was for disk_register_independent_access_ranges() instead
>>
>> Thanks, fixed here:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.16&id=68636e242d45453d48a7d30a18a49f80d4ae08c0
>>
> 
> I was about to hit send for a fix patch :)
> Thanks Jens.

Quickest draw in the west ;-)

-- 
Jens Axboe

