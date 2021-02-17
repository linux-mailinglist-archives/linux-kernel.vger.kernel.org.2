Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481AA31DFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 20:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhBQTta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 14:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhBQTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 14:49:25 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D06C061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 11:48:24 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id z68so9174244pgz.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 11:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=k6HcDZGX/4xp3gfmZFHxaqueAX1/1HYcrR8hDj5mTX0=;
        b=S+ZeX7yqgOTzf3bLqEUPIsM36N3BIBfsxQiMMOGbZqUP8EcXOpKPwRz//1Gpa+n0pY
         oa3uOzBoNF4EM0S+59Ixmi1zm4d8VVQbd4qovAEtL7uR12zZG45oboQBsufDGY69RA/a
         hRkKMAgQcK/v2mTe1nwkEdOmJkHJwUz2gYyc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=k6HcDZGX/4xp3gfmZFHxaqueAX1/1HYcrR8hDj5mTX0=;
        b=XcmieWDGq4Wy+MKZIBCLPkiJ76KNZzirdnibEW844cprcILco13Cm69S3XSaq5pa3o
         tIYQSjxoZzVqZLGZPHJbzX188ZWS06ajPmoqc3AQnAZvogBH70yxlZ4DwrjIOB4kFgXI
         sce0uzXnhayg/9G0CCFfS3bnlM7V8lnWuZv5BBq/F7CSnAsjK2TsrzRo5fuPallLATMw
         Wx7Qz8+w/lYaZkzKNUUN7QGm9wQdASjQJs+CCfBE7aBrTtj2ksvk99enler1UZWBRM61
         EiZaYolRyDsximte9lv++3ND5TlHajAChETcKEepyCfZsmU6CEewRPg9MMEFNKgXXWkS
         rN8Q==
X-Gm-Message-State: AOAM532Ixg5Apzj8duCJ3Ry/jf/CHdX56ySn0iIBRJww32xS89eSFFOp
        Ybp5SiqzMMkWa//y/jeAj1wypcqiiFc+f3BUga0=
X-Google-Smtp-Source: ABdhPJyb78XE5rtMn93TeqzZHMoH0mgukqbrKKXsROP3fu0YsHFMPOXxEg9Hi4C3o3w3QO+HTQOG8Q==
X-Received: by 2002:a63:5b47:: with SMTP id l7mr335916pgm.209.1613591304087;
        Wed, 17 Feb 2021 11:48:24 -0800 (PST)
Received: from lbrmn-lnxub113.ric.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g7sm3332008pgg.50.2021.02.17.11.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 11:48:23 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com> <YCzknUTDytY8gRA8@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
Date:   Wed, 17 Feb 2021 11:48:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCzknUTDytY8gRA8@kroah.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000086f40805bb8d80d2"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000086f40805bb8d80d2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Greg,

On 2021-02-17 1:40 a.m., Greg Kroah-Hartman wrote:
> On Tue, Jan 26, 2021 at 07:51:18PM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Jan 26, 2021 at 10:30:16AM -0800, Scott Branden wrote:
>>> Hi Greg,
>>>
>>>
>>> On 2021-01-25 11:29 p.m., Greg Kroah-Hartman wrote:
>>>> On Mon, Jan 25, 2021 at 11:55:11AM -0800, Scott Branden wrote:
>>>>> Hi All,
>>>>>
>>>>> The 5.10 LTS kernel being officially LTS supported for 2 years presents a problem:
>>>>> why would anyone select a 5.10 kernel with 2 year LTS when 5.4 kernel has a 6 year LTS.
>>>> Because they want to use all of the latest stuff that 5.10 provides
>>>> them.  Don't you want faster and more secure kernels for your devices?
>>> Yes, 5.10 is a more secure and less buggy kernel than 5.4.
>>
>> Great, use it, ship it to your customers and we are all happy.  What do
>> you need me for any of this?  :)
>>
>>>>>   And AOSP has already declared the use
>>>>> of 5.10 kernel in their Android S and T releases.
>>>> Publically?  Where?  And is that really the name of the new Android
>>>> releases, I thought they switched to numbers now (hence the naming of
>>>> the current android-common kernel branches, marketing is fun...)
>>> https://source.android.com/devices/architecture/kernel/android-common
>>> Feature and launch kernels provides kernels supported per version.
>>
>> Oh nice, didn't know that.
>>
>> But note, Android kernels do not reflect the lifespan of LTS kernels.
>> If that were the case, I would still be supporting 3.18 as they are
>> doing that at the moment for their devices and customers, and will be
>> doing so for I think another full year.
>>
>> So while Android is nice to see here, remember that is what Google is
>> promising to support for their users.  You can do the same thing for
>> your users, what do you need me here for this?  You can do the same
>> thing that Google is doing for 3.18 right now, pick the stable fixes
>> from upstream, backport them, test them, and push them out to their
>> users.
>>
>> While Google is a great help to me in the LTS effort, providing huge
>> amounts of resources to enable my life easier with this (i.e. funding
>> Linaro's testing efforts), their promise to their customers/users does
>> not depend on me keeping LTS kernels alive, if I stopped tomorrow their
>> contracts are still in place and they know how to do this work
>> themselves (as is proof with 3.18).
>>
>> So you can provide the same kind of guarantee to support any kernel
>> version for any amount of time to any customer you like, it shouldn't
>> require me to do that work for you, right?
>>
>>>>> Is there some way we could make the LTS support more clear.
>>>>> A 2 year declaration is not LTS any more.
>>>> Not true at all, a "normal" stable kernel is dropped after the next
>>>> release happens, making their lifespan about 4 months long.  2 years is
>>>> much longer than 4 months, so it still is a "long term supported" kernel
>>>> in contrast, correct?
>>> Perhaps a new name needs to be made for "LTS" for 6 years to distinguish it from 2 years.
>>> The timeframes are very different.
>>
>> At this point in time, anyone wanting a kernel longer than 2 years
>> should know how this all works.
>>
>> If not, please do some basic research, I have written whitepapers on
>> this and given numerous talks.  The information is out there...
>>
>>>>> If 5.10 is "actually" going to be supported for 6 years it would be quite valuable to make such a declaration.
>>>>> https://www.kernel.org/category/releases.html
>>>> Why?  What would that change?
>>>>
>>>> Ok, seriously, this happens every year, and every year we go through the
>>>> same thing, it's not like this is somehow new, right?
>>> No, but why do we need to keep playing the same game every year now.
>>
>> Because, 5.4 almost did not become "6 years" of support from me.  That
>> was because in the beginning, no one said they were going to use it in
>> their devices and offer me help in testing and backporting.  Only when I
>> knew for sure that we had people helping this out did I change the date
>> on kernel.org.
>>
>> So far the jury is still out for 5.10, are you willing to help with
>> this?  If not, why are you willing to hope that others are going to do
>> your work for you?  I am talking to some companies, but am not willing
>> to commit to anything in public just yet, because no one has committed
>> to me yet.
> 
> Following up on this as I did not hear back from you.  Are you and/or
> your company willing to help out with the testing of 5.10 to ensure that
> it is a LTS kernel?  So far I have not had any companies agree to help
> out with this effort, which is sad to see as it seems that companies
> want 6 years of stable kernels, yet do not seem to be able to at the
> least, do a test-build/run of those kernels, which is quite odd...
I personally cannot commit to supporting this kernel for 6 years
(and personally do not want to backport new features to a 6 year old kernel).
And customers are finicky and ask for one thing and then change their mind later.
We'll have to see what decisions are made at a company level for this as there
are added costs to run tests on LTS kernel branches.  We already run extensive QA on
whatever active development branches are in use and a subset on the mainline
branch as well.  QA resources are finite and committing those for 6 years is
not something that makes sense if customers drop that kernel version.
Testing of the LTS kernel changes really moves out of our hands and into the
customer's testing after our major releases to them.

Other difficulty with the LTS version is the frequency it is updated.  We would not
pickup the changes that frequently to test.  A quarterly, bi-annually, or when a critical fix
is identified would be when we update and perform any meaningful testing when in maintainence.
> 
> If you want to point people at your company this link that explains it
> all in a single location instead of an email thread:
> 	http://www.kroah.com/log/blog/2021/02/03/helping-out-with-lts-kernel-releases/
> that would be great.
Thanks for the link.  Will forward it to see if it helps make any commitment from customers
or company.

The link Pavel sent looks interesting.
"CIP project intends to maintain 5.10 for a long time, so you can expect testing/help from them:
https://www.cip-project.org/blog/2020/12/02/cip-to-embark-on-kernel-5-10-development-for-slts
"

If the CIP project has committed to 10 years you would think they would be in contact
with you to add their support to the 5.10 LTS effort.

> 
> thanks,
> 
> greg k-h
> 
Thanks,
 Scott

--00000000000086f40805bb8d80d2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
I/3RRboOeC9M13VNr5feU91O0iDoMreAgPQJ0Lo7YrodKYug0Tt/fFDjkW3v3VIbEr2liUN69U0C
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUWOK7
qiyDSt/IDm/SRcNi/sTEiyswDQYJKoZIhvcNAQELBQADggEBAEe2edd4F9tpp0GPmrFrQ+xp9kY7
uxBzPdCw588bgVrPemjLwiwV37XTT4iWJtNhPfEpaguM6jeLm58LCvHq5/IBjcyHyf4URQVwAg7B
pqkH8/M+IBstu4/D+znPHB59X+c+au3Q8D+xoNFd7I30kaE+oJuBuFsGXRBc0Ci+FM86x9k7SF8U
aui1E7Y9wDfsRSCL2TSwU773f09WkrvVdlKxNqQZj2z7bQUUn+yfXdFfBz0LqlYNfn7xJOpQE3HI
H4jq6U9+b0Qf+J0n0wyysjXPSeQ7EKXVkT8dM2KSpIN86v5dd9LkAz3C1dmjuPRGEC8ZhI1IjMBt
0itrn6C23NsxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgmBXRi/Gt
5ISlu232FIhfD5VYTniX6GJmDNOg2n07MmswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjEwMjE3MTk0ODI0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHyWLx1REV8CVkCH2ms/EatHtKl+
0oD4NIfiJozLxR1GMi2YrhCVUpAvK+DiCnnPeSPi3BAEGsH5mq/K+0QUqXeFvxJuhIKdC8kXxzIw
7WfLxlqupUal8/dmVrVW2PonmAfNENBSSgA7qH2mHq28u03wQsHiuRkVrlx5Aic5z5uKdklPhxBH
XIJ4Hea/Wu9WcE8kajJciZab+6vjV1lQxxrJttCIR8mEtrhO70rdKPyBB53EKxnWT/8WA1dK3inz
XYc8Gh8zzv1/wMsptPEyVCxdFYrugbKAWXUODiic2Q5krw36nnKeYyOyHJCzxLZ823Oz84jXIXvo
DO5ziJhLQo0=
--00000000000086f40805bb8d80d2--
