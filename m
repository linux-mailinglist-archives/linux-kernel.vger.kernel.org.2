Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A9D3F79C1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhHYQEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhHYQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:04:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F61C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:04:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so4470863pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=zd2jZc/9yTIPDfItLU6lcfiRqc2Lng9TYpcOVkZKrg0=;
        b=YxI/lLcPyJALksIFY3+WEllPty25JRJLtu29C2a2OsT1+CfoQ3LRKDYwoCq1kGt8kf
         /jtdi5LTreppqsDKAnNz8dQNkr5E8C5T4c3Ck31lZDwnZTFPCrocKcqjm5iMvJfOkSBP
         pwUBcrzFpj+d0jUxkm1+LplW94EWYHuBe8ei0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=zd2jZc/9yTIPDfItLU6lcfiRqc2Lng9TYpcOVkZKrg0=;
        b=cdjnyy7j8ZOby0GXTJJBiSfBRVqKzeIh6HWnnKfDF0K4SFylzOtVTJziH4TQoqWNLk
         RsJd2ddR/y254bKuY6xXSctJBO0xFD8Tlp8EIAYnLFTYj+1QP1YMWD2HYy62G8r9pzJK
         NZdqXqQK21MFvh6OSlCtJOT8+z0Te6nMW5sbadKsgWHR7HJ+ifN9qvm8LidfL2zQAXuL
         3zEFw9GbBYfLHSxs4i52M3S450jlRT+enE1iYzUDIN631ZKxFsSyiDQugISyIRBzd72T
         CllTzxtJqWP4pmHlgW5b59g/SrPE6RGwQzeIwqBCTXgCioBW9jj2Icm8pQs97GhFK87c
         736w==
X-Gm-Message-State: AOAM5316pjDg62KHEWiOxtQrBqZ5sbYynOwj4FaNe3yq4U15SXFg0fLL
        Fe8hcFGWScNrBG2BFdZtWRyor1a+sJGTbhqEcrojQvIykLveiadaYAxc87JZ8p/CVuJUzVKDjPX
        17AqAaKMhma2s63s=
X-Google-Smtp-Source: ABdhPJwfDUSwNZkf5iEcw+xuf8ehCie+1hewkDSgnH3gdymiouJLcQZ9U8zwhXQXwgU2hTVBCNWisA==
X-Received: by 2002:a17:902:a5c5:b029:12c:9108:d83 with SMTP id t5-20020a170902a5c5b029012c91080d83mr38918544plq.33.1629907442649;
        Wed, 25 Aug 2021 09:04:02 -0700 (PDT)
Received: from [192.168.1.40] (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id m2sm448296pgu.15.2021.08.25.09.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:04:00 -0700 (PDT)
Subject: Re: [PATCH v6 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
To:     Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        James Smart <jsmart2021@gmail.com>
References: <20210823112351.82899-1-dwagner@suse.de>
 <20210823112351.82899-4-dwagner@suse.de>
 <025942a6-4f57-b005-eb77-e9eed143522c@grimberg.me>
 <20210825130423.7tpeysh4xtcy2ark@carbon.lan>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <a4d0220e-0b50-9204-2ce4-5c4a486c8ed0@broadcom.com>
Date:   Wed, 25 Aug 2021 09:03:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210825130423.7tpeysh4xtcy2ark@carbon.lan>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002a03e005ca6466ce"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002a03e005ca6466ce
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



On 8/25/2021 6:04 AM, Daniel Wagner wrote:
> On Tue, Aug 24, 2021 at 01:38:20PM -0700, Sagi Grimberg wrote:
>>> freeze before calling update_hr_hw_queues". It's not an exact revert as
>>> it leaves the adjusting of hw queues only if the count changes.
>> I see that fc doesn't freeze the queues, so it obviously wrong to
>> unfreeze them. But is it correct to not freeze the queues?
> nvme-fc is draining the queues in the error recovery path
> (__nvme_fc_abort_outstanding_ios). There are no request in the queues
> hence we don't have to freeze.
>
> The only reason to keep the freeze/unfreeze in this path would be to
> make it look alike the other transport. But it would be a no-op.
Yep.

And updated commit is :=C2=A0 88e837ed0f1f

-- james

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--0000000000002a03e005ca6466ce
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
PXdbw8NJD55W/TyL5SqwLhkniLbboSA3j8lnH2Irpzm5VWjULsVCgV6+584AQ7cIYxFuSU2iy9oC
VOMV1KZcfEMa2w69xAPeGaT4svn9q4PyT7nKiygbAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGphbWVzLnNtYXJ0QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU38f2heZreKHlV6siVOSG/emDAbMw
DQYJKoZIhvcNAQELBQADggEBAFxOL7NTWX6Z3GGXKqmCIS7A9MeBSusGyxInLdVymGQsxEItQhHo
JsU6Nck6c8X77/ebCikLmw87STnywRJNGxUVRhcN/1p7Qyf246oxhG31fcVeSx/fEWzAbSrNTkLf
eAGDDdAlZdLD7C1DWW8Z4wYkkoAlQ/HX7/pShjmuT6UK3gkc7SxbWT0w3vpBYP0sbj0I+pdeNFBm
9mc9+qMcR1bhq+sAyYmBebwsAuCKTT1oY7Pfq1981wGcENAbCE/M0QL+PJwLYcM4UONNVqIfX6VL
rosksbNQhwjUlEcPdVzlzWQjhia2Gl3yjSb8HBLcnu4rh0oVjIP3NfBsRUkBYCYxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwooxvJJXw5eyVAy38wDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAO7ugRANEiS1WVIM2EjwuQwqiq7n7ZytYab
zHlgWvAlMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDgyNTE2
MDQwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQBuI1jzuHtJgU574b1a6a3NlyeE8tYTzmSDgxjbCTVRyN3Cxs7bZxpv
McwPfEFuFG/Ra3A2E92/N6puNyYZSrEyx/s5djCe7i53a8t5Z/l+eCx4I3Jx7frosfdNDxkXTiwB
w2eKYXsTGDzScU2V5AJKyTt+X/Zc24YGXP8gfxgZbpm4nP2gpalQO1NqnWVYNrQxQP0CkkWhrSLb
o5NmHAGd5Zh3KobuuItngLNWvMjzcDesiaqrTeWGmPyjoUuL3WVotI36u3EQwp7Z+OwOvAK3kTzj
tO5GY8IfglKFxpusdeJsB8KtyuV5hhSLghLWBefB+Dhg8+2BN6yPpyWtyWQz
--0000000000002a03e005ca6466ce--
