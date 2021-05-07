Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89E37633E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhEGKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:02:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:50644 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235011AbhEGKB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:01:58 -0400
IronPort-SDR: itHZCvST8MRFl0ZVGLUqXUZ+RsEVGL1Vs8AzCyfq5bUOoDGcmb/DBEEATlkEyYSnEWCf/sdbUK
 dBoctC3RggRA==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="284149542"
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="284149542"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 03:00:35 -0700
IronPort-SDR: 9kBkUl057/ytEEtNK/DAOum5ocXAtvMl75Bdv6DEOzUX57tQJ6cTWyVEfNyz0xxTD6UtKA0wvW
 i/BfZ+W1A5rw==
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="434842685"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.175.201]) ([10.249.175.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 03:00:33 -0700
Subject: Re: [kbuild-all] Re: drivers/hid/hid-ft260.c:794:44: warning: format
 specifies type 'short' but the argument has type 'int'
To:     Michael Zaidman <michael.zaidman@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Jiri Kosina <jikos@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <202105060637.LeEC6ztp-lkp@intel.com>
 <20210506115546.GA1745@michael-VirtualBox>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <0102b8fe-3edf-3d4f-2622-d1fefb36274f@intel.com>
Date:   Fri, 7 May 2021 18:00:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210506115546.GA1745@michael-VirtualBox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/2021 7:55 PM, Michael Zaidman wrote:
> On Thu, May 06, 2021 at 06:47:46AM +0800, kernel test robot wrote:
>>
>>     drivers/hid/hid-ft260.c:515:59: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
>>                     hid_err(hdev, "%s: unsupported wr len: %d\n", __func__, len);
>>                                                                             ^~~
>>     include/linux/hid.h:1190:30: note: expanded from macro 'hid_err'
>>             dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)
>>                                         ^~~~~~~~~~~
>>     include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
>>             _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
>>                                           ^~~~~~~~~~~
>>     drivers/hid/hid-ft260.c:507:9: note: initialize the variable 'len' to silence this warning
>>             int len, ret;
>>                    ^
>>                     = 0
> 
> This warning has already been found and fixed by Dan Carpenter in
> the "HID: ft260: fix an error message in ft260_i2c_write_read()" commit
> on March 18, 2021.

Hi Michael,

This report is about the below warning prefixed by '>>', it's still in 
mainline:

 >> drivers/hid/hid-ft260.c:794:44: warning: format specifies type 
'short' but the argument has type 'int' [-Wformat]
            return scnprintf(buf, PAGE_SIZE, "%hi\n", le16_to_cpu(*field));
                                              ~~~     ^~~~~~~~~~~~~~~~~~~
                                              %i

Best Regards,
Rong Chen
