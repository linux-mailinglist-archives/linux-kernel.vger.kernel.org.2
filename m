Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2AC34C354
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhC2Fwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhC2Fwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 01:52:41 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F91C061574;
        Sun, 28 Mar 2021 22:52:41 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id x16so5939887qvk.3;
        Sun, 28 Mar 2021 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=QEBhJRkUldP9MTqtPRl/PdQiaXTH0NuLwpqsVbpBShk=;
        b=u4EMbSXycOVxaI9gFtksc8Q0DjzCH/304aO/U+g6MfkEtnqLgnEajGG9nGr2SO7H/S
         nbTtC2vhk0kBSCfV4rXnWsSBh/2CbOf1q5wuFpm6Ey7TZQvl343T6QUBcZdE+s5iIP5s
         OnvQmAdoZ2zEQdwrkgEHYDSlCF+9sd17heSraLF+kMo43mjmbJP5saMXujT+KyZC/zxK
         rc0W0GMRPfFJcY8Qaqz5LBOUei2ai39pE+TC9bdeB2Yav28CEhckOpVwIKbdzMhvO+t2
         DJZifhkwwgreM27rEBv7GGYRP7YfekNf39S2LGYC/hO3Y34yT3VL7RoKhb5XlCOzwx3Q
         FU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=QEBhJRkUldP9MTqtPRl/PdQiaXTH0NuLwpqsVbpBShk=;
        b=L5W8ydZwR3pQA9sZe4rZXVWjpSvydszxUqr3+R4uN4LOD+aejMD6IGwModKAyv5V9i
         D1SzN76/KEpsrg2ldqIUZrUtOnIKhomNPwR790ba152yN+9Khl+eLSHnrOZ/gyqxPAQZ
         mUP3kYeAVPrWoaO5Rg7br6Gz0Rc6LcxPZgU5OiZf52v+k9hw+pO26/+ubWQq2qUj5sr1
         mKiGbgc4bMndTgljMDlkyNqHrrfXMPs+FUCghaIWZ1HpHgE7MCuPq4y+8cCfuvjxiXEU
         dhIg1R6Wi7sP8uty0r0PHIafDVMiCp4RER9lOyoL2I4xUupDE8TkcWDWRtwZeEdkGhRB
         rIMg==
X-Gm-Message-State: AOAM531eIHZaarNX7IuldO5xU0t+9YUg6kkNdlP/PW59h9E2rTnNaScQ
        afsVaWZH1jq1TqmiNPrivrE=
X-Google-Smtp-Source: ABdhPJw1wKFggJtj33zdivqYl1Ft26FlUNEVPyigiHgcrCBRMeeJGnO4nshGrsp0Ah5CrY0oNu6pQQ==
X-Received: by 2002:a05:6214:20c8:: with SMTP id 8mr23639661qve.15.1616997160403;
        Sun, 28 Mar 2021 22:52:40 -0700 (PDT)
Received: from Gentoo ([156.146.37.195])
        by smtp.gmail.com with ESMTPSA id r23sm2640561qtc.31.2021.03.28.22.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 22:52:39 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:22:26 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/23] atomctl.rst: A typo fix
Message-ID: <YGFrGkOlenyGYKHe@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1616992679.git.unixbhaskar@gmail.com>
 <b103bd6a8bcdad7f90806dbe7680017235cf1d9c.1616992679.git.unixbhaskar@gmail.com>
 <CAMo8BfKj+ojEbc1ZJ6QL+f9Sq+7oZeqVNMu6nTP=OSbrqD2XOg@mail.gmail.com>
 <CAMo8BfL8bzsVCSez8WUy5E7_izKmhYFB1O2gOXsqcsok65sM=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0XmWbfFiw7nwpR9E"
Content-Disposition: inline
In-Reply-To: <CAMo8BfL8bzsVCSez8WUy5E7_izKmhYFB1O2gOXsqcsok65sM=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0XmWbfFiw7nwpR9E
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 22:38 Sun 28 Mar 2021, Max Filippov wrote:
>On Sun, Mar 28, 2021 at 10:37 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>>
>> On Sun, Mar 28, 2021 at 10:18 PM Bhaskar Chowdhury
>> <unixbhaskar@gmail.com> wrote:
>> >
>> > s/controlers/controllers/
>> >
>> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> > ---
>> >  Documentation/xtensa/atomctl.rst | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/xtensa/atomctl.rst b/Documentation/xtensa/atomctl.rst
>> > index 1ecbd0ba9a2e..a0efab2abe8f 100644
>> > --- a/Documentation/xtensa/atomctl.rst
>> > +++ b/Documentation/xtensa/atomctl.rst
>> > @@ -23,7 +23,7 @@ doing a Cached (WB) transaction and use the Memory RCW for un-cached
>> >  operations.
>> >
>> >  For systems without an coherent cache controller, non-MX, we always
>> > -use the memory controllers RCW, thought non-MX controlers likely
>> > +use the memory controllers RCW, thought non-MX controllers likely
>>
>> In this line you could also do s/thought/though/.
>
>...and s/memory controllers/memory controller's/
>
Thanks, will do both the mentioned changes in V2..
>--
>Thanks.
>-- Max

--0XmWbfFiw7nwpR9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBhaxoACgkQsjqdtxFL
KRXXIQf9GMsn9znDSebcEheL3vjwgPpRw3wZJIPzeCrjPcrfD2vHVhf03wm8CTef
WBMZdv38qheb+iYL736Yobj12NNhqNLK2Y3Z9/3XNVYXUJN4aVdwOI9k1+meuMg7
ge3qvF0h+4B2uptY6c9zLrlJHjzPXCNd4WGVY1BhT+XP9aQMLJ5K8jrsbEBM0C7y
BArdKjN+In8ajlXxqClBR3w8jofdrrp378enc8UyI71SbB9MGNktzO6nOiTs5P+7
eYw5KJmsoN9vJqCevSpYa5EQqOOUDRZZEm23d6ERmser25fiOqACCp/PYNz6o6mT
bdpcRK+WHeLTb6oKpZekG6W9k2ywqw==
=2DiR
-----END PGP SIGNATURE-----

--0XmWbfFiw7nwpR9E--
