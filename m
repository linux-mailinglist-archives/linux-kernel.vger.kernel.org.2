Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6824310C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhJRGqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:46:33 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:56659 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhJRGq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:46:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UsVRLyC_1634539456;
Received: from 30.240.100.200(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UsVRLyC_1634539456)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Oct 2021 14:44:17 +0800
Message-ID: <c8907aec-de04-fbc0-e186-a4997fea77c9@linux.alibaba.com>
Date:   Mon, 18 Oct 2021 14:44:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [selftests/tls] e506342a03: kernel-selftests.net.tls.fail
Content-Language: en-US
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20211016135922.GB10051@xsang-OptiPlex-9020>
 <1c328ca1-457f-8946-02f4-09c600685ed4@linux.alibaba.com>
 <YWzhDhWPD5/Bf2Lp@rli9-dbox>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <YWzhDhWPD5/Bf2Lp@rli9-dbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip,

On 10/18/21 10:50 AM, Philip Li wrote:
> On Mon, Oct 18, 2021 at 10:40:13AM +0800, Tianjia Zhang wrote:
>> Hi,
>>
>> This test needs to enable the SM4 algorithm, and the config file you
>> provided does not enable this algorithm.
> thanks for the info, we will recheck this. And how about adding
> this kconfig requirement to tools/testing/selftests/net/config file?
> 

I fixed this problem and sent you an email, thanks for your test.

Best regards,
Tianjia
