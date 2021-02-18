Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D830B31F24B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhBRW1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhBRW1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:27:02 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03444C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 14:26:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id d2so2582705pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 14:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=w+4UAEev5gv/cykwNTKWMwbmlo5TU2Qy/mvdTGtkCP4=;
        b=RbV1PwpdVHBV7/SrtiSda5e2qsE60TjVuyosQVBAEF+36raAdsxvgLAMlvzQ7Vf4JT
         Gq32xUeJ4OCkZKColQUjJWWbdOo+VVAWnmtpKlSkS3M+KxsZVIsrzb0dcYeql9AU5xec
         Leqz5aMCUR+dl/E2SMZ7h2bwJbr516kyfQBxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=w+4UAEev5gv/cykwNTKWMwbmlo5TU2Qy/mvdTGtkCP4=;
        b=QyvaNv2u+6pdtEE//lPpY6sPyzTgYi7XFdyN6L53GoSgqfBXF3SeuRgXH1N5hARwyX
         nDuuoGsMC8SXy7knI+j6BdxnC+DghkW7iomh2i30Pnuaty/rA91xiGyrliWKfSqUEz7e
         idTf6OAj7Z7HIyrHSShFYAfRyKfp2bVzMq2j+IyBwSg8thSmKkDLJAIDYVKpAWSkelst
         12emj2f+kF3KAY4EyGtWTKSABD470NJdPK8dJD7q+WUItBBHX2tFGQ3H/lWTdvMbLh3e
         uy0j4QhqNX44n6ElwpetZcMRnZtNG6p/g/6ux8w1OsIkPujP6m7MDOqWWb5VYiEUCrSb
         Teog==
X-Gm-Message-State: AOAM531eINwNPpq4PO/xd3n2+ftq+9RGPYlQWClXxMgy1ui25HoOYd/8
        66aHpAurF+tBkDZCxXTbJ8b5fA==
X-Google-Smtp-Source: ABdhPJzwfIFZzOTuRX0wRJ8UDXced+j2G4FrH2bDhzWPmdLGxCvDKR0Oq8qb1FJce9syCQL5qO5laQ==
X-Received: by 2002:a17:902:7106:b029:e3:913b:f636 with SMTP id a6-20020a1709027106b02900e3913bf636mr6090400pll.24.1613687180796;
        Thu, 18 Feb 2021 14:26:20 -0800 (PST)
Received: from lbrmn-lnxub113.ric.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h23sm7044252pfn.118.2021.02.18.14.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 14:26:20 -0800 (PST)
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com> <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <20210218165104.GC2013@sasha-vm>
 <00b9e2fb-d818-58d6-edae-4dbd6aa814f7@gmail.com> <YC6ptKgsMh20tmu6@kroah.com>
 <20210218182050.GB15217@1wt.eu> <YC6zq3u2jciI2gyZ@kroah.com>
 <b283eaa5-028f-a3d0-42a1-5b11c48ffe91@broadcom.com>
 <20210218213925.GD2013@sasha-vm>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <d4e2b6dd-ba76-abd0-2ee1-7fcf5009454c@broadcom.com>
Date:   Thu, 18 Feb 2021 14:26:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210218213925.GD2013@sasha-vm>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003ffc3d05bba3d3d6"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003ffc3d05bba3d3d6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2021-02-18 1:39 p.m., Sasha Levin wrote:
> On Thu, Feb 18, 2021 at 12:16:50PM -0800, Scott Branden wrote:
>> On 2021-02-18 10:36 a.m., Greg Kroah-Hartman wrote:
>>> On Thu, Feb 18, 2021 at 07:20:50PM +0100, Willy Tarreau wrote:
>>>> On Thu, Feb 18, 2021 at 06:53:56PM +0100, Greg Kroah-Hartman wrote:
>>>>> On Thu, Feb 18, 2021 at 09:21:13AM -0800, Florian Fainelli wrote:
>>>>>> As a company, we are most likely shooting ourselves in the foot by not
>>>>>> having a point of coordination with the Linux Foundation and key people
>>>>>> like you, Greg and other participants in the stable kernel.
>>>>>
>>>>> What does the LF have to do with this?
>>>>>
>>>>> We are here, on the mailing lists, working with everyone.  Just test the
>>>>> -rc releases we make and let us know if they work or not for you, it's
>>>>> not a lot of "coordination" needed at all.
>>>>>
>>>>> Otherwise, if no one is saying that they are going to need these for 6
>>>>> years and are willing to use it in their project (i.e. and test it),
>>>>> there's no need for us to maintain it for that long, right?
>>>>
>>>> Greg, please remember I expressed I really need them for slightly more than
>>>> 3 years (say 3.5-4) :-) I'm fine with helping a bit more as time permits if
>>>> this saves me from having to take over these kernels after you, like in the
>>>> past, but I cannot engage on the regularity of my availability.
>>>
>>> Ok, great!
>>>
>>> That's one person/company saying they can help out (along with what CIP
>>> has been stating.)
>>>
>>> What about others?  Broadcom started this conversation, odd that they
>>> don't seem to want to help out :)
>> Greg, I'm sorry but I'm not in a position to provide such a commitment.
>>
>> My original question arose because the 5.10 kernel is declared as 2 years LTS while older LTS kernels are now 6 years.
>> One problem this has created is requests to provide silicon support in an older kernel version (for a new project) rather than starting from a newer kernel version that more properly supports the (silicon and non-silicon) features.
> 
> So this sounds like you have boatloads of out-of-tree code and need a
> stable kernel to avoid having to rebase that code. This is not why the
> LTS trees are around.
My question centered around the inconsistency of a 2 year LTS kernel and some of the problems
of having older LTS kernels declared as 6 years.

The discussion has gone sideways from there with many other assumptions.

There is not always control over what kernel version a customer uses,
how many hacks they have in it, when they upgrade it, what other vendor changes are in it, etc.

But, will keep this email chain to forward to others. It may help influence some decisions.
> 
> For new projects, the easiest route is to upstream your stuff and ship
> the latest kernel.
> 
>> If all LTS kernels were declared as 3.5-4 years as Willy commented this would solve a few issues.
>> 6 year LTS kernels would only have a maximum 1 year lifespan over the latest declared LTS kernel.
>> Also, many products take a year or more to develop, there isn't any life left in an LTS kernel if it is only 2 years.
> 
> Products are supposed to upgrade their kernel. If you released something
> with, for example, a 5.4 kernel, doesn't mean you're forever stuck on a
> 5.4 kernel for that product.
> 
>> After 1-3 years of kernel age the relevant parties that want to invest and care about supporting specific kernel versions longer should become apparent and could commit to longer support.  Perhaps you move the burden of 6 years LTS elsewhere to longer term projects.  But, I'm sure many are happy because you continue doing such a great job in a central location, especially those whose product lifespan is around 6 years.
> 
> But this is exactly what's happening now: we support LTS kernels for two
> years, and after that interested parties can figure it out on their own
> if it's worth it for them to keep going.
> 


--0000000000003ffc3d05bba3d3d6
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
RzMCDFtD165RQeUC8DvoCDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgi3VWfq1t
xAzhRR5UbRca5YQvkuY7uCQJPizqdJq3XVIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjEwMjE4MjIyNjIxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIjNtRjiJf1Z89JrchfEG28oWAP4
nWdF8MD1WCa+Fz2tvrTq1vl9+okWl589ewPgUIMxNoA+yufczdQKWG1TvBXoGG+fwawRWz4mXEaW
JiCL9qHFklLUy1A8kQGaSgeexmNlZXYxGSLUvSmME90T44SA4qI7bx4XihE9sc2IoB2OmnDWcre7
RF2fkDSWMXZF/rKJfp4NxmkHTP5W/IbxPRJlC4MgHQx+NizA4zi4W/qLsfGWp5lxEVqsVyZiHerg
yFpXK1P7nYL94EHrLJOlHLOpTicG3yHU5vR0wPvy1/EVRDMn2cuLfe+PsRk8i9iGKvxA2H/Wib3E
o4k5XAfeDNA=
--0000000000003ffc3d05bba3d3d6--
