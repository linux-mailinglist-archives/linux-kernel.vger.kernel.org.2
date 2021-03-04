Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A038D32D540
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhCDO02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:26:28 -0500
Received: from foss.arm.com ([217.140.110.172]:39136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhCDO0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:26:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 586931FB;
        Thu,  4 Mar 2021 06:25:22 -0800 (PST)
Received: from [10.57.63.81] (unknown [10.57.63.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1F1D3F766;
        Thu,  4 Mar 2021 06:25:19 -0800 (PST)
Subject: Re: [PATCH v4 04/10] coresight: etm-perf: update to handle
 configuration selection
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Yabin Cui <yabinc@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-5-mike.leach@linaro.org>
 <641a0d20-bf3d-24e2-8402-d99de9117584@arm.com>
 <CAJ9a7Vi5dTJTNRNC36UEwAeCayd_HF9jN8rXSggRF_4cPZ1NrA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <921225a2-14a8-2a4f-4726-f61224cafa28@arm.com>
Date:   Thu, 4 Mar 2021 14:25:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJ9a7Vi5dTJTNRNC36UEwAeCayd_HF9jN8rXSggRF_4cPZ1NrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/21 2:19 PM, Mike Leach wrote:
> Hi Suzuki,
> 
> On Thu, 4 Mar 2021 at 12:13, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> On 1/28/21 5:09 PM, Mike Leach wrote:
>>> Loaded coresight configurations are registered in the cs_etm\cs_config sub
>>> directory. This extends the etm-perf code to handle these registrations,
>>> and the cs_syscfg driver to perform the registration on load.
>>>
>>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>>> ---
>>>    .../hwtracing/coresight/coresight-config.h    |   5 +-
>>>    .../hwtracing/coresight/coresight-etm-perf.c  | 164 +++++++++++++++---
>>>    .../hwtracing/coresight/coresight-etm-perf.h  |   8 +
>>>    .../hwtracing/coresight/coresight-syscfg.c    |  13 +-
>>>    4 files changed, 166 insertions(+), 24 deletions(-)
>>>


>>> +static ssize_t etm_perf_cscfg_event_show(struct device *dev,
>>> +                                      struct device_attribute *dattr,
>>> +                                      char *buf)
>>> +{
>>> +     struct dev_ext_attribute *ea;
>>> +
>>> +     ea = container_of(dattr, struct dev_ext_attribute, attr);
>>> +     return scnprintf(buf, PAGE_SIZE, "%s\n", (const char *)(ea->var));
>>> +}
>>
>> "configid=0x%lx", (unsigned long)ea->var ?
>>
> 
> ea->var _is_ "configid=0x%lx" due to the way perf handles the events
> sub-dir entries.
> 

This must be combined with the suggestion below.

>>> +
>>> +static int etm_perf_add_cscfg_event(struct device *dev, struct cscfg_config_desc *cs_cfg)
>>> +{
>>> +     struct dev_ext_attribute *ea;
>>> +     unsigned long hash;
>>> +     int ret;
>>> +     struct device *pmu_dev = etm_pmu.dev;
>>> +
>>> +     ea = devm_kzalloc(dev, sizeof(*ea), GFP_KERNEL);
>>> +     if (!ea)
>>> +             return -ENOMEM;
>>> +
>>> +     hash = (unsigned long)cs_cfg->id_ea->var;
>>> +
>>> +     sysfs_attr_init(&ea->attr.attr);
>>> +     ea->attr.attr.name = devm_kstrdup(dev, cs_cfg->name, GFP_KERNEL);
>>> +     if (!ea->attr.attr.name)
>>> +             return -ENOMEM;
>>> +
>>> +     /*
>>> +      * attribute value is "configid=<hash>".
>>> +      * this will be what perf evaluates when the config name is used
>>> +      * on the command line.
>>> +      */
>>> +     ea->var = devm_kzalloc(dev, CSCFG_EVENT_STR_SIZE, GFP_KERNEL);
>>> +     if (!ea->var)
>>> +             return -ENOMEM;
>>
>> Could we drop this string and use the "hash" instead ?
>>
> 
> No. My understanding is that we have added an events directory to
> cs_etm, and add the configurations in there:-
> 
> cs_etm/events/autofdo
> 
> Now the contents of autofdo are "configid=0x<hash-value>" - where
> hash-value is the hash of "autofdo".
> 
> On the perf command line:-
> 
> perf record -e cs_etm/autofdo/ .....
> 
> will result in perf parsing autofdo, looking in the events dir for
> cs_etm, seeing the configid=-string, and parsing that to assign to
> configid attribute - which we have allocated to config2:63:32 - this
> will then appear as a value in the perf_event and we can load the
> configuration when starting up the event on the ETM etc.

Sorry, I was not explicit in my comments. You could drop the string and
have ea->var = hash. And the _show() could simply do

"configid=0x%lx" , hash

as mentioned above.

That would avoid another string allocation, with the same interface.

Suzuki
