Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728F933F98B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhCQTr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhCQTqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:46:50 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C44C06174A;
        Wed, 17 Mar 2021 12:46:50 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f124so40189941qkj.5;
        Wed, 17 Mar 2021 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=38QftDwGYTFsF09wdjbjQ7byRgm+bvbg9dFB30l6dug=;
        b=uWalbaNxjLCppgPJ94UGPOrX1aJSHK5Hzd+Dlgrg4b9hd51W7wZdDApkxzZwgmZVOr
         gw7qRH1/rwiyiVXKNUUlyxMAzsn19vShpZejSW5ZbVly+p6fYdGY77nJ0NJtvXWTtDK2
         NfP5rBFD3YeD1SuMK6OHHujQr0qJZX7Czc/0RAxcsVZhYr8te2+QdNrnln9FjCOneg2X
         zYMOM4pPAcOLz9327xW5lCNSqRLYPYV/1aRQeE+LWOPuJWqNQTVGZ/W13rPOc2ixLMQK
         dImMB897UKTu2CL95hqz6h3H+7icxY+EqAhsiXhopAiXNE9Qbyh06S69dGS0NGnytdpi
         f9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=38QftDwGYTFsF09wdjbjQ7byRgm+bvbg9dFB30l6dug=;
        b=cI4JLC8x6lMAuhR3KRfnA5P0MSlWRFuLuu3nSGbfW5tBRfa4xK+WUbSlWWFsvavFcA
         mmZflv1A6MRDrhW807UllkKrtbTbGgSUVc5V4gfXpFO35YJkrQaWiEpmgIz2YB0EIWbH
         Gch66NPPQaGiXLv6anmMLudu9MrvaVD6KAMBsJgCgcgk0e6BZMHkFwfHgqLZoBhkpUz4
         v7krGe3n9G1qfm3zG59S9OZpdfwabs+KzFj/q7xrnroneMybxj0mhgBcMS6cDQN5ykHS
         Th3ZC0aO4+EaMfihHycQXd6L5+97jBel7bm1DJ8JeDL8mQ1EpgX4MxGlSe+ba7C97PQj
         C8fw==
X-Gm-Message-State: AOAM532vTMYaMVMhqCppLb8aZ0MPk51Z1wimEY4jml8wdbg524b114rg
        idKx9+ry8HIyHpYKDcSvwu4=
X-Google-Smtp-Source: ABdhPJw9tRTcpQEibvaEVYUIv0PMURtsr3GgPkltKsE8vsap1jDVKEb/IoubKoRXNIx8i80ljBoW1w==
X-Received: by 2002:a05:620a:a8b:: with SMTP id v11mr868485qkg.414.1616010409321;
        Wed, 17 Mar 2021 12:46:49 -0700 (PDT)
Received: from ArchLinux ([156.146.37.138])
        by smtp.gmail.com with ESMTPSA id j6sm18570289qkm.81.2021.03.17.12.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:46:48 -0700 (PDT)
Date:   Thu, 18 Mar 2021 01:16:31 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] devicetree: bindings: clock: Minor typo fix in the file
 armada3700-tbg-clock.txt
Message-ID: <YFJcl6i95cRM22MI@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20210317100840.2449462-1-unixbhaskar@gmail.com>
 <546989ea-c6b2-42e4-46b2-d7de5d208728@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9hpVVWNMD0hP0C8Q"
Content-Disposition: inline
In-Reply-To: <546989ea-c6b2-42e4-46b2-d7de5d208728@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9hpVVWNMD0hP0C8Q
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 10:32 Wed 17 Mar 2021, Randy Dunlap wrote:
>On 3/17/21 3:08 AM, Bhaskar Chowdhury wrote:
>>
>> s/provde/provide/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>Bhaskar,
>
>Did you send this one to "robh+dt@kernel.org"?
>AFAICT, it was sent to "dt@kernel.org", which bounces.
>
>If you used "robh+dt@kernel.org", it appears that 'get send-email' has a problem with that.
>
I sent out a mail to David and Rob, including you for the same problem . Hope
David will do something to change that address or Rob might do something . So
that it will not bounce in future.

Lets see.
>thanks.
>
>> ---
>>  .../devicetree/bindings/clock/armada3700-tbg-clock.txt          | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
>> index 0ba1d83ff363..ed1df32c577a 100644
>> --- a/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
>> +++ b/Documentation/devicetree/bindings/clock/armada3700-tbg-clock.txt
>> @@ -1,6 +1,6 @@
>>  * Time Base Generator Clock bindings for Marvell Armada 37xx SoCs
>>
>> -Marvell Armada 37xx SoCs provde Time Base Generator clocks which are
>> +Marvell Armada 37xx SoCs provide Time Base Generator clocks which are
>>  used as parent clocks for the peripheral clocks.
>>
>>  The TBG clock consumer should specify the desired clock by having the
>> --
>
>
>--
>~Randy
>

--9hpVVWNMD0hP0C8Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBSXJMACgkQsjqdtxFL
KRWS3wgA2UZIYYaZVB6OMPavg2ALfytPLf3VNPNXZ85rvFOOE51TzBcdut85UVTu
GF3NnjDsf5r2jiojVrLg2kjG8PGDG+uMmoif3o/oKbyhCullJjjiWFJcuZiV++Oc
j5l6G5R1o4KuZzlMK6Ihf1zvznd4GANVGs+4eee2Xq5nunBwVLmdxbfCeUaqF9Fn
X9Rl1EL2ER6phR7tqV7cITb22dmVXhs36hJ2LEIphrYgSG7AJbi3gZ7EM7H+pW2l
raMAFJdNGwLfRM1i/98X86oy68Qb5i/jgscpGf3lsf9JJw3ZXty8Qzw6vq3mvFwm
OeGcAEuGfyfHwCDqHeZVQ2O6ulMX9Q==
=dR1+
-----END PGP SIGNATURE-----

--9hpVVWNMD0hP0C8Q--
