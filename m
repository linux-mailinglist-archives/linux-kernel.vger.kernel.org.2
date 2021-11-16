Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460FD453B25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhKPUoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 15:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhKPUo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 15:44:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD6C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:41:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id iq11so421457pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 12:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=IRnEer3ik49ebg0IV+YdqlubsT6DzyYJd9SL94CGobU=;
        b=QPHDeMLrLFsFeHRaLWH2O3Ps/aDt8DhtoNebGbmXnBcf8caYUszC9gfffp8jrB+XVG
         CB9yLCVSeH+GTj4H5ASImT4N4Be3nCDvx61g5b/AZb4y1gN3pGNFGXf0tmYz81F1PKEx
         /ozdjoRYW0vojMfNgPtRFWSTNDPRC29RsXBgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=IRnEer3ik49ebg0IV+YdqlubsT6DzyYJd9SL94CGobU=;
        b=pp0b3tHJmRsRIjRH7N0Z4YTGAHSteQHEt1nq6ZvdDtbN11YkOxbp8+g12GZHDVQKP2
         BnSWX7PXPiy5yeFMd809zIaq4EUVLdyNVWwiMVInLciw5ZP8N5UPztWCDxk1qKi83qhD
         YbvVAgZTWyidAMGV1yS8gX4EpcQb/AJQEfkHwc2FOfNr7nrGewaYXPWjqC3HudKQjLbd
         m0TDJ7FZRFlSFBW8PT9WsLQu/eOeY4fgvaYzxwRN+hwgU/Ey3bJvKgTz55i3dndgp+/D
         R4vE9+RQOUETNDLR+KNQpf95KS9vEVQ9hizoUDvHxXkHfstz553QBlmCnEck1dksQzjB
         fa9g==
X-Gm-Message-State: AOAM53189qszAPRNuGBbsat/eaABpGZnB9nADtMFd54PBVy45qG3I9aX
        JRlxOblaZ+X1O0N2CvWgebZgcA==
X-Google-Smtp-Source: ABdhPJxLqN9Vtnv9bBxe0+y4tRAazp4wBYe7ulDb2n+AUkfPjseSXv/txLf2GpMa8YO6XI/2lxMANQ==
X-Received: by 2002:a17:903:1d2:b0:142:24f1:1213 with SMTP id e18-20020a17090301d200b0014224f11213mr48905053plh.81.1637095290626;
        Tue, 16 Nov 2021 12:41:30 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h196sm2953502pfe.216.2021.11.16.12.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 12:41:29 -0800 (PST)
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
To:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
 <94d3f4e5-a698-134c-8264-55d31d3eafa6@arm.com>
 <CAHp75VeJ8ZiD=qQVfeahUjGZduFRJJ5683hn8f4810JYEzsCyw@mail.gmail.com>
 <YZJxG7JFAfIqr1/f@smile.fi.intel.com>
 <CAL_JsqJndi-gmenSpPtMVfsb3SrA=w+YBsSh3GigfgXC3rYDeQ@mail.gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <71a90592-99bb-13e1-a671-eb19c2dad3da@broadcom.com>
Date:   Tue, 16 Nov 2021 12:41:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJndi-gmenSpPtMVfsb3SrA=w+YBsSh3GigfgXC3rYDeQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000047303805d0edf3e7"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000047303805d0edf3e7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 11/16/21 10:20 AM, Rob Herring wrote:
> +Marc Z
> 
> On Mon, Nov 15, 2021 at 8:39 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Mon, Nov 15, 2021 at 04:14:21PM +0200, Andy Shevchenko wrote:
>>> On Mon, Nov 15, 2021 at 4:01 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>> On 2021-11-15 11:20, Andy Shevchenko wrote:
>>>>> Use BIT() as __GENMASK() is for internal use only. The rationale
>>>>> of switching to BIT() is to provide better generated code. The
>>>>> GENMASK() against non-constant numbers may produce an ugly assembler
>>>>> code. On contrary the BIT() is simply converted to corresponding shift
>>>>> operation.
>>>>
>>>> FWIW, If you care about code quality and want the compiler to do the
>>>> obvious thing, why not specify it as the obvious thing:
>>>>
>>>>         u32 val = ~0 << msi->legacy_shift;
>>>
>>> Obvious and buggy (from the C standard point of view)? :-)
>>
>> Forgot to mention that BIT() is also makes it easy to avoid such mistake.
>>
>>>> Personally I don't think that abusing BIT() in the context of setting
>>>> multiple bits is any better than abusing __GENMASK()...
>>>
>>> No, BIT() is not abused here, but __GENMASK().
>>>
>>> After all it's up to you, folks, consider that as a bug report.
> 
> Couldn't we get rid of legacy_shift entirely if the legacy case sets
> up 'hwirq' as 24-31 rather than 0-7? Though the data for the MSI msg
> uses the hwirq.

I personally find it clearer and easier to reason about with the current
code though I suppose that with an appropriate xlate method we could
sort of set up the hwirq the way we want them to be to avoid any
shifting in brcm_pcie_msi_isr().
-- 
Florian

--00000000000047303805d0edf3e7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDHG7gDNoanCGtqaNhjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNjU3MTBaFw0yMjA5MDUwNzA3MjNaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAu10WSl35INx8Ma97NH54zM3XKzx8Lo/KErWP5HPBtIxzYjBL20TDg9Jmnnbs
rZjwEVNKY30HiBRJcooDpalBATQpdw3kdYEgojrrXjVz4a+YaWhLbV0OwQ54QAkwKsdYTnuUX0B4
YLYGuUBDXYkcFWZv5BiAF4L97ClbTnUUCry8bhV9SP8b/tbivOhWUSjHLsQ9gEjuLhVId3Xgs9dA
TtoyOTJVs6HDth0+/13gxSrB3BwSY4wtw7EPHshswD1fzSV1fZf7QUQedadjH8BMBaKKseIieb6M
bhjsippX2btWEJOuUFS5RkK5HFFkzcGtIQd+gltZHQHohAcopF+cSwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIDZLMN77
IWw6rnhSvGm2V4nv3AowDQYJKoZIhvcNAQELBQADggEBADVdzyh3BQZiABHSdL7LQPNr6/6OQwg7
65j9Ggyr2Rdl2RnQIifKtGGodVlJ8e9XCYt5rCNU8PriYstIk4jlMJp6SziSN0CLE+A+FujmTqZJ
X8vEct7sdLXqdlBvR23TLvnkxbS3RwED7FDDTxpIv5j87o78e+wrZOPvDskdrYXVWGUu23xmd2IS
kYMLAXNeGrVe6HovEKCJPw07+B35iJvwdpZBXiti5hFa3q1L0+K5nGMpceIrj4dOOkSNB2ipHR6H
Q5HbB0UbWMkRv1PYpxf5eMjyDqxNigsE2JIFa1nk8ckA8hoTKbypCoALjcSuNqdZZyOnMBSKguHJ
Zz4bBBwxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxx
u4AzaGpwhramjYYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGryxWRhFXpuHTU8
+pfraNMP3yUX8flIjAJ1rWR/bYKiMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIxMTExNjIwNDEzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBogZG7RCPlT6sorTtrTZ4hF0D5R3MfzZ+a
uMzJFSl4mJ9st03+J1ztgeCkQ6+cyhxVQ2CTDhZ6dZxwLoWa3sCw4jywjKNUeweMQ+Ycy8PLRfuk
jF7fICYkO4kuwgnEIETiXxcJH7Ky1zq4h+sxtNFAOMZEZGxgxLcCjdC6spibUq4bnLaxrJzDdcjD
nZT6nQBvCUbUcjplkQnH0PRMfN4FD+MYbjVuHtOcRikHjIIrZSaj5QbZopf8LwpbRN+3mmxmiWq+
TC/cJ0BElfL6W7YMvMMW3Phf1/p1YNjKAkwbtal3GyGF1Lmci1oHeUR3ogLrJmQq4LvmdA+83yrI
i5+U
--00000000000047303805d0edf3e7--
