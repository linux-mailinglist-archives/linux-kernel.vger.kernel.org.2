Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EA434D360
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhC2PLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhC2PKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:10:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7201C061574;
        Mon, 29 Mar 2021 08:10:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h20so4538766plr.4;
        Mon, 29 Mar 2021 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N/NFcCbZ8SKrCYRliun6T/1PmIMqL/U+dGOxSrfuAnc=;
        b=CpLS08yoL0mgc/0jXiOqpJ1zYGIuIpq/bs/oA1AEx50zpsGFJc41Fsu0G4trNuVdqV
         IXy1vasTJYKOJQa66t3Rww7mrUxBdLFoWorvsm6EjqHzjWX3mWDw+DtzIRKCLefZb1a+
         7+yAxkDR+KPI3rbx8lyfBEAgSQWpswkhnpOmSFSxn51oM4UAYxD/4m/55ih2RLUG88wb
         cjLUxVHlEAVjye3+nRXv2vrsHUn7ajNRUPvuyFXm0yM0NWL8fNdQOnC4tm59kDgwSYJT
         tmffZR3ig0SjSIy55FZFTnNHH3693W/0uctfpQHqI3h0lM6xuGucjXWIS/uzn9iQl9mD
         Y/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N/NFcCbZ8SKrCYRliun6T/1PmIMqL/U+dGOxSrfuAnc=;
        b=B40kJatO1Id4D55iiGIa0y0KIgFkC+ykCemDqjaY/+L7bYl3j1OLblz4kDFjunAWuv
         5NZbAw/B4Yibmh4S4WkKyxHlHf5xHu4+Pt380pBcaKIEAyv/crtB+WdkZC+1lpxmHNEk
         MbFlll0RSZ7JJF9jPJ0Qj9k3evHNBwnMDmucsL3UCiBqT9IidEi8i0+i7Osjeh19bcOj
         ZKry7CQTFuGoyroGXv1EgrAj9oBdwGABqgcqX+dYM0Vf1nkcl9NauYvDGKl4UM4+WyxY
         53SotFcmsnwTSQy906XyLiavGJI0mh6lwJJ2PwDNziM50pmv3ZVU+khJvoQElpVMkFVI
         6bFA==
X-Gm-Message-State: AOAM533aTZNfRipHe9HDcUFuidv66EjpJjOMcWqu/140JGyg7aC9jqjE
        IeV46LnM9+S1keOeTiOnsciP3o0sFESWRqjC
X-Google-Smtp-Source: ABdhPJzqN2E68plwn/1hbIWAe8x57eA/rAEk/eQn0HrGMkeiOAN0s/buYE1hQii3Fd0eVYWo/4Xf2g==
X-Received: by 2002:a17:902:820e:b029:e6:f006:fcff with SMTP id x14-20020a170902820eb02900e6f006fcffmr28543194pln.60.1617030642988;
        Mon, 29 Mar 2021 08:10:42 -0700 (PDT)
Received: from ?IPv6:2405:201:600d:a089:b513:fdab:ff5:9ffb? ([2405:201:600d:a089:b513:fdab:ff5:9ffb])
        by smtp.gmail.com with ESMTPSA id q184sm17486614pfc.78.2021.03.29.08.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 08:10:42 -0700 (PDT)
Subject: Re: [PATCH] scripts: kernel-doc: add warning for comment not
 following kernel-doc syntax
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329092945.13152-1-yashsri421@gmail.com>
 <87czvit65m.fsf@meer.lwn.net>
From:   Aditya Srivastava <yashsri421@gmail.com>
Message-ID: <a35096d5-99e7-6b69-c959-1136d511a0ff@gmail.com>
Date:   Mon, 29 Mar 2021 20:40:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87czvit65m.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/3/21 7:26 pm, Jonathan Corbet wrote:
> Aditya Srivastava <yashsri421@gmail.com> writes:
> 
>> Currently, kernel-doc start parsing the comment as a kernel-doc comment if
>> it starts with '/**', but does not take into account if the content inside
>> the comment too, adheres with the expected format.
>> This results in unexpected and unclear warnings for the user.
>>
>> E.g., running scripts/kernel-doc -none mm/memcontrol.c emits:
>> "mm/memcontrol.c:961: warning: expecting prototype for do not fallback to current(). Prototype was for get_mem_cgroup_from_current() instead"
>>
>> Here kernel-doc parses the corresponding comment as a kernel-doc comment
>> and expects prototype for it in the next lines, and as a result causing
>> this warning.
>>
>> Provide a clearer warning message to the users regarding the same, if the
>> content inside the comment does not follow the kernel-doc expected format.
>>
>> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
>> ---
>>  scripts/kernel-doc | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> This is definitely a capability we want, but I really don't think that
> we can turn it on by default - for now.  Experience shows that if you
> create a blizzard of warnings, nobody sees any of them.  How many
> warnings does this add to a full docs build?
> 

Hi Jonathan, here's the diff I have created for the warnings before
and after the changes:
https://github.com/AdityaSrivast/kernel-tasks/blob/master/random/kernel-doc/kernel_doc_comment_syntax.txt

Around ~1320 new warnings of this type are added to the kernel tree,
and around ~1580 warnings are removed.

Thanks
Aditya

> For now I think we need a flag to turn this warning on, which perhaps
> can be set for a W=1 build.
> > Thanks,
> 
> jon
> 

