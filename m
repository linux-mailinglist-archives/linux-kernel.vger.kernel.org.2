Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6373A0E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhFIH4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:56:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbhFIH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:56:00 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B29981FD58;
        Wed,  9 Jun 2021 07:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623225245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yk5INOFfN9f3H0ZJfNkcqZ9R/JP7vV1QX2UcKR9PAZY=;
        b=f3bM1RpPwpvkQZBrWlBukHOTi6qJOb9WUBnAmpozj7aERLdceGaGGNtUxTd8evEFvCDH2L
        NZc/B9VmGv2uD+mlNXp8U0sqJSvZt4VpeR0WC8A+YhNNbutSqXJclAZtKz+2fsVjLHK7pW
        yalsr4qScQfN0P/notGhKjp21AfIsMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623225245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yk5INOFfN9f3H0ZJfNkcqZ9R/JP7vV1QX2UcKR9PAZY=;
        b=5W12RQ0VJRKJfmy7Oxy8JfR4JhRz6Op+l0T4USHAmSPz3BNxtduzDoRVwxZKGsNs0sZMGm
        r0cPDVvVFsC7zwDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A3462118DD;
        Wed,  9 Jun 2021 07:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623225245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yk5INOFfN9f3H0ZJfNkcqZ9R/JP7vV1QX2UcKR9PAZY=;
        b=f3bM1RpPwpvkQZBrWlBukHOTi6qJOb9WUBnAmpozj7aERLdceGaGGNtUxTd8evEFvCDH2L
        NZc/B9VmGv2uD+mlNXp8U0sqJSvZt4VpeR0WC8A+YhNNbutSqXJclAZtKz+2fsVjLHK7pW
        yalsr4qScQfN0P/notGhKjp21AfIsMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623225245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yk5INOFfN9f3H0ZJfNkcqZ9R/JP7vV1QX2UcKR9PAZY=;
        b=5W12RQ0VJRKJfmy7Oxy8JfR4JhRz6Op+l0T4USHAmSPz3BNxtduzDoRVwxZKGsNs0sZMGm
        r0cPDVvVFsC7zwDQ==
Received: from director1.suse.de ([192.168.254.71])
        by imap3-int with ESMTPSA
        id 9qSxJ51zwGCSRAAALh3uQQ
        (envelope-from <hare@suse.de>); Wed, 09 Jun 2021 07:54:05 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        gregkh@linuxfoundation.org, containers@lists.linux.dev,
        linux-kernel@vger.kernel.org, lkml@metux.net
References: <YL9liW99Ytf6uBlu@kroah.com>
 <9157affa-b27a-c0f4-f6ee-def4a991fd4e@suse.de>
 <20210608142911.ievp2rpuquxjuyus@wittgenstein>
 <d956398e-7ee6-ba36-43cc-4cdcea34b5b9@suse.de> <877dj4ff9g.fsf@disp2133>
 <20210609063818.xnod4rzvti3ujkvn@wittgenstein>
 <b9ea9116-7120-b0a7-b739-dd8513e12c5e@suse.de>
 <20210609072108.ldhsxfnfql4pacqx@wittgenstein>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: device namespaces
Message-ID: <85a0d777-dea6-9574-8946-9fc8f912c1af@suse.de>
Date:   Wed, 9 Jun 2021 09:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210609072108.ldhsxfnfql4pacqx@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 9:21 AM, Christian Brauner wrote:
> On Wed, Jun 09, 2021 at 09:02:36AM +0200, Hannes Reinecke wrote:
>> On 6/9/21 8:38 AM, Christian Brauner wrote:
>>> On Tue, Jun 08, 2021 at 12:16:43PM -0500, Eric W. Biederman wrote:
>>>> Hannes Reinecke <hare@suse.de> writes:
>>>>
>>>>> On 6/8/21 4:29 PM, Christian Brauner wrote:
>>>>>> On Tue, Jun 08, 2021 at 04:10:08PM +0200, Hannes Reinecke wrote:
>> [ .. ]
>>>>> Granted, modifying sysfs layout is not something for the faint-hearted,
>>>>> and one really has to look closely to ensure you end up with a
>>>>> consistent layout afterwards.
>>>>>
>>>>> But let's see how things go; might well be that it turns out to be too
>>>>> complex to consider. Can't tell yet.
>>>>
>>>> I would suggest aiming for something like devptsfs without the
>>>> complication of /dev/ptmx.
>>>>
>>>> That is a pseudo filesystem that has a control node and virtual block
>>>> devices that were created using that control node.
>>>
>>> Also see android/binder/binderfs.c
>>>
>> Ah. Will have a look.
> 
> I implemented this a few years back and I think it should've made it
> onto Android by default now. So that approach does indeed work well, it
> seems:
> https://chromium.googlesource.com/aosp/platform/system/core/+/master/rootdir/init.rc#257
> 
> This should be easier to follow than the devpts case because you don't
> need to wade through the {t,p}ty layer.
> 
>>
>>>>
>>>> That is the cleanest solution I know and is not strictly limited to use
>>>> with containers so it can also gain greater traction.  The interaction
>>>> with devtmpfs should be simply having devtmpfs create a mount point for
>>>> that filesystem.
>>>>
>>>> This could be a new cleaner api for things like loopback devices.
>>>
>>> I sent a patchset that implemented this last year.
>>>
>> Do you have a pointer/commit hash for this?
> 
> Yes, sure:
> https://lore.kernel.org/linux-block/20200424162052.441452-1-christian.brauner@ubuntu.com/
> 
> You can also just pull my branch. I think it's still based on v5.7 or sm:
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=loopfs
> 
> I'm happy to collaborate on this too.
>
How _very_ curious. 'kernfs: handle multiple namespace tags' and 'loop:
preserve sysfs backwards compability' are essentially the same patches I
did for my block namespaces prototyp; I named it 'KOBJ_NS_TYPE_BLK', not
'KOBJ_NS_TYPE_USER', though :-)

Guess we really should cooperate.

Speaking of which: why did you name it 'user' namespace?
There already is a generic 'user_namespace' in
include/linux/user_namespace.h, serving as a container for all
namespaces; as such it probably should include this 'user' namespace,
leading to quite some confusion.

Or did I misunderstood something here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
