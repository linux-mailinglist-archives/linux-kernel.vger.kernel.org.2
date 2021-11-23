Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38C5459D95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhKWIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:17:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233234AbhKWIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637655246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b3JlYQK6PE43Cmi3twQemyDQ+FoQmw3hXR4Nbq+t8SY=;
        b=Ossotp8o1DUlYxvIZvGScWQ4yz6mnSvy0w6Vv70LNPcVcos9GCBb4uGE1YfAAnRTbz5IQE
        hNI+zG1XNV8cquBrXxwUoP+J4UrD8zeVb0bOqYPqeKWyu3rHniRCPr155teUvROyIdk0Q2
        RRgGWgcWLUEkd+SDdUxMVw7Nv1LeM2I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-QvrmFcZMOR6EaG9uQoSIyg-1; Tue, 23 Nov 2021 03:14:04 -0500
X-MC-Unique: QvrmFcZMOR6EaG9uQoSIyg-1
Received: by mail-pj1-f70.google.com with SMTP id mn13-20020a17090b188d00b001a64f277c1eso1029963pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 00:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b3JlYQK6PE43Cmi3twQemyDQ+FoQmw3hXR4Nbq+t8SY=;
        b=k0GCtmJWxDZbbhWtd10vQBVYzU/hh+/UfDpJRzf2cDW9fkW2FGRTBvQd373cIPZWGx
         hQsULOXwpmx3GiO2tmZumUV7mQN/effu3AowG3Ed5TWWYtV/W37FIkmbh4cptJ51yQ41
         N4fCS3lXH7FGsNkM2/+q7DaCYR9pyRh6aLT9ZCYsefzleHoVWbuRrxujPAeXpgJZeDUX
         Q01glVdFqzWoLFnaX+u/mJRWzZBhUJ0xVUEr0mJfULgoHq5ShC6RJpU5QHMTDNFW0mst
         SDQCRoPEyX7JnC1ZlRuq6CQ85ZXXOolJxX0/5oBUeraq0MhS6epcGS4qDxNBQDMzNSgB
         kNSQ==
X-Gm-Message-State: AOAM533G0iUXJ/9PX2xsVpiuekRUkfMlyrzoDpbLDbds+xWEWNpbuDQ/
        zDb5wz9T6jrDx67beB5weWIXo/nQ56SMqzOWBcgC9Q2o1+yAZle/A3pz+65SB9DN9ihP+CIFQao
        44BtlKCUWK+Ua4sYF4C/DIOF2AzJJFz1GSBxD7oIq
X-Received: by 2002:aa7:950f:0:b0:4a2:54da:3a73 with SMTP id b15-20020aa7950f000000b004a254da3a73mr3357611pfp.18.1637655243723;
        Tue, 23 Nov 2021 00:14:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyM1d8oFqs75en9t+2zj0RH3whFFMQ1ACzCMm3oYEOcXSl0ETFbjaN9f+DgLxCUPRHGOiLkxhnsSWrFblvx/ag=
X-Received: by 2002:aa7:950f:0:b0:4a2:54da:3a73 with SMTP id
 b15-20020aa7950f000000b004a254da3a73mr3357584pfp.18.1637655243511; Tue, 23
 Nov 2021 00:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20211122191752.1308953-1-stefanb@linux.ibm.com> <20211122191752.1308953-3-stefanb@linux.ibm.com>
In-Reply-To: <20211122191752.1308953-3-stefanb@linux.ibm.com>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date:   Tue, 23 Nov 2021 12:13:52 +0400
Message-ID: <CAMxuvaxB=dpz-1J1RJ6Phaan8=a0QXcu7jYiwUOE85NN5v7xTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: tpm2: Reset the dictionary attack lock
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jarkko@kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:18 PM Stefan Berger <stefanb@linux.ibm.com> wrot=
e:
>
> Reset the dictionary attack lock to avoid the following types of test
> failures after running the test 2 times:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ERROR: test_unseal_with_wrong_policy (tpm2_tests.SmokeTest)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2_test=
s.py", line 105, in test_unseal_with_wrong_policy
>     blob =3D self.client.seal(self.root_key, data, auth, policy_dig)
>   File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py",=
 line 620, in seal
>     rsp =3D self.send_cmd(cmd)
>   File "/root/linux-ima-namespaces/tools/testing/selftests/tpm2/tpm2.py",=
 line 397, in send_cmd
>     raise ProtocolError(cc, rc)
> tpm2.ProtocolError: TPM_RC_LOCKOUT: cc=3D0x00000153, rc=3D0x00000921
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tools/testing/selftests/tpm2/tpm2_tests.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/s=
elftests/tpm2/tpm2_tests.py
> index a569c8d0db08..109ffd736c73 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -100,6 +100,7 @@ class SmokeTest(unittest.TestCase):
>              policy_dig =3D self.client.get_policy_digest(handle)
>          finally:
>              self.client.flush_context(handle)
> +            self.client.reset_da_lock()
>
>          blob =3D self.client.seal(self.root_key, data, auth, policy_dig)
>
> --
> 2.31.1
>

