Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F92351EEB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhDASur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:50:47 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.112]:29628 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240344AbhDASaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:30:09 -0400
Received: from [100.112.134.153] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.us-west-2.aws.symcld.net id 2C/76-17150-FC1E5606; Thu, 01 Apr 2021 15:07:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleJIrShJLcpLzFFi42JJl3vFpnvuYWq
  CQfM5RYsnB9oZLd4cn85ksbBtCYvF5V1z2Cwezr7KaPF4xVt2BzaPxXteMnlsWtUJZPVNZvV4
  v+8qm8fnTXIBrFGsmXlJ+RUJrBnHnl9lLLjKU3HweRNTA+M9ri5GLg4hgf+MEh9Xb2eBcJ4zS
  vw93MHaxcjJISyQKnHgwlywhIjABEaJV90nwBLMAuUSW1ffgOo4wijxZupWNpAEm4C2xJYtv4
  BsDg5eAVuJS584QEwWARWJAyviQCpEBcIleq/cBhvDKyAocXLmExYQm1PATmLK1DNMIOXMApo
  S63fpQ2wSl7j1ZD4ThC0vsf3tHGaQEgkBBYm1P8B2SggkSPT8e8Q2gVFwFpKhsxAGzUIyaBaS
  QQsYWVYxWiQVZaZnlOQmZuboGhoY6BoaGukaGhvpGhlY6CVW6SbplRbrlqcWl+ga6SWWF+sVV
  +Ym56To5aWWbGIExlBKQcuFHYzr3nzQO8QoycGkJMo7ZVpKghBfUn5KZUZicUZ8UWlOavEhRh
  kODiUJ3jX3UhOEBItS01Mr0jJzgPEMk5bg4FES4Y19AJTmLS5IzC3OTIdInWJUlBLnXQOSEAB
  JZJTmwbXBUsglRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8LMCEJMSTmVcCN/0V0GImoMWu
  N8AWlyQipKQamC69nzh3WUW7Qsa31upWwRVrexfqJZ5R27j40Y97G1cltb4VWrDnpArPh+dyw
  d2ldq4KbPcNmlub92d1/djYvPr8MRO7eSFP9N/+TsvZr/B2ifmixdza3CdzlFrPqulXCet/YJ
  0UvcfTWXDiil06Vv8DbwQe89DzKGcsYStbdkTR2nqRlfyWY192rGR899HRQ32f9EXvHmP3uyw
  NutPYEvf0M82vmjrZTm2j6lktzYqJO+9GP+jdrybQ+jX55Msll8x9BbbNzKrYJbB2Z+YivVy5
  s381lpe3PuAWLZaea/34XaTr541u8gf7cz64zQzT5Lj8+16AwPmvux9/WOgw8dzdFNenzx3KF
  UT42+7X9yixFGckGmoxFxUnAgDnzIpOnAMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-27.tower-356.messagelabs.com!1617289676!60248!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17845 invoked from network); 1 Apr 2021 15:07:58 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-27.tower-356.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Apr 2021 15:07:58 -0000
Received: from reswpmail01.lenovo.com (unknown [10.62.32.20])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 3305AC9AC3AC72103416;
        Thu,  1 Apr 2021 23:07:55 +0800 (CST)
Received: from localhost.localdomain (10.38.99.122) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Thu, 1 Apr 2021
 11:07:52 -0400
Subject: Re: [External] Re: [PATCH 31/32] Documentation: update
 sysfs-platform_profile.rst reference
To:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
 <828434d891e40234255e3f06c13827b7996b1ad1.1617279356.git.mchehab+huawei@kernel.org>
 <e042f8f8-0ba1-098d-2503-8c319c3c2bf9@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <79ad4a98-a70c-2f7d-3ce6-8202fcc83857@lenovo.com>
Date:   Thu, 1 Apr 2021 11:07:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <e042f8f8-0ba1-098d-2503-8c319c3c2bf9@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.99.122]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/2021 09:49, Hans de Goede wrote:
> Hi,
> 
> On 4/1/21 2:17 PM, Mauro Carvalho Chehab wrote:
>> The file name: Documentation/ABI/testing/sysfs-platform_profile.rst
>> should be, instead: Documentation/userspace-api/sysfs-platform_profile.rst.
>>
>> Update its cross-reference accordingly.
>>
>> Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
>> Fixes: 8e0cbf356377 ("Documentation: Add documentation for new platform_profile sysfs attribute")
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Rafael, I assume you will merge this through your tree?
> 
> Regards,
> 
> Hans
> 
Looks good to me too - though I'd missed the fact the file had moved
somehow :)

Not sure if my reviewed tag has any value but if it's useful:
Reviewed-by: Mark Pearson <markpearson@lenovo.com>

Just for my education - how do things get moved from testing to
somewhere else, is there a decision process etc?

Thank you!
Mark

>> ---
>>  include/linux/platform_profile.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
>> index a6329003aee7..e5cbb6841f3a 100644
>> --- a/include/linux/platform_profile.h
>> +++ b/include/linux/platform_profile.h
>> @@ -2,7 +2,7 @@
>>  /*
>>   * Platform profile sysfs interface
>>   *
>> - * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
>> + * See Documentation/userspace-api/sysfs-platform_profile.rst for more
>>   * information.
>>   */
>>  
>>
> 
