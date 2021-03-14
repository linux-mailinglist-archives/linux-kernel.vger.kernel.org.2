Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FCA33A8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 00:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCNXiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 19:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCNXhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 19:37:52 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 16:37:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 130so30059266qkh.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 16:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=izR7a2XTM/9p8TkjPfPsBWZ7me76Nozg2/VSA889rXg=;
        b=i40yrnL6/J5kPW0ByljtlGWxwt/M/Rnpp7USm9791mh13kTwo7RefV8vEEymoe2rpx
         9njupPiU+Y4q9At/Gb96OgFsPyA6VqpQ6Ic7R8clp/eTpoMulXtM603SFh+OvdScbmXv
         YpT0dyZ2tZTwu6iN/nxA9aXraVREzuOgZHULjJ9sYTb0pFY9Ytyjaaj/gOnXosHUo7EE
         jDd8avVihYNeyXxJjCzjkRK1zDGPD81SjL2GWgBQLSaHh/ElASu1IpiNN/Nh8i52RLL6
         btFZvC/Wpth0pk8LGp2fiXjCKbN05xxZR45oCZLcGQ/8uccB+1EJdRlot+VEHPHpPvvY
         5kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=izR7a2XTM/9p8TkjPfPsBWZ7me76Nozg2/VSA889rXg=;
        b=posdhGNbaa5qvre/pV4WbhDb3ACWG9TR6zfO0RyY5u1NDclTquxYMNJ1eymUFO8TsU
         pc5D+2Uybb1rHMFnpb9HvdD+SmGg4FiBK0aNKfq6VQHrt+ejS1vKyD4UScUbLoVBE8ys
         WiCO94SNzue8xEf5RXKaRZoF9bBCUurTZFPRlZEhf4cxKrlxG8KvaPe0O4zb4t50mJg+
         VXci7W+esZoL5w7EH+J7yOAYMDULNYf26oJYH7cXjB4UjR2vqfshpT9Z+c7FEKdjNhBW
         HEbnOtPE2WSgjkq76QYQV1VKAmyYrHfewg3NN8EqHrEKCqpe8hwi+LxshDhykbxOmDMF
         NwTQ==
X-Gm-Message-State: AOAM531BLJehBESTSEB7hmpbbVObYBNj7IpaXEDPZOiDWIWAZQ+CX0zC
        7w5+5OUhvk39m0svc9wzxrgq+SZLKNlIzsRJ
X-Google-Smtp-Source: ABdhPJxC5rRpgvpGi1j0RV0rUr8T0ojHmJduB5it5B4DCDeD1wSEriip1Jk012NgAvzQHicCNMz/PQ==
X-Received: by 2002:a05:620a:228b:: with SMTP id o11mr22387044qkh.204.1615765071842;
        Sun, 14 Mar 2021 16:37:51 -0700 (PDT)
Received: from ArchLinux ([156.146.37.247])
        by smtp.gmail.com with ESMTPSA id e3sm11052556qkn.39.2021.03.14.16.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 16:37:51 -0700 (PDT)
Date:   Mon, 15 Mar 2021 05:07:40 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.12-rc3
Message-ID: <YE6eRGPZTeXxWOVv@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgAr4Z2deEQs+5L6bJb68FouwBZUSURh+m-47TBnEsGZg@mail.gmail.com>
 <CAHk-=wiHX0SBy_RhbgkWETc_pxi8Gr7kmU72QE3jkRJieHuEPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7r5sg4zoA0ZXqGD8"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHX0SBy_RhbgkWETc_pxi8Gr7kmU72QE3jkRJieHuEPw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7r5sg4zoA0ZXqGD8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15:27 Sun 14 Mar 2021, Linus Torvalds wrote:
>On Sun, Mar 14, 2021 at 3:00 PM Linus Torvalds
><torvalds@linux-foundation.org> wrote:
>>
>> So rc3 is pretty big this time around, [..]
>
>Oh, and I had planned to mention the historical note that goes along
>with today's date, but then entirely forgot.
>
>Some people think today is =CF=80-day because of odd US date formatting.
>But as any true kernel geek knows, March 14 is actually much more
>important than that. It's the anniversary of the Linux 1.0 release
>announcement.
>
>No, it's not some nice round number this year - the 1.0 release
>happened in 1994, 27 years ago today.
>
>And it's arguably a much less interesting release than the _first_
>Linux kernel release of 0.01, which _will_ have a nice round age of 30
>years later this year.
>
>But still. I should have remembered to mention that minor historical
>significance of this date in the rc3 announcement.
>
>           Linus

Thank you so much for reminding and provide us something to cling on(it's b=
een
looooong)and earn daily bread and butter to survive.(If it doesn't sound "p=
olished" and "top
class" ..then can't help much...

~Bhaskar

--7r5sg4zoA0ZXqGD8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBOnkEACgkQsjqdtxFL
KRXzwgf+Ic13C0TwKqBJHdHROUcl3EWCKTTjHKq9G7+9gor7dV7QOEr9kP+AIiXx
NHItxbJxaE/sl+Iou2ld6+hZjV7IvDTw0Vby6yMaNcNZhUVZbH9Il8esahLXa+Ce
vhAMpWGrNoTnrvTyXgOspdgaCmwyyPQbxnA+qd5DD29c29fZc+QIaRQs9qr8eW8I
X9BxoY4pOxpYbaBGKd8DLEXLvLfu1N0qssiSdwc7EHjziunOiQEKFdDG/JB3lyxq
Yit6mtwjnixSFlp0blK+oSuqgV9PVvOjD//w/RCh6OmC16uZFnIZkXI7UbDQiEdf
nfJvCsnBDDsmYYUdHosSnqeebM1Vxg==
=HHLr
-----END PGP SIGNATURE-----

--7r5sg4zoA0ZXqGD8--
