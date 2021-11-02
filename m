Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F2744393B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhKBXDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhKBXDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:03:45 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F523C061205
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 16:01:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m26so450567pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p3U7Ew/W+tbL4gceCW5wKoRUR8TYR8jX2l7VfK2xpRc=;
        b=eBalN+j2S1Hc+t9eAuReZCnxpTHRdKSe3xN72ntQZhDMgHX0Fwrnk8UZ6SxPqvMRtx
         kG1BHJkTq1A88kNvwOMmIEEzr8xXWAPmSMhTrjp44t9vpA/lNxb3NDvxFkI6+FWSVjPD
         jNulI3vKLJtlmYIA2lDZr03xB1qcUpiKPZAvoYtfj7MsmKq+pGafcxno4hy0GxGtC7xz
         xsvUN9CDeu+FOqnj6xkCNMj/y4SGEzZBRdF2qatC8i+tyOIWqxhlv6yD+frLA7p9CISe
         zlqOH6u1+acosdHAQyJRv5yS5EpCW49CqAAKLGFUToFlwnV/dqZkUYL+KLVWoSeKz/eX
         jb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p3U7Ew/W+tbL4gceCW5wKoRUR8TYR8jX2l7VfK2xpRc=;
        b=uLtJ1jdZR8OAqW7g4ZDfvcFWbtOBsrMxnTgzFPsir+N8zSMGoPSIPBRVy6tU7893zL
         sWkytKBUkPc32c9SWOnzNyxi/OWqiF/5CFvJet7BiraWH4Xno7TT++OgGjMgWYIC+pyv
         gucgQe1+L8u+jt8eAufL5IeOBAZp4S3NsWVIVEY3swqE+LQPw4JlHKYfUd6x54P2Ub9f
         1aAl+4BLa2LFrfh6Zj6+eol24pp3oB7WYES1lrYs8J0Ytfkw5ZFAIZ/HkA1maGO36h46
         JNj5b9kmHiirInDQ91JjsnrxoZ8fHlIjm0mXOTYMCnIQx7+9nnvnqHASlKrASwqNlrtA
         iYmQ==
X-Gm-Message-State: AOAM530QxTdzbzkigmabS2Jukes5qTZAWmVZpO17cGDc7Wx1TRXNqYsh
        ZlTZvRxEwx8hM+Gm92WEbR3coA==
X-Google-Smtp-Source: ABdhPJzxJGHGRui/fHlPNNW8myCISikNziQ1qnSGdiz1EsgAa1iEqVHgQB3FRvCK7mK/jvJjNjC4mQ==
X-Received: by 2002:a63:df13:: with SMTP id u19mr19657494pgg.450.1635894069696;
        Tue, 02 Nov 2021 16:01:09 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id t38sm207636pfg.61.2021.11.02.16.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 16:01:09 -0700 (PDT)
Message-ID: <5dd944cd-e3be-acb1-3d96-e7939dc7bae8@linaro.org>
Date:   Tue, 2 Nov 2021 16:01:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] scsi: core: initialize cmd->cmnd before it is used
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, dgilbert@interlog.com,
        linux-scsi@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+5516b30f5401d4dcbcae@syzkaller.appspotmail.com
References: <20211101192417.324799-1-tadeusz.struk@linaro.org>
 <4cfa4049-aae5-51db-4ad2-b4c9db996525@acm.org>
 <0024e0e1-589c-e2cd-2468-f4af8ec1cb95@linaro.org>
 <da8d3418-b95c-203d-16c3-8c4086ceaf73@acm.org>
 <8fbb619a-37b3-4890-37e0-b586bdee49d6@interlog.com>
 <17a1b72e-2c2a-8492-cb92-4dec36a6531d@acm.org>
 <cad499a9-7587-1fa9-9f7d-223e66a18efa@interlog.com>
 <f80fd188-a0e5-2e75-506c-3e82d138fe28@linaro.org>
 <9115c893-3fcd-ae81-7422-723ae5370319@acm.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <9115c893-3fcd-ae81-7422-723ae5370319@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/21 15:27, Bart Van Assche wrote:
> On 11/2/21 3:22 PM, Tadeusz Struk wrote:
>> Do you want me to send a patch with the check in scsi_fill_sghdr_rq()?
>> I want to close the mentioned syzbot issue in 5.10. I can also do the
>> back-porting if anything will be required.
> 
> Hi Tadeusz,
> 
> I think we need two patches: one for the SG_IO code that rejects SG_IO
> requests if the CDB length is not valid and a second patch that removes
> the code from scsi_lib.c for assigning the CDB length. Please let me
> know if you would not have the time to work on this.

Yes, I agree. I will send the patches today.

-- 
Thanks,
Tadeusz
