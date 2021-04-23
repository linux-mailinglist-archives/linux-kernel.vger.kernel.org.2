Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC7368E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbhDWILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:11:02 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:49629 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229917AbhDWILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:11:00 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id ZqtHlzRhVvTEDZqtKlcUnC; Fri, 23 Apr 2021 10:10:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1619165423; bh=EcScAH6eePoXZNhp3QLEsBHw0eB+HfJTJNLE+H0Pt/A=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=OK7nVT847yTO3MMsxINrhRCWIjZpKnwazJdO5R4acHvWepErFi2bCOk7+3V4daHXs
         IMj/OzQeUwwpK7hxXkd/zruiY9BixEWzUQwAqTjGKxTVDHl+dMiAuZKqADTKy1P7rn
         IaApjmOjm1HGkEZqFZg84ZjyR87OG8Toykqe1CO19aGQDH50ELk+rbSWsLCBPBzGLN
         2rnNtuHWbH6zwo4z+9IVcpwo5+P7NCEfkQrZBSLcvzxFX1UrXiG3roz1Qu6w8MQJQo
         knftXxlB/P15z6uMUDYdXeEMJlY4md79iE9C3Lw+RwK11HlpqpirQMYohWGCw7hgAG
         /MynsUvU5cygQ==
Subject: Re: [PATCH 009/190] Revert "media: s5p-mfc: Fix a reference count
 leak"
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Julia Lawall <julia.lawall@inria.fr>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-10-gregkh@linuxfoundation.org>
 <b43fc2b0-b3cf-15ab-7d3c-25c1f2a3e658@canonical.com>
 <YIJy6AnG6QBlkV/5@kroah.com> <20210423100727.5a999c2e@coco.lan>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <02966f20-342d-cf21-8216-d364b67753b7@xs4all.nl>
Date:   Fri, 23 Apr 2021 10:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210423100727.5a999c2e@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFv5AVe5WAV0eqXvSpQ3I9w5TgfoQ64YGz9JCetHfj46pyXEfamPgtQe+QKbzYSRg8RMnWyrfq/BMJWCB6uwddqsZItPG7UEWPXy7FCj87hLrCBV3RU6
 3ZPs3KHUcaMk9444sk3YbA+KPFU+70W3ueUKU2AXjDlhHMqEbm6UDjghfpTj42fN0jolknVUyjzSQB8CXERA0BRWwJv41PubALLAWbv3HyIocKwAoJb+U01G
 Bk6NvFHjdRiAduICSB61OQ4Psd+VuLIeeJXM+jkWrd1Nb0JfvMso9gh6sHtHmliNv69u51a8rzhp3Ptfj57Br+5BDPL4dfPuSfHYFh2lUqkxld8q9m24JfMd
 vxwfV1XtG5iqCL6mh45L7xguLJUk6Mr+b5iS21824GjaFiYakkc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 10:07, Mauro Carvalho Chehab wrote:
> Em Fri, 23 Apr 2021 09:10:32 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
>> On Fri, Apr 23, 2021 at 09:04:27AM +0200, Krzysztof Kozlowski wrote:
>>> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:  
>>>> This reverts commit 78741ce98c2e36188e2343434406b0e0bc50b0e7.
>>>>
>>>> Commits from @umn.edu addresses have been found to be submitted in "bad
>>>> faith" to try to test the kernel community's ability to review "known
>>>> malicious" changes.  The result of these submissions can be found in a
>>>> paper published at the 42nd IEEE Symposium on Security and Privacy
>>>> entitled, "Open Source Insecurity: Stealthily Introducing
>>>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
>>>> of Minnesota) and Kangjie Lu (University of Minnesota).
>>>>
>>>> Because of this, all submissions from this group must be reverted from
>>>> the kernel tree and will need to be re-reviewed again to determine if
>>>> they actually are a valid fix.  Until that work is complete, remove this
>>>> change to ensure that no problems are being introduced into the
>>>> codebase.
>>>>
>>>> Cc: Qiushi Wu <wu000273@umn.edu>
>>>> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
>>>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>  drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 4 +---
>>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>>   
>>>
>>> This looks like a good commit but should be done now in a different way
>>> - using pm_runtime_resume_and_get().  Therefore I am fine with revert
>>> and I can submit later better fix.  
>>
>> Great, thanks for letting me know, I can have someone work on the
>> "better fix" at the same time.
> 
> IMO, it is better to keep the fix. I mean, there's no reason to
> revert a fix that it is known to be good.
> 
> The "better fix" patch can be produced anytime. A simple coccinelle
> ruleset can replace patterns like:
> 
> 	ret = pm_runtime_get_sync(pm->device);
> 	if (ret < 0) {
> 		pm_runtime_put_noidle(pm->device);
> 		return ret;
> 	}
> 
> and the broken pattern:
> 
> 	ret = pm_runtime_get_sync(pm->device);
> 	if (ret < 0)
> 		return ret;
> 
> to:
> 
> 	ret = pm_runtime_resume_and_get(pm->device);
> 	if (ret < 0)
> 		return ret;

That's my preference as well.

	Hans

> 
> Regards,
> Mauro
> 

