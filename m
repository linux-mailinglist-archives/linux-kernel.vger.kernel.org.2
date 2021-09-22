Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425424144DD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhIVJN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:13:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56672 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhIVJN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:13:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2D9E31F42CDF
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Fix check_features ret
 val
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20210916014632.2662612-1-pmalani@chromium.org>
 <f6860aa6-b541-b03d-da8d-333661a8322f@collabora.com>
 <YUoWgdK2+t8d11oq@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f3c7dde6-c82e-4cae-c5b2-9e0c37b6fe2f@collabora.com>
Date:   Wed, 22 Sep 2021 11:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YUoWgdK2+t8d11oq@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 21/9/21 19:29, Prashant Malani wrote:
> Hi Enric,
> 
> Thanks for reviewing the patch.
> 
> On Tue, Sep 21, 2021 at 01:42:04PM +0200, Enric Balletbo i Serra wrote:
>> Hi Prashant,
>>
>> Thank you for the patch. Just one comment below ...
>>
>> On 16/9/21 3:46, Prashant Malani wrote:
>>> The kerneldoc for cros_ec_check_features() states that it returns 1 or 0
>>> depedending on whether a feature is supported or not, but it instead
>>> returns a negative error number in one case, and a non-1 bitmask in
>>> other cases.
>>>
>>> Since all call-sites only check for a 1 or 0 return value, update
>>> the function to return boolean values.
>>>
>>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
>>> ---
>>>  drivers/platform/chrome/cros_ec_proto.c     | 12 +++++++-----
>>>  include/linux/platform_data/cros_ec_proto.h |  2 +-
>>>  2 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
>>> index a7404d69b2d3..a34cf58c5ef7 100644
>>> --- a/drivers/platform/chrome/cros_ec_proto.c
>>> +++ b/drivers/platform/chrome/cros_ec_proto.c
>>> @@ -808,9 +808,9 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
>>>   *
>>>   * Call this function to test whether the ChromeOS EC supports a feature.
>>>   *
>>> - * Return: 1 if supported, 0 if not
>>> + * Return: true if supported, false if not (or if an error was encountered).
>>>   */
>>> -int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>>> +bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>>>  {
>>>  	struct cros_ec_command *msg;
>>>  	int ret;
>>> @@ -818,8 +818,10 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>>>  	if (ec->features[0] == -1U && ec->features[1] == -1U) {
>>>  		/* features bitmap not read yet */
>>>  		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
>>> -		if (!msg)
>>> -			return -ENOMEM;
>>> +		if (!msg) {
>>> +			dev_err(ec->dev, "failed to allocate memory to get EC features\n");
>>
>> In case of failure you will be noticed by the allocator, prints after
>> [k|v][m|z|c]alloc() functions are not needed, so I think you can just return
>> false here.
>>>
> 
> Makes sense; I can make the change, but I had one question:
> 
> If we solely return false, how will we tell from the logs that the
> allocation error message was associated with this driver? Only returning
> false means the driver probe (e.g cros-ec-typec) will continue (just assuming a certain feature
> is not present). Wouldn't having this error message make this clear?
> 

So I tried to find some doc about this without luck. But I think it has been an
unwritten rule that GFP_KERNEL allocations for small allocations will never
fail. If you system fails to allocate that small amount of memory you probably
have bigger problems to solve and the above message is not really useful, even
confusing, as the focus, likely, shouldn't be in this driver to solve the problem.

Thinking a bit more about this change, and after your question, I don't really
like functions not returning an error in the unlikely case that fails. On the
other hand, I like this function return a bool as is a bit more clear IMO, so
I'm wondering if wouldn't be better don't use dynamic memory here (I know that
this is not really related to your patch)

And another thing that I detected, now that you're returning a bool is that in
drivers/platform/chrome/cros_ec_typec.c there is:

   typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev,
   typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,

I think that you can remove the !! now. That could be in another patch.

Thanks,
  Enric

> Best regards,
> 
> -Prashant
> 
