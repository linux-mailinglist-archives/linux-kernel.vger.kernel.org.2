Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5555A345059
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhCVT44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCVT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:56:22 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8A0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:56:18 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id h3so9299848qvh.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nuGQ5K6K7mjOj3wRHwkoepkWfsUAAdT4sZj/2DT8CSA=;
        b=iBPwR/E6DGTUhdnWTN65nPW1EPs1I2gzt/aDDGroOoQiAntr6EkVbs5cnZTDMfWUzu
         Gkjp6f09QQN/v1LU5zuniG7iQiyvZcyOEwRrQcEG/47YHdN21jjKOtWSWHOWFIO3Iljk
         BPovcjFKKMsbTnr6CW8H4j+74Gtt0kfAHRutYDkhb3xLi4mcW1j1uelDXY3ZWTa/Rdvt
         ziGPjDQqvlkBS0z08cWGOVu9d2COJcys9IBR8+0Sg3rXSL+didvslTXbTRv///tC+n9A
         P2UzmKYgeTePz5s8CMrOLc+e/9a4oZpjvxe43N31Uqv7i68VVXZ1XjL0cEIWJFEMTROo
         8Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nuGQ5K6K7mjOj3wRHwkoepkWfsUAAdT4sZj/2DT8CSA=;
        b=lG5DmVMJ9G/WuFcgDE6jl7/pOoN7X9kfN74SrGSyR9BCCkTpO4nzvmFZlD4uVTVxR6
         1XigPW1xNhhwG1fbXQ/UTpJlnZq+hUaZHD+SSMoLw14IGDH1xEvj74DxsZTg7phsgpxC
         LU3IbF8Ds5iFUuudkU6Pyf/vIO3oTv0SWCUqpAC88GsMroxHV+neFyjTXqPBX2ieo1iR
         wFHZSAyxeG2aBkYG4w5vgtqod2k3jgmOSNvLqaiG9i69VnrQAKz5Rv+ybId0FVnCbySp
         Sh9AOsq1jFS3Q5V0Q4XZrVl04ABpP3B+Kl8Z7kxX9Lx8AOYY9dZNWd9Bu+H0oiAeixiO
         LnAg==
X-Gm-Message-State: AOAM5317kkIoQ7TaCFcMHl7NtJlXzTmQYsee0ZOlax6RIhjwI6H70uPr
        ZPTbKLJR6CqvjbsqKiaNhi7uKi0BjdO+xtef
X-Google-Smtp-Source: ABdhPJw3E+AWo8sJ5SeLjbEdlJ0YJrd9FzTg4YN92TkVpxwbxUhUtIKMSTZPr3o/3+BftOUVRv2l5g==
X-Received: by 2002:a05:6214:1c0c:: with SMTP id u12mr1459861qvc.24.1616442977524;
        Mon, 22 Mar 2021 12:56:17 -0700 (PDT)
Received: from ArchLinux ([138.199.10.68])
        by smtp.gmail.com with ESMTPSA id b17sm9584850qtp.73.2021.03.22.12.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 12:56:16 -0700 (PDT)
Date:   Tue, 23 Mar 2021 01:26:07 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Mundane typo fixes
Message-ID: <YFj2V8ytnP5um+dC@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210322072808.996970-1-unixbhaskar@gmail.com>
 <YFjAMa6AJ0nOK7F3@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HLu9vF6pIJnNX7en"
Content-Disposition: inline
In-Reply-To: <YFjAMa6AJ0nOK7F3@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HLu9vF6pIJnNX7en
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 17:05 Mon 22 Mar 2021, Greg KH wrote:
>On Mon, Mar 22, 2021 at 12:58:08PM +0530, Bhaskar Chowdhury wrote:
>>
>> s/stoping/stooping/
>
>Huh?
>
>Are you _sure_ that is the correct replacement?  Last I looked it
>wasn't...
>
No it is not. Will correct it. I hope you won't mind V2.
>greg k-h

--HLu9vF6pIJnNX7en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBY9lcACgkQsjqdtxFL
KRX8dQgAnC3UNEv+G44swdJdDeTIueZX/jViCF3low7Jk1dZmRrjdH8fwD20ZL5f
ZZ3U21MM4MvUhIXGsdjVFTmPiLt71NShgxkeiCZXhVek5E7pRW4KcA4+pePfRlV0
sNJk/NvOIVU0sn7MhD5++SgDLxvD/D3oYqh/jmjfxSP7NEwFRVYHmjYnpt1sjX+l
S0xkKwgxkMazbdctI0TQSsDpEH7k5HJbTnU60n6Qv+D0SYDfbaFvkQnYA7EuDe/g
YcdIgY330eRYDypITD0bFPjXizeN2kgGwWZvjwJDqIUl1K3+LxCq9NNn9RSip8DF
yELn70pduCQQYT0Sm8EUY5//b4DMSg==
=W4fK
-----END PGP SIGNATURE-----

--HLu9vF6pIJnNX7en--
